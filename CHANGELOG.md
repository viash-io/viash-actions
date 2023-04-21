# viash-actions v3.1.0

# New features

* `pro/generate-documentation-qmd`: Added `working_directory` option. 

## Bug fixes

* `project/detect-changed-components`: Use `path` and `parent` to detect a component's resources.

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