{ inputs, lib, config, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
	pad = "12x12";
      };
    };
  };
}
