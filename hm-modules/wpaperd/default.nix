{ config, lib, pkgs, ... }:
let 
  cfg = config.skadic.programs.wpaperd;
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) fetchurl;
  bg1 = fetchurl {
    url = "https://konachan.net/image/99b220c21bcd3a52e4df009afbc16ab2/Konachan.com%20-%20309927%20animal_ears%20boat%20even_%28even_yiwen%29%20hood%20monochrome%20original%20short_hair%20tentacles.png";
    hash = "sha256-I+bdtBV3JSfWG5/uKWNihoLeFMkY/cxJ8xT1TPzDg5E=";
  };
in {
  options.skadic.programs.wpaperd = {
    enable = mkEnableOption "enable wpaperd";
  };

  config = mkIf cfg.enable {
    programs.wpaperd = {
      enable = true;
      settings = {
        Virtual-1 = {
          path = bg1;
        };
      };
    };
    wayland.windowManager.sway.config.startup = [ 
        { command = "wpaperd"; }
    ];
  };
}
