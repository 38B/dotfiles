{ self, inputs, ... }:
{
  # Available through 'home-manager --flake .#your-username@your-hostname'
  flake =
    {
      homeConfigurations = {
        "muck@crumb" = inputs.home-manager.lib.homeManagerConfiguration {
	  modules = [
            inputs.sops-nix.nixosModules.home-manager.sops
	    ./muck/crumb.nix
          ];
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
