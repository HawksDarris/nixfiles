# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      #<home-manager/nixos>
      #../../modules/main-user.nix
    ];

  programs.hyprland.enable = true;

  users.defaultUserShell = pkgs.nushell;

  #home-manager.users.sour = { pkgs, ... }: {

    #home.packages = with pkgs; [ ];

   # home.stateVersion = "23.11";
  # };

#  Can't use global packages and nixpkgs in home.nix at the same time (it's only for use of home-manager as a module)
#  home-manager.useGlobalPkgs = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone. time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

#main-user.enable = true;
#main-user.userName = "sour";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sour = {
    isNormalUser = true;
    description = "sour";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  gnome.adwaita-icon-theme
  loupe
  baobab
  kitty
  # gnome-software
  wl-gammactl
  wl-clipboard
  wayshot
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

  xdg.portal = {
  	enable = true;
	configPackages = with pkgs; [
		xdg-desktop-portal-gtk
	];
	extraPortals = with pkgs; [
	  xdg-desktop-portal-gtk 
	];
  };

  security = {
  	polkit.enable = true;
	pam.services.swaylock = {};
	rtkit.enable = true;
  };

  services = {
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
		# evolution-data-server.enable = true;# TODO probably delete
		glib-networking.enable = true; # TODO probably delete
		# gnome-keyring.enable = true;
		# gnome-online-accounts.enable = true; # TODO probably delete
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

  system.autoUpgrade.enable  = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
