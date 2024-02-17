{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.common.nixvim = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.nixvim {
    programs.nixvim = {
      enable = true;
      enableMan = false;
      defaultEditor = true;
      vimAlias = true;
      luaLoader.enable = true;
      colorschemes.rose-pine = {
        enable = true;
        disableItalics = true;
      };
      options = {
        number = true;
        shiftwidth = 2;
        smartindent = true;
        ttyfast = true;
        undofile = true;
      };
      keymaps = [
        {
          key = "t";
          action = "<cmd>NvimTreeToggle<cr>";
        }
      ];
      extraPlugins = with pkgs.vimPlugins; [
        plenary-nvim
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
            settings.formatting.command = ["alejandra --quiet"];
          };
        };
        lsp-format = {
          enable = true;
          lspServersToEnable = ["nil_ls"];
        };
        none-ls = {
          enable = true;
          sources = {
	    code_actions.statix.enable = true;
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
    environment.sessionVariables = {EDITOR = "nvim";};
  };
}
