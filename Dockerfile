# Use official Go Alpine image
FROM golang:1.24-alpine

# Install required packages: bash, curl, unzip, make, nodejs, npm
RUN apk add --no-cache bash curl unzip make nodejs npm

# Set protoc version here (change as needed)
ENV PROTOC_VERSION=31.1

# Download and install protoc compiler from official release
RUN curl -Lo /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip \
    && unzip /tmp/protoc.zip -d /usr/local \
    && rm /tmp/protoc.zip

# Verify protoc installed correctly
RUN protoc --version

# Install Go protobuf plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Install ts-proto plugin globally via npm
RUN npm install -g ts-proto

# Ensure Go bin and npm global bin are in PATH
ENV PATH="/go/bin:/root/.npm-global/bin:/usr/local/bin:${PATH}"

# Set working directory inside container
WORKDIR /app

# Copy dependency files and install Go and npm dependencies
COPY go.mod go.sum package.json package-lock.json ./
RUN go mod download && npm ci

# Copy all source files (including proto files)
COPY . .

# Default command to keep container alive (override in docker run)
CMD ["bash"]
