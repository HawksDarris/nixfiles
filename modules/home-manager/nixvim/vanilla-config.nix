{
  programs.nixvim.opts = {
    clipboard = [ "unnamedplus" ];
    cursorline = true;
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2;        # Tab width should be 2
    tabstop = 2;
    softtabstop = 2;
    showtabline = 2;
    showmode = false;
    expandtab = true;
    smartindent = true;
    breakindent = true;
    hlsearch = true;
    incsearch = true;
    wrap = true;
    splitbelow = true;
    splitright = true;
    mouse = "a"; # Mouse
    ignorecase = true;
    smartcase = true; # Don't ignore case with capitals
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";

    updatetime = 50; # faster completion (4000ms default)

    # Set completeopt to have a better completion experience
    completeopt = ["menuone" "noselect" "noinsert"]; # mostly just for cmp

    # Enable persistent undo history
    swapfile = false;
    backup = false;
    undofile = true;

    # Enable 24-bit colors
    termguicolors = true;

    # Enable the sign column to prevent the screen from jumping
    signcolumn = "yes";

    # These options were reccommended by nvim-ufo
    # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

    # Always keep 8 lines above/below cursor unless at start/end of file
    scrolloff = 8;

    # Place a column line
    colorcolumn = "80";

    # Reduce which-key timeout to 10ms
    timeoutlen = 100;

    # Set encoding type
    encoding = "utf-8";
    fileencoding = "utf-8";

    # Change cursor options
    guicursor = [
      "n-v-c:block" # Normal, visual, command-line: block cursor
      "i-ci-ve:block" # Insert, command-line insert, visual-exclude: vertical bar cursor with block cursor, use "ver25" for 25% width
      "r-cr:hor20" # Replace, command-line replace: horizontal bar cursor with 20% height
      "o:hor50" # Operator-pending: horizontal bar cursor with 50% height
      "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" # All modes: blinking settings
      "sm:block-blinkwait175-blinkoff150-blinkon175" # Showmatch: block cursor with specific blinking settings
    ];

    # Enable chars list
    list = true; # Show invisible characters (tabs, eol, ...)
    listchars = "eol:↲,tab:|->,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";

    # More space in the neovim command line for displaying messages
    cmdheight = 2;

    # Maximum number of items to show in the popup menu (0 means "use available screen space")
    pumheight = 0;

    # Use conform-nvim for gq formatting. ('formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it)
    formatexpr = "v:lua.require'conform'.formatexpr()";

    laststatus = 3; # (https://neovim.io/doc/user/options.html#'laststatus')
  };

  programs.nixvim.globals.mapleader = " ";

  # extraPlugins = with pkgs.vimPlugins; [
  #   {
  #   }
  # ];

  programs.nixvim.autoCmd = [
    {
      event = [ "BufWritePost" ];
      pattern = [ "*.c" "*.cpp" "*.cs" "*.go" "*.h" "*.java" "*.m" "*.md" "*.mom" "*.ms" "*.py" "*.Rmd" "*.rs" "*.sass" "*.scad" "*.sent" "*.typ" ];
      callback = {
        __raw = "function() CompileOnSave() end"; # TODO: Make CompileOnSave a switch so it only compiles on save after the function has been manually called
      };
    }
  ];

  programs.nixvim.extraConfigLua = ''
      local opt = vim.opt
      local g = vim.g
      local o = vim.o
      -- Neovide
      if g.neovide then
        -- Neovide options
        g.neovide_fullscreen = false
        g.neovide_hide_mouse_when_typing = false
        g.neovide_refresh_rate = 165
        g.neovide_cursor_vfx_mode = "ripple"
        g.neovide_cursor_animate_command_line = true
        g.neovide_cursor_animate_in_insert_mode = true
        g.neovide_cursor_vfx_particle_lifetime = 5.0
        g.neovide_cursor_vfx_particle_density = 14.0
        g.neovide_cursor_vfx_particle_speed = 12.0
        g.neovide_transparency = 0.8

        -- Neovide Fonts
        -- o.guifont = "CommitMono:Medium:h15"
        o.guifont = "JetBrainsMono Nerd Font:h14:Medium:i"
        -- o.guifont = "FiraMono Nerd Font:Medium:h14"
        -- o.guifont = "CaskaydiaCove Nerd Font:h14:b:i"
      end
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
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        }
      }

      require("neorg").setup {
        load = {
          ["core.defaults"] = {}
        }
      }
      '';

  programs.nixvim.extraConfigVim = ''
      '';
}

