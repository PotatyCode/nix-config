{
  inputs,
  self,
  ...
}:

{
  flake.nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.disko.nixosModules.default
      self.nixosModules.server
      self.nixosModules.server-hardware

      self.nixosModules.server-disko
      self.nixosModules.admin-user
      self.nixosModules.ssh
      self.nixosModules.zfs

      self.nixosModules.common
      self.nixosModules.media
      self.nixosModules.grafana
      self.nixosModules.prometheus
    ];
  };

  flake.nixosModules.server = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.useDHCP = true;
    networking.hostId = "d4bbac73";
    networking.hostName = "potatyserv";
    system.stateVersion = "26.05";
  };
}
