{self, ...}: {
  flake.nixosModules.common = {
    config,
    inputs,
    lib,
    pkgs,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.system}";
  in {
    environment.systemPackages = [
      selfpkgs.git
      selfpkgs.nvim
      pkgs.gh
      pkgs.btop
      pkgs.tree
      pkgs.nixfmt
    ];
    imports = [
      self.nixosModules.fish
    ];
    time.timeZone = "Australia/Brisbane";

    i18n.defaultLocale = "en_AU.UTF-8";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "delete-older-than 7d";
      };
    };
  };
}
