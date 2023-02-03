# Sync and Cache S3 Bucket

A GitHub Action to sync an S3 bucket to a local folder and create a cache.

For now, this will only be able to sync public S3 buckets.

## Inputs

  * `s3_bucket`: (Required) Path to an S3 bucket.
  * `dest_path`: (Required) Where to store the data.
  * `cache_key_prefix`: (Optional) A prefix for the cache hash key. Prefix is also used for restoring stale cache if no cache hit occurred for key. Default value is `cachekey__`.

## Outputs

  * `cache_key`: The caching key, which is the hash of the contents of the S3 bucket.

## Examples

```yaml
name: demo of sync-and-cache-s3

on:
  push:

jobs:
  demo:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    - uses: viash-io/viash-actions/sync-and-cache-s3
      with:
        s3_bucket: s3:/mybucket/resources
        dest_path: resources
```
