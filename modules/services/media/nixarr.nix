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

      };

      seerr.enable = true;
      seerr.openFirewall = true;
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
    services.qbittorrent.serverConfig = {
      legalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          Username = "admin";
          Password_PBKDF2 = "IZZUu4EhdX3gDiHYLy+eIw==:ZzBijzk6BP9ZLQ2kfNtFhEfxY5pVmtbJ2gd7xMnLIXeFZKg9ViF2pnemetYAxxMbAvYerheUCN5M2sL0P9TB6Q==";
        };
      };
    };

    virtualisation.oci-containers = {
      backend = "podman";

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
