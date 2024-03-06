{ lib, pkgs, config, ...}:
let 
  cfg = config.skadic.programs.kitty;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.skadic.programs.kitty = {
    enable = mkEnableOption "enable the kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.kitty = let 
      colors = config.colorScheme.palette;
    in {
      enable = true;
      font = {
        name = "FantasqueSansM Nerd Font Mono";
        size = 15;
      };
      shellIntegration.enableFishIntegration = true;
      keybindings = {
        "ctrl+plus" = "change_font_size all +2.0";
        "ctrl+minus" = "change_font_size all -2.0";
        "ctrl+backspace" = "change_font_size all 0";
      };
      settings = {
        confirm_os_window_close = 0;
        disable_ligatures = "never";
        kitty_mod = "ctrl+shift";

        # Color theme settings
        background_opacity = "0.7";

        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        selection_background = "#${colors.base05}";
        selection_foreground = "#${colors.base00}";
        url_color = "#${colors.base0D}";
        cursor = "#${colors.base0D}";
        cursor_text_color = "#${colors.base00}";
        active_border_color = "#${colors.base03}";
        inactive_border_color = "#${colors.base01}";
        active_tab_background = "#${colors.base00}";
        active_tab_foreground = "#${colors.base05}";
        inactive_tab_background = "#${colors.base01}";
        inactive_tab_foreground = "#${colors.base04}";

        # Normal
        color0 = "#${colors.base00}";
        color1 = "#${colors.base08}";
        color2 = "#${colors.base0B}";
        color3 = "#${colors.base0A}";
        color4 = "#${colors.base0D}";
        color5 = "#${colors.base0E}";
        color6 = "#${colors.base0C}";
        color7 = "#${colors.base05}";

        # Bright (same as Normal except 8/15)
        color8 = "#${colors.base03}";
        color9 = "#${colors.base08}";
        color10 = "#${colors.base0B}";
        color11 = "#${colors.base0A}";
        color12 = "#${colors.base0D}";
        color13 = "#${colors.base0E}";
        color14 = "#${colors.base0C}";
        color15 = "#${colors.base07}";

        # Other (like base16-shell)
        color16 = "#${colors.base09}";
        color17 = "#${colors.base0F}";
        color18 = "#${colors.base01}";
        color19 = "#${colors.base02}";
        color20 = "#${colors.base04}";
        color21 = "#${colors.base06}";
      };
    };
  };
}
