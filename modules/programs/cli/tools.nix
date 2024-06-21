{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs.cli = {
    btop = mkEnableOption "";
    nh = mkEnableOption "";
    yazi = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.cli) btop nh yazi;
  in
    mkMerge [
      (mkIf btop {
        homefile."btop" = {
          target = ".config/btop/btop.conf";
          source = (pkgs.formats.toml {}).generate "btop.conf" {
            color_theme = "TTY";
            theme_background = false;
            proc_sorting = "name";
            proc_tree = true;
            proc_left = true;
            proc_filter_kernel = true;
            show_swap = false;
            show_io_stat = false;
            show_battery = false;
            net_iface = "${config.cute.net.name}";
          };
        };
        environment.systemPackages = [pkgs.btop];
      })
      (mkIf nh {
        programs.nh = {
          enable = true;
          flake = "/home/pagu/camp/";
          clean = {
            enable = true;
            extraArgs = "--keep 10 --keep-since 3d";
          };
        };
      })
      (mkIf yazi {
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
      })
    ];
}
