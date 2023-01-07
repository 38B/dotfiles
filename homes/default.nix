{ self, inputs, ... }:
{
  # Available through 'home-manager --flake .#your-username@your-hostname'
  flake =
  let
    homeManagerConfiguration =
        { extraModules ? [ ]
        , system ? "x86_64-linux"
        ,
        }: (inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              _module.args.self = self;
              _module.args.inputs = self.inputs;
              imports = [ extraModules ];
            }
          ];
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        });
    in
    {
      homeConfigurations = {
        "muck@crumb" = homeManagerConfiguration {
          extraModules = [
	    ./muck
	    ./muck/crumb.nix
          ];
        };
      };
    };
}
