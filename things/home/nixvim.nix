{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  mountain = pkgs.vimUtils.buildVimPlugin {
    name = "mountain";
    src = pkgs.fetchFromGitHub {
      owner = "lokesh-krishna";
      repo = "mountain.nvim";
      rev = "f618ec96f80f89b06cf87221a7d624cab7092f4c";
      hash = "sha256-Ks+Z5pIEeNy3v+sjsAE8eD/Q/okxmJmkWtB2onOtPqY=";
    };
  };
in {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  options.cute.programs.nixvim = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraPlugins = [mountain];
      colorscheme = "mountain";
      options = {
        number = true;
        shiftwidth = 2;
        smartinent = true;
        termguicolors = true;
        title = true;
        ttyfast = true;
        undofile = true;
      };
      plugins = {
        treesitter.enable = true;
        rainbow-delimiters.enable = true;
        lsp.enable = true;
        null-ls = {
          enable = true;
          sources = {
            code_actions.statix.enable = true;
            diagnostics.deadnix.enable = true;
            formatting.alejandra.enable = true;
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
    };
    home.packages = with pkgs; [
      deadnix
      nil
      statix
    ];
  };
}
