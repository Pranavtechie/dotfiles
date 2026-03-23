
## Update Workflow
- Use this sequence when updating the local Nix toolchain and this flake:
  1. Upgrade Determinate Nix first: `sudo determinate-nixd upgrade`
  2. Refresh the flake inputs in this repo: `nix flake update`
  3. Optionally pre-build the target host to catch evaluation/build issues early: `darwin-rebuild build --flake .#<host>`
  4. Apply the updated Darwin configuration: `darwin-rebuild switch --flake .#<host>`
- Replace `<host>` with `Pranavs-MacBook-Pro` or `Pranavs-Mac-mini`.

> [!NOTE]
> `darwin-rebuild switch` already performs the build before activating the new generation, so `darwin-rebuild build` is not required for the normal update flow.
>
> In this repo, `build` is only a preflight check. It can catch evaluation or derivation failures early, but it does not validate activation-time steps. That matters here because Homebrew updates and app installs run during activation, so a successful `build` does not guarantee that `switch` will complete without issues.

## Build/Update Commands
- Apply changes (MacBook): `darwin-rebuild switch --flake .#Pranavs-MacBook-Pro`
- Apply changes (Mac mini): `darwin-rebuild switch --flake .#Pranavs-Mac-mini`
- Build without applying (MacBook): `darwin-rebuild build --flake .#Pranavs-MacBook-Pro`
- Build without applying (Mac mini): `darwin-rebuild build --flake .#Pranavs-Mac-mini`

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
