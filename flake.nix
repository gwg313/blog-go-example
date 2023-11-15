{
  description = "A simple go flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      withSystem =
        f:
        nixpkgs.lib.fold nixpkgs.lib.recursiveUpdate { } (
          map f [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-linux"
            "aarch64-darwin"
          ]
        );
    in
    withSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        custom_lint = pkgs.writeShellApplication {
          name = "my-lint-script";
          text = ''
            #!/bin/sh
            echo "Running golint..."
            golint .
          '';
        };

        some_tests = pkgs.writeShellApplication {
          name = "my-test-script";
          text = ''
            #!/bin/sh
            echo "Running tests..."
            go test
          '';
        };

        ci_checks = pkgs.writeShellApplication {
          name = "my-ci-checks";
          text = ''
            #!/bin/sh
            echo "Running all CI checks..."
            my-lint-script
            my-test-script
            echo "building..."
            nix build
          '';
        };

      in
      {
        devShells.${system} = {
          default = pkgs.mkShell {
            buildInputs = [ custom_lint some_tests ci_checks ] ++ (with pkgs; [
              go
              golint
            ]);
          };
        };
        defaultPackage.${system} = pkgs.stdenv.mkDerivation {
          name = "a-go-example";
          src = ./.;
          buildInputs = with pkgs; [ go ];
          buildPhase = ''
            export GOCACHE=$TMPDIR/go-cache
            mkdir -p $TMPDIR/go-cache
            go build -o $out/a-go-project ./main.go
          '';
        };
      }
    );
}
