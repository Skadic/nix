{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.skadic.programs.nvim;
  nvimCfg = pkgs.fetchFromGitHub {
    owner = "Skadic";
    repo = "nvim";
    rev = "5513e6b051a4779e55f5bba95787d2dc876ee29f";
    hash = "sha256-4P3n5313yYQdfK0hkvGTzar+SpD4M7eF6lAP6R9BFw4=";
  };
in
{
  options.skadic.programs.nvim = {
    enable = mkEnableOption "enable nvim";
  };
  
  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = nvimCfg;
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
