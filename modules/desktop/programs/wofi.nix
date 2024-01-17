{
  config,
  lib,
  ...
}: {
  options.cute.desktop.programs.wofi.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.wofi.enable {
    home-manager.users.pagu = {
      programs.wofi = {
        enable = true;
        settings = { 
          hide_scroll = true;
          insensitive = true;
	  dynamic_lines = true;
	  width = "10%";
          #height = "30%";
	  x = 2;
          prompt = "";
	  location = 1;
	  lines = 11;
        };
	style = ''
	  #outer-box {
	    border: 2px solid #${config.cute.colours.iris};
	    /* background-color: #${config.cute.colours.base}; */
	  }
	  #input {
	    border: none;
	  }
	  #inner-box {
	    background-color: #${config.cute.colours.base};
	  }
	'';
      };
    };
  };
}
