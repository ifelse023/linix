# use nushell for shell commands
set shell := ["bash", "-uc"]

switch:
  nh os switch . -- --impure

boot:
  nh os boot -- --impure


repair:
  nix-store --verify --check-contents --repair

curgen:
  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# update all the flake inputs
up:
  nix flake update
  nh os switch -- --impure

# List all generations of the system profile
history:
  nix profile history --profile /nix/var/nix/profiles/system

# remove all generations
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

# Garbage collect all unused nix store entries
gc:
  sudo nix-collect-garbage
  nix-collect-garbage

# Remove all reflog entries and prune unreachable objects
gitgc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now
