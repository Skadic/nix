{ config, pkgs, inputs, ... }:
let 
  flake-utils = inputs.flake-utils.lib;
in
{
  imports = [
    ../../hm-modules
    inputs.nix-colors.homeManagerModules.default
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "skadic";
  home.homeDirectory = "/home/skadic";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  system = flake-utils.system.x86_64-linux;
  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 144;
      x = 1920;
      y = 0;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 0;
      y = 0;
    }
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  #colorScheme = inputs.nix-colors.colorSchemes.kanagawa;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  #home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  #];

  home.packages = with pkgs; [
    thunderbird
    floorp
    kitty
    bitwarden
    nextcloud-client
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    gcc
    gnumake
    ninja
    cmake
    rustup
    ripgrep
    wl-clipboard
    hyprpaper
    nurl
    nodejs
    podman
    podman-compose
    discord
    telegram-desktop
    zotero
    obsidian
    logseq
    pavucontrol
  ];

  skadic.windowManager.sway.enable = true;

  skadic.programs.eww = {
    enable = true; 
    topbar-src = "topbar-desktop.yuck";
  };
  skadic.programs.fcitx5.enable = true;
  skadic.programs.zellij.enable = true;
  skadic.programs.rofi.enable = true;
  skadic.programs.nvim.enable = true;
  skadic.programs.foot.enable = true;
  skadic.programs.kitty.enable = true;
  skadic.programs.fish.enable = true;
  skadic.programs.trash-cli.enable = true;
  skadic.programs.swww.enable = true;
  skadic.programs.neofetch.enable = true;
  skadic.services.mako.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
    };
  };
  programs.jq.enable = true;
  programs.bat.enable = true;
  programs.rofi.enable = true;
  programs.vscode.enable = true;

  services.blueman-applet.enable = true;

  programs.fzf = let inherit (config.colorScheme) palette; in {
    enable = true;
    enableFishIntegration = true;
    colors = {
      fg = "#${palette.base05}";        # Text
      bg = "#${palette.base00}";        # Base
      "bg+" = "#${palette.base03}";     # Surface 1
      "fg+" = "#${palette.base05}";     # Surface 1
      hl = "#${palette.base08}";        # red
      "hl+" = "#${palette.base08}";     # red
      border = "#${palette.base0D}";    # blue
      prompt = "#${palette.base0B}";    # green
      info = "#${palette.base0A}";      # yellow
      pointer = "#${palette.base0A}";   # yellow
      marker = "#${palette.base0B}";    # green
      header = "#${palette.base0D}";    # teal
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = { 
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
  };
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = true;
  };
  programs.git = {
    enable = true;
    delta.enable = true;
    userEmail = "me@skadic.moe";
    userName = "Skadic";
  };

  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    #WLR_RENDERER_ALLOW_SOFTWARE=1;
    CMAKE_GENERATOR="Ninja";
  };
}
