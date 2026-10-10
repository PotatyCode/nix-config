{ ... }:

{
  flake.nixosModules.grafana = { config, self, ... }: {
    services.grafana = {
      enable = true;
      dataDir = "/services/grafana";

      settings = {
        server = {
          http_addr = "0.0.0.0";
          http_port = 3000;
        };

        security.secret_key = "f3fedfc2845b0b29e0f77ac4bc42276b9700522b9f00152f8b1789b399fcf8e5";
      };

      provision = {
        enable = true;

        dashboards.settings.providers = [
          {
            name = "NixOS";
            options.path = "/etc/grafana/dashboards";
          }
        ];

        datasources.settings = {
          datasources = [
            {
              name = "Prometheus";
              uid = "prometheus";
              type = "prometheus";
              access = "proxy";
              url = "http://127.0.0.1:9090";
              isDefault = true;
              editable = false;
            }
          ];
        };
      };
    };

    environment.etc = {
      "grafana/dashboards/system-overview.json".source = ./dashboards/system-overview.json;
      "grafana/dashboards/linux-overview.json".source = ./dashboards/19937_rev8.json;
    };
  };

}
