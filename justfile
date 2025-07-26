set shell := ["bash", "-uc"]

switch:
    nh os switch . -- --impure

boot:
    nh os boot -- --impure

repair:
    nix-store --verify --check-contents --repair

curgen:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

up:
    nix flake update
    nh os switch -- --impure

history:
    nix profile history --profile /nix/var/nix/profiles/system

clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

gc:
    sudo nix-collect-garbage
    nix-collect-garbage

gitgc:
    git reflog expire --expire-unreachable=now --all
    git gc --prune=now
