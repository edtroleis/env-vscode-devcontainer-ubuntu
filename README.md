# Dev Container

A **development container** is a running container with a well-defined tool/runtime stack and its prerequisites.

The Visual Studio Code Dev Containers extension lets you use a container as a full-featured development environment. It allows you to open any folder inside (or mounted into) a container and take advantage of Visual Studio Code's full feature set.

# Softwares installed in dev container

- [Terraform](https://www.terraform.io/)
- [terraform-docs](https://terraform-docs.io/)
- [tflint](https://github.com/terraform-linters/tflint-ruleset-azurerm)
- [checkov](https://www.checkov.io/)
- [Infracost](https://www.infracost.io/)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

# Setting up the development container

## 1. Requirements

- [vscode](https://code.visualstudio.com/)
- [dev container extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Docker

## 2. Clone dev container code

```
git clone ...
```

## Run dev container

- In vscode > ctrl + shift + p > Dev Container: Open Folder in Container...

![Alt text](./images/image1.png)

- Select cloned dev container code

![Alt text](./images/image2.png)

# References

- [Devloping inside a container](https://code.visualstudio.com/docs/devcontainers/containers)
- [Templates](https://containers.dev/templates)
- [Using images, Dockerfiles, and Docker Compose](https://containers.dev/guide/dockerfile)
