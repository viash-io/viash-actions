# build-nextflow-params

This action will build nextflow parameter file templates for Viash workflows and components in a folder.

## Usage

This action will look for viash configs for workflows and components in a directory,
and will generate (nextflow parameter file templates)[https://www.nextflow.io/docs/latest/cli.html#run].
For workflows, the parameter files will saved next to the Viash config, for components will output to the target directory (see viash ns build). 
This component required Viash to be installed and available in `$PATH`. 
We recommend to use [viash-actions/setup](https://github.com/viash-io/viash-actions/tree/main/setup) before you run `build-nextflow-params`.

### Inputs available

It is _required_ to set at least one argument for `components` or for `worklows`:

* `components` - _optional_. Location of the viash configurations for components. Will most often be a folder from a repository that has been cloned in a previous step of your workflow using [checkout](https://github.com/marketplace/actions/checkout). Ex: `example_repository/src`.

* `workflows` - _optional_. Location of the viash configurations for workflows. Will most often be a folder from a repository that has been cloned in a previous step of your workflow using [checkout](https://github.com/marketplace/actions/checkout). Ex: `example_repository/workfows`.

* `viash_pro_token` - Viash Pro token.

* `tools_version` - _optional_. Release of Viash tools to use. Will use the latest release by default. Ex: `main_build`

## Examples

```yaml
name: demo of build-nextflow-params
on:
  pull_request:
jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: viash-io/viash-actions/setup@v2
    - uses: actions/checkout@v3
      with:
        fetch-depth: 0

    - name: Build nextflow parameter files
      uses: viash-io/viash-actions/build-nextflow-params@v2
      with:
        workflows: workflows
        token: ${{ secrets.GTHB_PAT }}
        tools_version: 'main_build'
```