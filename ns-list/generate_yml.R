library(tidyverse)

# use this script to generate part of this action

# fetch schema
out <- system("viash export cli_schema", intern = TRUE)
cli_schema <- jsonlite::fromJSON(out, simplifyVector = FALSE)

# find ns list schema
ns_schema <- cli_schema[[which(sapply(cli_schema, function(li) li$name == "ns"))]]

ns_subcommands_schema <- ns_schema$subcommands
ns_list_schema <- ns_subcommands_schema[[which(sapply(ns_subcommands_schema, function(li) li$name == "list"))]]

# construct yaml
selected_opts <- ns_list_schema$opts[sapply(ns_list_schema$opts, function(x) !x$name %in% "parallel")]
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
  name = ns_list_schema$bannerCommand,
  description = ns_list_schema$bannerDescription,
  inputs = input_values,
  outputs = list(
    output = list(
      description = "A list of all of the components found. By default this will be a yaml, unless the format argument was set to 'json'."
    )
  ),
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
yaml::write_yaml(out, "ns-list/action.yml", handlers = handlers)
