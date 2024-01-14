{
  config,
  lib,
  ...
}: {
  options.hm.programs.wofi.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        width = "15%";
        height = "30%";
        hide_scroll = true;
        insensitive = true;
        prompt = "";
      };
    };
  };
}
