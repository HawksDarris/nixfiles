# Run sudo nixos-rebuild switch --flake .#default
# Then run home-manager switch --flake .#sour
# TODO: 
# Figure out how to use disko
# 1. Impermanence
# 2. LUKS

{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/nixos/locale.nix
      #<home-manager/nixos>
      ../../modules/main-user.nix
    ];
main-user.enable = true;
main-user.userName = "sour";

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.hyprland.enable = true;
  xdg.portal = {
  	enable = true;
	configPackages = with pkgs; [
		xdg-desktop-portal-gtk
	];
	extraPortals = with pkgs; [
	  xdg-desktop-portal-gtk 
	];
  };

  users.defaultUserShell = pkgs.nushell;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # networking.hostName = "${hostname}"; 
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. Cannot use with networkmanager.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # services.blueman.enable = true;
  
  services.pipewire = {
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.sour = {
  #   isNormalUser = true;
  #   description = "sour";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #   ];
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    swww
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.neovim.enable = true;
  programs.nano.enable = false;


  security = {
  	polkit.enable = true;
	pam.services.swaylock = {};
	rtkit.enable = true;
  };

  services = {
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  	gvfs.enable = true;
	devmon.enable = true;
	udisks2.enable = true;
	upower.enable = true;
	power-profiles-daemon.enable = true;
	#displayManager = {
	#	sddm = {
	#	  enable = true;
	#	  wayland = {
	#	    enable = true;
	#	    compositor = "weston";
	#	  };
	#	};
	#};
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

  system = {
    autoUpgrade.enable  = true;
    stateVersion = "23.11"; # Did you read the comment?
  };

# TODO either figure this out (and delete firefox files on close, since the errors are caused mostly by firefox files existing during home-manager rebuilds)
#  home-manager.backupFileExtension = "backup";
}
