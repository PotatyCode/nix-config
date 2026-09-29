{ inputs, ... }:

{
  flake.nixosModules.media = {
    imports = [
      inputs.nixarr.nixosModules.default
    ];
    services.prowlarr.settings.auth.required = "DisabledForLocalAddresses";
    services.sonarr.settings.auth.required = "DisabledForLocalAddresses";
    services.radarr.settings.auth.required = "DisabledForLocalAddresses";
    services.flaresolverr.enable = true;

    nixarr = {
      enable = true;
      mediaDir  = "/media";
      stateDir = "/services";
      exporters.enable = true;

      vpn = {
        enable = true;
        wgConf = "/home/nixos/vpn.txt";

        vpnTestService = {
          enable = true;
          port = 60729;
        };
      };

      seerr.enable = true;
      transmission = {
        enable = true;
        vpn.enable = true;
        peerPort = 60729;
      };

      jellyfin.enable = true;
      radarr = {
        enable =  true;
        settings-sync.transmission.enable = true;
      };

      sonarr = {
        enable =  true;
        settings-sync.transmission.enable = true;
      };
      
      bazarr = {
        enable = true;
        settings-sync = {
          sonarr.enable = true;
          radarr.enable = true;
        };
      };

      prowlarr = {
        enable =  true;
        settings-sync = {
          sonarr.enable = true;
          radarr.enable = true;
        };
      };
    };

    virtualisation.oci-containers = {
      backend = "docker";

      containers.profilarr = {
        image = "ghcr.io/dictionarry-hub/profilarr:latest";
        ports = [ "6868:6868" ];
        volumes = [ "/services/profilarr:/config" ];
        extraOptions = [
          "--add-host=host.docker.internal:host-gateway"
        ];
      };
    };
  };
}
