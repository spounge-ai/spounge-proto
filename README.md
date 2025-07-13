# [AWAITING UPDATE (need to configure for correct installation and usage guide)]

# Spounge AI - Centralized Protocol Buffers

This repository is the definitive source of truth for the Protocol Buffer (Protobuf) definitions that govern data contracts and gRPC service interfaces across the Spounge AI ecosystem. It provides a robust framework for generating and distributing versioned, type-safe client libraries for Go and TypeScript, ensuring seamless and reliable communication between all microservices and applications.

## Key Capabilities

  - **Single Source of Truth**: Centralized schema management ensures all teams build from the same data contracts.
  - **Type-Safe Generation**: Automatically generate clients for Go and TypeScript, eliminating bugs at compile time.
  - **Automated Workflow**: Use `make` and Docker to reliably generate, lint, and test definitions and clients.
  - **Cross-Platform Consistency**: Guarantees that backend and frontend services speak the same language.
  - **Enterprise-Ready**: Versioned, linted, and designed for scalable CI/CD integration and deployment.

-----

## Quick Start

Get up and running with a single command using our Docker-based workflow (requires **Docker**):

```bash
# Clone the repository and navigate into it
git clone https://github.com/spoungeai/spounge-proto.git
cd spounge-proto

# Build the environment and generate all clients
make docker-setup
```

Alternatively, if you have **Go** and **Node.js** installed locally:

```bash
# Install local tooling
make install-tools

# Generate all clients
make generate
```

The generated code will be available in the `gen/` directory.

-----

## Go Module

This repository generates and publishes a native Go module for use in backend microservices.

### Installation

To add the module to your Go project, run:

```bash
go get github.com/spoungeai/spounge-proto@latest
```

### Usage

You can then import the generated packages and use the gRPC clients and message types directly in your application.

```go
import (
    "context"
    polykeypb "github.com/spoungeai/spounge-proto/gen/go/polykey/v1"
    "google.golang.org/grpc"
)

// <fill in with a detailed Go usage example,
// for instance, how to create a client and make a call.>

func main() {
    // ... setup gRPC connection
    client := polykeypb.NewPolykeyServiceClient(conn)
    res, err := client.YourMethod(context.Background(), &polykeypb.YourRequest{
        // ...
    })
}
```

### Resources

  - 📚 **Go Package Docs**: [pkg.go.dev/github.com/spoungeai/spounge-proto](https://www.google.com/search?q=https://pkg.go.dev/github.com/spoungeai/spounge-proto)

-----

## TypeScript NPM Package

A distributable NPM package is generated for use in frontend applications or Node.js services.

### Installation

To add the package to your project using **npm** or **yarn**:

```bash
npm install @spounge/proto-ts
```

### Usage

Import the generated clients and message types for use with a gRPC-Web transport like `@protobuf-ts/grpcweb-transport`.

```typescript
import { PolykeyServiceClient } from '@spounge/proto-ts/polykey/v1/polykey';
import { GrpcWebFetchTransport } from '@protobuf-ts/grpcweb-transport';
import type { YourRequest } from '@spounge/proto-ts/polykey/v1/polykey';


// <fill in with a detailed TypeScript usage example,
// showing transport setup and a client call.>

const transport = new GrpcWebFetchTransport({
  baseUrl: 'http://localhost:8080'
});

const client = new PolykeyServiceClient(transport);

const call = client.yourMethod({
    // ... request properties
});
```

### Resources

  - 📦 **NPM Package**: [npmjs.com/package/@spounge/proto-ts](https://www.google.com/search?q=https://www.npmjs.com/package/%40spounge/proto-ts)

-----

## Development & Contributing

Need to make a change to a `.proto` file?

1.  **Modify the `.proto` file** in the `proto/` directory.
2.  **Run `make generate`** to update the generated clients.
3.  **Submit a Pull Request** for review.

For more detailed instructions, see our **[Contributing Guide](https://www.google.com/search?q=%23fill-in-link-to-CONTRIBUTING.md)**.

### Support

Reach out to the team in the \<**\#fill-in-slack-channel**\> channel.

-----

## License

This project is licensed under the **MIT License**. See the [`LICENSE`](https://www.google.com/search?q=./LICENSE) file for full details.