FROM alpine:3.16

ARG AWSCLI_ARCH
ARG KUBECTL_ARCH

RUN apk update && apk add --no-cache curl jq unzip\
    && curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/$KUBECTL_ARCH/kubectl" \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-$AWSCLI_ARCH.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && rm awscliv2.zip \
    && ./aws/install \
    && curl -OL https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh \
    && chmod a+x ./install.sh \
    && ./install.sh --accept-all-defaults --exec-dir /usr/local/bin \
    && rm ./install.sh \