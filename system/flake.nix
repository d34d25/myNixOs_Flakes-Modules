{
	description = "flake for the system";
	
	inputs = {
	
			nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    		nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
 	 };

  	outputs = {self, nixpkgs-stable, nixpkgs-unstable, ...} @inputs:
  	let
		system = "x86_64-linux";

		commonModules = [
			./configuration.nix
		];

		stable = import nixpkgs-stable {

			inherit system;

			config.allowUnfree = true;

		};

		unstable = import nixpkgs-unstable {

			inherit system;

			config.allowUnfree = true;

		};

  	in
  	{
	
		nixosConfigurations.desktop = nixpkgs-stable.lib.nixosSystem {

			specialArgs = {inherit inputs stable unstable;};

			modules = commonModules ++ [
				./myModules/sys-settings.nix
				./myModules/programs.nix

				{
					mySystem.enableNvidia = true;
					mySystem.chosenDesktop = "kde";
				}
			];

		};

  	};
}
