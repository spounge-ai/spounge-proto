FROM golang:1.24-alpine

ENV PROTOC_VERSION=31.1
ENV PATH="/go/bin:/usr/local/bin:$PATH"

RUN apk add --no-cache \
    bash \
    curl \
    unzip \
    make \
    nodejs \
    npm \
    git

RUN ARCH=$(uname -m) && \
  case "$ARCH" in \
    x86_64) BUF_ARCH=buf-Linux-x86_64 ;; \
    aarch64 | arm64) BUF_ARCH=buf-Linux-aarch64 ;; \
    *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
  esac && \
  curl -sSL "https://github.com/bufbuild/buf/releases/latest/download/${BUF_ARCH}" \
    -o /usr/local/bin/buf && \
  chmod +x /usr/local/bin/buf

RUN curl -sSL -o /tmp/protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip" && \
    unzip -q /tmp/protoc.zip -d /usr/local && \
    chmod +x /usr/local/bin/protoc && \
    rm -rf /tmp/protoc.zip

RUN --mount=type=cache,target=/go/pkg/mod \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

RUN npm install -g ts-proto && \
    npm cache clean --force

WORKDIR /app

COPY gen/go/go.mod gen/go/go.sum ./gen/go/
WORKDIR /app/gen/go
RUN go mod download

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY . .
CMD ["bash"]
