This template references an image that was [pre-built](https://containers.dev/implementors/reference/#prebuilding) to automatically include needed devcontainer.json metadata.

- **Image**: mcr.microsoft.com/devcontainers/base:ubuntu ([source](https://github.com/devcontainers/images/tree/main/src/base-ubuntu))
- **Applies devcontainer.json contents from image**: Yes ([source](https://github.com/devcontainers/images/blob/main/src/base-ubuntu/.devcontainer/devcontainer.json))

# Sharing ssh keys with Dev Container
This dev container is configured to mount local ssh keys in container. To do this put all desired ssh keys and config files into local_home_dir/.ssh. Example c:\Users\edtro\\.ssh

# VSCode extensions

```bash
code --list-extensions
code --install-extension hashicorp.terraform
```

# Ubuntu packages

```bash
apt search package_name                 # search package
apt update                              # update apt database
apt install package_name=version        # install package using specific version
apt remove package_name                 # remove package
apt list | grep python3.11              # check if package python3.11 is available to install
apt install --reinstall <package-name>  # reinstall package already installed
```

# Windows local home
```powershell
ls Env:         # list all local Windows environment variables
```

# Check internet connection

```
curl -Is www.google.com | head -n 1
```
