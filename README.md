# Github Actions for Viash


This repository stores [Github
Actions](https://github.com/features/actions) useful for building and
publishing [Viash](https://viash.io) components:

    1. [viash-io/viash-actions/ns-build@v6](ns-build) - viash ns build
    1. [viash-io/viash-actions/ns-list@v6](ns-list) - viash ns list
    1. [viash-io/viash-actions/setup@v6](setup) - Setup Viash

There are also some actions that are commonly used in Viash projects:

    1. [viash-io/viash-actions/project/build-target@v6](project/build-target) - Build target directory
    1. [viash-io/viash-actions/project/detect-changed-components@v6](project/detect-changed-components) - Detect components with changed files
    1. [viash-io/viash-actions/project/is-pr@v6](project/is-pr) - Is PR
    1. [viash-io/viash-actions/project/sync-and-cache-s3@v6](project/sync-and-cache-s3) - Sync and cache an S3 bucket
    1. [viash-io/viash-actions/project/update-docker-engine@v6](project/update-docker-engine) - Update Docker Engine

Finally, there are some [Viash
Pro](https://www.data-intuitive.com/services/viashpro.html) actions:

    1. [viash-io/viash-actions/pro/build-nextflow-params@v6](pro/build-nextflow-params) - Build parameter yaml
    1. [viash-io/viash-actions/pro/build-nextflow-schemas@v6](pro/build-nextflow-schemas) - Build nf-tower schemas
    1. [viash-io/viash-actions/pro/generate-documentation-qmd@v6](pro/generate-documentation-qmd) - Build and publish qmd

We recommend using `v6` for your actions.

## Release Management

This repository uses [GitHub’s recommended release management for
actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions#using-release-management-for-actions):

- GitHub releases with tags are used for updates on the actions.
- Semantic versioning is used, with major, minor and possibly patch
  release.
- Major versions (such as `v1`) will always point to the last minor or
  patch release for this major version. (when `v1.0.2` is out, `v1` will
  point to this update to). This means using
  `viash-io/viash-actions/setup@v1` in your workflow file will
  automatically get the updated versions. Using
  `viash-io/viash-actions/setup@v1.0.2` will pin a specific release.
- Major version changes (`v1` to `v2`) will often come with breaking
  changes, and workflows might require manual updates.
