{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  options.cute.system.nix = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.nix (lib.mkMerge [
    {
      nix = {
        settings = {
          auto-allocate-uids = true;
          auto-optimise-store = true;
          builders-use-substitutes = true;
          use-xdg-base-directories = true;
          warn-dirty = false;
          experimental-features = [
            "auto-allocate-uids"
            "flakes"
            "nix-command"
            "no-url-literals"
          ];
          allowed-users = ["@wheel"];
          trusted-users = ["pagu"];
        };
        optimise.automatic = true;
      };
      nixpkgs = {
        config.allowUnfree = true;
        hostPlatform = "x86_64-linux";
        overlays = [inputs.self.overlays.default];
      };
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 5 --keep-since 3d";
        };
        flake = "/home/pagu/camp/";
      };
    }
    {
      nix = {
        channel.enable = false;
        nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
        settings.nix-path = ["nixpkgs=flake:nixpkgs"];
        registry.nixpkgs.flake = inputs.nixpkgs;
      };
      environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
    }
  ]);
}
