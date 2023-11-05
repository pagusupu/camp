{
  lib,
  config,
}: {
  options.cute.misc.nix = {
    enable = lib.mkEnableOption "nix settings";
  };
  config = lib.mkIf config.cute.misc.nix.enable {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        allowed-users = ["@wheel"];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
    nixpkgs = {
      hostPlatform = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
}
