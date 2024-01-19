{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.common.programs.nixvim = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.programs.nixvim {
    programs.nixvim = {
      enable = true;
      luaLoader.enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraPlugins = with pkgs.vimPlugins; [plenary-nvim];
      colorschemes.rose-pine = {
        enable = true;
        disableItalics = true;
      };
      options = {
        number = true;
        shiftwidth = 2;
        smartindent = true;
        termguicolors = true;
        title = true;
        ttyfast = true;
        undofile = true;
      };
      keymaps = [
        {
          key = "t";
          action = "<cmd>NvimTreeToggle<cr>";
        }
        {
          key = "f";
          action = "<cmd>%!alejandra -qq<cr>";
        }
      ];
      plugins = {
        treesitter.enable = true;
        rainbow-delimiters.enable = true;
	barbar = {
	  enable = true;
	  autoHide = true;
	};
        lsp = {
          enable = true;
          servers.nil_ls = {
            enable = true;
            autostart = true;
            cmd = ["nil"];
            settings.formatting.command = ["alejandra" "--quiet"];
          };
        };
        none-ls = {
          enable = true;
          sources = {
            formatting.alejandra.enable = true;
            diagnostics.deadnix.enable = true;
          };
        };
        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          disableNetrw = true;
          hijackNetrw = true;
          hijackCursor = true;
          openOnSetup = true;
          git.enable = true;
          filters.dotfiles = true;
          renderer = {
            icons.gitPlacement = "after";
            highlightGit = true;
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
