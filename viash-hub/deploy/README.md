# Deploy

This action will deploy/push build artifacts to Viash-Hub.
The functionality is greatly inspired by `peaceiris/actions-gh-pages@v3` but tweaked and minimized for our use case.

## Usage

This action will deploy/pull a branch from a repository and replace all content with the available build artifacts from the pipeline.

If the `github_repo` is specified, the action will first pull the branch from the GitHub repository and then push it to the Viash-Hub repository.
If the `github_repo` is not specified, the action will first pull the branch from the Viash-Hub repository and then push it back to the Viash-Hub repository.

### Inputs available

  `github_token`: GitHub token.
  `viash_hub_token`: Viash-Hub token.
  `viash_hub_repo`: user/repo_name on Viash-Hub.
  `github_repo`: user/repo_name on GitHub from where to get the base branch information.
  `src-branch`: Source Git branch name.
  `dest-branch`: Destination Git branch name.
  `commit-message`: Override the commit message for the deployment.

## Examples

```yaml
name: demo of viash-hub/push
on:
  pull_request:
jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: viash-io/viash-actions/setup@v4

    - uses: actions/checkout@v3
      with:
        fetch-depth: 0

    - uses: viash-io/viash-actions/ns-build@v4
      with:
        parallel: true        

    - name: Deploy to Viash-Hub
      uses: viash-io/viash-actions/viash-hub/push@v4
      with:
        github_token: ${{ github.token }}
        viash_hub_token: ${{ secrets.VIASHHUB_PAT }}
        viash_hub_repo: openpipelines-bio/openpipeline
        github_repo: openpipelines-bio/openpipeline
        src-branch: main_build
        dest-branch: main_build
```