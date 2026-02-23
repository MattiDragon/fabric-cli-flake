{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    {self, nixpkgs, ...}:
    let
      forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
    in {
      overlays.default = final: prev: {
        fabricmc-cli = prev.callPackage ./. {};
      };

      packages = forAllSys (system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in {
        inherit (pkgs) fabricmc-cli;
        default = pkgs.fabricmc-cli;
      });
    };

}
