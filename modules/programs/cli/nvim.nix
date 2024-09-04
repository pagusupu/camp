{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.programs.cli.nvim = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.cli.nvim {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      enableMan = false;
      vimAlias = true;
      luaLoader.enable = true;
      opts = {
        foldmethod = "manual";
        number = true;
        showmode = false;
        shiftwidth = 2;
        smartindent = true;
        undofile = true;
      };
      plugins = {
        indent-blankline = {
          enable = true;
          settings.scope = {
            enabled = true;
            show_start = false;
            show_end = false;
          };
        };
        lsp = {
          enable = true;
          servers = {
            nil-ls = {
              enable = true;
              settings = {
                formatting.command = ["alejandra"];
                nix.flake.autoArchive = false;
              };
              cmd = ["nil"];
            };
            cssls.enable = true;
            html.enable = true;
          };
        };
        none-ls = {
          enable = true;
          sources = {
            diagnostics = {
              deadnix.enable = true;
              statix.enable = true;
            };
            code_actions.statix.enable = true;
          };
          enableLspFormat = false;
        };
        lualine.enable = true;
        lsp-format.enable = true;
        lsp-lines.enable = true;
        rainbow-delimiters.enable = true;
        treesitter.enable = true;
      };
    };
    environment = {
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      systemPackages = [pkgs.alejandra];
    };
  };
}
