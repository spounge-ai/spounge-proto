# spounge-proto-py

Generated protobuf Python packages for Spounge AI ecosystem microservices.

## About

This package contains auto-generated Python protobuf code from the canonical Spounge Protocol Buffer definitions. It powers data contracts and gRPC service interfaces throughout the Spounge AI ecosystem, designed primarily for large language model (LLM) workflows and microservices communication.

## Installation

```bash
pip install spounge-proto-py
```

### Optional Dependencies

For LangChain integration:
```bash
pip install spounge-proto-py[langchain]
```

For graph functionality:
```bash
pip install spounge-proto-py[graph]
```

For development:
```bash
pip install spounge-proto-py[dev]
```

## Usage

After installation, import the generated protobuf modules:

```python
from py.api.v2 import auth_gateway_service_pb2
from py.auth.v2 import auth_service_pb2
from py.common.v1 import common_pb2

# Create authentication request
auth_request = auth_service_pb2.LoginRequest(
    email="user@example.com",
    password="secure_password"
)

# Use with gRPC client
import grpc
from py.api.v2 import auth_gateway_service_pb2_grpc

channel = grpc.insecure_channel('localhost:8080')
client = auth_gateway_service_pb2_grpc.AuthGatewayServiceStub(channel)
```

## Architecture

The protobuf definitions are organized by domain and version:

- `py.api.v*` - Public API Gateway interfaces
- `py.auth.v*` - Authentication and authorization services  
- `py.common.v*` - Shared definitions and types
- `py.workflow.v*` - LLM workflow orchestration
- `py.dashboard.v*` - Analytics and reporting

## Python Compatibility

| Python Version | Support Status |
|----------------|----------------|
| 3.9 | ✅ Fully Supported |
| 3.10 | ✅ Fully Supported |
| 3.11 | ✅ Fully Supported |
| 3.12 | ✅ Fully Supported |
| 3.13 | ✅ Fully Supported |

## Development

This package contains auto-generated protobuf Python code. The source `.proto` files
are maintained in the [spounge-proto repository](https://github.com/spoungeai/spounge-proto).

### Local Development

```bash
# Install with development dependencies
pip install -e .[dev]

# Run tests
pytest

# Format code
black .
isort .

# Type checking  
mypy .
```

## License

MIT License - see LICENSE file for details.
