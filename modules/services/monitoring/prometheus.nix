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
        "hwmon"
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
