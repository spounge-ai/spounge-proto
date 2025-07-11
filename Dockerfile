# Use official Go Alpine image
FROM golang:1.24-alpine

# Set environment variables
ENV PROTOC_VERSION=31.1
ENV PATH="/go/bin:/usr/local/bin:$PATH"

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    unzip \
    make \
    nodejs \
    npm \
    git

# Install protoc
RUN curl -sSL -o /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip \
    && unzip /tmp/protoc.zip -d /usr/local \
    && rm -rf /tmp/protoc.zip

# Install Go plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Install ts-proto globally and clean npm cache
RUN npm install -g ts-proto \
    && npm cache clean --force

# Set working directory
WORKDIR /app

# Cache Go dependencies
COPY go.mod go.sum ./
RUN go mod download

# Cache npm dependencies
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy remaining project files
COPY . .

# Default command
CMD ["bash"]
