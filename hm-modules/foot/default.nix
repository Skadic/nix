{ lib, config, ... }:
let
  cfg = config.skadic.programs.foot;
  inherit (lib) mkIf mkEnableOption;
in 
{
  options.skadic.programs.foot = {
    enable = mkEnableOption "enable foot";
  };

  config = mkIf cfg.enable {
    programs.foot = let 
      colors = config.colorScheme.palette;
    in {
      enable = true;
      settings = {
        main = {
          dpi-aware = "no";
          pad = "5x5 center";
          font="FantasqueSansM Nerd Font Mono:style=Regular:size=15";
          font-bold="FantasqueSansM Nerd Font Mono:style=Bold:size=15";
          font-italic="FantasqueSansM Nerd Font Mono:style=Italic:size=15";
          font-bold-italic="FantasqueSansM Nerd Font Mono:style=Bold Italic:size=15";
          workers = 4;
        };

        colors = {
          alpha = "0.95";
          foreground = colors.base05; # Text
          background = colors.base00; # Base
          regular0 = colors.base03;   # Surface 1
          regular1 = colors.base08;   # red
          regular2 = colors.base0B;   # green
          regular3 = colors.base0A;   # yellow
          regular4 = colors.base0D;   # blue
          regular5 = colors.base06;   # pink
          regular6 = colors.base0D;   # teal
          regular7 = colors.base02;   # Subtext 1
          bright0 = colors.base04;    # Surface 2
          bright1 = colors.base08;   # red
          bright2 = colors.base0B;   # green
          bright3 = colors.base0A;   # yellow
          bright4 = colors.base0D;   # blue
          bright5 = colors.base06;   # pink
          bright6 = colors.base0D;   # teal
          bright7 = colors.base04;    # Subtext 0
        };
      };
    };
  };
}
