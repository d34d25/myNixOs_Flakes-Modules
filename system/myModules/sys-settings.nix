{pkgs, config, lib, ...}:
let

	cfg = config.mySystem;

in
{
	options.mySystem = {

		enableNvidia = lib.mkOption {

			type = lib.types.bool;

			default = false;

		};

		chosenDesktop = lib.mkOption {

			type = lib.types.enum ["none" "kde" "gnome" "lxqt" "xfce"];

			default = "none";

		};

	};

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

			services.xserver.enable = (cfg.chosenDesktop != "none");
		}

		#drivers

		(lib.mkIf cfg.enableNvidia {
	
			services.xserver.videoDrivers = ["nvidia"];

			hardware.nvidia = {
		
				open = false;
		
				package = config.boot.kernelPackages.nvidiaPackages.production;
		
			};
		})		
		
		#desktop		
		
		(lib.mkIf (cfg.chosenDesktop == "kde") {
		
			services.displayManager.sddm.enable = true;

			services.desktopManager.plasma6.enable = true;

		})

		(lib.mkIf (cfg.chosenDesktop == "gnome") {
		
			services.displayManager.gdm.enable = true;

			services.desktopManager.gnome.enable = true;

		})

		(lib.mkIf (cfg.chosenDesktop == "lxqt") {
		
			services.displayManager.sddm.enable = true;

			services.xserver.desktopManager.lxqt.enable = true;

		})

		(lib.mkIf (cfg.chosenDesktop == "xfce") {

			services.xserver.displayManager.lightdm.enable = true;

			services.xserver.desktopManager.xfce.enable = true;
		})
	];

}
