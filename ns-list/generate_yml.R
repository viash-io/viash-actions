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
input_names <- map_chr(ns_list_schema$opts, "name")
input_values <- map(ns_list_schema$opts, function(opt) {
  list(
    description = gsub("@\\[[^]]*\\]\\(([^\\)]*)\\)", "\\1", opt$descr),
    required = opt$required
  )
})
out <- list(
  name = ns_list_schema$bannerCommand,
  description = ns_list_schema$bannerDescription,
  inputs = setNames(input_values, input_names),
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
