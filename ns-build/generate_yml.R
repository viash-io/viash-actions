# This script generates a github action given a Viash schema

library(tidyverse)

# parameters
skip_args <- c("push", "flatten")
dest_file <- "ns-build/action.yml"
subcommands <- c("ns", "build")

#################### common code
# fetch schema
out <- system("viash export cli_schema --format json", intern = TRUE)
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

input_values$project_directory <- list(
  description = "Path to the project directory. This is the directory where the project's `_viash.yaml` file is located. If not provided, the current working directory is used.",
  required = FALSE
)

out <- list(
  name = schema$bannerCommand,
  author = "Data Intuitive",
  description = schema$bannerDescription,
  inputs = input_values,
  outputs = list(
    output = list(
      description = "The output of 'viash ns build'."
    )
  ),
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
yaml_str <- yaml::as.yaml(
  out,
  handlers = handlers
)
out_str <- c(
  "########################################################",
  "#            DO NOT EDIT THIS FILE MANUALLY            #",
  "# Please run 'Rscript ns-build/generate_yml.R' instead #",
  "########################################################",
  yaml_str
)
writeLines(out_str, dest_file)
