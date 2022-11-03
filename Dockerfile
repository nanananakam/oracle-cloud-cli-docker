FROM debian:11-slim

ARG KUBECTL_ARCH
ARG AWSCLI_ARCH

RUN apt-get update && apt-get -y install curl jq unzip\
    && curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/$KUBECTL_ARCH/kubectl" \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-$AWSCLI_ARCH.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip && rm awscliv2.zip \
    && ./aws/install \
    && curl -OL https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh \
    && chmod a+x ./install.sh \
    && ./install.sh --accept-all-defaults --exec-dir /usr/local/bin \
    && rm ./install.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*