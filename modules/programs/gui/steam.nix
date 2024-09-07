{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];
  options.cute.programs.gui.steam = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.steam {
    programs.steam = {
      enable = true;
      extest.enable = true;
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
          SDL_VIDEODRIVER = "x11"; # games apparently prefer this
          WLR_RENDERER = "vulkan";
        };
      };
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
    environment.sessionVariables.WINEDEBUG = "-all"; # also apparently helps
    hardware.xone.enable = true;
  };
}
