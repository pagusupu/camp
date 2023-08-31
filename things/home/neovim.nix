{
  pkgs,
  lib,
  config,
  ...
}: let
  mountain = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "mountain";
    src = pkgs.fetchFromGitHub {
      owner = "mountain-theme";
      repo = "vim";
      rev = "99d4b7bf1a0a12f2d78f35a159384b1eb8aa9c15";
      hash = "sha256-wOA40gja1Htbk4StafdO4ri3Pyx8PfkQ3vqgh2pMjnY=";
    };
  };
in {
  options.local.programs.neovim = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        lua <<EOF
        local o = vim.opt
        o.lazyredraw = true
        o.shell = "zsh"
        o.shadafile = "NONE"
        o.ttyfast = true
        o.termguicolors = true
        o.undofile = true
        o.smartindent = true
        o.tabstop = 4
        o.shiftwidth = 4
        o.shiftround = true
        o.expandtab = true
        o.cursorline = true
        o.relativenumber = true
        o.number = true
        o.viminfo = ""
        o.viminfofile = "NONE"
        o.wrap = false
        o.splitright = true
        o.splitbelow = true
        o.laststatus = 0
        o.cmdheight = 0
        vim.cmd.colorscheme 'mountain'
        vim.api.nvim_command("autocmd TermOpen * startinsert")
        vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")

        require('nvim-tree').setup {
          disable_netrw = true,
          hijack_netrw = true,
          hijack_cursor = true,
          git = {
            enable = true,
          },
          sort_by = "case_sensitive",
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = true,
          },
        }
        require('nvim-treesitter.configs').setup {
          ensure_install = "maintained",
          highlight = {
            enable = true,
          },
          indent = { enable = true },
        }
        require('lspconfig').nil_ls.setup {
          autostart = true,
          capabilities = vim.lsp.protocol.make_client_capabilities(),
          cmd = {'nil'},
          settings = {
            ['nil'] = {
              formatting = {
                command = {'alejandra', '--quiet'},
              }
            }
          }
        }
        require('null-ls').setup {
          sources = {
            require('null-ls').builtins.formatting.alejandra,
            require('null-ls').builtins.diagnostics.deadnix
          }
        }
        EOF
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        null-ls-nvim
        nvim-treesitter
        nvim-ts-rainbow2
        nvim-tree-lua
        nvim-web-devicons
        lualine-nvim
        mountain
      ];
    };
   home.packages = with pkgs; [
     deadnix
     statix
     nil
    ];
  };
}
