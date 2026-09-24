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
		nixosConfigurations.dev = nixpkgs-stable.lib.nixosSystem {
			
			specialArgs = {inherit inputs stable unstable;};

			modules = [

				({config, ...}:
				{

					services.xserver.enable = true;
				
					#drivers

					services.xserver.videoDrivers = ["nvidia"];

					hardware.nvidia = {

						open = true;
						package = config.boot.kernelPackages.nvidiaPackages.production;
					};

					#desktop

					services.xserver.desktopManager.xfce.enable = true;
					services.displayManager.defaultSession = "xfce";

					#programs

					programs.vscode = {
						
						enable = true;
						package = stable.vscode;
						extensions = [stable.vscode-extensions.ms-vscode.cpptools];

					};

					environment.systemPackages = [

						stable.git
						stable.htop
						stable.fastfetch
						stable.aseprite
						stable.blender
						stable.librewolf

						stable.gpu-screen-recorder
						stable.gpu-screen-recorder-gtk						

					];

				})
			
				./configuration.nix			
	
			];

		};	

	};
}
