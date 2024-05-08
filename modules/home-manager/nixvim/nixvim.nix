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
        vim-css-color.enable = true;
        vimtex = {
          enable = true; 
#          texlivePackage = null; # if not set, has default package
          settings = {
            # compiler_method = "latexrun";
            view_method = "zathura";
          };
        };
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
      {
        plugin = vimwiki;
        config = "
        ";
      }
    ];

    autoCmd = [
      {
        event = [ "BufWritePost" ];
        pattern = [ "*.c" "*.cpp" "*.cs" "*.go" "*.h" "*.java" "*.m" "*.md" "*.mom" "*.ms" "*.org" "*.py" "*.Rmd" "*.rs" "*.sass" "*.scad" "*.sent" "*.tex" "*.typ" ];
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
    local function IsRevealJSPresentation(bufname)
    if string.find(bufname, "reveal.js%-master/") then
      return true
    else 
      return false
    end
    end

    local function CompileOnSave()
    local bufname = vim.api.nvim_buf_get_name(0)
    local filename = bufname:match("^.+/(.+)%..+$")
    local output_html = filename .. ".html"

    if IsRevealJSPresentation(bufname) then
      os.execute("pandoc -i \"" .. bufname .. "\" -t revealjs -o " .. output_html .. " --slide-level=2 --standalone")
      os.execute("sed -i 's;https://unpkg.com/reveal.js@^4//;../;g' " .. output_html)
    else 
      -- print(bufname)
      os.execute("compiler \"" .. bufname .. "\"" )
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
