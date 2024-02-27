{ pkgs, lib, config, ...}:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable main user";
    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
    description = lib.mkOption {
      default = "Main User";
      description = ''
      	Short description of the user, usually the full name.
      '';
    };
    hashedPasswordFile = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
      description = ''
      	hashed password file
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = cfg.description;
      hashedPasswordFile = cfg.hashedPasswordFile;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
    };
  };
}
