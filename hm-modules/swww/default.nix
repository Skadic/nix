{ config, lib, pkgs, pkgs-unstable, ... }:
let
  cfg = config.skadic.programs.swww;
  inherit (lib) mkEnableOption mkIf;
in {
  options.skadic.programs.swww = {
    enable = mkEnableOption "enable swww";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs-unstable.swww ];
    home.sessionVariables = {
      SWWW_TRANSITION_FPS=60;
      SWWW_TRANSITION_STEP=90; # 2
      SWWW_TRANSITION="wave";
      SWWW_TRANSITION_POS="0.8,0.9";
    };
    wayland.windowManager.sway.config.startup = [ 
        { command = "swww-daemon"; }
    ];
  };
}
