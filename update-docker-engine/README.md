# Install or Update Latest Available Docker 

Install the latest Docker Engine or update an existing one to the latest available version.
Note that this action only works on Ubuntu based images.


## Examples

```yaml
name: demo of update-docker-engine

on:
  push:

jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3

    - uses: viash-io/viash-actions/update-docker-engine@v3
```
