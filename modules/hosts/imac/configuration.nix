{
  inputs,
  self,
  ...
}:

{
  flake.nixosConfigurations.imac = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
        self.nixosModules.common
	self.nixosModules.imac-hardware
	self.nixosModules.potatyman-user
    ]
  };

  flake.nixosModules.server = { config, pkgs, ... }: let
    selfpkgs = self.packages."${pkgs.system}";
  in {
    environment.systemPackages =[
     selfpkgs.noctalia
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.useDHCP = true;
    networking.hostName = "nixos";
    system.stateVersion = "26.05";
  };
}

