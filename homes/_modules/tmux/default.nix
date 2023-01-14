{ inputs, lib, config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "`";
  };
}
