# viash-actions v5.2.2

## Minor changes

* `project/detect-changed-components`: bump `tj-actions/changed-files` to `42.0.5` (PR #)

# viash-actions v5.2.1

## Bug Fixes

* `project/detect-changed-components`: fix changed components not being detected after updating `tj-actions/changed-files` (PR #25).

# viash-actions v5.2.0

## Minor changes

* `project/detect-changed-components`: bump `tj-actions/changed-files` to `42.0.2` (PR #24)

# viash-actions v5.1.0

## New functionality

* `pro/build-nextflow-schemas`: Add optional flag to allow dataset input for nf-tower (PR #23)

# viash-actions v5.0.0

## Breaking changes

* `ns-build` and `ns-list`: update to node20 (PR #20).

## Minor changes

* Update `actions/checkout@v3` to `actions/checkout@v4` and `actions/cache@v3` to `actions/cache@v4` (PR #20).

* Update several node dependencies (PR #20).

# viash-actions v4.1.1

## Minor changes

* `viash-hub/deploy`: Add a `commit_message` input parameter to allow specifying the commit message for the deployment.

* `viash-hub/deploy`: Fix dash in `src-branch` and `dest-branch` to underscore, now `src_branch` and `dest_branch`. Like any other parameter.

# viash-actions v4.1.0

## Minor changes

* `ns-build`, `ns-list`: Allow `config_mod` to be used as multiline text. Each line will become a separate `--config_mod` parameter.

## New functionality

* `viash-hub/deploy`: Add an action to deploy build artifacts from GitHub to Viash-Hub.

# viash-actions v4.0.0

## Breaking changes

* `pro/generate-documentation-qmd`: Renamed `working_directory` to `project_directory`, and renamed `input_dir` to `src` (#17).

# viash-actions v3.2.1

## Bug fixes

* `setup`: Add fallback to downloading the Viash installer (#18).

# viash-actions v3.2.0

## New features

* Added `update-docker-engine` (#15).

# viash-actions v3.1.2

## Bug fixes

`setup`: Fetch Viash from `dl.viash.io` instead of deprecated `get.viash.io`.

# viash-actions v3.1.1

## Bug fixes

`pro/generate-documentation-qmd`: Avoid building .qmd files for the components in the `viash_tools` repository by cloning it into `RUNNER_TEMP`.

# viash-actions v3.1.0

## New features

* `pro/generate-documentation-qmd`: Added `working_directory` option. 

## Bug fixes

* `project/detect-changed-components`: Refactor component resource detection.

# viash-actions v3.0.0

## New features

* Added `project/sync-and-cache-s3`: Sync and cache an S3 bucket.

* Added `project/detect-changed-components`: Filter a json produced by `ns-list` such that
  only components whose resources have changed in comparison to the default branch
  are retained.

## Minor changes

* `ns-list`: No longer prints output to interactive console.

## Breaking changes

* `pro/build-nextflow-params`:
  - Renamed from `build-nextflow-params`.
  - Input `token` was renamed to `viash_pro_token`.

* `pro/build-nextflow-schemas`:
  - Renamed from `build-nextflow-schemas`.
  - Input `token` was renamed to `viash_pro_token`.

* `pro/generate-documentation-qmd`:
  - Renamed from `generate-documentation-qmd`.
  - Input `token` was renamed to `viash_pro_token`.

# viash-actions v2.0.0

## New features

* Added `ns-build` - Build a namespace from many viash config files.

* Added `build-nextflow-schemas` - Build schemas from a viash config to use with nf-tower

* Added `build-nextflow-params` - build nextflow parameter file templates (see nextflow's -params-file option) from viash configs

## Major changes

* `ns-list`: Added arguments `query_namespace`, `query_name`, `platform`,
  `config_mod`, `format` and `parse_argument_groups` to make the action more in line with the
  arguments of `viash ns list`.

* `ns-list`: Added the `output_file` argument that allows writing the output for this action to a file.

* `setup`: Remove parameters that should be specified in `_viash.yaml`.

## Breaking changes

* `ns-list`: Renamed the output variable from `components_json` to simply `output`.
  The default format is `format: yaml`, set to `format: json` to restore the previous
  behaviour.

# viash-actions v1.0.0

Initial release. Contains the following actions:

* `setup`: Install Viash
* `ns-list`: List components in repo
