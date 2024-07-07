{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs.cli = {
    misc = mkEnableOption "";
    btop = mkEnableOption "";
    nh = mkEnableOption "";
    yazi = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs) cli;
    inherit (cli) btop nh yazi;
  in
    mkMerge [
      (mkIf cli.misc {
        environment.systemPackages = with pkgs; [
          ouch
          radeontop
          wget
        ];
      })
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
          clean = {
            enable = true;
            extraArgs = "--keep 10 --keep-since 3d";
          };
          flake = "/home/pagu/camp/";
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
