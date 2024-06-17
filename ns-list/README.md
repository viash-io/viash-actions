# ns-list


List a namespace containing many viash config files.

## Usage

This action will run `viash ns list`. See the reference documentation on
[ns list](https://viash.io/reference/viash/ns.html) for more info on
each of the arguments.

We recommend using a Linux or MacOS runner if possible.

### Inputs available

- `query`: - *optional*. Filter which components get selected by
  component and namespace name. Can be a regex. Example:
  “^mynamespace/component1\$”.
- `query_namespace`: - *optional*. Filter which namespaces get selected
  by namespace name. Can be a regex. Example: “^mynamespace\$”.
- `query_name`: - *optional*. Filter which components get selected by
  component name. Can be a regex. Example: “^component1”.
- `src`: - *optional*. A source directory containing viash config files,
  possibly structured in a hierarchical folder structure. Default: src/.
- `runner`: - *optional*. Acts as a regular expression to filter the
  runner ids specified in the found config files. If this is not
  provided, all runners will be used. If no runners are defined in a
  config, the executable runner will be used.
- `engine`: - *optional*. Acts as a regular expression to filter the
  engine ids specified in the found config files. If this is not
  provided, all engines will be used. If no engines are defined in a
  config, the native engine will be used.
- `config_mod`: - *optional*. Modify a viash config at runtime using
  config_mod.
- `colorize`: - *optional*. Specify whether the console output should be
  colorized. If not specified, we attempt to detect this automatically.
  Possible values are: “true”, “false”, “auto”.
- `loglevel`: - *optional*. Specify the log level in us. Possible values
  are: “error”, “warn”, “info”, “debug”, “trace”.
- `format`: - *optional*. Which output format to use. Possible values
  are: “yaml”, “json”.
- `parse_argument_groups`: - *optional*. DEPRECATED. This is now always
  enabled. Whether or not to postprocess each component’s
  argument_groups.
- `platform`: - *optional*. Acts as a regular expression to filter the
  platform ids specified in the found config files. If this is not
  provided, all platforms will be used. If no platforms are defined in a
  config, the native platform will be used. In addition, the path to a
  platform yaml file can also be specified. Deprecated in Viash 0.9.0,
  will be removed in Viash 1.0.0.

### Outputs

- `output`: A list of all of the components found. By default this will
  be a yaml, unless the format argument was set to ‘json’.

## Examples

``` yaml
name: demo of viash ns list

on: 
  branch: main

jobs:
  viash-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: viash-io/viash-actions/setup@v3

      - id: ns_list
        uses: viash-io/viash-actions/ns-list@v3

      - run: |
          # do something with the output yaml
          echo "${{steps.ns_list.outputs.output}}"
  viash-macos:
    runs-on: macos-latest
    steps:
      - uses: viash-io/viash-actions/setup@v3

      - id: ns_list
        uses: viash-io/viash-actions/ns-list@v3
        with:
          format: json

      - run: |
          # do something with the output json
          echo "${{steps.ns_list.outputs.output}}"
```
