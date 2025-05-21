#!/usr/bin/env python

import argparse
import shutil
import subprocess
import sys
from pathlib import Path


def copy_template(src: Path, dest: Path) -> bool:
    try:
        shutil.copytree(src, dest)
        print(f"Successfully copied {src} to {dest}")
    except FileNotFoundError as fnf_error:
        print(f"File not found: {fnf_error}")
        return False
    except PermissionError as perm_error:
        print(f"Permission denied: {perm_error}")
        return False
    except shutil.Error as shutil_error:
        print(f"Shutil error: {shutil_error}")
        return False

    return True


def initialize_git_repo(dest: Path) -> None:
    try:
        subprocess.run(["git", "init"], cwd=dest, check=True)
        print(f"Initialized a new git repository in {dest}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to initialize git repository: {e}")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Create a new project from a template.",
    )
    parser.add_argument(
        "language",
        type=str,
        help="The programming language of the template.",
    )
    parser.add_argument(
        "destination",
        type=Path,
        help="The destination directory for the new project.",
    )
    parser.add_argument(
        "--nogit",
        action="store_true",
        help="Initialize git repository in the new project directory",
    )

    args = parser.parse_args()
    templates_root = Path.home() / "misc/dev-templates"
    src_path = templates_root / args.language

    print(f"Templates root: {templates_root}")
    print(f"Source path: {src_path}")
    print(f"Source path exists: {src_path.exists()}")

    if not src_path.exists():
        print(f"No template found for {args.language}")
        sys.exit(1)

    if args.destination.exists():
        print(f"The destination directory {args.destination} already exists.")
        sys.exit(1)

    if copy_template(src_path, args.destination) and not args.nogit:
        initialize_git_repo(args.destination)


if __name__ == "__main__":
    main()
