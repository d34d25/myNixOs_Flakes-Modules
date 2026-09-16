{ config, pkgs, stable, unstable, ... }:

{
  	imports = [./hardware-configuration.nix];

  	# Use the systemd-boot EFI boot loader.
  	boot.loader.systemd-boot.enable = true;
  	boot.loader.efi.canTouchEfiVariables = true;

  	#networking
  	networking.hostName = "dision";
 
  	networking.networkmanager.enable = true;

	networking.firewall.enable = true;

  	#time zone / locale

  	time.timeZone = "America/Argentina/Buenos_Aires";

  	i18n.defaultLocale = "en_US.UTF-8";

  	i18n.extraLocaleSettings = {

    		LC_ADDRESS = "en_US.UTF-8";
    		LC_IDENTIFICATION = "en_US.UTF-8";
    		LC_MEASUREMENT = "en_US.UTF-8";
    		LC_MONETARY = "en_US.UTF-8";
    		LC_NAME = "en_US.UTF-8";
    		LC_NUMERIC = "en_US.UTF-8";
    		LC_PAPER = "en_US.UTF-8";
    		LC_TELEPHONE = "en_US.UTF-8";
    		LC_TIME = "en_US.UTF-8";

  	};

  	services.xserver.xkb = {
    		layout = "latam";
    		variant = "";
  	};

  	console.keyMap = "la-latin1";

  	#users

  	users.users."dision" = {
    		isNormalUser = true;
    		description = "dision";
    		extraGroups = [ "networkmanager" "wheel" ];
    		packages = with pkgs; [];
  	};

  	nixpkgs.config.allowUnfree = true;

  	system.stateVersion = "26.05"; #<--- do not touch

	nix.settings.experimental-features = ["nix-command" "flakes"];

	#sound

	security.rtkit.enable = true;

	services.pipewire = {

		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;

	};

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

	];  
}
