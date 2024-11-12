{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.programs.cli.btop = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.btop {
    assertions = cutelib.assertHm "btop";
    home-manager.users.pagu = {
      programs.btop = {
        enable = true;
        settings = {
          color_theme = "TTY";
          theme_background = false;
          proc_sorting = "name";
          proc_tree = true;
          proc_left = true;
          proc_filter_kernel = true;
          show_swap = false;
          show_io_stat = false;
          show_battery = false;
        };
      };
    };
  };
}
