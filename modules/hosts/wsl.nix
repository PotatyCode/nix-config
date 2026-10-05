{
  inputs,
  self,
  ...
}:

{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.nixos-wsl.nixosModules.default

      self.nixosModules.common
      self.nixosModules.wsl
    ];
  };

  flake.nixosModules.wsl = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    ];
    system.stateVersion = "26.05";

    wsl.enable = true;
    wsl.defaultUser = "nixos";

  };
}
