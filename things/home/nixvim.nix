{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  options.cute.programs.nixvim = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.nixvim.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      options = {
        number = true;
        title = true;
      };
      plugins = {
        nvim-tree = {
	  enable = true;
	  autoClose = true;
          autoReloadOnWrite = true;
	  git = {
	    enable = true;
	  };
	  modified = {
	    enable = true;
	    showOnDirs = true;
	  };
	};
      };
    };
  };
}
