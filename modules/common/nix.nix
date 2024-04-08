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
          "auto-allocate-uids"
          "flakes"
          "nix-command"
          "no-url-literals"
        ];
        allowed-users = ["@wheel"];
        auto-optimise-store = true;
        nix-path = ["nixpkgs=flake:nixpkgs"];
        use-xdg-base-directories = true;
        warn-dirty = false;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      channel.enable = false;
      nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
      optimise.automatic = true;
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
