{

programs.nixvim.opts = {
  clipboard = [ "unnamedplus" ];
  cursorline = true;
  number = true;         # Show line numbers
  relativenumber = true; # Show relative line numbers
  shiftwidth = 2;        # Tab width should be 2
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

