{ inputs, lib, config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
  };
  file.".config/tmux/tmux.conf".source = ./tmux.conf;
}
