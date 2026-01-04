{
  description = "clawdbot plugin: summarize";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    root.url = "path:../..";
  };

  outputs = { self, nixpkgs, root }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      summarize = root.packages.${system}.summarize;
    in {
      packages.${system}.summarize = summarize;

      clawdbotPlugin = {
        name = "summarize";
        skills = [ ./skills/summarize ];
        packages = [ summarize ];
        needs = {
          stateDirs = [];
          requiredEnv = [];
        };
      };
    };
}
