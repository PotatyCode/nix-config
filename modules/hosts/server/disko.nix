# /root/config/disko.nixmkdir -p /root/config
{ ... }:
{
  flake.nixosModules.server-disko = {
    disko.devices = {
      disk = {

        # ── Primary disk ──────────────────────────────────────────────────────
        primary = {
          type = "disk";
          device = "/dev/disk/by-id/ata-LITEON_CV8-CE256-HP_002830100G06"; # e.g. /dev/disk/by-id/ata-Samsung_...
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  extraArgs = [
                    "-n"
                    "ESP-primary"
                  ]; # Partition label for reliable detection
                };
              };
              swap = {
                size = "8G";
                content = {
                  type = "swap";
                  randomEncryption = true;
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };

        # ── Mirror disk ───────────────────────────────────────────────────────
        # ESP is formatted but NOT auto-mounted. A systemd service (boot-esp-sync)
        # keeps it in sync with /boot so this disk can boot independently.
        # No swap partition — swap does not need to be mirrored.
        mirror = {
          type = "disk";
          device = "/dev/disk/by-id/ata-MTFDDAK256TDL-1AW1ZABHA_UHWSK0153D3J5L"; # e.g. /dev/disk/by-id/ata-Samsung_...
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = null;
                  extraArgs = [
                    "-n"
                    "ESP-mirror"
                  ]; # Used by boot-esp-sync to locate this partition
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };

      zpool = {
        zroot = {
          type = "zpool";
          mode = "mirror";

          options = {
            ashift = "12"; # 4K sector alignment — verify with: blockdev --getpbsz /dev/sdX
          };

          rootFsOptions = {
            compression = "zstd";
            dnodesize = "auto";
            atime = "off";
            xattr = "sa";
            acltype = "posixacl";
            "com.sun:auto-snapshot" = "false";
          };

          datasets = {
            # ── System ────────────────────────────────────────────────────────
            root = {
              type = "zfs_fs";
              mountpoint = "/";
              options.mountpoint = "legacy";
            };

            nix = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options = {
                mountpoint = "legacy";
                atime = "off";
              };
            };

            # ── User data ──────────────────────────────────────────────────────
            home = {
              type = "zfs_fs";
              mountpoint = "/home";
              options = {
                mountpoint = "legacy";
                "com.sun:auto-snapshot" = "true";
              };
            };

            photos = {
              type = "zfs_fs";
              mountpoint = "/photos";
              options = {
                mountpoint = "legacy";
                recordsize = "1M"; # Large records suit image files
                "com.sun:auto-snapshot" = "true";
              };
            };

            # ── Services ──────────────────────────────────────────────────────
            services = {
              type = "zfs_fs";
              mountpoint = "/services";
              options = {
                mountpoint = "legacy";
                "com.sun:auto-snapshot" = "true";
              };
            };

            # Media with compression disabled — video/audio files are already
            # compressed. zstd/lz4 would waste CPU with near-zero size benefit.
            temp-media = {
              type = "zfs_fs";
              mountpoint = "/media";
              options = {
                mountpoint = "legacy";
                recordsize = "1M";
                compression = "zstd";
                atime = "off";
                "com.sun:auto-snapshot" = "false";
              };
            };

            # ── Pool safety ───────────────────────────────────────────────────
            # Prevents the pool silently filling to 100%, which causes write
            # failures and metadata corruption. To reclaim emergency headroom:
            #   zfs set refreservation=none zroot/reserved
            reserved = {
              type = "zfs_fs";
              options = {
                mountpoint = "none";
                refreservation = "5G";
              };
            };
          };
        };
      };
    };
  };
}
