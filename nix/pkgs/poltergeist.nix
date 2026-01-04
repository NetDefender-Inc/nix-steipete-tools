{ lib, stdenv, fetchurl, watchman }:

stdenv.mkDerivation {
  pname = "poltergeist";
  version = "2.1.1";

  src = fetchurl {
    url = "https://github.com/steipete/poltergeist/releases/download/v2.1.1/poltergeist-macos-universal-v2.1.1.tar.gz";
    hash = "sha256-plQQjbB0QV7UY7U3ZdhfAZsAY/5m0G1E1WEgMm+elk8=";
  };

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    tar -xzf "$src"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp poltergeist "$out/bin/poltergeist"
    cp polter "$out/bin/polter"
    chmod 0755 "$out/bin/poltergeist" "$out/bin/polter"
    runHook postInstall
  '';

  propagatedBuildInputs = [ watchman ];

  meta = with lib; {
    description = "Universal file watcher with auto-rebuild for any language or build system";
    homepage = "https://github.com/steipete/poltergeist";
    license = licenses.mit;
    platforms = [ "aarch64-darwin" ];
    mainProgram = "poltergeist";
  };
}
