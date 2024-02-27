{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.skadic.services.mako;
in
{
  options.skadic.services.mako = {
    enable = mkEnableOption "enable mako";
  };
  
  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      font = "Noto Sans CJK JP 10";
      height = 150;
      width = 200;
      backgroundColor="#1E1E2E";
      textColor="#CDD6F4";
      borderColor="#6C7086";
      borderRadius=5;
      progressColor="over #A6D189AA";
      defaultTimeout=3000;
      extraConfig=''
        [urgency=high]
        border-color=#EF9F76
        default-timeout=7500
      '';
    };
  };
}
