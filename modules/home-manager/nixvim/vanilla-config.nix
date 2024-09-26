{
pkgs,
lib,
config,
...
}:   

programs.nixvim.opts = {
  clipboard = [ "unnamedplus" ];
  cursorline = true;
  number = true;         # Show line numbers
  relativenumber = true; # Show relative line numbers
  shiftwidth = 2;        # Tab width should be 2
};

};

