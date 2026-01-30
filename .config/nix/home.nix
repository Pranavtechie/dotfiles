{ config, pkgs, lib, username, homeDirectory ? "/Users/${username}", ... }:

{
  # Home Manager needs information about you
  home.username = username;
  home.homeDirectory = lib.mkForce (/. + (lib.removePrefix "/" homeDirectory));
  home.stateVersion = "23.11";

  # Set environment variables
  home.sessionVariables = {
    EDITOR = lib.mkDefault "hx";
    VISUAL = lib.mkDefault "hx";
    NIX_DARWIN_FLAKE = "$HOME/.config/nix";
    XDG_CONFIG_HOME = "$HOME/.config";
    PGUSER = "postgres";
    PGDATABASE = "postgres";
  };

  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/.local/bin"
    "/Applications/Tailscale.app/Contents/MacOS"
    "/Applications/Postgres.app/Contents/Versions/latest/bin"
  ];

  home.packages = with pkgs; [
    btop
    bun
    cloudflared
    eza
    exiftool
    fastfetch
    gh
    git-lfs
    helix
    nodejs_24
    ripgrep
    rustup
    stow
    tmux
    tree
    uv
    wget
    xcbuild
    zellij
  ];

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Configure zsh with oh-my-zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "docker"
        "npm"
        "macos"
        "vscode"
        "brew"
      ];
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
