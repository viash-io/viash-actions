ns-list
================

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
  possibly structured in a hierarchical folder structure. Default:
  “src/”.
- `platform`: - *optional*. Acts as a regular expression to filter the
  platform ids specified in the found config files. If this is not
  provided, all platforms will be used. If no platforms are defined in a
  config, the native platform will be used. In addition, the path to a
  platform yaml file can also be specified.
- `config_mod`: - *optional*. Modify a viash config at runtime using
  dynamic config modding.
- `format`: - *optional*. Which output format to use. Possible values
  are: “yaml”, “json”. Default is “yaml”.
- `parse_argument_groups`: - *optional*. Whether or not to postprocess
  each component’s argument groups.
- `output_file`: - *optional*. Path of a file to which the output will
  be written. If not set, this action will create a file with a random
  name in `RUNNER_TEMP`.

### Outputs

- `output`: A list of all of the components found. By default this will
  be a yaml, unless the format argument was set to ‘json’.
- `output_file`: Path of a file to which the output was written (same as
  inputs.output_file). We recommend using this property for capturing
  the action’s output because there is a limit in the object size that
  github actions can manage. Additionally, if you use this property
  instead of a static file path, changing the location of the output
  file will not require you to adjust settings for downstream actions as
  well.

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
