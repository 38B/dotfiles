{ self, inputs, ... }:
{
  # Available through 'home-manager --flake .#your-username@your-hostname'
  flake =
    {
      homeConfigurations = {
        "muck@crumb" = inputs.home-manager.lib.homeManagerConfiguration {
	  modules = [
	    ./muck/crumb.nix
          ];
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
