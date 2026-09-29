{ ... }: 

{
 flake.nixosModules.caddy = {
   networking.firewall.allowedTCPPorts = [ 80 443 ];
   services.caddy = {
     enable = true;
     virtualHosts."jellyfin.aottr.local".extraConfig = ''
       reverse_proxy http://localhost:3000
       '';

   };
 };
}
