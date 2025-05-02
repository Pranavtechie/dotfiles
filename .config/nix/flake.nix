{
  description = "Pranav's Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {


      nixpkgs.config.allowUnfree = true; 
      nixpkgs.config.allowBroken = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
	  pkgs.mkalias
	  pkgs.obsidian
	  pkgs.tmux
	  pkgs.arc-browser
	  pkgs.qbittorrent
	  pkgs.brave
	  pkgs.stow
	  pkgs.uv
	  pkgs.tree
	  pkgs.gh
        ];

      nix.enable = false;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      homebrew = {
	enable = true;
	
	brews = [
		"mas"
		"nvm"
	];

	casks = [
		"ghostty"
		"the-unarchiver"
		"iina"
		"raycast"
		"activitywatch"
		"karabiner-elements"
		"zed"
	];
	
	masApps = {
		"WhatsApp" = 310633997;
	};

	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      fonts.packages = with pkgs; [
  	(nerdfonts.override { fonts = [ "Recursive" ]; })
      ];

      system.defaults = {
	dock.autohide = true;
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
      modules = [ 
      configuration
      nix-homebrew.darwinModules.nix-homebrew
      {
      	nix-homebrew = {
	  enable = true;
	  user = "pranav";
	  autoMigrate = true;
	};


      }
      ];
    };
  };
}
