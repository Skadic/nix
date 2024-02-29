{ config, lib, pkgs, ...}:
let
  nfThemes = pkgs.fetchFromGitHub {
    owner = "Chick2D";
    repo = "neofetch-themes";
    rev = "3ea7c37ae791aa31240434dbda2e0cb387d1ddfe";
    hash = "sha256-btK1TZg49bASOFxQDY5edE0QM+iSsTQmJko4AiyYlpY=";
  };
  cfg = config.skadic.programs.neofetch;
  inherit (lib) mkIf mkEnableOption mkOption types;
in 
{
  options.skadic.programs.neofetch = {
    enable = mkEnableOption "enable neofetch";
    theme = mkOption {
      type = types.str;
      default = "normal/ozozfetch.conf";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.neofetch ];
    xdg.configFile."neofetch/config.conf".source = "${nfThemes}/${cfg.theme}";
  };
}
