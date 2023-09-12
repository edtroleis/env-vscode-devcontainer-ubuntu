FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG TERRAFORM_VERSION=1.5.5-1
ARG TERRAFORM_DOCS_VERSION=v0.16.0
ARG TFLINT_VERSION=v0.47.0
ARG CHECKOV_VERSION=2.4.1
ARG INFRACOST_VERSION=v0.10.28
ARG AZCLI_VERSION=2.52.0-1~jammy
ARG KUBECTL_VERSION=v1.28.0
ARG LINKCHECKER_VERSION=1.4.0
ARG ANSIBLE_VERSION=8.3.0
ARG PACKER_VERSION=1.9.4-1
ARG ARGOCD_CLI_VERSION=v2.8.3
ARG HOME_DIR=/data

USER root

RUN apt update \
  && apt install -y software-properties-common \
  gnupg \
  gnupg2 \
  apt-transport-https \
  ca-certificates \
  lsb-release \
  vim \
  curl \
  unzip \
  python3-pip \
  jq \
  bash-completion \
  git \
  tree \
  bash-completion \
  traceroute \
  iputils-ping

# Terraform - to view available version terraform: 'apt-cache policy terraform'
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
&& apt update \
&& apt install terraform=${TERRAFORM_VERSION} \
&& terraform -install-autocomplete

# Terraform docs
RUN curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-$(uname)-amd64.tar.gz \
  && tar -xzf terraform-docs.tar.gz \
  && chmod +x terraform-docs \
  && mv terraform-docs /usr/bin/terraform-docs \
  && terraform-docs completion bash > ~/.terraform-docs-completion \
  && rm terraform-docs.tar.gz

# tflint
ADD ./scripts/tflint.hcl ${HOME_DIR}/.tflint.hcl
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/${TFLINT_VERSION}/install_linux.sh | bash \
  && tflint --init

# Checkov
RUN pip3 install checkov==${CHECKOV_VERSION}

# infracost - get api key: 'infracost configure get api_key'
RUN curl -fsSL https://raw.githubusercontent.com/infracost/infracost/${INFRACOST_VERSION}/scripts/install.sh | sh

# azcli - to view available version az cli: 'apt-cache policy azure-cli'
RUN mkdir -p /etc/apt/keyrings \
  && curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null \
  && chmod go+r /etc/apt/keyrings/microsoft.gpg \
  && AZ_REPO=$(lsb_release -cs) \
  && echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
  && apt update \
  && apt install azure-cli=${AZCLI_VERSION}

# docker cli
RUN install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
  && chmod a+r /etc/apt/keyrings/docker.gpg \
  && echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt update && apt install -y docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  && curl -L https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > /etc/bash_completion.d/docker \
  && curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

# kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
  && kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null \
  && chmod a+r /etc/bash_completion.d/kubectl

# Hashicorp Packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
  && apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  && apt update \
  && apt install -y packer=${PACKER_VERSION}

# Ansible
RUN pip3 install ansible==${ANSIBLE_VERSION}

# Argo CD cli - versions from https://github.com/argoproj/argo-cd/releases
RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_CLI_VERSION}/argocd-linux-amd64 \
  && install -m 555 argocd-linux-amd64 /usr/local/bin/argocd \
  && rm argocd-linux-amd64

# Linkchecker for Markdown-based static generated sites - https://pypi.org/project/linkcheckmd/
# RUN pip3 install linkcheckmd==${LINKCHECKER_VERSION}

# WORKDIR ${HOME_DIR}

# USER vscode
