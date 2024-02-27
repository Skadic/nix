{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.rofi;
  themes = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "5350da41a11814f950c3354f090b90d4674a95ce";
    hash = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
  };
in
{
  options.skadic.programs.rofi = {
    enable = mkEnableOption "enable rofi";
  };
  
  config = mkIf cfg.enable {
    # Link the themes folder
    home.file.".local/share/rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "${themes}/basic/.local/share/rofi/themes";
    programs.rofi = {
      enable = true;
      theme = "${themes}/basic/.config/rofi/config.rasi";
    };
  };
}
