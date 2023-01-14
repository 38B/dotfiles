{ inputs, lib, config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
  };
  home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
}
