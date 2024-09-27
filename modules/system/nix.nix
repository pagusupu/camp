{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  options.cute.system.nix = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.nix {
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
        builders-use-substitutes = true;
        nix-path = ["nixpkgs=flake:nixpkgs"];
        trusted-users = ["pagu"];
        use-xdg-base-directories = true;
        warn-dirty = false;
      };
      channel.enable = false;
      nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
      optimise.automatic = true;
      registry.nixpkgs.flake = inputs.nixpkgs;
    };
    nixpkgs = {
      config.allowUnfree = true;
      hostPlatform = "x86_64-linux";
    };
    environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  };
}
