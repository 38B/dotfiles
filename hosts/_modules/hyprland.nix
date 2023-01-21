{ inputs, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayland
    mesa
    brightnessctl
    playerctl 
    eww-wayland
    wl-clipboard
    wofi
    grim
    hyprland
    firefox-wayland
    foot
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];

}

