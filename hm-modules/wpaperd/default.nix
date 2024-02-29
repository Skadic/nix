{ config, lib, pkgs, ... }:
let 
  cfg = config.skadic.programs.wpaperd;
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) fetchurl;
  bg1 = fetchurl {
    url = "https://i.pximg.net/img-original/img/2020/09/26/10/09/10/82687664_p0.png";
    hash = "";
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
  };
}
