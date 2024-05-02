{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.nvim;
in
{
  options.skadic.programs.nvim = {
    enable = mkEnableOption "enable nvim";
  };
  
  config = mkIf cfg.enable {
    home.packages = [ 
      pkgs.tree-sitter 
    ];
    xdg.configFile."nvim".source = inputs.nvimconf;
    # Link the themes folder
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withPython3 = true;
      defaultEditor = true;
      package = pkgs.neovim;
    };
  };
}
