{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.eww;
in
{
  options.skadic.programs.eww = {
    enable = mkEnableOption "enable eww";
  };
  
  config = mkIf cfg.enable {
    home.packages = [ 
      inputs.eww.packages.x86_64-linux.eww
    ];
    xdg.configFile."eww".source = "${inputs.dots}/.config/eww";
  };
}
