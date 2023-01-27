# generate_documentation_qmd

Create quarto markdown files for viash components or workflows, based on a jinja template.

## Usage

This action will look for viash configs for workflows and components in a directory, 
and will apply information for each of these configs to a jinja template to generate qmd files.
This component required Viash to be installed and available in `$PATH`. We recommend to use [viash-actions/setup](https://github.com/viash-io/viash-actions/tree/main/setup) before you run `generate_documentation_qmd`.

We recommend using a Linux or MacOS runner if possible.

### Inputs available

* `input_dir` - 'Directory contain viash configs for components and workflows, together with the build components in a target folder. Will most often be a repository that has been cloned in a previous step of your workflow using [checkout](https://github.com/marketplace/actions/checkout). Ex: `.`.

* `component_template` - _optional_. Path pointing to Jinja template that can be used to customize the resulting qmd files. By default will use a default included template. An example of a template can be found at the bottom of this page.

* `output_dir`: 'Output folder to write the qmd files to. If you wish to output to another repository, you can use [checkout](https://github.com/marketplace/actions/checkout) to fetch that repo and write to repository clone.'

* `dest_path` - _optional_. Template for the location of the qmd files. Can contain `{type}`, `{namespace}` and `{name}` wildcards to create a custom folder hierarchy for storing the output for different components. Default: `"{type}s/{namespace}/{name}.qmd"`

* `git_tag` - _optional_. A git tag or branch. Used to create links to the source code in the generated documentation. Default: tag of the current branch. Ex: `0.2.0`

* `git_repo` - _optional_. Github repository. Used to create links to the source code in the generated documentation.
Must use format "owner/repo-name". Will default to the repo where this action is being run for. Ex: `openpipelines-bio/openpipeline`

* `write_index` - _optional_. Whether or not to also create a quarto index file that joins the different pages for the components and workflows. Options are `'true'` or `'false'`.

* `token` - Personal access token (PAT) used to fetch the viash tools repository.

* `tools_version` - _optional_. Release of Viash tools to use. Will use the latest release by default. Ex: `main_build`


## Examples

```yaml
name: demo of generate_documentation_qmd

on:
  pull_request:

jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: viash-io/viash-actions/setup@v1.0.0
    - uses: actions/checkout@v3
      with:
        fetch-depth: 0

    - name: Get changed files
      id: changed-files
      uses: tj-actions/changed-files@v34

    - name: List all changed files
      run: |
        for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
          echo "$file was changed"
        done
    
    - uses: actions/checkout@v3
      with:
        repository: openpipelines-bio/website
        path: openpipelines-website
        
    - uses: actions/checkout@v3
      with:
        repository: openpipelines-bio/openpipeline
        path: openpipelines
        ref: "main_build"

    - uses: viash-io/viash-actions/generate_documentation_qmd@generate_documentation_qmd
      with:
        input_dir: openpipelines
        output_dir: openpipelines-bio/website/components
        dest_path: "{type}s/{namespace}/{name}.qmd"
        git_repo: openpipelines-bio/openpipelines
        token: ${{ secrets.GTHB_PAT }}
        tools_version: main_build
        

```

# Example template

````

---
title: "{{functionality.info.name}}"
namespace: "{{functionality.info.namespace}}"
description: "{{functionality.info.short_description}}"
type: "{{info.type}}"
toc: false
---

::: {.column-margin}

### Info

ID: `{{functionality.name}}`{{'  '}}
{%- if functionality.namespace is defined %}
Namespace: `{{functionality.namespace}}`
{%- endif %}

{%- if render.source_url is defined %}

### Links
[Source]({{render.source_url}}){.btn-action .btn-sm .btn-info .btn role="button"}
{%- endif %}

:::

{{functionality.description}}

## Example commands

You can run the pipeline using `nextflow run`.

### View help

You can use `--help` as a parameter to get an overview of the possible parameters.

```bash
nextflow run {{par.git_repo}} \
  -r {{par.git_tag}} -latest \
  -main-script {{render.nf_path}} \
  --help
```

### Run command

<details>
<summary>Example of `params.yaml`</summary>
```yaml
{{render.params_yaml}}
```
</details>

```bash
nextflow run {{par.git_repo}} \
  -r {{par.git_tag}} -latest \
  -profile docker \
  -main-script {{render.nf_path}} \
  -params-file params.yaml
```

:::{.callout-note}
Replace `-profile docker` with `-profile podman` or `-profile singularity` depending on the desired backend.
:::

## Argument group{% if render.argument_groups|length > 1 %}s{% endif %}

{%- for group in render.argument_groups %}

### {{group.name}}

{%- if group.description is defined %}

{{group.description}}
{% endif %}

{{group.table_md}}
{% endfor %}

{%- if functionality.authors is defined %}
## Authors
{% for author in functionality.authors %}
  * {{author.name}}
    {%- if author.props.github is defined -%}
      {% raw %} [{{< fa brands github >}}{% endraw %}](https://github.com/{{author.props.github}})
    {%- endif -%}
    {%- if author.props.orcid is defined -%}
      {% raw %} [{{< fa brands orcid >}}{% endraw %}](https://orcid.org/{{author.props.orcid}})
    {%- endif -%}
    {%- if author.roles is defined and author.roles is not string -%}
      {{' '}}({{author.roles|join(", ")}})
    {%- endif -%}
    {%- if author.roles is defined and author.roles is string -%}
      {{' '}}({{author.roles}})
    {%- endif -%}
{% endfor %}
{% endif %}

{%- if render.graph is defined %}
## Visualisation

```{mermaid}
%%| column: screen-inset-shaded
{{render.graph}}
```
{%endif %}


````