

# build-target

<!--
DO NOT EDIT THIS FILE MANUALLY!
This README was generated by running `make`
-->

Build a target directory using the viash ns build command and create a
matrix of the executables which have Docker containers that need to be
built.

### Inputs

- `project_directory`: - *optional*. Path to the project directory. This
  is the directory where the project config `_viash.yaml` is located.
- `version`: - *optional*. Version name to use for the build. If not
  specified, `${BRANCH_NAME}_build` will be used.
- `target_branch`: - *optional*. Branch to deploy to. If not specified,
  `${BRANCH_NAME}_build` will be used.
- `image_tag`: - *optional*. Force the built components to use a
  specific Docker image tag.
- `viash_pro_token`: - *optional*. Viash pro token

### Outputs

- `version`: The version that was used for the build.
- `target_branch`: The branch that the build was deployed to.
- `docker_matrix`: Matrix of executables for which Docker containers
  need to be built.

## Examples

``` yaml
name: Demo of build-target

on:
  push:
  pull_request:

jobs:
  demo:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: viash-io/viash-actions/setup@v6

      - name: Build target directory
        id: build_target
        uses: viash-io/viash-actions/build-target@v6

      - name: Check output
        run: |
          # view target directory
          ls -l target/

          # do something with the output
          echo "${{steps.build_target.outputs.docker_component_matrix}}"
          echo "${{steps.build_target.outputs.component_matrix}}"
```
