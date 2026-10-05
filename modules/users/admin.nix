{ ... }:

{
  flake.nixosModules.admin-user = {
    users.users.admin = {
      isNormalUser = true;
      description = "Administrator for server";
      hashedPassword = "$y$j9T$EG4b9irjPZVFU95WXWyiE/$KFeXVmAmH4gJOefZwOmjpZO7qymuKyPuJOJ.cBgdCk2";

      extraGroups = [
        "wheel"
        "docker"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtvU5YqxRWmJTYxOyOUrPmapOpmnlFia73R4TqY/k3s Potatyyman@proton.me"
      ];
    };

    security.sudo.wheelNeedsPassword = true;
  };
}
