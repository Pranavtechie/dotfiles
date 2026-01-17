## New machine setup (macOS)

### 1) Prereqs
```
xcode-select --install
```

### 2) Install Determinate Nix
Use the official installer from Determinate Systems. The command may change, so check the docs if this fails.
```
curl -L https://install.determinate.systems/nix | sh -s -- install
```

### 3) Clone dotfiles + stow
```
git clone git@github.com:pranav/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
```

### 4) Add a new host (if needed)
Find your host name:
```
scutil --get LocalHostName
```

Create host config:
```
mkdir -p ~/.config/nix/hosts/<LocalHostName>
```

Add/adjust host vars at:
```
~/.config/nix/hosts/<LocalHostName>/vars.nix
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
~/.config/nix/flake.nix
```

### 5) Apply nix-darwin
```
darwin-rebuild switch --flake ~/.config/nix#<LocalHostName>
```

### 6) Authenticate GitHub + set git identity
```
gh auth login
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
