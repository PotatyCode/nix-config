{ inputs, self, ... }:

{
  flake.nixosModules.common = { config, lib, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        git
        btop
      ];
      time.timeZone = "Australia/Brisbane";

      i18n.defaultLocale = "en_AU.UTF-8";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
