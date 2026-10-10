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
      mediaDir = "/media";
      stateDir = "/services";
      exporters.enable = true;

      vpn = {
        enable = true;
        wgConf = "/secrets/vpn.txt";

        vpnTestService = {
          enable = true;
          port = 60729;
        };
      };

      seerr.enable = true;
      qbittorrent = {
        enable = true;
        vpn.enable = true;
        openFirewall = true;
      };

      jellyfin.enable = true;
      jellyfin.openFirewall = true;
      radarr = {
        enable = true;
        openFirewall = true;
      };

      sonarr = {
        enable = true;
        openFirewall = true;
      };

      bazarr = {
        enable = true;
        settings-sync = {
          sonarr.enable = true;
          radarr.enable = true;
        };
        openFirewall = true;
      };

      prowlarr = {
        enable = true;
        settings-sync = {
          sonarr.enable = true;
          radarr.enable = true;
        };
        openFirewall = true;
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
