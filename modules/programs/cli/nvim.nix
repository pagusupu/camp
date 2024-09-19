{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.programs.cli.nvim = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.nvim {
    programs.nixvim = lib.mkMerge [
      {
        enable = true;
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
            settings.scope.enabled = false;
          };
          lsp = {
            enable = true;
            servers = {
              nil-ls = {
                enable = true;
                settings = {
                  formatting.command = ["${lib.getExe pkgs.alejandra}"];
                  nix.flake.autoArchive = false;
                };
                cmd = ["nil"];
              };
              cssls.enable = true;
              html.enable = true;
              nushell.enable = true;
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
          treesitter = {
            enable = true;
            settings.highlight.enable = true;
          };
          autoclose.enable = true;
          lualine.enable = true;
          lsp-format.enable = true;
          lsp-lines.enable = true;
          rainbow-delimiters.enable = true;
        };
        defaultEditor = true;
      }
      (let
        treesitter-nu-grammar = pkgs.tree-sitter.buildGrammar {
          version = "unstable-2024-09-17";
          src = pkgs.fetchFromGitHub {
            owner = "nushell";
            repo = "tree-sitter-nu";
            rev = "91ada3c0bed7d2963f6bbe2a57d68d77e67c5f07";
            hash = "sha256-3Wng4cAMdHLSkDa+IJA6vNq9o5Ft93NSrRNu2cwJ970=";
          };
          language = "nu";
        };
      in {
        plugins.treesitter.grammarPackages =
          pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars
          ++ [treesitter-nu-grammar];
        extraPlugins = [treesitter-nu-grammar];
      })
    ];
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
