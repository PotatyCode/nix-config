{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.system}";
  in {
    environment.systemPackages = [
      selfpkgs.noctalia
      selfpkgs.kitty
      pkgs.ungoogled-chromium
      pkgs.firefox
    ];
    imports = [
      self.nixosModules.potatyman-user
    ];
    programs.niri.enable = true;
    programs.niri.package = selfpkgs.niri;
    services.displayManager.noctalia-greeter.enable = true;

    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
  };
}
