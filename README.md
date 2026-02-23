# Fabric CLI Flake
The [FabricMC CLI ](https://fabricmc.net/develop/cli/) as a nix flake for convenient installation.

## Usage
This flake can either be run directly or installed as a package.
In order to run the flake directly, simply run `nix run github:MattiDragon/fabric-cli-flake`.
For installation you can either add this flake as an overlay and install `fabricmc-cli`,
or directly install the default package of this flake.

## Updating
To update to the latest version, simply run `update.sh`. It only requires `nix-shell` and `curl`.
