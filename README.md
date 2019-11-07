# Using Pivotal Build Service CLI as a Docker image

This project builds a Docker image which contains
the [Pivotal Build Service](https://content.pivotal.io/blog/pivotal-build-service-now-alpha-assembles-and-updates-containers-in-kubernetes)
CLI.

This image is often used with CI/CD tools, when you need access to the `pb` CLI.

## How to use it?

This image contains the `pb` CLI as an entrypoint.

Run this Docker image, just like `pb`:
```bash
$ docker run --rm alexandreroman/pb-cli:0.0.3 help
Usage:
  pb [command]

Available Commands:
  api
  help        Help about any command
  image       Image commands
  login       Log user in
  logout      Log user out
  secrets     Secret commands
  team        Team commands
  version     Show CLI and targeted build service version

Flags:
  -h, --help   help for pb

Use "pb [command] --help" for more information about a command.
```

The `pb` CLI is available in `PATH`, so you can also invoke the command
from within the container.

For example, you can use this Docker image in a [Concourse](https:/concourse-ci.org) task:
```yaml
- task: deploy
  config:
    platform: linux
    image_resource:
      type: docker-image
      source:
        repository: alexandreroman/pb-cli
        tag: 0.0.3
    inputs:
      - name: source-code
    run:
      path: /bin/bash
      args:
      - -c
      - |
        cat > image.yml << EOF
        team: myteam
        source:
          git:
            url: http://github.com/myorg/myapp.git
            revision: master
        image:
          tag: registry.myorg.com/myorg/myapp
        EOF
        export BUILD_SERVICE_USERNAME=((build-username))
        export BUILD_SERVICE_PASSWORD=((build-password))
        pb api set ((build-target)) --skip-ssl-validation
        pb login
        pb image apply -f image.yml
```

## Contribute

Contributions are always welcome!

Feel free to open issues & send PR.

## License

Copyright &copy; 2019 [Pivotal Software, Inc](https://pivotal.io).

This project is licensed under the [Apache Software License version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
