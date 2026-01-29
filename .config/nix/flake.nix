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
    system = "aarch64-darwin";

    hosts = {
      "Pranavs-MacBook-Pro" = import ./hosts/Pranavs-MacBook-Pro/vars.nix;
      "Pranav-Mandavas-Mac-mini" = import ./hosts/Pranav-Mandavas-Mac-mini/vars.nix;
    };

    mkConfiguration = { username }: { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;
      nix.enable = false;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      homebrew = {
        enable = true;

        brews = [
          "mas"
          "mole"
          "libpq" # for psql cli tool
        ];

        taps = [
          "oven-sh/homebrew-bun"
          "nikitabobko/homebrew-tap"
          "mhaeuser/mhaeuser"
        ];

        casks = [
          "the-unarchiver"
          "iina"
          "obsidian"
          "lm-studio"
          "hyperkey"
          "raycast"
          "activitywatch"
          "google-chrome"
          "maccy"
          "orbstack"
          "ghostty"
          "aerospace"
          "flux-app"
          "jordanbaird-ice@beta"
          "stats"
          "postgres-unofficial"
          "qbittorrent"
	        "caffeine"
        ];

        masApps = {
          "Tailscale" = 1475387142;
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
        dock = {
          autohide = true;
          mineffect = "scale"; # "scale" for immediate animation instead of "genie"
          static-only = false;
          show-recents = false; # Don't show recent applications
          orientation = "bottom";
          persistent-apps = [];
          persistent-others = [];
        };
        NSGlobalDomain."com.apple.swipescrolldirection" = false;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      };

      system.primaryUser = username;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

    };

    mkDarwin = hostName:
      let
        host = hosts.${hostName};
        username = host.username;
        homeDirectory = host.homeDirectory;
        hostDir = ./hosts + "/${hostName}";
      in
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs username homeDirectory hostName; };
        modules = [
          (mkConfiguration { inherit username; })
          (hostDir + "/darwin.nix")
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
              extraSpecialArgs = { inherit username homeDirectory hostName; };
              users.${username} = {
                imports = [
                  ./home.nix
                  (hostDir + "/home.nix")
                ];
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
  in
  {
    darwinConfigurations = {
      "Pranavs-MacBook-Pro" = mkDarwin "Pranavs-MacBook-Pro";
      "Pranav-Mandavas-Mac-mini" = mkDarwin "Pranav-Mandavas-Mac-mini";
    };
  };
}
