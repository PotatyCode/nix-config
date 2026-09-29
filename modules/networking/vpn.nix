{ inputs, ... }:

{
  flake.nixosModules.vpn = {
    imports = [
      inputs.vpn-confinement.nixosModules.default
    ];
    vpnNamespaces.wg = {
      enable = true;

      wireguardConfigFile = "/home/nixos/vpn.txt";

      accessibleFrom = [
        "192.168.0.0/24"
      ];
      portMappings = [
      {
        from = 8080;
        to = 8080;
      }
      ];

      openVPNPorts = [
        {
          port = 60729;
          protocol = "both";
        }
      ];
    };
  };
}
