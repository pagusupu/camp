{
  pkgs,
  config,
  lib,
  ...
}: {
  options.local.programs.neofetch = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.neofetch.enable {
    home = {
      packages = [pkgs.neofetch];
      file.".config/neofetch/config.conf".text = ''
        print_info() {
        info title
        info underline
        info "OS" distro
        info "Kernel" kernel
        info "Shell" shell
        info "Packages" packages
        info "WM" wm
        info "WM Theme" wm_theme
        info "Theme" theme
        info "Terminal" term
        prin "Terminal Font" "Fira Code"
        info "CPU" cpu
        prin "GPU" "AMD ATI Radeon RX 6750 XT"
        info "Memory" memory
        info cols
        }
        distro_shorthand="on"
        os_arch="off"
        cpu_speed="off"
        cpu_cores="off"
        gtk_shorthand="on"
        package_managers="tiny"
      '';
    };
  };
}
