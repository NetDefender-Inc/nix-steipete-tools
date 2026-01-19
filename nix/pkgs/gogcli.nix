{ lib, stdenv, fetchurl }:

let
  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.8.0/gogcli_0.8.0_darwin_arm64.tar.gz";
      hash = "sha256-ijLAVoI34quaKLxW5BBxQbsAopMvCmgYiO1YEMfebp4=";
    };
    "x86_64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.8.0/gogcli_0.8.0_linux_amd64.tar.gz";
      hash = "sha256-d7o4zomuXwzlf9nQJZA5KkXfoulCGJvWJ5b+51ww9ho=";
    };
    "aarch64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.8.0/gogcli_0.8.0_linux_arm64.tar.gz";
      hash = "sha256-oyRIQPrW+oQvFJevrqrb/Gw6no9L3BcnOJT7KSU7s+k=";
    };
  };
in
stdenv.mkDerivation {
  pname = "gogcli";
  version = "0.8.0";

  src = fetchurl sources.${stdenv.hostPlatform.system};

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    tar -xzf "$src"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp gog "$out/bin/gog"
    chmod 0755 "$out/bin/gog"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Google CLI for Gmail, Calendar, Drive, and Contacts";
    homepage = "https://github.com/steipete/gogcli";
    license = licenses.mit;
    platforms = builtins.attrNames sources;
    mainProgram = "gog";
  };
}
