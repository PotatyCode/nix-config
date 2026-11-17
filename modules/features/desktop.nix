{
  self,
  inputs,
  ...
}: {
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
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.nix-index-database.nixosModules.default
    ];
    services.flatpak.enable = true;
    services.flatpak.packages = [
      {
        appId = "app.zen_browser.zen";
        origin = "flathub";
      }
    ];
    programs.niri.enable = true;
    programs.niri.package = selfpkgs.niri;
    services.displayManager.noctalia-greeter.enable = true;

    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
  };
}
