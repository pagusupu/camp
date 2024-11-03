{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [./hosts ./treefmt.nix];
      systems = ["x86_64-linux"];
    };
  inputs = {
    nixpkgs.follows = "unstable";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    hosts.url = "github:StevenBlack/hosts";
    nixcord.url = "github:kaylorben/nixcord";
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt.url = "github:numtide/treefmt-nix";
  };
}
