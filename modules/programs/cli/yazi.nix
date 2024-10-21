{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.yazi = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.yazi {
    homefile."yazi" = {
      target = ".config/yazi/yazi.toml";
      source = (pkgs.formats.toml {}).generate "yazi.toml" {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
        };
      };
    };
    environment.systemPackages = [pkgs.yazi];
  };
}
