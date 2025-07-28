<div align="center">
<picture>
  <source media="(prefers-color-scheme: light)" srcset="./docs/dark.svg">
  <img alt="spounge-protos-logo" src="./docs/light.svg" width="50%" height="50%"> 
</picture>

Protocol Buffer definitions repositoiry powering the [@Spounge](https://github.com/spounge-ai) ecosystem services.

[![Build](https://img.shields.io/github/actions/workflow/status/spoungeai/spounge-proto/build.yml?label=Build&style=flat&color=brightgreen)](https://github.com/spoungeai/spounge-proto/actions/workflows/build.yml)
[![Go Module Version](https://img.shields.io/github/v/tag/spoungeai/spounge-proto?label=proto-go&style=flat&color=17a2b8)](https://github.com/spoungeai/spounge-proto/releases/latest)
[![TypeScript Package](https://img.shields.io/npm/v/@spounge/proto-ts?label=proto-ts&style=flat&color=blue)](https://www.npmjs.com/package/@spounge/proto-ts)
[![Python Package](https://img.shields.io/pypi/v/spounge-proto-py?label=proto-py&style=flat&color=DAA520)](https://pypi.org/project/spounge-proto-py/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=flat)](https://opensource.org/licenses/MIT)
[![Changelog](https://img.shields.io/badge/Changelog-Available-blue?style=flat)](./docs/CHANGELOG.md)

</div>
<hr style="width: 100%; height: 4px; background-color: #888; border: none; margin: 2em auto 1em;" />
 
 
Universal schema translator for LLM microservices. Automated code generation for Go, TypeScript, and Python clients.

## Table of Contents

- [Quick Start](#quick-start)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage Examples](#usage-examples)
- [Code Generation](#code-generation)
- [Design Conventions](#design-conventions)
- [API Evolution Rules](#api-evolution-rules)
- [Testing](#testing)
- [Development Workflow](#development-workflow)
- [CI/CD Pipeline](#cicd-pipeline)
- [Prerequisites](#prerequisites)
- [Contact & Support](#contact--support)
- [References](#references)

## Quick Start

```bash
git clone https://github.com/spounge-ai/spounge-proto
cd spounge-proto
make docker-setup && make gen
```

## Installation

| Language | Command |
|----------|---------|
| Go | `go get github.com/spoungeai/spounge-proto@latest` |
| TypeScript | `npm install @spounge/proto-ts` |
| Python | `pip install spounge-proto-py` |

## Project Structure

```
proto/
├── <domain>/<version>/     # Domain definitions (auth/v1/)
├── common/v1/              # Shared definitions  
└── api/v1/                 # API Gateway definitions

gen/                        # Generated code
├── go/                     # Go protobuf + gRPC/Connect
├── ts/                     # TypeScript + Connect-Web
├── py/                     # Python protobuf
└── openapi/                # OpenAPI specs
```

## Usage Examples

<details>
<summary><strong>Go Client</strong></summary>

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
    conn, err := grpc.Dial("localhost:8080", 
        grpc.WithTransportCredentials(insecure.NewCredentials()),
        grpc.WithBlock())
    if err != nil {
        log.Fatalf("connection failed: %v", err)
    }
    defer conn.Close()

    client := apiv1.NewAuthGatewayServiceClient(conn)
    
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()
    
    ctx = metadata.AppendToOutgoingContext(ctx, 
        "authorization", "Bearer your_token",
        "x-request-id", "unique-request-id")

    req := &apiv1.AuthGatewayServiceLoginRequest{
        LoginRequest: &authv1.LoginRequest{
            Email:    "test@example.com",
            Password: "SecurePassword123",
        },
    }

    res, err := client.Login(ctx, req)
    if err != nil {
        log.Fatalf("login failed: %v", err)
    }

    log.Printf("Token: %s", res.GetLoginResponse().GetToken())
}
```
</details>

<details>
<summary><strong>TypeScript Client</strong></summary>

```typescript
import { createConnectTransport } from '@bufbuild/connect-web';
import { AuthGatewayServiceClient } from '../gen/ts/api/v1/auth_gateway_service.client';
import { AuthGatewayServiceLoginRequest } from '../gen/ts/api/v1/auth_gateway_service';
import { LoginRequest } from '../gen/ts/auth/v1/auth_service';

const transport = createConnectTransport({
    baseUrl: 'http://localhost:8080',
    interceptors: [
        (next) => async (req) => {
            req.header.set('Authorization', 'Bearer YOUR_TOKEN');
            return next(req);
        },
    ],
});

const client = new AuthGatewayServiceClient(transport);

async function login() {
    try {
        const request = new AuthGatewayServiceLoginRequest({
            loginRequest: new LoginRequest({
                email: 'user@example.com',
                password: 'SecurePassword!',
            }),
        });

        const response = await client.login(request);
        console.log('Token:', response.loginResponse?.token);
    } catch (error) {
        console.error('Login failed:', error);
    }
}
```
</details>

## Code Generation

| Command | Purpose |
|---------|---------|
| `make gen` | Generate all clients |
| `make gen-go` | Go only |
| `make gen-ts` | TypeScript only |
| `make gen-py` | Python only |
| `make docker-gen` | Docker-based generation |

## Design Conventions

### Naming Standards

| Element | Convention | Example |
|---------|------------|---------|
| Packages | `lower.snake.case` | `api.v1` |
| Services | `PascalCase` + `Service` | `AuthGatewayService` |
| RPC Methods | `PascalCase` | `Login`, `GetUserProfile` |
| Messages | `ServiceMethodRequest/Response` | `AuthGatewayServiceLoginRequest` |
| Fields | `lower_snake_case` | `workflow_id` |
| Enums | `PascalCase` | `ExecutionStatus` |
| Enum Values | `PREFIX_VALUE_NAME` | `EXECUTION_STATUS_PENDING` |

### Field Modifiers

- `repeated` - Arrays/lists
- `optional` - Nullable scalars (recommended for new fields)
- `oneof` - Mutually exclusive field groups

## API Evolution Rules

| ✅ Allowed | ❌ Breaking Changes |
|------------|-------------------|
| Add new fields, services, methods | Remove/rename fields, services, methods |
| Add `optional` fields | Change field types or numbers |
| Add enum values (append only) | Reorder enum values |

## Testing

<details>
<summary><strong>gRPC Testing</strong></summary>

```bash
# List services
grpcurl localhost:8080 list

# Test RPC
grpcurl -plaintext -d '{
    "loginRequest": {
        "email": "test@example.com", 
        "password": "password"
    }
}' localhost:8080 api.v1.AuthGatewayService/Login
```
</details>

<details>
<summary><strong>HTTP/REST Testing</strong></summary>

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"loginRequest": {"email": "test@example.com", "password": "password"}}' \
  http://localhost:8080/v1/auth/login
```
</details>

| Command | Purpose |
|---------|---------|
| `make test-go` | Go integration tests |
| `make test-ts` | TypeScript client tests |
| `make test-py` | Python client tests |

## Development Workflow

1. Edit `.proto` files following conventions
2. `buf format -w proto/` - Format
3. `make lint` - Lint
4. `make gen` - Generate
5. `make test` - Test
6. Commit (include generated code)

## CI/CD Pipeline

- Protobuf linting (`buf lint`)
- Breaking change detection (`buf breaking --against origin/main`)
- Code generation verification
- Client library testing

## Prerequisites

| Tool | Version | Installation |
|------|---------|-------------|
| Go | 1.24+ | [go.dev/doc/install](https://go.dev/doc/install) |
| Node.js | LTS | [nodejs.org](https://nodejs.org/en/download/) |
| protoc | v3.20.0+ | [grpc.io/docs/protoc-installation](https://grpc.io/docs/protoc-installation/) |
| buf | v1.x.x+ | [docs.buf.build/installation](https://docs.buf.build/installation) |
| Docker | Latest | [docs.docker.com/get-docker](https://docs.docker.com/get-docker/) |

## Contact & Support

- **Issues**: GitHub Issues
- **Support**: dev@spounge.com
- **License**: MIT

## References

<details>
<summary><strong>Documentation Links</strong></summary>

**Protocol Buffers & gRPC**
- [Protocol Buffers Documentation](https://protobuf.dev/)
- [Proto3 Language Guide](https://protobuf.dev/programming-guides/proto3/)
- [gRPC Documentation](https://grpc.io/docs/)

**Buf Ecosystem**
- [Buf Documentation](https://buf.build/docs)
- [Buf Style Guide](https://buf.build/docs/style-guide)
- [Buf Lint Rules](https://buf.build/docs/lint-overview)

**Connect & Gateway**
- [ConnectRPC Documentation](https://connectrpc.com/docs)
- [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)

**API Design**
- [Google API Design Guide](https://cloud.google.com/apis/design)
</details>