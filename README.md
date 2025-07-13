<h1 align="center">
  <img src="./spounge.webp" alt="Spounge Logo" width="80" style="border-radius: 15px;" />
  <br/>
  Spounge – Centralized Protocol Buffers
    <p align="center">
        <a href="https://github.com/spoungeai/spounge-proto/actions/workflows/build.yml">
            <img
            src="https://img.shields.io/github/actions/workflow/status/spoungeai/spounge-proto/build.yml?label=Build&style=flat-square&color=brightgreen"
            alt="Build"
            style="border-radius:4px;" />
        </a>
        <a href="https://www.npmjs.com/package/@spounge/proto-ts">
            <img
            src="https://img.shields.io/npm/v/@spounge/proto-ts?label=%40spounge%2Fproto-ts&style=flat-square&color=blue"
            alt="@spounge/proto-ts"
            style="border-radius:4px;" />
        </a>
        <a href="https://opensource.org/licenses/MIT">
            <img
            src="https://img.shields.io/badge/License-MIT-blue?style=flat-square"
            alt="MIT License"
            style="border-radius:4px;" />
        </a>
        <a href="./CHANGELOG.md">
            <img
            src="https://img.shields.io/badge/Changelog-Available-blue?style=flat-square"
            alt="Changelog"
            style="border-radius:4px;" />
        </a>
    </p>

</h1>


## About

**Spounge-Proto** is the canonical repository for all Protocol Buffer (`.proto`) definitions powering data contracts and gRPC service interfaces throughout the Spounge AI ecosystem.

Designed primarily for our large language model (LLM) workflows, this repository serves as a universal translator for Protobuf schemas, enabling seamless communication between microservices implemented in various languages and platforms.

Automated code generation ensures consistent, type-safe clients for Go and TypeScript, minimizing integration errors and speeding up development.

## Table of Contents

- [Key Features](#key-features)
- [Getting Started](#getting-started)
  - [Quick Start with Docker](#quick-start-with-docker)
  - [Local Setup (Without Docker)](#local-setup-without-docker)
- [Usage](#usage)
  - [Go Module](#go-module)
  - [TypeScript Package](#typescript-package)
- [Development](#development)
- [Running Tests](#running-tests)
- [License](#license)
- [Contact](#contact)

---

## Key Features

- 🔑 **Single Source of Truth**: Centralized `.proto` files under `proto/` ensure all teams build from the same, authoritative schema.
- 🛠️ **Automatic Client Generation**: Generate idiomatic Go and TypeScript client libraries with zero manual effort.
- 🚀 **Containerized Workflow**: Use Docker and Makefiles for reproducible builds, linting, testing, and generation.
- 🔄 **Cross-Platform Consistency**: Guarantees uniform API contracts between backend and frontend.
- 📦 **CI/CD Friendly**: Pre-configured GitHub Actions automate build, test, and release pipelines.

---

## Getting Started

### Quick Start with Docker

Make sure you have [Docker](https.www.docker.com/get-started) installed.

```bash
# Clone the repo
git clone [https://github.com/spoungeai/spounge-proto.git](https://github.com/spoungeai/spounge-proto.git)
cd spounge-proto

# Build the Docker image and generate clients
make docker-setup
````

Generated clients will be in the `gen/` directory.

### Local Setup (Without Docker)

Install required tools locally:

  * [Go 1.24.1+](https://golang.org/dl/)
  * [Node.js 24.2.0+](https://nodejs.org/en/download/)
  * npm (comes with Node.js)

Install protoc plugins and dependencies:

```bash
make install-tools
```

After editing `.proto` files, regenerate clients:

```bash
make gen       # regenerate all clients (Go + TypeScript)
make gen-go    # regenerate Go client only
make gen-ts    # regenerate TypeScript client only
```

-----

## Usage

### Go Module

Add the Go client to your project:

```bash
go get [github.com/spoungeai/spounge-proto/gen/go@vX.Y.Z](https://github.com/spoungeai/spounge-proto/gen/go@vX.Y.Z)
```

Import and use the generated clients:

```go
package main

import (
    "context"
    "log"

    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials/insecure"
    "google.golang.org/protobuf/types/known/structpb"

    polykeyv1 "[github.com/spoungeai/spounge-proto/gen/go/polykey/v1](https://github.com/spoungeai/spounge-proto/gen/go/polykey/v1)"
)

func main() {
    conn, err := grpc.Dial("localhost:50051", grpc.WithTransportCredentials(insecure.NewCredentials()))
    if err != nil {
        log.Fatalf("failed to connect: %v", err)
    }
    defer conn.Close()

    client := polykeyv1.NewPolykeyServiceClient(conn)

    params, err := structpb.NewStruct(map[string]interface{}{
        "prompt": "Tell me a joke about gRPC.",
    })
    if err != nil {
        log.Fatalf("failed to create struct: %v", err)
    }

    resp, err := client.ExecuteTool(context.Background(), &polykeyv1.ExecuteToolRequest{
        ToolName:   "joke_generator",
        Parameters: params,
        UserId:     "user-12345",
    })
    if err != nil {
        log.Fatalf("ExecuteTool RPC failed: %v", err)
    }

    log.Printf("Status: %s", resp.GetStatus().GetMessage())
    log.Printf("Output: %s", resp.GetStringOutput())
}
```

### TypeScript Package

Install via npm or yarn:

```bash
npm install @spounge/proto-ts
# or
yarn add @spounge/proto-ts
```

Example usage with gRPC-Web:

```typescript
import { PolykeyServiceClient } from '@spounge/proto-ts/polykey/v1/polykey.client';
import { GrpcWebFetchTransport } from '@protobuf-ts/grpcweb-transport';
import { Struct } from '@spounge/proto-ts/google/protobuf/struct';

const transport = new GrpcWebFetchTransport({
  baseUrl: 'http://localhost:8080',
});

const client = new PolykeyServiceClient(transport);

async function executeTool() {
  try {
    const request = {
      toolName: 'joke_generator',
      parameters: Struct.fromJson({ prompt: 'Tell me a joke about TypeScript.' }),
      userId: 'user-abcde',
    };

    const call = await client.executeTool(request);
    const response = call.response;

    console.log('Status:', response.status?.message);
    console.log('Output:', response.output.oneofKind === 'stringOutput' ? response.output.stringOutput : 'N/A');
  } catch (error) {
    console.error('RPC error:', error);
  }
}

executeTool();
```

-----

## Development

Add or update `.proto` files in `proto/`, then regenerate clients. Submit a pull request.

## Running Tests

Testing has been moved to individual microservices that consume this repository. Since Protobuf definitions are shared across services, each service is responsible for validating its own integration and usage of the generated clients.

## License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE).

## Contact

🧽 For questions, support, or to report bugs, please open an issue or contact the maintainers at [dev@spounge.com](mailto:dev@spounge.com).
