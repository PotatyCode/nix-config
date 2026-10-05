{ ... }:

{
  flake.nixosModules.zfs = {
    boot = {
      supportedFilesystems = [ "zfs" ];
      initrd.supportedFilesystems = [ "zfs" ];
      zfs = {
        devNodes = "/dev/disk/by-id";
	forceImportRoot = true;
	forceImportAll = false;
      };
    };
    services.zfs = {
      autoScrub = {
        enable = true;
	interval = "monthly";
      };
      autoSnapshot = {
        enable = true;
	monthly = 3;
        weekly = 4;
	daily = 7;
	hourly = 24;
      };
    };
  };
}
