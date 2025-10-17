# monarch-nix

Nix flake for installing [Monarch launcher](https://www.monarchlauncher.com/) on macOS via nix-darwin.

## Usage

### 1. Add to your nix-darwin flake inputs

In your `~/.config/nix-darwin/flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    # ... other inputs

    monarch-nix.url = "github:reeve567/monarch-nix";
    monarch-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

### 2. Add to your configuration

Option A - Add to your configuration modules:

```nix
outputs = inputs@{ self, nix-darwin, nixpkgs, monarch-nix, ... }: {
  darwinConfigurations = {
    personal = nix-darwin.lib.darwinSystem {
      modules = [
        # ... your other modules
        monarch-nix.darwinModules.default
      ];
    };
  };
}
```

Option B - Add directly to packages:

```nix
{
  environment.systemPackages = [
    # ... other packages
    monarch-nix.packages.aarch64-darwin.default
  ];
}
```

### 3. Rebuild your system

```bash
darwin-rebuild switch --flake ~/.config/nix-darwin#personal
```

## Updating

To update to the latest version:

```bash
nix flake update monarch-nix
darwin-rebuild switch --flake ~/.config/nix-darwin#personal
```

## Development

To test the package locally:

```bash
nix build
```

## Version

Current version: 0.8.20
