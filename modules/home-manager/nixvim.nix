{ config, inputs, pkgs, ... }:
{
  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim = {
      enableMan = true;
      enable = true;
      defaultEditor = true;
      highlight = {
      };
      colorschemes.base16 = with config.colorScheme.palette; {
        enable = true;
        colorscheme = {
          base00 = "#${base00}";
          base01 = "#${base01}";
          base02 = "#${base02}";
          base03 = "#${base03}";
          base04 = "#${base04}";
          base05 = "#${base05}";
          base06 = "#${base06}";
          base07 = "#${base07}";
          base08 = "#${base08}";
          base09 = "#${base09}";
          base0A = "#${base0A}";
          base0B = "#${base0B}";
          base0C = "#${base0C}";
          base0D = "#${base0D}";
          base0E = "#${base0E}";
          base0F = "#${base0F}";
        };
      };
      globals.mapleader = " ";
      plugins = {
        cmp = {
          enable = true;
          autoEnableSources = true;
        };
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
        rainbow-delimiters.enable = true;
        surround.enable = true;
        telescope.enable = true;
        treesitter = {
          enable = true;
          folding = true;
          indent = true;
        };
        typst-vim.enable = true;
        nvim-colorizer.enable = true;
        vimtex = {
          enable = true;
          texlivePackage = null; # if not set to null, has default package: texlive-combined-medium-2023-final. I need full.
          settings = {
            # compiler_method = "latexrun";
            view_method = "zathura";
          };
        };
      };

      plugins.lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          kotlin-language-server.enable = true;
          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          nushell.enable = true;
          tsserver.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        {
          plugin = vimwiki;
          config = "
          ";
        }
      ];

      autoCmd = [
        {
          event = [ "BufWritePost" ];
          pattern = [ "*.c" "*.cpp" "*.cs" "*.go" "*.h" "*.java" "*.m" "*.md" "*.mom" "*.ms" "*.py" "*.Rmd" "*.rs" "*.sass" "*.scad" "*.sent" "*.tex" "*.typ" ];
          callback = {
            __raw = "function() CompileOnSave() end";
          };
        }
      ];


      opts = {
        clipboard = [ "unnamedplus" ];
        number = true;         # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2;        # Tab width should be 2
      };

      extraConfigLua = ''
      local function AvoidStrings(bufname)
        local stringsToAvoid = {"reveal.js%-master/", "README"}
        for i = 1, #stringsToAvoid do
          if stringsToAvoid[i] == bufname then
            return true
          end
        end
        return false
      end
      local function CompileOnSave()
        local bufname = vim.api.nvim_buf_get_name(0)
        local filename = bufname:match("^.+/(.+)%..+$")
        local output_html = filename .. ".html"
        if not AvoidStrings(bufname) then
          os.execute("compiler \"" .. bufname .. "\"" )
        end
        if string.find(bufname, "reveal.js%-master/") then
          os.execute("pandoc -i \"" .. bufname .. "\" -t revealjs -o " .. output_html .. " --slide-level=2 --standalone")
        end
      end
      init=function ()
      vim.g.vimwiki_ext2syntax = {
        Rmd = 'markdown',
        rmd = 'markdown',
        md = 'markdown',
        markdown = 'markdown',
        mdown = 'markdown',
           }
      local l = {}
      l.path = '$HOME/Documents'
      l.syntax = 'markdown'
      l.ext = '.md'
      l.nested_syntaxes = {
        js = 'javascript',
        html = 'html',
        css = 'css',
        python = 'python',
        py = 'python',
        rust = 'rust',
        tex = 'tex',
              }
      vim.g.vimwiki_list = {
        l
                          }
      -- Do not apply vimwiki settings to all md files
      vim.g.vimwiki_global_ext = 0
      -- Conceal preformatted text markers
      vim.g.vimwiki_conceal_pre = 1
      -- This is to allow code execution on python
      -- This needs to be done in the vimwiki_server settings, if I decide to bring that to nvchad
      -- vim.g.vimwiki_server#code#python = 'python3'
      -- stop vimwiki from stealing the tab key for completion purposes
      vim.g.vimwiki_key_mappings = {
        table_mappings = 0,
                                                                  }
      end
      '';

      extraConfigVim = ''
      '';
    };
}
