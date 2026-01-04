{ lib, stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "summarize";
  version = "0.9.0";

  src = fetchurl {
    url = "https://github.com/steipete/summarize/releases/download/v0.9.0/summarize-macos-arm64-v0.9.0.tar.gz";
    hash = "sha256-B6/eUcbv4K9kgozo1fELFX+NNGa0C64dB6OSydwu6A8=";
  };

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    tar -xzf "$src"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp summarize "$out/bin/summarize"
    chmod 0755 "$out/bin/summarize"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Link → clean text → summary";
    homepage = "https://github.com/steipete/summarize";
    license = licenses.mit;
    platforms = [ "aarch64-darwin" ];
    mainProgram = "summarize";
  };
}
