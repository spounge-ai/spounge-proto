#!/usr/bin/env python3
"""
Script to prepare the gen/py directory for packaging as a Python module.
Can be run from the project root directory or any subdirectory.
"""

import os
import sys
from pathlib import Path

def create_init_files(base_path: Path):
    """Recursively create __init__.py files in all subdirectories."""
    created_files = []
    
    # Walk through all directories
    for root, dirs, files in os.walk(base_path):
        root_path = Path(root)
        init_file = root_path / "__init__.py"
        
        # Only create __init__.py if the directory contains .py files (excluding existing __init__.py)
        py_files = [f for f in files if f.endswith('.py') and f != '__init__.py']
        
        if py_files and not init_file.exists():
            init_file.touch()
            created_files.append(str(init_file))
            print(f"Created: {init_file}")
    
    return created_files

def create_packaging_files(gen_py_path: Path):
    """Create pyproject.toml and other packaging files in the gen/py directory."""
    
    # Create pyproject.toml (ONLY packaging file needed for modern Python)
    pyproject_content = '''
[build-system]
requires = ["setuptools>=80.9.0", "wheel>=0.45.1"]
build-backend = "setuptools.build_meta"

[project]
name = "spounge-proto-py"
version = "0.1.0"
description = "Generated protobuf Python packages for Spounge AI ecosystem microservices"
readme = "README.md"
license = {text = "MIT"}
authors = [
    {name = "Spounge AI Team", email = "dev@spounge.com"}
]
maintainers = [
    {name = "Spounge AI Team", email = "dev@spounge.com"}
]
keywords = [
    "protobuf",
    "grpc",
    "microservices",
    "spounge",
    "ai",
    "llm",
    "workflows",
    "authentication",
    "api-gateway"
]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
    "Programming Language :: Python :: 3.13",
    "Topic :: Software Development :: Libraries :: Python Modules",
    "Topic :: System :: Networking",
    "Topic :: Internet",
    "Topic :: Scientific/Engineering :: Artificial Intelligence",
    "Typing :: Typed"
]
requires-python = ">=3.9"
dependencies = [
    "protobuf>=6.31.1,<7.0.0",
    "grpcio>=1.74.0rc1,<2.0.0",
    "grpcio-tools>=1.73.1,<2.0.0"
]

[project.optional-dependencies]
dev = [
    "build>=1.2.2",
    "twine>=5.1.1",
    "pytest>=8.4.1",
    "pytest-cov>=6.2.1",
    "black>=25.1.0",
    "isort>=5.13.3",
    "mypy>=1.14.0"
]

[project.urls]
Homepage = "https://github.com/spoungeai/spounge-proto"
Repository = "https://github.com/spoungeai/spounge-proto"
Documentation = "https://github.com/spoungeai/spounge-proto#readme"
Changelog = "https://github.com/spoungeai/spounge-proto/blob/main/CHANGELOG.md"
"Bug Reports" = "https://github.com/spoungeai/spounge-proto/issues"

[tool.setuptools]
zip-safe = false

[tool.setuptools.packages.find]
where = ["."]
include = ["py*"]
exclude = ["tests*"]

[tool.setuptools.package-data]
"*" = ["*.proto"]

[tool.black]
line-length = 88
target-version = ["py39", "py310", "py311", "py312", "py313"]
include = '\.pyi?$'

[tool.isort]
profile = "black"
line_length = 88
multi_line_output = 3

[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
'''

    # Create README.md
    readme_content = '''# spounge-proto-py

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
'''

    # Create MANIFEST.in (still needed for including non-Python files)
    manifest_content = '''include README.md
include LICENSE
include pyproject.toml
recursive-include py *.py
recursive-include py *.proto
global-exclude __pycache__
global-exclude *.py[co]
global-exclude .DS_Store
global-exclude *.so
global-exclude .pytest_cache
global-exclude .mypy_cache
'''

    # Create LICENSE file
    license_content = '''MIT License

Copyright (c) 2025 Spounge AI Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'''

    files_to_create = [
        ('pyproject.toml', pyproject_content),
        ('README.md', readme_content),
        ('MANIFEST.in', manifest_content),
        ('LICENSE', license_content),
    ]

    created_files = []
    for filename, content in files_to_create:
        file_path = gen_py_path / filename
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        created_files.append(str(file_path))
        print(f"Created: {file_path}")
    
    return created_files

def main():
    """Main function to prepare the package."""
    # Get the current working directory (where the script is run from)
    current_dir = Path.cwd()
    
    # Try to find gen/py directory from current location
    # First, try from current directory (if running from root)
    gen_py_path = current_dir / "gen" / "py"
    
    # If not found and we're in scripts/, try parent directory
    if not gen_py_path.exists() and current_dir.name == "scripts":
        gen_py_path = current_dir.parent / "gen" / "py"
    
    # If still not found, try looking for gen/py in parent directories
    if not gen_py_path.exists():
        # Search up the directory tree for gen/py
        search_path = current_dir
        for _ in range(5):  # Don't search too far up
            test_path = search_path / "gen" / "py"
            if test_path.exists():
                gen_py_path = test_path
                break
            search_path = search_path.parent
            if search_path == search_path.parent:  # Reached filesystem root
                break
    
    if not gen_py_path.exists():
        print(f"Error: Could not find gen/py directory!")
        print(f"Searched from: {current_dir}")
        print("Make sure the gen/py/ directory exists in your project.")
        print("This script can be run from:")
        print("  - Project root directory (recommended)")
        print("  - scripts/ directory")
        print("  - Any subdirectory of the project")
        sys.exit(1)
    
    print(f"Processing directory: {gen_py_path}")
    
    # Create __init__.py files
    print("\n1. Creating missing __init__.py files...")
    init_files = create_init_files(gen_py_path)
    if init_files:
        print(f"Created {len(init_files)} __init__.py files")
    else:
        print("No new __init__.py files needed")
    
    # Create packaging files
    print("\n2. Creating packaging configuration files...")
    packaging_files = create_packaging_files(gen_py_path)
    print(f"Created {len(packaging_files)} packaging files")
    
    print(f"\n✅ Package preparation complete!")
    print(f"Directory {gen_py_path} is now ready for packaging.")
    print("\n" + "="*50)
    print("NEXT STEPS - PACKAGING & DEPLOYMENT:")
    print("="*50)
    print(f"1. cd {gen_py_path}")
    print("2. python -m build")
    print("3. twine check dist/*")
    print("4. twine upload dist/*  # Upload to PyPI")
    print()
    print("For TestPyPI (recommended first):")
    print("4a. twine upload --repository testpypi dist/*")
    print()
    print("Test installation:")
    print("pip install --index-url https://test.pypi.org/simple/ spounge-proto-py")

if __name__ == "__main__":
    main()