# This script generates a github action given a Viash schema

library(tidyverse)

# parameters
skip_args <- c("push", "flatten")
dest_file <- "ns-build/action.yml"
subcommands <- c("ns", "build")

#################### common code
# fetch schema
out <- system("viash export cli_schema", intern = TRUE)
schema <- jsonlite::fromJSON(out, simplifyVector = FALSE)

# go down schema to find the right command
for (i in seq_along(subcommands)) {
  subcommand <- subcommands[[i]]
  schema <- schema[[which(sapply(schema, function(li) li$name == subcommand))]]

  if (i != length(subcommands)) {
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
out <- list(
  name = schema$bannerCommand,
  description = schema$bannerDescription,
  inputs = input_values,
  # outputs = list(
  #   output = list(
  #     description = "A list of all of the components found. By default this will be a yaml, unless the format argument was set to 'json'."
  #   )
  # ),
  runs = list(
    using = "node16",
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
