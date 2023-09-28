This template references an image that was [pre-built](https://containers.dev/implementors/reference/#prebuilding) to automatically include needed devcontainer.json metadata.

- **Image**: mcr.microsoft.com/devcontainers/base:ubuntu ([source](https://github.com/devcontainers/images/tree/main/src/base-ubuntu))
- **Applies devcontainer.json contents from image**: Yes ([source](https://github.com/devcontainers/images/blob/main/src/base-ubuntu/.devcontainer/devcontainer.json))

# VSCode extensions

```
code --list-extensions
code --install-extension hashicorp.terraform
```

# Ubuntu packages

```
apt search package_name                 # search package
apt update                              # update apt database
apt install package_name=version        # install package using specific version
apt remove package_name                 # remove package
apt list | grep python3.11              # check if package python3.11 is available to install
apt install --reinstall <package-name>  # reinstall package already installed
```

# Check internet connection

```
curl -Is www.google.com | head -n 1
```
