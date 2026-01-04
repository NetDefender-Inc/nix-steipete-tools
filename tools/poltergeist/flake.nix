{
  description = "clawdbot plugin: poltergeist";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    root.url = "path:../..";
  };

  outputs = { self, nixpkgs, root }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      poltergeist = root.packages.${system}.poltergeist;
    in {
      packages.${system}.poltergeist = poltergeist;

      clawdbotPlugin = {
        name = "poltergeist";
        skills = [ ./skills/poltergeist ];
        packages = [ poltergeist ];
        needs = {
          stateDirs = [];
          requiredEnv = [];
        };
      };
    };
}
