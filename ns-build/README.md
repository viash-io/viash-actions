ns-build
================

Build a namespace from many viash config files.

## Usage

This action will run `viash ns build`.

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
- `parallel`: - *optional*. Whether or not to run the process in
  parallel.
- `config_mod`: - *optional*. Modify a viash config at runtime using
  dynamic config modding.
- `target`: - *optional*. A target directory to build the executables
  into. Default: target/.
- `setup`: - *optional*. Which setup strategy for creating the container
  to use \[Docker Platform only\].
- `flatten`: - *optional*. Flatten the target builds, handy for building
  one platform to a bin directory.

## Examples

``` yaml
name: demo of viash ns build

on: 
  branch: main

jobs:
  viash-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1

      - uses: viash-io/viash-actions/ns-build@v1
  viash-macos:
    runs-on: macos-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1

      - uses: viash-io/viash-actions/ns-build@v1
```
