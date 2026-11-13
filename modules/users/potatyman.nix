{ ... }:

{
  flake.nixosModules.potatyman-user = {
    users.users.potatyman = {
      isNormalUser = true;
      description = "Standard Desktop user";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}

