# Optimized Dockerfile - focuses on biggest performance wins
FROM alpine:3.19

ENV PROTOC_VERSION=31.1
ENV PATH="/usr/local/go/bin:/go/bin:/usr/local/bin:$PATH"
ENV GOPATH="/go"

# Install system dependencies
RUN apk add --no-cache \
    bash curl unzip make git ca-certificates \
    nodejs npm python3 py3-pip

# Install Go binary (much faster than building)
RUN ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/') && \
    curl -sSL "https://go.dev/dl/go1.24.1.linux-${ARCH}.tar.gz" | \
    tar -xz -C /usr/local

# Install buf binary
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
        x86_64) BUF_ARCH=Linux-x86_64 ;; \
        aarch64) BUF_ARCH=Linux-aarch64 ;; \
    esac && \
    curl -sSL "https://github.com/bufbuild/buf/releases/latest/download/buf-${BUF_ARCH}" \
        -o /usr/local/bin/buf && chmod +x /usr/local/bin/buf

# Install protoc binary
RUN ARCH=$(uname -m | sed 's/aarch64/aarch_64/') && \
    curl -sSL "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-${ARCH}.zip" \
        -o /tmp/protoc.zip && \
    unzip -q /tmp/protoc.zip -d /usr/local && \
    rm /tmp/protoc.zip && chmod +x /usr/local/bin/protoc

# THE BIG WIN: Pre-compile Go tools in a cached layer
# This avoids the expensive go install step on every build
RUN mkdir -p /go/bin && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest && \
    go clean -cache -modcache

WORKDIR /app

# Better caching: install dependencies before copying source
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund

COPY gen/go/go.mod gen/go/go.sum ./gen/go/
RUN cd gen/go && go mod download

# Copy source last (changes most frequently)
COPY . .

CMD ["bash"]