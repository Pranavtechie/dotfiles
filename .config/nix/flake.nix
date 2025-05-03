{
  description = "Pranav's Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    # Define system and user variables
    system = "aarch64-darwin";
    username = "pranav";
    
    # Import nixpkgs for the system
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        neovim
        mkalias
        obsidian
        tmux
        arc-browser
        qbittorrent
        stow
        uv
        tree
        gh
      ];

      nix.enable = false;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      homebrew = {
        enable = true;

        brews = [
          "mas"
          "nvm"
          "bun"
          "atuin"
        ];

        taps = [
          "oven-sh/homebrew-bun"
          "nikitabobko/homebrew-tap"
          "mhaeuser/mhaeuser"
        ];

        casks = [
          "ghostty"
          "the-unarchiver"
          "iina"
          "raycast"
          "activitywatch"
          "zed"
          "maccy"
          "aerospace"
          "flux"
          "netnewswire"
          "lm-studio"
          "battery-toolkit"
          "jordanbaird-ice"
          "brave-browser"
          "karabiner-elements"
        ];

        masApps = {
          "WhatsApp" = 310633997;
          "Keynote" = 409183694;
          "Pages" = 409201541;
          "Numbers" = 409203825;
        };

        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };


      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      fonts.packages = [
        pkgs.nerd-fonts.recursive-mono
      ];

      system.defaults = {
        dock.autohide = true;
        NSGlobalDomain."com.apple.swipescrolldirection" = false;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      };
      
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Pranavs-MacBook-Pro
    darwinConfigurations."Pranavs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs username; };
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = username;
            autoMigrate = true;
          };
        }
        # Add home-manager module
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home.nix;
          };
        }
      ];
    };
  };
}