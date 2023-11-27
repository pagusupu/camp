{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.xserver.common.awesome = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.xserver.common.awesome.enable {
    windowManager.awesome = {
      enable = true;
      package = pkgs.callPackage ../../../pkgs/awesome.nix;
      noArgb = true;
    };
  };
}

