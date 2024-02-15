{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.common = {
    age = lib.mkEnableOption "";
    git = lib.mkEnableOption "";
    nix = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common) age git nix;
  in { 
    programs.git = lib.mkIf git {
      enable = true;
      config = {
	init.defaultBranch = "main";
	user = {
	  name = "pagu";
	  email = "me@pagu.cafe";
	};
      };
    };
    nix = lib.mkIf nix {
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
        auto-optimise-store = true;
        allowed-users = ["@wheel"];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
    nixpkgs = lib.mkIf nix {
      hostPlatform = "x86_64-linux";
      config.allowUnfree = true;
    };
     environment.systemPackages = lib.mkIf age [inputs.agenix.packages.${pkgs.system}.default];
    age.identityPaths = lib.mkIf age ["/home/pagu/.ssh/id_ed25519"];
  };
}
