# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Update Commands
- Apply changes (MacBook): `darwin-rebuild switch --flake .#Pranavs-MacBook-Pro`
- Apply changes (Mac mini): `darwin-rebuild switch --flake .#Pranav-Mandavas-Mac-mini`
- Build without applying (MacBook): `darwin-rebuild build --flake .#Pranavs-MacBook-Pro`
- Build without applying (Mac mini): `darwin-rebuild build --flake .#Pranav-Mandavas-Mac-mini`

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

## Configuration Structure
- **Determinate Systems Nix Installation**: Used as the foundational Nix package manager installation
- **nix-darwin Flake**: Primary configuration for macOS system-level settings
  - Defines `darwinConfigurations` for system-wide configuration
  - Manages system packages, services, and macOS defaults
  - Entry point is typically in `flake.nix` referencing darwin modules
- **home-manager Flake**: User-specific configuration integrated within the nix-darwin setup
  - Configured as a module within the darwin configuration
  - Manages user environment, dotfiles, and user-specific packages
  - Uses `home.nix` plus per-host overrides from `hosts/<hostname>/home.nix`
- **Proper Integration Flow**: Determinate Systems Nix → nix-darwin → home-manager
