# Detect components with changed files

Filter a json file produced by viash ns list on whether
  the component has been changed with respect to the
  default branch.

## Inputs

  * `input_file`: (Required) Path to a viash ns list json file.

## Outputs

  * `output_file`: Path to the filtered viash ns list json file, 
    filtered on whether one of the resources of the component has
    been changed or not.

## Examples

```yaml
name: demo of filter-changed

on:
  push:

jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3

    - id: ns_list
      uses: viash-io/viash-actions/ns-list@v2
      with:
        format: json  

    - id: ns_list_changed
      uses: viash-io/viash-actions/filter-changed@v2
      with:
        input_file: ${{ steps.ns_list.outputs.output_file }}
```
