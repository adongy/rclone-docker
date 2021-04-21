FROM debian:buster-slim AS builder

RUN apt-get update && apt-get install -y gpg curl unzip

WORKDIR /tmp

COPY nick.asc /tmp
RUN gpg --import /tmp/nick.asc

# Fetch latest stable version
RUN set -eux; \
    version=$(curl -fsSL https://downloads.rclone.org/version.txt | cut -d' ' -f2); \
    curl -fsSLO "https://downloads.rclone.org/${version}/rclone-${version}-linux-amd64.zip"; \
    curl -fsSLO "https://downloads.rclone.org/${version}/SHA256SUMS"; \
    gpg --verify --trust-model always --output=- SHA256SUMS | grep "rclone-${version}-linux-amd64.zip" > checksums; \
    sha256sum --check checksums --strict; \
    unzip -j -a "rclone-${version}-linux-amd64.zip"

FROM gcr.io/distroless/base-debian10

USER nonroot:nonroot
WORKDIR /data
ENV XDG_CONFIG_HOME=/config
COPY --from=builder /tmp/rclone /usr/local/bin/rclone

CMD ["/usr/local/bin/rclone"]
