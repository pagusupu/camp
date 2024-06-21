{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];
  options.cute.programs.gui.steam = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.steam {
    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      platformOptimizations.enable = true;
      protontricks.enable = true;
      gamescopeSession = {
        enable = true;
        args = [
          "-H 1080" # height, assumes 16:9
          "-r 165" # refresh rate
          "-e" # steam integration
          "--expose-wayland"
        ];
        env = {
          SDL_VIDEODRIVER = "x11";
          WLR_RENDERER = "vulkan";
        };
      };
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
    environment.sessionVariables.WINEDEBUG = "-all";
    hardware.xone.enable = true;
  };
}
