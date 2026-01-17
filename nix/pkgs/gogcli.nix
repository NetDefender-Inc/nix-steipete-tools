{ lib, stdenv, fetchurl }:

let
  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.6.1/gogcli_0.6.1_darwin_arm64.tar.gz";
      hash = "sha256-x23EBYggJkZk4LuujdTfk650qcKFZD+ieGZvOMHmCx8=";
    };
    "x86_64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.6.1/gogcli_0.6.1_linux_amd64.tar.gz";
      hash = "sha256-OTZHx2+gI8K36tT5d5YALmhVWQZcrHfRapnwSfZLIkM=";
    };
    "aarch64-linux" = {
      url = "https://github.com/steipete/gogcli/releases/download/v0.6.1/gogcli_0.6.1_linux_arm64.tar.gz";
      hash = "sha256-WxOQjHDfsIepFxeRyCCkDz6WdJYYf3ZqBGtQ6HnLqKA=";
    };
  };
in
stdenv.mkDerivation {
  pname = "gogcli";
  version = "0.6.1";

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
