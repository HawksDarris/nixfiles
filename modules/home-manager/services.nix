# [[file:../../README.org::*Services][Services:1]]
{ ... }:
{
# Services:1 ends here

# [[file:../../README.org::*Emacs][Emacs:1]]
services.emacs.client.enable = true;
# Emacs:1 ends here

# [[file:../../README.org::*Syncthing][Syncthing:1]]
services.syncthing = {
  enable = true;
  extraOptions = [
    "--gui-user=${username}"
  ];
};
# Syncthing:1 ends here

# [[file:../../README.org::*Espanso][Espanso:1]]
services.espanso = {
  enable = true;
  configs = {
    default = {
    };
  };
  package = pkgs.espanso-wayland;
  wayland = true;
  matches = {
    matches = [
      {
        trigger = ":hello";
        replace = ''world'';
      }
    ];
    base = {
      matches = [
        {
          trigger = ":now";
          replace = "It's {{currentdate}} {{currenttime}}";
        }
      ];
    };
  };
};
# Espanso:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
}
# Closing:1 ends here
