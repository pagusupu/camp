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
      vimAlias = true;
      colorscheme = "mountain";
      options = {
        number = true;
        title = true;
        smartindent = true;
        shiftwidth = 2;
        termguicolors = true;
      };
      plugins = {
        treesitter.enable = true;
        rainbow-delimiters.enable = true;
        lsp.enable = true;
        null-ls = {
          enable = true;
          sources = {
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
          openOnSetup = true;
          git.enable = true;
          view.cursorline = false;
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
      extraPlugins = with pkgs.vimPlugins; [
        mountain
        nvim-web-devicons
      ];
    };
    home.packages = with pkgs; [
      deadnix
      nil
    ];
  };
}
