#!/usr/bin/env python3
import os
from pathlib import Path

def is_valid_module(filename: str) -> bool:
    """Check if filename is a valid Python module (non-private, ends with .py, not __init__.py)."""
    return filename.endswith(".py") and not filename.startswith("_") and filename != "__init__.py"

def is_valid_package(directory: Path) -> bool:
    """Check if directory is a valid Python package (contains __init__.py)."""
    return (directory / "__init__.py").exists()

def generate_init_file(dir_path: Path):
    """Generate __init__.py that imports all modules and subpackages in dir_path."""
    if not dir_path.is_dir():
        return

    # Find Python modules and subpackages
    modules = sorted(f.stem for f in dir_path.iterdir() if f.is_file() and is_valid_module(f.name))
    subpackages = sorted(d.name for d in dir_path.iterdir() if d.is_dir() and is_valid_package(d))

    lines = []

    # Import subpackages
    for pkg in subpackages:
        lines.append(f"from . import {pkg}")

    # Import modules if any
    if modules:
        lines.append(f"from . import {', '.join(modules)}")

    all_items = sorted(subpackages + modules)
    if all_items:
        all_str = ", ".join(f'"{item}"' for item in all_items)
        lines.append(f"\n__all__ = [{all_str}]")

    init_file = dir_path / "__init__.py"
    with open(init_file, "w", encoding="utf-8") as f:
        f.write("# Auto-generated __init__.py\n")
        if lines:
            f.write("\n".join(lines) + "\n")
        else:
            f.write("# This package contains no modules or subpackages\n")

    print(f"Generated {init_file}")

def walk_and_generate(root_dir: Path):
    """Recursively walk root_dir and generate __init__.py files."""
    for current_dir, dirs, files in os.walk(root_dir):
        current_path = Path(current_dir)
        has_modules = any(is_valid_module(f) for f in files)
        has_packages = any(is_valid_package(current_path / d) for d in dirs)
        if has_modules or has_packages:
            generate_init_file(current_path)

def main():
    root_package_path = Path.cwd() / "gen" / "py"
    if not root_package_path.exists():
        print(f"Error: root package path {root_package_path} does not exist.")
        return

    walk_and_generate(root_package_path)
    print("All __init__.py files generated successfully.")

if __name__ == "__main__":
    main()
