{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.fish = pkgs.fish;
  };

  flake.nixosModules.fish = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.fish
    ];

    programs.fish = {
      enable = true;
    };

    users.defaultUserShell = pkgs.fish;
  };
}
