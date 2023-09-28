{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nix-index-database.hmModules.nix-index];
  options.cute.programs.comma = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.comma.enable {
    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
