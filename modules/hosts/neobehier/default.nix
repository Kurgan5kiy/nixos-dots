{ self, inputs, ... }: {
	flake.nixosConfigurations.nixosbtw = inputs.nixpkgs.lib.nixosSystem {
		modules = [
      self.nixosModules.neobehier
    ];
	};
}
