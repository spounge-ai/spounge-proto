<div align="center">
  <img src="./SpoungeBordered.png" alt="Spounge Logo" width="80" />

  <h1>Spounge – Centralized Protocol Buffers</h1>

  <p>
    The canonical repository of Protocol Buffer definitions powering Spounge AI ecosystem services.
  </p>

  <p>
    <a href="https://github.com/spoungeai/spounge-proto/actions/workflows/build.yml">
      <img src="https://img.shields.io/github/actions/workflow/status/spoungeai/spounge-proto/build.yml?label=Build&style=flat&color=brightgreen" alt="Build" />
    </a>
    <a href="https://www.npmjs.com/package/@spounge/proto-ts">
      <img src="https://img.shields.io/npm/v/@spounge/proto-ts?label=%40spounge%2Fproto-ts&style=flat&color=blue" alt="@spounge/proto-ts" />
    </a>
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/badge/License-MIT-blue?style=flat" alt="MIT License" />
    </a>
    <a href="./CHANGELOG.md">
      <img src="https://img.shields.io/badge/Changelog-Available-blue?style=flat" alt="Changelog" />
    </a>
  </p>
</div>


## About

**Spounge-Proto** is the canonical repository for all Protocol Buffer (`.proto`) definitions powering data contracts and gRPC service interfaces throughout the Spounge AI ecosystem.

Designed primarily for our large language model (LLM) workflows, this repository serves as a universal translator for Protobuf schemas, enabling seamless communication between microservices implemented in various languages and platforms.

Automated code generation ensures consistent, type-safe clients for Go and TypeScript, minimizing integration errors and speeding up development.



## Table of Contents

- [Overview](#1-overview)
- [Key Features](#2-key-features)
- [Getting Started](#3-getting-started)
- [Calling the API](#4-calling-the-api)
- [Proto Design Conventions](#5-proto-design-conventions)
- [Code Generation](#6-code-generation)
- [Best Practices](#7-best-practices)
- [Testing the API](#8-testing-the-api)
- [CI/CD Integration](#9-cicd-integration)
- [Contributing to the API](#10-contributing-to-the-api)
- [License](#11-license)
- [Contact](#12-contact)
- [References & Tool Links](#13-references--tool-links)



## 1. Overview

This project utilizes Protocol Buffers (Protobuf) to define a strongly-typed, language-agnostic API layer for our microservices architecture. This API serves as the primary communication contract between our backend services and various clients (web, mobile, other services).

**Purpose of the API:**  
To provide a unified, versioned, and performant interface for interacting with core business domains such as authentication, user management, workflow orchestration, and dashboard analytics. It ensures data consistency and reliability across our distributed system.

**Systems it Connects or Powers:**  
This API layer forms the backbone for inter-service communication within our microservices, powers our web frontends (via gRPC-Web/Connect-Web), and provides a robust contract for any future third-party integrations.

**General Architecture:**  
The project operates within a monorepo structure, where `.proto` files are centrally managed. Services are implemented as independent microservices, communicating via gRPC. An API Gateway exposes a subset of these gRPC services over HTTP/REST for external consumption.



## 2. Key Features

- 🔑 **Single Source of Truth**: Centralized `.proto` files under `proto/` ensure all teams build from the same, authoritative schema.
- 🛠️ **Automatic Client Generation**: Generate idiomatic Go and TypeScript client libraries with zero manual effort.
- 🚀 **Containerized Workflow**: Use Docker and Makefiles for reproducible builds, linting, testing, and generation.
- 🔄 **Cross-Platform Consistency**: Guarantees uniform API contracts between backend and frontend.
- 📦 **CI/CD Friendly**: Pre-configured GitHub Actions automate build, test, and release pipelines.



## 3. Getting Started

To work with the Protobuf definitions and generate client/server code, ensure you have the following prerequisites installed.

### Prerequisites

- **Go**: [Installation Guide](https://go.dev/doc/install) (Go 1.24+ recommended)  
- **Node.js**: [Installation Guide](https://nodejs.org/en/download/) (LTS version recommended)  
- **`protoc`** (Protocol Buffer Compiler): [Installation Guide](https://grpc.io/docs/protoc-installation/) (v3.20.0+ recommended)  
- **`buf`** (Protobuf CLI): [Installation Guide](https://docs.buf.build/installation) (v1.x.x+ recommended)  
- **Docker**: [Installation Guide](https://docs.docker.com/get-docker/) (for containerized workflow)

### Setup Instructions for Code Generation

All code generation is orchestrated via the project's `Makefile`. The `generate_pb.sh` script is invoked by these make commands.

#### Clone the Repository:

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

#### Quick Start with Docker:

```bash
make docker-setup
```

This builds the Docker image and generates all clients inside the container.

#### Local Setup (Without Docker):

```bash
make install-tools
```

Installs required Go and TypeScript Protobuf plugins.

#### Run the Generation Command:

```bash
make gen
```

This will:
- Update buf dependencies
- Clean existing generated code
- Generate Go code (`gen/go`)
- Generate TypeScript code (`gen/ts`)
- Generate OpenAPI definitions (`gen/openapi`)
- Tidy Go modules

### Folder Layout

- `proto/`: All `.proto` source files
- `proto/<domain>/<version>/`: Domain-specific definitions (e.g., `auth/v1/`)
- `proto/common/v1/`: Shared definitions
- `proto/api/v1/`: Public-facing API Gateway definitions
- `gen/`: All auto-generated code  
  - `gen/go/`: Go Protobuf messages and gRPC/Connect clients/servers  
  - `gen/ts/`: TypeScript Protobuf messages and Connect-Web clients  
  - `gen/openapi/`: OpenAPI (Swagger) specs for HTTP Gateway  



## 4. Calling the API

Supported via gRPC (Go) and Connect-Web (TypeScript), with optional HTTP/REST gateway.

### Tooling Used

- **Go**: `google.golang.org/protobuf`, `google.golang.org/grpc`, `connectrpc.com/connect`, `grpc-gateway`
- **TypeScript**: `@bufbuild/protobuf`, `@connectrpc/connect`, `@connectrpc/connect-web`

### Go Example

<details>
<summary>Click to expand Go example</summary>

```go
package main

import (
	"context"
	"log"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/metadata"

	apiv1 "github.com/spounge-ai/spounge-protos/gen/go/api/v1"
	authv1 "github.com/spounge-ai/spounge-protos/gen/go/auth/v1"
)

func main() {
	conn, err := grpc.Dial("localhost:8080", grpc.WithTransportCredentials(insecure.NewCredentials()), grpc.WithBlock())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	authClient := apiv1.NewAuthGatewayServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*5)
	defer cancel()

	ctx = metadata.AppendToOutgoingContext(ctx, "authorization", "Bearer your_auth_token_here")
	ctx = metadata.AppendToOutgoingContext(ctx, "x-request-id", "unique-request-id-123")

	coreLoginReq := &authv1.LoginRequest{
		Email:    "test@example.com",
		Password: "SecurePassword123",
	}

	gatewayLoginReq := &apiv1.AuthGatewayServiceLoginRequest{
		LoginRequest: coreLoginReq,
	}

	res, err := authClient.Login(ctx, gatewayLoginReq)
	if err != nil {
		log.Fatalf("could not login: %v", err)
	}

	log.Printf("Login successful! Token: %s", res.GetLoginResponse().GetToken())
}
```

</details>

### TypeScript Example

<details>
<summary>Click to expand TypeScript example</summary>

```ts
import { createConnectTransport } from '@bufbuild/connect-web';
import { AuthGatewayServiceLoginRequest, AuthGatewayServiceLoginResponse } from '../gen/ts/api/v1/auth_gateway_service';
import { LoginRequest as CoreLoginRequest } from '../gen/ts/auth/v1/auth_service';
import { AuthGatewayServiceClient } from '../gen/ts/api/v1/auth_gateway_service.client';

const transport = createConnectTransport({
  baseUrl: 'http://localhost:8080',
  interceptors: [
    (next) => async (req) => {
      req.header.set('Authorization', 'Bearer YOUR_AUTH_TOKEN');
      return next(req);
    },
  ],
});

const authClient = new AuthGatewayServiceClient(transport);

async function performLogin() {
  try {
    const coreLoginRequest = new CoreLoginRequest({
      email: 'webuser@example.com',
      password: 'AnotherSecurePassword!',
    });

    const gatewayLoginRequest = new AuthGatewayServiceLoginRequest({
      loginRequest: coreLoginRequest,
    });

    const response: AuthGatewayServiceLoginResponse = await authClient.login(gatewayLoginRequest);

    console.log('Login successful! Token:', response.loginResponse?.token);
  } catch (error) {
    console.error('Login failed:', error);
  }
}

performLogin();
```

</details>

### Metadata & Errors

- **Metadata/Auth**:
  - Go: `metadata.AppendToOutgoingContext(...)`
  - TypeScript: Use `createConnectTransport` interceptors
- **Errors**:
  - Go: Use `status.FromError(err)`
  - TS: Caught as `ConnectError` objects



## 5. Proto Design Conventions

Our Protobuf schema adheres to a set of conventions to ensure consistency, clarity, and maintainability.

### Versioning

- All packages are versioned (e.g., `package api.v1;`)
- For breaking changes, create a new versioned package (e.g., `v2`), keeping `v1` stable for existing clients

### Field Modifiers

- `repeated`: For lists/arrays
- `optional`: For scalar fields that may or may not be set (better semantics, clearer intent)
- `oneof`: Used when only one field in a group can be set

### Naming Standards

| Element                  | Convention                              | Example                              |
|--||--|
| **Package Names**        | `lower.snake.case`                       | `api.v1`                             |
| **Service Names**        | `PascalCase` ending in `Service`         | `AuthGatewayService`                |
| **RPC Method Names**     | `PascalCase`                             | `Login`, `GetUserProfile`          |
| **Messages (API Gateway)** | `ServiceNameMethodNameRequest/Response` | `AuthGatewayServiceLoginRequest`   |
| **Field Names**          | `lower_snake_case`                       | `workflow_id`                       |
| **Enum Names**           | `PascalCase`                             | `ExecutionStatus`                  |
| **Enum Values**          | `ALL_UPPER_SNAKE_CASE` w/ enum prefix    | `EXECUTION_STATUS_UNSPECIFIED`     |

### Imports & Modularity

- Keep `.proto` files modular and clean
- Import only what's necessary (e.g., `auth_service.proto` inside `auth_gateway_service.proto`)



## 6. Code Generation

Code generation is fully automated using `buf` and custom tooling.

### 🛠️ Common Commands

```bash
# Generate both Go and TypeScript clients
make gen

# Generate Go only
make gen-go

# Generate TypeScript only
make gen-ts

# Run generation inside Docker
make docker-gen
make docker-gen-go
make docker-gen-ts
```

### 🧩 Tools Used

| Tool / Plugin | Purpose |
|||
| `protoc`      | Core protobuf compiler (indirect via `buf`) |
| `buf`         | Linter, formatter, code generation orchestrator |
| `buf.build/protocolbuffers/go` | Go message generation |
| `buf.build/grpc/go`           | Go gRPC stubs |
| `buf.build/grpc-ecosystem/gateway` | Go HTTP/REST gateway stubs |
| `buf.build/connectrpc/go`     | Go Connect stubs |
| `buf.build/bufbuild/es`       | TS messages + Connect-Web clients |
| `buf.build/grpc-ecosystem/openapiv2` | OpenAPI v2 specs |
| `ts_imports.sh`               | Post-process TS output (index files) |
| `update_ts_package.js`       | Generate `package.json` and `tsconfig.json` in `gen/ts` |



## 7. Best Practices

### 🔁 Evolving APIs Safely

- **Only Add Fields**: No removals or renames in v1
- **Do Not Reuse Field Numbers**: Use `reserved <number>` when deprecating
- **Use `optional`** for new or nullable fields
- **Use Versioning** (`v2`, etc.) for breaking changes
- **Use `buf breaking`** in CI to prevent breaking changes

### 💬 Documentation

- Comment every service, RPC, message, and field
- Use `//` comments above definitions to include in docs

### 🔒 Forward Compatibility

- Use strict linting (`buf lint`)
- Clients should gracefully handle unknown fields



## 8. Testing the API

Testing is critical for maintaining reliability.

### 🔍 Local Testing

#### gRPC (`grpcurl`)

```bash
# List available services
grpcurl localhost:8080 list

# Test login RPC
grpcurl -plaintext -d '{"loginRequest": {"email": "test@example.com", "password": "password"}}'   localhost:8080 api.v1.AuthGatewayService/Login
```

#### HTTP/REST (`curl`)

```bash
curl -X POST -H "Content-Type: application/json"   -d '{"loginRequest": {"email": "test@example.com", "password": "password"}}'   http://localhost:8080/v1/auth/login
```

### 🧪 Integration Testing

- Spin up local services + gateway
- Use mocks for gRPC/Connect in tests

### 🧰 Test Commands

```bash
make test-go   # Runs Go tests in tests/go
make test-ts   # Runs TypeScript tests in tests/ts
```



## 9. CI/CD Integration

CI ensures correctness, stability, and style compliance.

### ✅ CI Checks

- `buf lint`: Protobuf style and structure
- `buf breaking`: Prevent breaking changes
- `make gen`: Ensures code is regenerated before commit

```yaml
# Example CI step
- name: Lint Protobuf
  run: buf lint

- name: Check for Breaking Changes
  run: buf breaking --against 'main'
```

Generated code is checked into the repo for clarity and reproducibility.



## 10. Contributing to the API

### 📜 Protobuf Rules

- All changes to existing `v1` files **must be backward compatible**
- Use `optional`, `repeated`, and unique field numbers
- Never remove or reuse field numbers (`reserved` instead)
- Do not change field types
- New services/RPCs are always welcome

### 🧼 Formatting & Linting

```bash
# Format .proto files
buf format -w proto/

# Lint .proto files
make lint
```

### 🔍 Review & PR Process

- All `.proto` changes go through a PR
- PRs must pass all CI checks
- Review required from a designated API owner or senior engineer



## 11. License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).



## 12. Contact

🧽 For questions, support, or to report bugs:

- Open an issue
- Contact maintainers: [dev@spounge.com](mailto:dev@spounge.com)



## 13. References & Tool Links

- [Buf Documentation](https://buf.build/docs)
- [Buf Style Guide](https://buf.build/docs/style-guide)
- [Buf Lint Rules](https://buf.build/docs/lint-overview)
- [Buf Breaking Detection](https://buf.build/docs/breaking-overview)
- [Protocol Buffers](https://protobuf.dev/)
- [Proto3 Language Guide](https://protobuf.dev/programming-guides/proto3/)
- [API Best Practices](https://cloud.google.com/apis/design)
- [gRPC Docs](https://grpc.io/docs/)
- [ConnectRPC Docs](https://connectrpc.com/docs)
- [grpc-gateway GitHub](https://github.com/grpc-ecosystem/grpc-gateway)
- [grpcurl GitHub](https://github.com/fullstorydev/grpcurl)