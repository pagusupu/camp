{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  options.local.programs.nixvim = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.nixvim.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      options = {
        number = true;
        title = true;
      };
    };
  };
}
