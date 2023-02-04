{ inputs, lib, config, pkgs, ... }:
{
  home = {
    file.".config/wofi/config".source = ./config;
    file.".config/wofi/wofi_styles.css".source = ./wofi_styles.css;
  };
}
