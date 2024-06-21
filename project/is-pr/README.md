# Is PR

Check whether the branch has a PR and if this run was triggered by a push event.

## Usage

This action will check whether the branch has a PR and if this run was triggered by a push event.

### Outputs

- `check`: Returns "true" if the branch has a PR and this run was not triggered by a push event, else "false".

### Examples

```yaml
name: Is PR

on:
  push:
  pull_request:

jobs:
  is-pr:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: viash-io/viash-actions/is-pr@v1
        id: is_pr
      - run: |
          echo "Is PR: ${{ steps.is_pr.outputs.check }}"
```
