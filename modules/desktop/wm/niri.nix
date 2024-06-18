{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];
  options.cute.desktop.wm.niri = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.wm.niri {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
    nix.settings = {
      substituters = ["https://niri.cachix.org"];
      trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="];
    };
    cute.desktop.misc.greetd = {
      enable = true;
      sessionDirs = ["${pkgs.niri-stable}/share/wayland-sessions"];
    };
  };
}
