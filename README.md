# Github Actions for Viash

This repository stores [Github Actions](https://github.com/features/actions) useful for building and publishing [Viash](https://viash.io) documents.

1. [viash-io/viash-actions/setup](setup) - Install Viash
2. [viash-io/viash-actions/ns-list](ns-list) - List Viash components in a repository
3. [viash-io/viash-actions/ns-build](ns-build) - Build a namespace from many viash config files.

We recommend using `v2` for your actions.

## Release Management

This repository uses [GitHub's recommended release management for actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions#using-release-management-for-actions): 

* GitHub releases with tags are used for updates on the actions. 
* Semantic versioning is used, with major, minor and possibly patch release. 
* Major versions (such as `v1`) will always point to the last minor or patch release for this major version. (when `v1.0.2` is out, `v1` will point to this update to). This means using `viash-io/viash-actions/setup@v1` in your workflow file will automatically get the updated versions. Using `viash-io/viash-actions/setup@v1.0.2` will pin a specific release.
* Major version changes (`v1` to `v2`) will often come with breaking changes, and workflows might require manual updates.