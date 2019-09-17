FROM ubuntu:xenial as builder
ARG PIVNET_CLI_URL=https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.63/pivnet-linux-amd64-0.0.63
ARG PIVNET_TOKEN=changeme
ARG PBS_CLI_VERSION=0.0.2

RUN apt-get update && apt-get install -y wget
RUN wget "${PIVNET_CLI_URL}" -O /usr/local/bin/pivnet && chmod +x /usr/local/bin/pivnet
RUN pivnet login --api-token "${PIVNET_TOKEN}"
RUN pivnet download-product-files --accept-eula -p build-service -r "${PBS_CLI_VERSION}" -g "pb-*-linux" -d /usr/local/bin \
    && mv "/usr/local/bin/pb-${PBS_CLI_VERSION}-linux" /usr/local/bin/pb && chmod +x /usr/local/bin/pb

FROM ubuntu:xenial
COPY --from=builder /usr/local/bin/pb /bin/pb
CMD [ "/bin/pb" ]
