{
  description = "Shikanime's algorithms sketchbook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    extra-substituters = [
      "https://shikanime.cachix.org"
      "https://devenv.cachix.org"
    ];
  };

  outputs = { nixpkgs, devenv, ... }@inputs: {
    devShells = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ./modules/base.nix
            ./modules/beam.nix
            ./modules/cc.nix
            ./modules/javascript.nix
            ./modules/ocaml.nix
            ./modules/python.nix
          ];
        };
      }
    );
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in {
        algorithm-cc = pkgs.gccStdenv.mkDerivation {
          name = "algorithm-cc";
          src = ./algorithm-cc;
          nativeBuildInputs = [ pkgs.pkg-config pkgs.cmake ];
          buildInputs = [ pkgs.openssl ];
          checkInputs = [ pkgs.gtest ];
          doCheck = true;
        };
        algorithm-python = pkgs.poetry2nix.mkPoetryApplication {
          projectDir = ./algorithm-python;

        };
      }
    );
  };
}
