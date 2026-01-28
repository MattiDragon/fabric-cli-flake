{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    {self, nixpkgs, ...}:
    let
      forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
    in {
      packages = forAllSys (system: let
        pkgs = import nixpkgs { inherit system; };
        fabricmc-cli = pkgs.callPackage ./. {
          inherit pkgs;
        };
      in {
        inherit fabricmc-cli;
        default = fabricmc-cli;
      });
    };

}
