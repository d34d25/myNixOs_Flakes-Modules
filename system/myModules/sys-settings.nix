{pkgs, config, lib, enableNvidia,  choosenDesktop,...}:

{
	config = lib.mkMerge [
		
		#general settings

		{
			nixpkgs.config.allowUnfree = true;
	
			networking.firewall.enable = true;

			nix.settings.experimental-features = ["nix-command" "flakes"];

			#sound

			services.pulseaudio.enable = false;

			security.rtkit.enable = true;

			services.pipewire = {
		
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;	

			};

			services.xserver.enable = (choosenDesktop != "none");
		}

		#drivers

		(lib.mkIf enableNvidia {
	
			services.xserver.videoDrivers = ["nvidia"];

			hardware.nvidia = {
		
				open = false;
		
				package = config.boot.kernelPackages.nvidiaPackages.production;
		
			};
		})		
		
		#desktop		
		
		(lib.mkIf (choosenDesktop == "kde") {
		
			services.displayManager.sddm.enable = true;

			services.desktopManager.plasma6.enable = true;

		})

		(lib.mkIf (choosenDesktop == "gnome") {
		
			services.displayManager.gdm.enable = true;

			services.desktopManager.gnome.enable = true;

		})

		(lib.mkIf (choosenDesktop == "lxqt") {
		
			services.displayManager.sddm.enable = true;

			services.xserver.desktopManager.lxqt.enable = true;

		})

		(lib.mkIf (choosenDesktop == "xfce") {

			services.xserver.displayManager.lightdm.enable = true;

			services.xserver.desktopManager.xfce.enable = true;
		})
	];

}
