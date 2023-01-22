{ inputs, lib, config, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
	pad = "12x12";
      };
      colors = {
        alpha = "1.0";
        foreground = "78796f";
        background = "373b43";
        regular0 = "373b43";
        bright0 = "373b43";
        regular1 = "fdcd39";
        bright1 = "fdcd39";
        regular2 = "fbfd59";
        bright2 = "fbfd59";
        regular3 = "deac40";
        bright3 = "deac40";
        regular4 = "afb171";
        bright4 = "afb171";
        regular5 = "b387e7";
        bright5 = "b387e7";
        regular6 = "63e860";
        bright6 = "63e860";
        regular7 = "efdecb";
        bright7 = "efdecb";
      };
    };
  };
}
