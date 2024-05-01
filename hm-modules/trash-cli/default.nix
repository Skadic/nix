{pkgs, config, lib, ...}: let 
  cfg = config.skadic.programs.trash-cli;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.skadic.programs.trash-cli = {
    enable = mkEnableOption "enable trash-cli";
  };

  
  config = mkIf cfg.enable {
    home.packages = [ pkgs.trash-cli ];
    programs.fish.shellAliases = { 
      trash-size = "ll --total-size --no-permissions $(trash-list --trash-dirs) | grep files | string trim | string split \" \" | head -n 1";
      rm = "trash";
    };
  };

}
