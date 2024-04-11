{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.cli = {
    yazi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.cli) yazi;
    inherit (lib) mkMerge mkIf;
  in
    mkMerge [
      (mkIf yazi {
        home.file."yazi" = {
          target = ".config/yazi/yazi.toml";
          source = (pkgs.formats.toml {}).generate "yazi.toml" {
            manager = {
              sort_by = "natrual";
              sort_dir_first = true;
            };
          };
        };
	environment.systemPackages = [pkgs.yazi];
      })
    ];
}
