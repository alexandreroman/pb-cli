# Pivotal Build Service CLI as a Concourse resource

This project builds a [Concourse](https://concourse-ci.org) resource which contains
a [Pivotal Build Service](https://content.pivotal.io/blog/pivotal-build-service-now-alpha-assembles-and-updates-containers-in-kubernetes)
CLI tool.

## How to use it?

This image contains the `pb` CLI, that you can use from a Concourse task:
```yaml
---
platform: linux

image_resource:
  type: docker-image
  source: {repository: alexandreroman/pb-cli-resource}

inputs:
- name: some-important-input

run:
  path: pb
  args: ['api', 'set', 'http://build.pks.fqdn.com']
```

## Contribute

Contributions are always welcome!

Feel free to open issues & send PR.

## License

Copyright &copy; 2019 [Pivotal Software, Inc](https://pivotal.io).

This project is licensed under the [Apache Software License version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
