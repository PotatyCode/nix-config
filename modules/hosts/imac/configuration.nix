{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.imac = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.common
      self.nixosModules.imac-hardware
      self.nixosModules.imac
      self.nixosModules.desktop
      self.nixosModules.gaming
    ];
  };

  flake.nixosModules.imac = {...}: {
    networking.hostName = "nixos";
    system.stateVersion = "26.05";
  };
}
