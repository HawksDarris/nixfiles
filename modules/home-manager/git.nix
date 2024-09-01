{
  programs.git = {
    enable = true;
    userName = "HawksDarris";
    userEmail = "darris.hawks@gmail.com";
    diff-so-fancy = {
      enable = true;
      changeHunkIndicators = true;
    };
    extraConfig = {
      core = {
        editor = "nvim";
        # whitespace = "trailing-space,space-before-tab";
      };
      # url = {
      #   "https://mirror.ghproxy.com/https://github" = {
      #     insteadOf = "https://github";
      #   };
      # };
    };
  };
}
