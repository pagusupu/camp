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
      defaultEditor = true;
      enableMan = false;
      vimAlias = true;
      luaLoader.enable = true;
      opts = {
        number = true;
        shiftwidth = 2;
        smartindent = true;
        undofile = true;
      };
      plugins = {
        lsp-lines.enable = true;
        rainbow-delimiters.enable = true;
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
        treesitter = {
          enable = true;
          nixvimInjections = true;
        };
        treesitter-refactor.enable = true;
      };
    };
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
