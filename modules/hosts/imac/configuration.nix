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
      self.nixosModules.imac
    ];
  };

  flake.nixosModules.imac =
    { config, pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.system}";
    in
    {
      environment.systemPackages = [
        selfpkgs.noctalia
        selfpkgs.kitty
        pkgs.ungoogled-chromium
      ];

      services.displayManager.noctalia-greeter.enable = true;
      programs.niri.enable = true;
      programs.niri.package = selfpkgs.niri;
      networking.wireless.enable = true;
      networking.networkmanager.enable = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      networking.hostName = "nixos";
      system.stateVersion = "26.05";
    };
}
