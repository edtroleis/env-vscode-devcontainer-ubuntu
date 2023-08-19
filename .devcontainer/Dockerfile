FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG TERRAFORM_VERSION=1.5.5-1
ARG TERRAFORM_DOCS_VERSION=v0.16.0
ARG TFLINT_VERSION=v0.47.0
ARG CHECKOV_VERSION=2.4.1
ARG INRACOST_VERSION=v0.10.28
ARG AZCLI_VERSION=2.51.0-1~jammy
ARG KUBECTL_VERSION=v1.28.0
ARG HOME_DIR=/data

USER root

RUN apt update \
  && apt install -y software-properties-common gnupg gnupg2 \
  apt-transport-https ca-certificates lsb-release \
  curl \
  unzip \
  python3-pip \
  jq \
  bash-completion \
  git \
  tree \
  bash-completion

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
RUN curl -fsSL https://raw.githubusercontent.com/infracost/infracost/${INRACOST_VERSION}/scripts/install.sh | sh

# WORKDIR ${HOME_DIR}

# CMD ["/bin/bash", "-c"]
# ENTRYPOINT [ "/bin/bash", "-c" ]

# Check internet
# curl -Is www.google.com | head -n 1

# USER vscode

# azcli - to view available version az cli: 'apt-cache policy azure-cli'
RUN mkdir -p /etc/apt/keyrings \
  && curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null \
  && chmod go+r /etc/apt/keyrings/microsoft.gpg \
  && AZ_REPO=$(lsb_release -cs) \
  && echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
  && apt-get update \
  && apt-get install azure-cli=${AZCLI_VERSION}

# docke cli
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
