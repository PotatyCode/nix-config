{ inputs, self, ... }:

{
  flake.nixosConfigurations.wsl =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.nixos-wsl.nixosModules.default

        self.nixosModules.common
        self.nixosModules.wsl
        self.nixosModules.nvim
        self.nixosModules.fish
      ];
    };

  flake.nixosModules.wsl = { ... }: {
    system.stateVersion = "26.05";

    wsl.enable = true;
    wsl.defaultUser = "nixos";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
