{pkgs, ...}: {
  options.cute.programs.firefox = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.firefox.enable {
    programs = {
      firefox = {
        enable = true;
        package = [firefox-wayland];
      };
    };
  };
}
