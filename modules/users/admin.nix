{ ... }:

{
  flake.nixosModules.admin-user = {
    users.users.admin = {
      isNormalUser = true;
      description = "Administrator for server";

      extraGroups = [
        "wheel"
        "docker"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtvU5YqxRWmJTYxOyOUrPmapOpmnlFia73R4TqY/k3s Potatyyman@proton.me"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDNQiwbuLB77lPFYs93qL/dV/K9F3NFzplQvk3EZPiKA Potattyman@proton.me"
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
