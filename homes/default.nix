{
  # Available through 'home-manager --flake .#your-username@your-hostname'
  homeConfigurations = {
    "muck@crumb" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs outputs; };
      modules = [
        ./muck
	./muck/crumb.nix
      ];
    };
  };
}
