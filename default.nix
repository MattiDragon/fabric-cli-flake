{
  lib,
  stdenv,
  deno,
  makeBinaryWrapper,
  installShellFiles,
  ...
}:
stdenv.mkDerivation {
  name = "fabricmc-cli";
  version = lib.fileContents ./version;

  src = ./.;

  nativeBuildInputs = [
    makeBinaryWrapper
    installShellFiles
  ];

  buildInputs = [
    deno
  ];

  installPhase  =  ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp ./fabric-cli $out/share/fabric-cli
    makeWrapper "${deno}/bin/deno" $out/bin/fabric \
      --add-flags "run -A --no-remote $out/share/fabric-cli"
  '';

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd fabric \
      --bash <($out/bin/fabric completion bash) \
      --fish <($out/bin/fabric completion fish) \
      --zsh <($out/bin/fabric completion zsh)
  '';

  meta = {
    homepage = "https://fabricmc.net/develop/cli/";
    description = "The Fabric command line tools (CLI) used by mod developers to generate new mods directly from their terminal.";
    license = lib.licenses.mit;
  };
}
