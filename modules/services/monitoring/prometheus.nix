{ ... }:

{
  flake.nixosModules.prometheus = {lib, config, ... }: {
  services.prometheus = {
    enable = true;

    globalConfig = {
      scrape_interval = "30s";
      evaluation_interval = "30s";
    };

    exporters.node = {
      enable = true;
      enabledCollectors = lib.mkForce [
        "systemd"
        "tcpstat"
        "network_route"
        "sensors"
      ];
    };

  scrapeConfigs = [
    {
      job_name = "node";
      static_configs = [
        {
          targets = [ "127.0.0.1:9100" ];
        }
      ];
    }

  ];
  };
};
}
