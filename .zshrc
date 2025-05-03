    export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    export NIX_PATH="~/.config/nix/"
    export NIX_DARWIN_FLAKE="~/.config/nix/"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/pranav/.lmstudio/bin"
# End of LM Studio CLI section

eval "$(atuin init zsh)"
