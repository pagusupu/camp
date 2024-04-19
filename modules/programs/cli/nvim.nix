{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.programs.cli.nvim = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.cli.nvim {
    programs.nixvim = {
      enable = true;
      enableMan = false;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      luaLoader.enable = true;
      opts = {
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
      plugins = {
        lsp-lines.enable = true;
        rainbow-delimiters.enable = true;
        barbar = {
          enable = true;
          autoHide = true;
        };
        lsp = {
          enable = true;
          servers = {
            nil_ls = {
              enable = true;
              cmd = ["nil"];
              settings.formatting.command = ["alejandra --quiet"];
            };
            cssls.enable = true;
            html.enable = true;
          };
        };
        lsp-format = {
          enable = true;
          lspServersToEnable = ["cssls" "html"];
        };
        none-ls = {
          enable = true;
          sources = {
            formatting = {
              alejandra.enable = true;
              biome.enable = true;
            };
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
        treesitter = {
          enable = true;
          nixvimInjections = true;
        };
      };
    };
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
