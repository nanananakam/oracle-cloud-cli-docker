FROM debian:11-slim

ARG ARCH

RUN apt-get update && apt-get -y install curl jq apt-transport-https gnupg2 unzip\
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y kubectl \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && rm awscliv2.zip \
    && ./aws/install \
    && curl -OL https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh \
    && chmod a+x ./install.sh \
    && ./install.sh --accept-all-defaults --exec-dir /usr/local/bin \
    && rm ./install.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*