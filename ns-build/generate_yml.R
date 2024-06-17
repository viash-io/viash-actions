# This script generates a github action given a Viash schema

library(tidyverse)

# parameters
skip_args <- c("push", "flatten")
dest_file <- "ns-build/action.yml"
subcommands <- c("ns", "build")

#################### common code
# fetch schema
out <- system("VIASH_VERSION=0.9.0-RC6 viash export cli_schema --format json", intern = TRUE)
schema <- jsonlite::fromJSON(out, simplifyVector = FALSE)

# go down schema to find the right command
for (i in seq_along(subcommands)) {
  subcommand_names <- sapply(schema, function(li) li$name)
  schema <- schema[[which(subcommand_names == subcommands[[i]])]]

  if ("subcommands" %in% names(schema) && i < length(subcommands)) {
    schema <- schema$subcommands
  }
}

# construct yaml
selected_opts <- schema$opts[sapply(schema$opts, function(x) !x$name %in% skip_args)]
input_values <- sapply(selected_opts, function(opt) {
  descr <- opt$descr %>%
    str_replace_all("@\\[[^]]*\\]\\(([^\\)]*)\\)", "\\1") %>%
    str_replace_all(". *$", ".")

  choices_str <-
    if (!is.null(opt$choices)) {
      paste0(" Possible values are: \"", paste(opt$choices, collapse = "\", \""), "\".")
    } else {
      ""
    }
  out <- list(
    description = paste0(descr, choices_str),
    required = opt$required
  )
  setNames(list(out), opt$name)
})
# workaround for viash 0.9.0-RC6, should be fixed in 0.9.0
if (!"platform" %in% names(input_values)) {
  input_values$platform <- list(
    description = "Acts as a regular expression to filter the platform ids specified in the found config files. If this is not provided, all platforms will be used. If no platforms are defined in a config, the native platform will be used. In addition, the path to a platform yaml file can also be specified. Deprecated in Viash 0.9.0, will be removed in Viash 1.0.0.",
    required = FALSE
  )
}

out <- list(
  name = schema$bannerCommand,
  author = "Data Intuitive",
  description = schema$bannerDescription,
  inputs = input_values,
  # outputs = list(
  #   output = list(
  #     description = "A list of all of the components found. By default this will be a yaml, unless the format argument was set to 'json'."
  #   )
  # ),
  runs = list(
    using = "node20",
    main = "index.js"
  )
)

# write github action
handlers <- list(
  logical = function(x) {
    result <- ifelse(x, "true", "false")
    class(result) <- "verbatim"
    return(result)
  }
)
yaml::write_yaml(
  out,
  dest_file,
  handlers = handlers
)
