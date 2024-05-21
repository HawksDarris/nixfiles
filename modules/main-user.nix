{ lib, config, pkgs, ... }:

{
  options = {
    main-user.enable
      = lib.mkEnableOption "enable user module";
    main-user.userName = lib.mkOption {
      default = "sour";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "12345";
      description = "${config.main-user.userName}";
      shell = pkgs.nushell;
    };
  };
}
