{ lib, config, inputs, ... }:
with lib;
let
  cfg = config.skadic.programs.nvim;
in
{
  options.skadic.programs.nvim = {
    enable = mkEnableOption "enable nvim";
  };
  
  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = inputs.nvimconf;
    # Link the themes folder
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withPython3 = true;
      defaultEditor = true;
    };
  };
}
