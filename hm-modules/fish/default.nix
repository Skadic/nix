{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.fish;
in
{
  options.skadic.programs.fish = {
    enable = mkEnableOption "enable fish";
  };
  
  config = mkIf cfg.enable {
    # Link the themes folder
    programs.fish = {
      enable = true;
      shellAliases = {
        rm = "trash";
        za =  ''
          set ZJ_SESSIONS (zellij list-sessions | rg -v 'EXITED' | awk '{print $1;}' | sed -e 's/\x1b\[[0-9;]*m//g')
          set NO_SESSIONS (echo $ZJ_SESSIONS | wc -w)

          if test $NO_SESSIONS -ge 2
            zellij attach (echo $ZJ_SESSIONS | string split " " | fzf --header "Choose Zellij Workspace")
          else if test $NO_SESSIONS -ge 1
            zellij attach -c
          else
            zellij
          end
        '';
      };
    };
  };
}
