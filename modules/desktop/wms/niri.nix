{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];
  options.cute.desktop.wm.niri = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.wm.niri {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri = {
      enable = true;
    };
  };
}
