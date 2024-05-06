{ inputs, pkgs, ... }:
{  
  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          # flavour = "latte";
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            treesitter = true;
          };
          styles = {
            booleans = [
              "bold"
              "italic"
            ];
            conditionals = [
              "bold"
            ];
          };
          term_colors = true;
        };
      };

      globals.mapleader = " ";

      plugins = {
        cmp.enable = true;
        cmp-buffer.enable = true;
        cmp-cmdline.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-path.enable = true;
        cmp_luasnip.enable = true;
        comment.enable = true;
        friendly-snippets.enable = true;
        fzf-lua.enable = true;
        lightline.enable = true;
        lint.enable = true; # TODO set up linting https://github.com/mfussenegger/nvim-lint
        luasnip.enable = true;
        nix.enable = true;
        surround.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        typst-vim.enable = true;
      };

      plugins.lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
      # {
      #   plugin = vimwiki;
      #   config = "";
      # }
    ];

    opts = {
      clipboard = [ "unnamedplus" ];
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    };
    extraConfigLua = ''
      print("Hiya")
    '';
    extraConfigVim = ''
    '';

  };

}
