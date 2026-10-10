{ self, ... }:

{
  flake.nixosModules.common =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        git
        gh
        btop
        tree
        devenv
        nixfmt
      ];
      imports = [
        self.nixosModules.nvim
        self.nixosModules.fish
      ];
      time.timeZone = "Australia/Brisbane";

      i18n.defaultLocale = "en_AU.UTF-8";

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
          options = "delete-older-than 14d";
        };
      };
    };
}
