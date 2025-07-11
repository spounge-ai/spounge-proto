# Use official Go Alpine image
FROM golang:1.24-alpine

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    unzip \
    make \
    nodejs \
    npm \
    git

# Set environment variables
ENV PROTOC_VERSION=31.1
ENV PATH="/go/bin:/usr/local/bin:${PATH}"

# Install protoc
RUN curl -Lo /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip \
    && unzip /tmp/protoc.zip -d /usr/local \
    && rm /tmp/protoc.zip

# Verify protoc installed
RUN protoc --version

# Install Go plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Install ts-proto globally
RUN npm install -g ts-proto

# Set working directory
WORKDIR /app

# Cache go and npm dependencies separately (faster rebuilds)
COPY go.mod go.sum ./
RUN go mod download

COPY package.json package-lock.json ./
RUN npm ci

# Copy the rest of the source code
COPY . .

# Default to bash for interactive container
CMD ["bash"]
