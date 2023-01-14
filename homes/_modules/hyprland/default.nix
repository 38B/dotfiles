{ inputs, lib, config, pkgs, ... }:
{
  home = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = import ./config.nix;
  };
}
