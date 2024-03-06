{ lib, config, inputs, ...}:
let 
  inherit (inputs.flake-utils.lib) system;
  inherit (lib) mkOption types;
in {
  
  options.system = mkOption {
    type = types.str;
    default = system.x86_64-linux;
  };
}
