## New machine setup (macOS)

### 1) Prereqs
```
xcode-select --install
```

### 2) Install Determinate Nix
Use the official installer from Determinate Systems. The command may change, so check the docs if this fails.
```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### 3) Clone dotfiles
```
git clone https://github.com/pranavtechie/dotfiles ~/.dotfiles
```

### 4) Add a new host (if needed)
Find your host name:
```
scutil --get LocalHostName
```

Create host config:
```
mkdir -p ~/.dotfiles/.config/nix/hosts/<LocalHostName>
```

Add/adjust host vars at:
```
~/.dotfiles/.config/nix/hosts/<LocalHostName>/vars.nix
```
Example:
```
{
  username = "<short-username>";
  homeDirectory = "/Users/<short-username>";
}
```

Then add the host to:
```
~/.dotfiles/.config/nix/flake.nix
```

### 5) Build + activate (first run)
On a fresh machine, `darwin-rebuild` won't be in your PATH yet. Run nix-darwin directly:
```
cd ~/.dotfiles/.config/nix
nix run github:LnL7/nix-darwin -- switch --flake .#<LocalHostName>
```

Quick notes:
- The first build takes a while (it installs everything).
- You may need to restart your terminal after the first activation.
- This flake integrates home-manager, so it will activate too.

### 6) Stow dotfiles
Now that `stow` is installed, symlink everything into place:
```
cd ~/.dotfiles
stow -n .
stow .
```

### 7) Apply updates (future runs)
After the first run, `darwin-rebuild` will be available in your PATH:
```
darwin-rebuild switch --flake ~/.config/nix#<LocalHostName>
```

### 8) Authenticate GitHub + set git identity
```
gh auth login
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
