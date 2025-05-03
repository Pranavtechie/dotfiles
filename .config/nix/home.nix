{ config, pkgs, ... }:

{
  # Home Manager needs information about you
  home.username = "pranav";
  home.homeDirectory = "/Users/pranav";
  home.stateVersion = "23.11";

  # Configure zsh with oh-my-zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
    
    initExtra = ''
      # Custom zsh configuration can go here
    '';
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}