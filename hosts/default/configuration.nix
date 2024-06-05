# [[file:../../README.org::*Main File: configuration.nix][Main File: configuration.nix:1]]
{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
# Main File: configuration.nix:1 ends here

# [[file:../../README.org::*Imports][Imports:1]]
imports =
  [
    ./hardware-configuration.nix
    ./../../modules/nixos/locale.nix
    ../../modules/nixos/overrides.nix
    ../../modules/main-user.nix
    #<home-manager/nixos>
  ];
# Imports:1 ends here

# [[file:../../README.org::*User Set-up][User Set-up:1]]
main-user.enable = true;
main-user.userName = "sour";
users.defaultUserShell = pkgs.nushell;
# User Set-up:1 ends here

# [[file:../../README.org::*Flake Set-up][Flake Set-up:1]]
nix.settings.experimental-features = [ "nix-command" "flakes" ];
# Flake Set-up:1 ends here

# [[file:../../README.org::*Hyprland][Hyprland:1]]
programs.hyprland.enable = true;
# Hyprland:1 ends here

# [[file:../../README.org::*Opening][Opening:1]]
networking = {
  hostName = "nixos";
  # hostName = "${hostname}";
  networkmanager.enable = true;
# Opening:1 ends here

# [[file:../../README.org::*Firewall][Firewall:1]]
# firewall.allowedTCPPorts = [ ... ];
# firewall.allowedUDPPorts = [ ... ];
# Firewall:1 ends here

# [[file:../../README.org::*Proxy][Proxy:1]]
# Configure network proxy if necessary
# proxy.default = "http://user:password@proxy:port/";
# proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# Proxy:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
};
# Closing:1 ends here

# [[file:../../README.org::*XDG Portal][XDG Portal:1]]
xdg.portal = {
        enable = true;
        configPackages = with pkgs; [
                xdg-desktop-portal-gtk
        ];
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
  };
# XDG Portal:1 ends here

# [[file:../../README.org::*Bootloader][Bootloader:1]]
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
boot.supportedFilesystems = [ "ntfs" ];
# Bootloader:1 ends here

# [[file:../../README.org::*Services][Services:1]]
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
# Services:1 ends here

# [[file:../../README.org::*Sound][Sound:1]]
sound.enable = true;
hardware = {
  pulseaudio.enable = false;
  bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
};
# Sound:1 ends here

# [[file:../../README.org::*System Packages][System Packages:1]]
environment.systemPackages = with pkgs; [
  kitty
];
# System Packages:1 ends here

# [[file:../../README.org::*Programs][Programs:1]]
programs = {
  neovim.enable = true;
  nano.enable = false;
};
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };
# Programs:1 ends here

# [[file:../../README.org::*Security][Security:1]]
security = {
  polkit.enable = true;
  pam.services.swaylock = {};
  rtkit.enable = true;
};
# Security:1 ends here

# [[file:../../README.org::*System][System:1]]
system = {
  autoUpgrade.enable  = true;
  stateVersion = "23.11";
};
# System:1 ends here

# [[file:../../README.org::*Virtual Machine Configuration][Virtual Machine Configuration:1]]
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;
# Virtual Machine Configuration:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
}
# Closing:1 ends here
