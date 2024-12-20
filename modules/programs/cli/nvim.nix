{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  options.cute.programs.cli.nvim = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.nvim {
    programs.nixvim = {
      enable = true;
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      colorschemes.rose-pine = {
        enable = true;
        settings = {
          styles = {
            italic = false;
            transparency = false;
          };
          variant = "auto";
        };
        package = pkgs.nvim-rose-pine;
      };
      opts = {
        autoindent = true;
        breakindent = true;
        smartindent = true;
        shiftwidth = 2;

        autoread = true;
        backup = false;
        swapfile = false;
        undofile = true;

        number = true;
        showmode = false;
        termguicolors = true;
      };
      performance.byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        plugins = true;
      };
      plugins = {
        barbar = {
          enable = true;
          settings.auto_hide = 1;
        };
        indent-blankline = {
          enable = true;
          settings.scope.enabled = false;
        };
        lsp = {
          enable = true;
          servers = {
            nil_ls = {
              enable = true;
              settings = {
                formatting.command = [ "${lib.getExe pkgs.alejandra-custom}" ];
                nix.flake.autoArchive = false;
              };
            };
            cssls.enable = true;
            html.enable = true;
            jsonls.enable = true;
          };
        };
        notify = {
          enable = true;
          render = "minimal";
          stages = "fade";
          timeout = 1000;
        };
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };
        autoclose.enable = true;
        lualine.enable = true;
        lsp-format.enable = true;
        lsp-lines.enable = true;
        markview.enable = true;
        noice.enable = true;
        rainbow-delimiters.enable = true;
        web-devicons.enable = true;
      };
      extraConfigVim = ''
        aun PopUp.How-to\ disable\ mouse
        aun PopUp.-1-
      '';
      enableMan = false;
      defaultEditor = true;
      luaLoader.enable = true;
      vimAlias = true;
      withPython3 = false;
      withRuby = false;
    };
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
