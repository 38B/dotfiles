{ inputs, lib, config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    aggressiveResize = true;
    escapeTime = 0;
    prefix = "`";
    keyMode = "vi";
    extraConfig = import ./tmux.conf.nix;
  };
}
