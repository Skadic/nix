{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.eww;
in
{
  options.skadic.programs.eww = {
    enable = mkEnableOption "enable eww";
    topbar-src = mkOption {
      type = types.str;
      example = "topbar-laptop.yuck";
    };
  };
  
  config = mkIf cfg.enable {
    home.packages = [ 
      inputs.eww.packages.x86_64-linux.eww
    ];
    xdg.configFile."eww/eww.yuck".text = "(include \"${cfg.topbar-src}\")";
    
    xdg.configFile."eww/carbonfox.scss".source = "${inputs.dots}/.config/eww/carbonfox.scss";
    xdg.configFile."eww/catppuccin.scss".source = "${inputs.dots}/.config/eww/catppuccin.scss";
    xdg.configFile."eww/colors.scss".source = "${inputs.dots}/.config/eww/colors.scss";
    xdg.configFile."eww/dashboard.scss".source = "${inputs.dots}/.config/eww/dashboard.scss";
    xdg.configFile."eww/dashboard.yuck".source = "${inputs.dots}/.config/eww/dashboard.yuck";
    xdg.configFile."eww/dracula.scss".source = "${inputs.dots}/.config/eww/dracula.scss";
    xdg.configFile."eww/eww.scss".source = "${inputs.dots}/.config/eww/eww.scss";
    xdg.configFile."eww/example.yuck".source = "${inputs.dots}/.config/eww/example.yuck";
    xdg.configFile."eww/scripts".source = "${inputs.dots}/.config/eww/scripts";
    xdg.configFile."eww/topbar-desktop.yuck".source = "${inputs.dots}/.config/eww/topbar-desktop.yuck";
    xdg.configFile."eww/topbar-laptop.yuck".source = "${inputs.dots}/.config/eww/topbar-laptop.yuck";
    xdg.configFile."eww/topbar.scss".source = "${inputs.dots}/.config/eww/topbar.scss";
    xdg.configFile."eww/topbar.yuck".source = "${inputs.dots}/.config/eww/topbar.yuck";
    xdg.configFile."eww/vars.scss".source = "${inputs.dots}/.config/eww/vars.scss";
  };
}
