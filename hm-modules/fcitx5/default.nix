{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.fcitx5;
  catppuccin = inputs.catppuccin-fcitx5;
in
{
  options.skadic.programs.fcitx5 = {
    enable = mkEnableOption "enable fcitx5";
  };
  
  config = mkIf cfg.enable {
    xdg.configFile."fcitx5/conf/classicui.conf".text = "Theme=catppuccin-mocha";
    xdg.dataFile."fcitx5/themes".source = "${catppuccin}/src";

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
      };
    };

    home.sessionVariables = {
      # https://www.reddit.com/r/swaywm/comments/i6qlos/how_do_i_use_an_ime_with_sway/g1lk4xh?utm_source=share&utm_medium=web2x&context=3
      INPUT_METHOD="fcitx";
      QT_IM_MODULE="fcitx";
      GTK_IM_MODULE="fcitx";
      XMODIFIERS="@im=fcitx";
      XIM_SERVERS="fcitx";
    };
  };
}
