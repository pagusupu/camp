{
  lib,
  config,
  ...
}: {
  options.cute.common.system.nix = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.system.nix {
    nix = {
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
        auto-optimise-store = true;
        allowed-users = ["@wheel"];
	builders-use-substitutes = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      optimise.automatic = true;
      channel.enable = false;
    };
    nixpkgs = {
      hostPlatform = "x86_64-linux";
      config.allowUnfree = true;
    };
    documentation = {
      enable = false;
      doc.enable = false;
      info.enable = false;
      nixos.enable = false;
    };
  };
}
