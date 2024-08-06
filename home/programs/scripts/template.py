import argparse
import subprocess
from pathlib import Path


def get_template(lang: str, project_directory: Path) -> bool:
    try:
        flake_command = [
            "nix",
            "flake",
            "new",
            "--template",
            f"github:ifelse023/dev-templates#{lang}",
            str(project_directory),
        ]
        subprocess.run(flake_command, check=True)
        print(f"Template for {lang} initialized in {project_directory}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Failed to get template: {e}")
        return False


def initialize_git_repo(dest: Path) -> bool:
    if dest.exists() and not (dest / ".git").exists():
        try:
            subprocess.run(["git", "init"], cwd=str(dest), check=True)
            subprocess.run(["git", "add", "."], cwd=str(dest), check=True)
            return True
        except subprocess.CalledProcessError as e:
            print(f"no git: {e}")
            return False
    return True


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Initialize a development environment using Nix templates.",
    )
    parser.add_argument("language", type=str, help="The programming language.")
    parser.add_argument(
        "destination", type=str, help="The destination directory for the project."
    )
    args = parser.parse_args()

    destination = Path(args.destination)
    if not destination.exists():
        destination.mkdir(parents=True)
        print(f"Created directory {args.destination}")

    if get_template(args.language, destination):
        initialize_git_repo(destination)


if __name__ == "__main__":
    main()
