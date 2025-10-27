{
  description = "Monarch launcher packaged for nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };

      version = "0.8.23";

      monarch = pkgs.stdenv.mkDerivation {
        pname = "monarch";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://storage.googleapis.com/monarchlauncher/v08/aarch64/monarch-${version}.dmg";
          hash = "sha256-pQEy1WuhHdPLx9zjV8DY92A8B/LlXFxVhRMpPxbC+5M=";
        };

        nativeBuildInputs = [ pkgs.undmg ];

        sourceRoot = ".";

        installPhase = ''
          mkdir -p $out/Applications
          cp -r Monarch.app $out/Applications/
        '';

        meta = with pkgs.lib; {
          description = "Monarch launcher - a macOS app launcher";
          homepage = "https://www.monarchlauncher.com/";
          platforms = platforms.darwin;
          maintainers = [ ];
        };
      };
    in
    {
      packages.${system} = {
        default = monarch;
        monarch = monarch;
      };

      # For use with nix-darwin
      darwinModules.default = { pkgs, ... }: {
        # Install Monarch to /Applications/Nix\ Apps
        environment.systemPackages = [ self.packages.${system}.monarch ];
      };

      # For use with home-manager
      homeManagerModules.default = import ./home-manager-module.nix;
    };
}
