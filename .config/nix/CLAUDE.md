# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Update Commands
- Apply changes: `darwin-rebuild switch --flake .#Pranavs-MacBook-Pro`
- Build without applying: `darwin-rebuild build --flake .#Pranavs-MacBook-Pro`

## Code Style Guidelines
- **Formatting**: Maintain consistent indentation (2 spaces) as shown in existing code
- **Structure**: Group related packages in `environment.systemPackages` and Homebrew sections
- **Naming**: Use descriptive names for variables and configurations
- **Package Organization**: 
  - System packages go in `environment.systemPackages`
  - macOS apps belong in `homebrew.casks` or `homebrew.masApps`
  - Command-line tools generally go in `homebrew.brews` or system packages
  
## Repository Information
- This is a Nix flake for macOS (Darwin) system configuration
- Uses nix-darwin and nix-homebrew for macOS customization
- Configures system packages, homebrew apps, and macOS defaults