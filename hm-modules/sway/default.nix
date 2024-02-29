{config, lib, ...}:
let
  cfg = config.skadic.windowManager.sway;
  inherit (lib) mkEnableOption mkIf mkOptionDefault;
in 
{
  options.skadic.windowManager.sway = {
    enable = mkEnableOption "enable sway";
  };

  config = {
    wayland.windowManager.sway =  let
      terminal = "foot";
      inherit (config.colorScheme) palette;
    in mkIf cfg.enable {
      enable = true;
      extraConfigEarly = ''
        set $terminal ${terminal}
        set $cl_acce #${palette.base0B}
        set $cl_high #${palette.base0B}
        set $cl_indi #${palette.base04}
        set $cl_surf #${palette.base02}
        set $cl_back #${palette.base00}
        set $cl_over #${palette.base03}
        set $cl_fore #${palette.base05}
        set $cl_intx #${palette.base04}
        set $cl_urge #${palette.base08}
      '';
      extraConfig = ''
        # Colors                border   bg       text     indi     childborder
        client.focused          $cl_acce $cl_back $cl_fore $cl_indi $cl_high
        client.focused_inactive $cl_over $cl_surf $cl_intx $cl_back $cl_back
        client.unfocused        $cl_over $cl_surf $cl_intx $cl_back $cl_back
        client.urgent           $cl_urge $cl_urge $cl_fore $cl_urge $cl_urge
      '';
      config = rec {
        modifier = "Mod4";
        inherit terminal;
        fonts = {
          names = [ "JetBrains Mono Nerd Font" ];
          size = 11.0;
        };
        window = {
          titlebar = false;
          border = 3;
        };
        floating = { 
          inherit modifier; 
          titlebar = false;
          border = 3;
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "de";
            xkb_variant = "neo_qwertz";
          };
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
          "type:touchpad" = {
            scroll_factor = "0.5";
            tap = "enabled";
            natural_scroll = "enabled";
          };
        };
        output = let 
          makeOutput = mon: { 
            inherit (mon) name; 
            value = {
              mode = "${toString mon.width}x${toString mon.height}@${toString mon.refreshRate}Hz";
              pos = "${toString mon.x} ${toString mon.y}";
            };
          };
          enabledMonitors = builtins.filter (mon: mon.enabled) config.monitors;
          outputList = map makeOutput enabledMonitors;
        in builtins.listToAttrs outputList;
        bars = [];
        gaps = {
          smartBorders = "on";
          inner = 8;
          outer = 10;
        };
        workspaceAutoBackAndForth = false;
        seat = {
          seat0 = {
            xcursor_theme = "Posy's Cursor Black";
          };
        };
        startup = [
          { command = "wpaperd"; }
          { command = "fcitx5"; }
          { command = "eww open topbar"; }
        ];
        keybindings = let 
          mod = config.wayland.windowManager.sway.config.modifier;
          modshift = "${mod}+Shift";
        in mkOptionDefault {
          "${modshift}+c" = "exec cd .config/sway && lmt config.md; reload";
          "${modshift}+r" = "restart";
          "${mod}+Return" = "exec $terminal";
          "${mod}+d" = "exec rofi -show drun";
          "${mod}+p" = "exec rofi -show run";
          "XF86MonBrightnessUp" = "exec 'brightnessctl set +10'";
          "XF86MonBrightnessDown" = "exec 'brightnessctl set 10-'";
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+odiaeresis" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          "${mod}+1" = "workspace $ws1";
          "${mod}+2" = "workspace $ws2";
          "${mod}+3" = "workspace $ws3";
          "${mod}+4" = "workspace $ws4";
          "${mod}+5" = "workspace $ws5";
          "${mod}+6" = "workspace $ws6";
          "${mod}+7" = "workspace $ws7";
          "${mod}+8" = "workspace $ws8";
          "${mod}+b" = "workspace back_and_forth";
          "${mod}+Ctrl+Right" = "workspace next";
          "${mod}+Ctrl+Left" = "workspace prev";
          "${modshift}+j" = "move left";
          "${modshift}+k" = "move down";
          "${modshift}+l" = "move up";
          "${modshift}+odiaeresis" = "move right";
          "${modshift}+Left" = "move left";
          "${modshift}+Down" = "move down";
          "${modshift}+Up" = "move up";
          "${modshift}+Right" = "move right";
          "${mod}+Ctrl+1" = "move container to workspace $ws1";
          "${mod}+Ctrl+2" = "move container to workspace $ws2";
          "${mod}+Ctrl+3" = "move container to workspace $ws3";
          "${mod}+Ctrl+4" = "move container to workspace $ws4";
          "${mod}+Ctrl+5" = "move container to workspace $ws5";
          "${mod}+Ctrl+6" = "move container to workspace $ws6";
          "${mod}+Ctrl+7" = "move container to workspace $ws7";
          "${mod}+Ctrl+8" = "move container to workspace $ws8";
          "${modshift}+1" = "move container to workspace $ws1; workspace $ws1";
          "${modshift}+2" = "move container to workspace $ws2; workspace $ws2";
          "${modshift}+3" = "move container to workspace $ws3; workspace $ws3";
          "${modshift}+4" = "move container to workspace $ws4; workspace $ws4";
          "${modshift}+5" = "move container to workspace $ws5; workspace $ws5";
          "${modshift}+6" = "move container to workspace $ws6; workspace $ws6";
          "${modshift}+7" = "move container to workspace $ws7; workspace $ws7";
          "${modshift}+8" = "move container to workspace $ws8; workspace $ws8";
          "${modshift}+b" = "move container to workspace back_and_forth; workspace back_and_forth";
          "${modshift}+q" = "kill";
          "${mod}+u" = "border none";
          "${mod}+y" = "border pixel 2";
          "${mod}+n" = "border normal";
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+q" = "split toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${modshift}+space" = "floating toggle";
          "${mod}+f" = "fullscreen toggle";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "       exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioStop" = "exec playerctl stop";
          "Shift+Print" = "exec grim -g '$(slurp)' - | wl-copy";
          "${mod}+r" = "mode 'resize'";
          "${modshift}+g" = "mode '${mod}e_gaps'";
        };
      };
    };
  };
}
