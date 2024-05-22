{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

imports =
  [
    ./hardware-configuration.nix
    ./../../modules/nixos/locale.nix
    #<home-manager/nixos>
    ../../modules/main-user.nix
  ];

main-user.enable = true;
main-user.userName = "sour";
users.defaultUserShell = pkgs.nushell;

nix.settings.experimental-features = [ "nix-command" "flakes" ];

programs.hyprland.enable = true;

networking = {
  hostName = "nixos";
  # hostName = "${hostname}";
  networkmanager.enable = true;

# firewall.allowedTCPPorts = [ ... ];
# firewall.allowedUDPPorts = [ ... ];

# Configure network proxy if necessary
# proxy.default = "http://user:password@proxy:port/";
# proxy.noProxy = "127.0.0.1,localhost,internal.domain";

};

xdg.portal = {
        enable = true;
        configPackages = with pkgs; [
                xdg-desktop-portal-gtk
        ];
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
  };

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
boot.supportedFilesystems = [ "ntfs" ];

services = {
  printing.enable = true;
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # blueman.enable = true;
  # Enable the OpenSSH daemon.
  # openssh.enable = true;
  gvfs.enable = true;
  devmon.enable = true;
  udisks2.enable = true;
  upower.enable = true;
  power-profiles-daemon.enable = true;
  gnome = {
    glib-networking.enable = true; # TODO probably delete
  };
  mpd = {
    enable = true;
    musicDirectory = "/home/sour/Music"; # TODO make this a variable
    extraConfig = ''
              # must specify one or more outputs in order to play audio
              # e.g., PipeWire
              audio_output {
                type "pipewire"
                name "My PipeWire Output"
              }
            '';
    user = "sour"; # TODO make this a variable

    startWhenNeeded = true;
  };
};
#  services.mpd = {
#    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.sour.uid}";
#  };
#displayManager = {
#	sddm = {
#	  enable = true;
#	  wayland = {
#	    enable = true;
#	    compositor = "weston";
#	  };
#	};
#};

sound.enable = true;
hardware = {
  pulseaudio.enable = false;
  bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
};

environment.systemPackages = with pkgs; [
  kitty
];

programs = {
  neovim.enable = true;
  nano.enable = false;
};
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

security = {
  polkit.enable = true;
  pam.services.swaylock = {};
  rtkit.enable = true;
};

system = {
  autoUpgrade.enable  = true;
  stateVersion = "23.11";
};

virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

# home-manager.backupFileExtension = "backup";

}
