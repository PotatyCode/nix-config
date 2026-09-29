{ inputs, self, pkgs, ... }:

{
  flake.nixosConfigurations.wsl =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.nixos-wsl.nixosModules.default
        inputs.sops-nix.nixosModules.sops

        self.nixosModules.common
        self.nixosModules.wsl
        self.nixosModules.nvim
        self.nixosModules.fish
        self.nixosModules.media
        
        self.nixosModules.grafana
        self.nixosModules.prometheus

        self.nixosModules.caddy
      ];
    };

  flake.nixosModules.wsl = { config, pkgs,... }: {
    environment.systemPackages = with pkgs; [
        cargo
        typst
    ];
    system.stateVersion = "26.05";

    wsl.enable = true;
    wsl.defaultUser = "nixos";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
