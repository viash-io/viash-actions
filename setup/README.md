# setup

Setup a Viash release (https://github.com/viash-io/viash/releases) using GitHub Actions.

## Usage

This action will use `wget get.viash.io` to install Viash in the `$HOME/.local/bin` directory and add that folder to the PATH.

We recommend using a Linux or MacOS runner if possible.

### Inputs available

* `version` - _optional_. If provided, the specific Viash version will be installed. Ex: `version: 0.6.0`.

  ```yaml
    steps:
      - uses: viash-io/viash-actions/setup@v1
        with:
          version: 0.6.0
  ```
  
  If not provided, `setup` will use the latest _released_ version of Viash.
  
  If the latest development build is desired, use `version: develop`.

* `registry` - _optional_. Which Docker registry to use in the Docker image name. Setting the value to `ghcr.io` is recommended.

  ```yaml
    steps:
      - uses: viash-io/viash-actions/setup@v1
        with:
          registry: ghcr.io
  ```

* `organization` - _optional_. Which organization name to use in the Docker image name. Setting the value to your github organization is recommended.

  ```yaml
    steps:
      - uses: viash-io/viash-actions/setup@v1
        with:
          organization: viash-io
  ```

* `target_image_source` - _optional_. Which image source to specify in the component builds. Setting it to this git repo is recommended.

  ```yaml
    steps:
      - uses: viash-io/viash-actions/setup@v1
        with:
          target_image_source: https://github.com/openpipelines-bio/openpipeline
  ```

## Examples

```yaml
name: viash-setup

on: 
  branch: main

jobs:
  viash-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1
      - run: |
          viash --version
  viash-windows:
    runs-on: windows-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1
      - run: |
          viash --version
  viash-macos:
    runs-on: macos-latest
    steps:
      - uses: viash-io/viash-actions/setup@v1
      - run: |
          viash --version
```

