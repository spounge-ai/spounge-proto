#!/usr/bin/env python3

import os
import sys
from pathlib import Path

def create_init_files(base_path: Path):
    """Create __init__.py files in directories containing Python files"""
    created_files = []
    for root, dirs, files in os.walk(base_path):
        root_path = Path(root)
        init_file = root_path / "__init__.py"
        py_files = [f for f in files if f.endswith('.py') and f != '__init__.py']
        if py_files and not init_file.exists():
            init_file.touch()
            created_files.append(str(init_file))
            print(f"Created: {init_file}")
    return created_files

def create_packaging_files(gen_py_path: Path):
    """Create packaging files directly in gen/py directory"""
    
    # The key fix: configure setuptools to find packages correctly
    pyproject_content = '''[build-system]
requires = ["setuptools>=80.9.0", "wheel>=0.45.1"]
build-backend = "setuptools.build_meta"


[project]
name = "spounge-proto-py"
version = "0.2.3"
description = "Generated protobuf Python packages for Spounge AI ecosystem microservices"
readme = "README.md"
license = {text = "MIT"}
authors = [
    {name = "Spounge AI Team", email = "dev@spounge.com"}
]
keywords = [
    "protobuf", "grpc", "microservices", "spounge", "ai"
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
    "pytest>=8.4.1"
]

[project.urls]
Homepage = "https://github.com/spoungeai/spounge-proto"
Repository = "https://github.com/spoungeai/spounge-proto"

# CRITICAL: Define parent table BEFORE sub-tables
[tool.setuptools]
zip-safe = false

# This tells setuptools how to find your packages
[tool.setuptools.packages.find]
# Look for packages in current directory (gen/py)
where = ["."]
# Include everything that looks like a Python package
include = ["*"]
# Don't package these
exclude = ["tests*", "build*", "dist*", "*.egg-info*"]

# Include .proto files in the package
[tool.setuptools.package-data]
"*" = ["*.proto"]
'''

    readme_content = '''# spounge-proto-py

Generated protobuf Python packages for Spounge AI ecosystem microservices.

## Installation

```bash
pip install spounge-proto-py
```

## Usage

```python
# Import your generated protobuf modules
from api.v2 import auth_gateway_service_pb2
from auth.v2 import auth_service_pb2
from common.v1 import common_pb2

# Create requests
auth_request = auth_service_pb2.LoginRequest(
    email="user@example.com", 
    password="password"
)

# Use with gRPC
import grpc
from api.v2 import auth_gateway_service_pb2_grpc

channel = grpc.insecure_channel('localhost:8080')
client = auth_gateway_service_pb2_grpc.AuthGatewayServiceStub(channel)
```

## Package Structure

Your protobuf modules are organized by domain and version:
- `api.v*` - API Gateway interfaces
- `auth.v*` - Authentication services
- `common.v*` - Shared definitions  
- `workflow.v*` - Workflow orchestration
- `dashboard.v*` - Analytics

## License

MIT License
'''

    manifest_content = '''include README.md
include LICENSE
include pyproject.toml
recursive-include * *.py
recursive-include * *.proto
global-exclude __pycache__
global-exclude *.py[co]
global-exclude .DS_Store
global-exclude *.egg-info
global-exclude build
global-exclude dist
'''

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
            f.write(content.strip())
        created_files.append(str(file_path))
        print(f"Created: {file_path}")
    
    return created_files

def main():
    current_dir = Path.cwd()
    gen_py_path = current_dir / "gen" / "py"
    
    # Try to find gen/py directory
    if not gen_py_path.exists() and current_dir.name == "scripts":
        gen_py_path = current_dir.parent / "gen" / "py"
    
    if not gen_py_path.exists():
        search_path = current_dir
        for _ in range(5):
            test_path = search_path / "gen" / "py"
            if test_path.exists():
                gen_py_path = test_path
                break
            search_path = search_path.parent
            if search_path == search_path.parent:
                break
    
    if not gen_py_path.exists():
        print(f"Error: Could not find gen/py directory!")
        print(f"Searched from: {current_dir}")
        sys.exit(1)
    
    print(f"Processing directory: {gen_py_path}")
    print("="*50)
    
    print("\n1. Creating missing __init__.py files...")
    init_files = create_init_files(gen_py_path)
    if init_files:
        print(f"Created {len(init_files)} __init__.py files")
    else:
        print("No new __init__.py files needed")
    
    print("\n2. Creating packaging configuration files...")
    packaging_files = create_packaging_files(gen_py_path)
    print(f"Created {len(packaging_files)} packaging files")
    
    print(f"\n✅ Package preparation complete!")
    
    print("\n" + "="*50)
    print("PACKAGING INSTRUCTIONS:")
    print("="*50)
    print(f"1. cd {gen_py_path}")
    print("2. python -m build")
    print()
    print("To check what will be packaged:")
    print("3. tar -tzf dist/*.tar.gz  # Check source distribution contents")
    print("4. twine check dist/*      # Validate packages")
    print()
    print("To upload (test first!):")
    print("5. twine upload --repository testpypi dist/*")
    print("6. pip install --index-url https://test.pypi.org/simple/ spounge-proto-py")
    print()
    print("If test looks good:")
    print("7. twine upload dist/*")

if __name__ == "__main__":
    main()