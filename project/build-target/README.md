# Build the target directory

This action will build a target directory using the `viash ns build` command.

## Usage

This action will build a target directory using the `viash ns build` command. 

### Inputs

- `target_branch`: - *optional*. Branch to deploy to. If not specified, `build-${BRANCH_NAME}` will be used.
- `version`: - *optional*. Version name to use for the build. If not specified, `build-${BRANCH_NAME}` will be used.

### Outputs

- `docker_component_matrix`: Matrix of Docker components
- `component_matrix`: Matrix of components

### Examples

```yaml
name: demo of build-target

on: 
  branch: main

jobs:
  build-target:
    runs-on: ubuntu-latest
    steps:
      - uses: viash-io/viash-actions/setup@v3

      - id: build_target
        uses: viash-io/viash-actions/build-target@v5

      - run: |
          # view target directory
          ls -l target/

          # do something with the output
          echo "${{steps.build_target.outputs.docker_component_matrix}}"
          echo "${{steps.build_target.outputs.component_matrix}}"
```
