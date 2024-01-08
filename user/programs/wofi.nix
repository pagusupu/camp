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
        location = "center";
        allow_markup = true;	
	term = "alacritty";
	hide_scroll = true;
	insensitive = true;
	prompt = "test";
      };
      style = ''
        #entry:selected {
	  color: #${config.cute.colours.primary.main};
	}
      '';
    };
  };
}
