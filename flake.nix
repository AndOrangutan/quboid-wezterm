{
  description = "WezTerm flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wezterm-source.url = "github:wezterm/wezterm?dir=nix";
  };

  outputs = { self, nixpkgs, wezterm-source }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    deps = with pkgs; [
      fantasque-sans-mono
    ];

  in {
    packages.${system}.default = pkgs.symlinkJoin {
      name = "wezterm-with-deps";
      paths = [
        wezterm-source.packages.${system}.default
      ] ++ deps;
    };

    devShells."${system}".default = pkgs.mkShell {
      buildInputs = deps;
      shellHook = ''
        echo "wezTerm Config Dev Mode Enabled"
      '';
    };
  };
}
