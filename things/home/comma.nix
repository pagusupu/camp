{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nix-index-database.hmModules.nix-index];
  options.local.programs.comma = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.comma.enable {
    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
