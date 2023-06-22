# generate-documentation-qmd

Create quarto markdown files for viash components or workflows, based on
a jinja template.

This action will look for viash configs for workflows and components in
a directory, and will apply information for each of these configs to a
jinja template to generate qmd files. This component required Viash to
be installed and available in `$PATH`.

We recommend to use
[viash-actions/setup](https://github.com/viash-io/viash-actions/tree/main/setup)
before you run `generate_documentation_qmd`.

### Inputs available

- `output_dir`: Output folder to write to.
- `viash_pro_token`: Viash Pro token.
- `project_directory`: *(Optional)* The directory in which the Viash
  project config (`_viash.yaml`) resides. Most useful when using
  `actions/checkout` with a different `path:`, as paths to files in the
  resulting qmd are generated relative to the working directory.
  Default: `./`.
- `component_template`: *(Optional)* Jinja template that can be used to
  customize the resulting qmd files. By default will use the included
  template.
- `dest_path`: *(Optional)* Template for output paths. Can contain
  `{type}`, `{namespace}` and `{name}` wildcards to create a custom
  folder hierarchy for storing the output for different component.
  Default: `{type}s/{namespace}/{name}.qmd`.
- `ref`: *(Optional)* The git tag. Used to create links to the source
  code and to build nextflow commands in the generated documentation.
  Default: `${{ github.ref_name }}`.
- `repository`: *(Optional)* Github repository. Used to create links to
  the source code and to build nextflow commands in the generated
  documentation. Must use format “owner/repo-name” will default to the
  repo where this action is being run for. Default:
  `${{ github.repository }}`.
- `write_index`: *(Optional)* Whether or not to also create an index
  file. Options are ‘true’ or ‘false’. Default: `false`.
- `tools_version`: *(Optional)* Release of Viash tools to use. Default:
  `latest`.
- `src`: *(Optional)* An override for the `--src` parameter in
  `viash ns list`. Example: `src/`.

## Examples

``` yaml
name: demo of generate-documentation-qmd

on:
  pull_request:

jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: viash-io/viash-actions/setup@v3
    - uses: actions/checkout@v3
    - uses: viash-io/viash-actions/generate-documentation-qmd@v3
      with:
        project_dir: ./
        src: src
        output_dir: /website/components
        dest_path: "{type}s/{namespace}/{name}.qmd"
        git_repo: openpipelines-bio/openpipelines
        token: ${{ secrets.GTHB_PAT }}
        tools_version: main_build
```
