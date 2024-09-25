{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        separatorStyle = "thick"; # “slant”, “padded_slant”, “slope”, “padded_slope”, “thick”, “thin“
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
    };
  };
}
