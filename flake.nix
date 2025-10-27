{
  description = "Dev shell for blink-deployments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      with pkgs; {
        devShells.default = mkShell {
          packages = [
            alejandra
            opentofu
            jq
            ytt
            vendir
            google-cloud-sdk
            yq-go
            rover
            openstackclient
          ];
        };

        formatter = alejandra;
      });
}
