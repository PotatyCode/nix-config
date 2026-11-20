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

  flake.nixosModules.imac = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = true;
    environment.systemPackages = [
      pkgs.tidal
      pkgs.jellyfin-desktop
    ];
    networking.hostName = "nixos";
    system.stateVersion = "26.05";
  };
}
