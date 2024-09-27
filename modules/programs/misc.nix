{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.misc = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.misc (lib.mkMerge [
    {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 10 --keep-since 3d";
        };
        flake = "/home/pagu/camp/";
      };
      environment.systemPackages = with pkgs; [
        ouch
        wget
      ];
    }
    {
      homefile = {
        "btop" = {
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
        "yazi" = {
          target = ".config/yazi/yazi.toml";
          source = (pkgs.formats.toml {}).generate "yazi.toml" {
            manager = {
              sort_by = "natural";
              sort_dir_first = true;
            };
          };
        };
      };
      environment.systemPackages = with pkgs; [
        btop
        yazi
      ];
    }
  ]);
}
