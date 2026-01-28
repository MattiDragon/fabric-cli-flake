#! /bin/sh
curl -o fabric-cli https://fabricmc.net/cli
nix-shell -p deno --command "deno run -A --no-remote ./fabric-cli -V > version"
