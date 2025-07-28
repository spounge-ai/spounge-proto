#!/usr/bin/env python3
import os
from pathlib import Path
<<<<<<< HEAD
import re

SKIP_DIRS = {"google"}  

def is_valid_module(filename: str) -> bool:
    return filename.endswith(".py") and not filename.startswith("_") and filename != "__init__.py"

def is_valid_package(directory: Path) -> bool:
    return (directory / "__init__.py").exists()

def should_skip_dir(path: Path) -> bool:
    return any(part in SKIP_DIRS for part in path.parts)

def generate_init_file(dir_path: Path):
    if not dir_path.is_dir() or should_skip_dir(dir_path):
        return

=======

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
>>>>>>> main
    modules = sorted(f.stem for f in dir_path.iterdir() if f.is_file() and is_valid_module(f.name))
    subpackages = sorted(d.name for d in dir_path.iterdir() if d.is_dir() and is_valid_package(d))

    lines = []
<<<<<<< HEAD
    for pkg in subpackages:
        lines.append(f"from . import {pkg}")

=======

    # Import subpackages
    for pkg in subpackages:
        lines.append(f"from . import {pkg}")

    # Import modules if any
>>>>>>> main
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

<<<<<<< HEAD
def rewrite_imports_add_prefix(root_dir: Path, packages_prefix: str, package_names: list[str]):
    pattern = re.compile(r"^(from|import)\s+(" + "|".join(map(re.escape, package_names)) + r")(\.|[\s])")

    for py_file in root_dir.rglob("*.py"):
        if py_file.name == "__init__.py" or should_skip_dir(py_file):
            continue

        text = py_file.read_text(encoding="utf-8")
        new_lines = []
        changed = False

        for line in text.splitlines():
            m = pattern.match(line)
            if m:
                kind = m.group(1)
                pkg = m.group(2)
                new_line = line.replace(f"{kind} {pkg}", f"{kind} {packages_prefix}.{pkg}")
                if new_line != line:
                    changed = True
                new_lines.append(new_line)
            else:
                new_lines.append(line)

        if changed:
            py_file.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
            print(f"Patched imports in {py_file}")

def walk_and_generate(root_dir: Path):
=======
def walk_and_generate(root_dir: Path):
    """Recursively walk root_dir and generate __init__.py files."""
>>>>>>> main
    for current_dir, dirs, files in os.walk(root_dir):
        current_path = Path(current_dir)
        has_modules = any(is_valid_module(f) for f in files)
        has_packages = any(is_valid_package(current_path / d) for d in dirs)
        if has_modules or has_packages:
            generate_init_file(current_path)

def main():
<<<<<<< HEAD
    root_package_path = Path.cwd() / "gen" / "py" / "spounge"
=======
    root_package_path = Path.cwd() / "gen" / "py"
>>>>>>> main
    if not root_package_path.exists():
        print(f"Error: root package path {root_package_path} does not exist.")
        return

<<<<<<< HEAD
    top_level_packages = [
        d.name for d in root_package_path.iterdir()
        if d.is_dir() and is_valid_package(d) and not should_skip_dir(d)
    ]
    if not top_level_packages:
        print(f"No sub-packages found under {root_package_path}")
        return

    print(f"Discovered top-level proto packages: {top_level_packages}")

    walk_and_generate(root_package_path)
    # Uncomment to rewrite imports if needed:
    rewrite_imports_add_prefix(root_package_path, "spounge", top_level_packages)

    print("All __init__.py files generated (excluding skipped dirs).")
=======
    walk_and_generate(root_package_path)
    print("All __init__.py files generated successfully.")
>>>>>>> main

if __name__ == "__main__":
    main()
