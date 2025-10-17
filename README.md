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

## Configuration Management (Optional)

You can manage Monarch's settings declaratively using the home-manager module:

### 1. Import the home-manager module

In your home-manager configuration:

```nix
home-manager.users.youruser = { ... }: {
  imports = [
    monarch-nix.homeManagerModules.default
  ];

  programs.monarch = {
    enable = true;
    settings = {
      # Your custom settings
      searchEngine = "kagi";
      darkMode = true;
      clipboardHistoryEnabled = true;
      cbHistoryLength = 200;
      autorun = true;
      menuBarIcon = true;

      # Enable specific modes
      modeSelectOrder = [
        { mode = "clipboard_history"; enabled = true; }
        { mode = "note_capture"; enabled = true; }
        { mode = "color_picker"; enabled = true; }
        { mode = "audio_devices"; enabled = false; }
        { mode = "monarch_ai"; enabled = false; }
      ];
    };
  };
};
```

### 2. Available Settings

Common settings you might want to configure:

- `searchEngine` - Default search engine (e.g., "google", "kagi", "duckduckgo")
- `darkMode` - Enable dark mode
- `clipboardHistoryEnabled` - Enable clipboard history
- `cbHistoryLength` - Number of clipboard items to keep (default: 100)
- `autorun` - Launch Monarch at login
- `menuBarIcon` - Show menu bar icon
- `autoPaste` - Automatically paste after selection
- `soundEnabled` - Enable sound effects
- `vault` - Default vault location for notes
- `colorFormat` - Color format for color picker ("hex", "rgb", etc.)

The settings will be written to `~/Library/Application Support/com.monarch.macos/settings.json`.

## Updating

To update to the latest version:

```bash
nix flake update monarch-nix
darwin-rebuild switch --flake ~/.config/nix-darwin#personal
```

Automatic updates are handled via GitHub Actions that check for new versions daily.

## Development

To test the package locally:

```bash
nix build
```

## Version

Current version: 0.8.20
