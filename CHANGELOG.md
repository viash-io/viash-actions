# viash-actions v2.0.0

## New Features

* Added [build_nextflow_schemas](build_nextflow_schemas) - Build schemas from a viash config to use with nf-tower

* Added [build_nextflow_params](build_nextflow_params) - build nextflow parameter file templates (see nextflow's -params-file option) from viash configs

## Major changes

* [ns-list](ns-list): Added arguments `query_namespace`, `query_name`, `platform`,
  `config_mod`, `format` and `parse_argument_groups` to make the action more in line with the
  arguments of `viash ns list`.

* [ns-list](ns-list): Added the `output_file` argument that allows writing the output for this action to a file.

* [setup](setup): Remove parameters that should be specified in `_viash.yaml`.

## Breaking changes

* [ns-list](ns-list): Renamed the output variable from `components_json` to simply `output`.
  The default format is `format: yaml`, set to `format: json` to restore the previous
  behaviour.

# viash-actions v1.0.0

Initial release. Contains the following actions:

* [setup](setup): Install Viash
* [ns-list](ns-list): List components in repo