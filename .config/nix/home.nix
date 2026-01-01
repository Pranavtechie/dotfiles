{ config, pkgs, lib, ... }:

{
  # Home Manager needs information about you
  home.username = "pranav";
  home.homeDirectory = lib.mkForce "/Users/pranav";
  home.stateVersion = "23.11";
  
  # Set environment variables
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
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
    
    initContent = ''
      # Set up NVM
      export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

      # Nix configuration paths
      export NIX_PATH="~/.config/nix/"
      export NIX_DARWIN_FLAKE="~/.config/nix/"

      # LM Studio CLI
      export PATH="$PATH:/Users/pranav/.lmstudio/bin"

      # Initialize atuin for shell history
      eval "$(atuin init zsh)"
      
      # https://www.visualmode.dev/a-better-man-page-viewer - set nvim for man pages
      export MANPAGER='nvim +Man!'

      # make psql available of postgresapp.com 
      export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

      export PGUSER=postgres
      export PGDATABASE=postgres

      export PATH="/Users/pranav/.bun/bin:$PATH"

      # Customize Agnoster theme to hide username@hostname
      # Override the prompt_context function to do nothing
      prompt_context() {}

      export PATH="/Users/pranav/.local/bin:$PATH"

      eval "$(zoxide init zsh)"

      export NU_CONFIG_DIR="$HOME/.config/nushell"
    '';
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
