{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.zellij;
in
{
  options.skadic.programs.zellij = {
    enable = mkEnableOption "enable zellij";
  };
  
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = false;
    };
    xdg.configFile."zellij".source = "${inputs.dots}/.config/zellij";
  };
}
