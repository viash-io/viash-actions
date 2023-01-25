ns-list
================

List a namespace containing many viash config files.

## Usage

This action will run `viash ns list` and store the resulting yaml / json
in the output.

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
- `platform`: - *optional*. Acts as a regular expression to filter the
  platform ids specified in the found config files. If this is not
  provided, all platforms will be used. If no platforms are defined in a
  config, the native platform will be used. In addition, the path to a
  platform yaml file can also be specified.
- `config_mod`: - *optional*. Modify a viash config at runtime using
  dynamic config modding.
- `format`: - *optional*. Which output format to use. Possible values
  are: “yaml”, “json”.
- `parse_argument_groups`: - *optional*. Whether or not to postprocess
  each component’s argument groups.

## Examples

``` yaml
name: demo of viash ns list

on: 
  branch: main

jobs:
  viash-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1

      - id: ns_list
        uses: viash-io/viash-actions/ns-list@v1

      - run: |
          # do something with the output yaml
          echo "${{steps.ns_list.outputs.output}}"
  viash-macos:
    runs-on: macos-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1

      - id: ns_list
        uses: viash-io/viash-actions/ns-list@v1
        with:
          format: json

      - run: |
          # do something with the output json
          echo "${{steps.ns_list.outputs.output}}"
```
