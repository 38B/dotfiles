{ inputs, lib, config, pkgs, ... }:
{
  home = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS= "1";
    };
    sessionPath = [ "$HOME/.local/bin" ];
    file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    file.".local/bin/hypr".source = ./hypr.sh;
  };
}
