# Reusable GitHub Actions workflows


## Test components

``` {yaml}
name: Test components

on:
  pull_request:
  push:
    branches:
      - main
      - master

jobs:
  test:
    uses: viash-io/viash-actions/.github/workflows/test.yaml@add-working-dir-input
```

## Build components

``` {yaml}
name: Build components

on:
  push:
    branches:
      - main
      - master
  workflow_dispatch:
    inputs:
      version:
        description: |
          The version of the project to build. Example: `1.0.3`.

          If not provided, a development build with a version name
          based on the branch name will be built. Otherwise, a release
          build with the provided version will be built.
        required: false
      retag_image_tag:
        description: |
          A previously known tag that was used to build the Docker
          images. When provided, these images will be retagged and
          reused for the current build. This is useful when creating
          bug fix releases where the Docker images are known to be
          working.
        required: false

jobs:
  test:
    uses: viash-io/viash-actions/.github/workflows/build.yaml@add-working-dir-input
```
