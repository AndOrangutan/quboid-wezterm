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
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        mkdir -p $out/share/wezterm
        cp ${./wezterm.lua} $out/share/wezterm/wezterm.lua
        cp ${./smart-splits.lua} $out/share/wezterm/smart-splits.lua
        wrapProgram $out/bin/wezterm \
          --set WEZTERM_CONFIG_FILE $out/share/wezterm/wezterm.lua
        wrapProgram $out/bin/wezterm-gui \
          --set WEZTERM_CONFIG_FILE $out/share/wezterm/wezterm.lua
      '';
    };

    devShells."${system}".default = pkgs.mkShell {
      buildInputs = deps;
      shellHook = ''
        echo "wezTerm Config Dev Mode Enabled"
      '';
    };
  };
}
