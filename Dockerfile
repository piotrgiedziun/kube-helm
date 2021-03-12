FROM alpine:3

ARG HELM_VERSION
ARG KUBECTL_VERSION

ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
ENV KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ADD ${KUBECTL_URL} /usr/local/bin/kubectl

RUN apk add --update --no-cache curl ca-certificates bash && \
    chmod +x /usr/local/bin/kubectl && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    apk del curl && \
    rm -f /var/cache/apk/*

WORKDIR /apps

CMD ["/bin/bash"]

# docker build --no-cache --build-arg KUBECTL_VERSION=1.18.8 --build-arg HELM_VERSION=3.3.0 -t piotrgiedziun/helm:3.3.0 .
# docker build --no-cache --build-arg KUBECTL_VERSION=1.19.3 --build-arg HELM_VERSION=3.5.2 -t piotrgiedziun/helm:3.5.2 .
