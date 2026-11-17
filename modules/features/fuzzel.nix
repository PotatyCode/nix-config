{
  inputs,
  self,
  ...
}: {
  flake.wrappersModules.fuzzel = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options = {
      font = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font:size=11";
        description = "Fuzzel font.";
      };

      terminal = lib.mkOption {
        type = lib.types.package;
        default = pkgs.kitty;
        description = "Terminal emulator.";
      };

      width = lib.mkOption {
        type = lib.types.int;
        default = 40;
        description = "Launcher width.";
      };

      lines = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Number of visible entries.";
      };

      settings = lib.mkOption {
        type = pkgs.formats.ini {}.type;
        default = {};
        description = "Additional Fuzzel settings.";
      };
    };

    config = {
      settings = lib.mkDefault {
        main = {
          font = config.font;
          terminal = lib.getExe config.terminal;
          prompt = "❯ ";
          layer = "overlay";
          anchor = "center";

          width = config.width;
          lines = config.lines;

          horizontal-pad = 20;
          vertical-pad = 12;
          inner-pad = 10;
          line-height = 24;

          fields = "name,generic,comment";
          match-mode = "fuzzy";
          exit-on-keyboard-focus-loss = true;
        };

        border = {
          width = 2;
          radius = 12;
        };

        colors = {
          background = self.theme.base00;
          text = self.theme.base05;
          match = self.theme.baseOE;

          selection = self.theme.base02;
          selection-text = self.theme.base03;
          selection-match = "f5c2e7ff";

          border = self.theme.base08;
          placeholder = "6c7086ff";
        };
      };

      wrapper = {
        package = pkgs.fuzzel;
        args = [
          "--config"
          (pkgs.formats.ini {}).generate
          "fuzzel.ini"
          config.settings
        ];
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.fuzzel = inputs.wrapper-modules.wrappers.generic.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.fuzzel];
    };
  };
}
