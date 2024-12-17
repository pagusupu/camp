{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./hosts ./parts ];
      systems = [ "x86_64-linux" ];
    };
  inputs = {
    nixpkgs.follows = "stable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    aagl = {
      inputs = {
        nixpkgs.follows = "stable";
        flake-compat.follows = "flake-compat";
      };
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
    };
    agenix = {
      inputs = {
        nixpkgs.follows = "unstable";
        darwin.follows = "";
        home-manager.follows = "";
        systems.follows = "systems";
      };
      url = "github:ryantm/agenix";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "unstable";
    };
    git-hooks-nix = {
      inputs = {
        nixpkgs.follows = "unstable";
        nixpkgs-stable.follows = "stable";
        flake-compat.follows = "flake-compat";
        gitignore.follows = "";
      };
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "unstable";
    };
    idle-inhibit = {
      inputs = {
        nixpkgs.follows = "unstable";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
    };
    nixcord = {
      inputs = {
        nixpkgs.follows = "unstable";
        flake-compat.follows = "flake-compat";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:kaylorben/nixcord";
    };
    nix-gaming = {
      inputs = {
        nixpkgs.follows = "unstable";
        flake-parts.follows = "flake-parts";
        umu.follows = "";
      };
      url = "github:fufexan/nix-gaming";
    };
    nixvim = {
      inputs = {
        nixpkgs.follows = "stable";
        devshell.follows = "";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks-nix";
        home-manager.follows = "";
        nix-darwin.follows = "";
        nuschtosSearch.follows = "";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nixvim/nixos-24.11";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "unstable";
    };
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";

    # unused by config
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
  };
}
