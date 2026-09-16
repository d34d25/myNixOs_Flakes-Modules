{
	description = "flake for the system";

	inputs = {
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	};
	
	outputs = {self, nixpkgs-stable, nixpkgs-unstable, ...} @inputs:
	let
		system = "x86_64-linux";

		stable = import nixpkgs-stable {inherit system; config.allowUnfree = true;};

		unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true;};
	in
	{

		nixosConfigurations.desktop = nixpkgs-stable.lib.nixosSystem {
	
			specialArgs = {inherit inputs stable unstable;};

			modules = [
				
				({config, ...}:
				{
					services.xserver.enable = true;

					services.xserver.videoDrivers = ["nvidia"];

					hardware.nvidia = {
					
						open = false;
						package = config.boot.kernelPackages.nvidiaPackages.production;

					};

					services.xserver.displayManager.lightdm.enable = true;
					services.xserver.desktopManager.xfce.enable = true;

				})
				
				./configuration.nix
			];
		
		};

	};
		
}
