{
  description = "flake for system, divided into modules";

  inputs = {

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";

  };

  outputs = {self, nixpkgs-unstable, nixpkgs-stable, ...}  @inputs:
  let

    target_system = "x86_64-linux";

    stable = import inputs.nixpkgs-stable {

        system = target_system;

        config.allowUnfree = true;

    };

    unstable = import inputs.nixpkgs-unstable {

        system = target_system;

        config.allowUnfree = true;

    };

  in
  {

    nixosConfigurations.dision = nixpkgs-stable.lib.nixosSystem {

      specialArgs = {inherit inputs stable unstable;};

      modules = [

        ./configuration.nix

        ./myModules/sys-settings.nix

        ./myModules/desktop.nix

        ./myModules/nvidia-drivers.nix

        ./myModules/programs.nix

      ];

    };

  };


}
