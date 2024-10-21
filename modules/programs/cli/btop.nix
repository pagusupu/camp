{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.btop = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.btop {
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
  };
}
