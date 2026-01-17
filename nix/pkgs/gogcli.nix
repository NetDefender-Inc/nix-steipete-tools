{ lib, stdenv, fetchurl }:

let
  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.7.0/gogcli_0.7.0_darwin_arm64.tar.gz";
      hash = "sha256-9QZX49hmwwy8gqH1eT9XP7yPDP/ubKRf+ykzL2XqqxM=";
    };
    "x86_64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.7.0/gogcli_0.7.0_linux_amd64.tar.gz";
      hash = "sha256-k+WF3AyLNy02myoO5mG8ILebCfW4fSIK829rdi1K+6Y=";
    };
    "aarch64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.7.0/gogcli_0.7.0_linux_arm64.tar.gz";
      hash = "sha256-CB1TZw48IRuULOBIXrn2pHaDCmFX7rX3p1tFX82p5hw=";
    };
  };
in
stdenv.mkDerivation {
  pname = "gogcli";
  version = "0.7.0";

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
