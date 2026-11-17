{
  inputs,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages = {
      noctalia = inputs.wrapper-modules.wrappers.noctalia.wrap {
        inherit pkgs;
        package = pkgs.noctalia.overrideAttrs {
          name = "vjnoctalia2";
        };
        env = {
          "NOCTALIA_CACHE_DIR" = "/tmp/vj-noctalia-cache/";
        };
        colors = {
          mError = "#${self.themeNoHash.base08}";
          mHover = "#83a598";
          mOnError = "#282828";
          mOnHover = "#282828";
          mOnPrimary = "#${self.themeNoHash.base00}";
          mOnSecondary = "#${self.themeNoHash.base02}";
          mOnSurface = "#${self.themeNoHash.base01}";
          mOnSurfaceVariant = "#ebdbb2";
          mOnTertiary = "#282828";
          mOutline = "#${self.themeNoHash.base0D}";
          mPrimary = "#b8bb26";
          mSecondary = "#fabd2f";
          mShadow = "#282828";
          mSurface = "#282828";
          mSurfaceVariant = "#3c3836";
          mTertiary = "#83a598";
        };
        settings = {
          backdrop.enabled = false;
          appLauncher = {
            customLaunchPrefix = "";
            customLaunchPrefixEnabled = false;
            enableClipPreview = true;
            enableClipboardHistory = false;
            iconMode = "tabler";
            pinnedExecs = [];
            position = "center";
            showCategories = true;
            sortByMostUsed = true;
            terminalCommand = "kitty -e";
            useApp2Unit = false;
            viewMode = "list";
          };
          audio = {
            cavaFrameRate = 30;
            externalMixer = "pwvucontrol || pavucontrol";
            mprisBlacklist = [];
            preferredPlayer = "";
            visualizerType = "linear";
            volumeOverdrive = false;
            volumeStep = 5;
          };

          bar = {
            order = ["default"];

            default = {
              enabled = true;
              position = "top";

              # Layout and behaviour
              auto_hide = false;
              smart_auto_hide = false;
              show_on_workspace_switch = true;
              reserve_space = true;
              layer = "top";

              # Appearance
              thickness = 42;
              background_opacity = 1.0;
              compositor_blur = true;

              border = "outline_variant";
              border_width = 0.0;
              shadow = true;
              contact_shadow = false;

              # Corners
              radius = 12;
              radius_top_left = 12;
              radius_top_right = 12;
              radius_bottom_left = 12;
              radius_bottom_right = 12;
              concave_edge_corners = true;

              # Spacing
              margin_ends = 12;
              margin_edge = 0;
              margin_opposite_edge = 0;
              padding = 10;
              widget_spacing = 6;

              # Sizing
              scale = 1.0;
              font_scale = 1.0;
              font_weight = 500;

              # Widget appearance
              capsule = false;
              capsule_opacity = 1.0;
              capsule_fill = "surface_container";
              capsule_thickness = 0.76;
              capsule_padding = 6;
              capsule_border_width = 1.0;

              hover_highlight = true;
              show_tooltip = true;

              # Widget placement
              start = [
                "control-center"
                "workspaces"
              ];

              center = [];

              end = [
                "notifications"
                "power-profile"
                "volume"
                "input-volume"
                "battery"
                "keyboard-layout"
                "clock"
                "tray"
              ];
            };
          };

          # Widget-specific configuration
          widget = {
            # Control Center
            control-center = {
              type = "control-center";
            };

            # Workspaces
            workspaces = {
              type = "workspaces";
            };

            # Notifications
            notifications = {
              type = "notifications";
            };

            # Power profile
            power-profile = {
              type = "power_profile";
            };

            # Output volume
            volume = {
              type = "volume";
              device = "output";
            };

            # Input volume / microphone
            input-volume = {
              type = "volume";
              device = "input";
            };

            # Battery
            battery = {
              type = "battery";
            };

            # Keyboard layout
            keyboard-layout = {
              type = "keyboard_layout";
            };

            # Clock
            clock = {
              type = "clock";
              format = "{:%H:%M}";
            };

            # System tray
            tray = {
              type = "tray";
            };
          };

          brightness = {
            brightnessStep = 5;
            enableDdcSupport = false;
            enforceMinimum = true;
          };
          calendar = {
            cards = [
              {
                enabled = true;
                id = "calendar-header-card";
              }
              {
                enabled = true;
                id = "calendar-month-card";
              }
              {
                enabled = true;
                id = "timer-card";
              }
              {
                enabled = true;
                id = "weather-card";
              }
            ];
          };
          colorSchemes = {
            darkMode = true;
            generateTemplatesForPredefined = true;
            manualSunrise = "06:30";
            manualSunset = "18:30";
            matugenSchemeType = "scheme-fruit-salad";
            schedulingMode = "off";
            useWallpaperColors = true;
          };
          controlCenter = {
            cards = [
              {
                enabled = true;
                id = "profile-card";
              }
              {
                enabled = true;
                id = "shortcuts-card";
              }
              {
                enabled = true;
                id = "audio-card";
              }
              {
                enabled = true;
                id = "brightness-card";
              }
              {
                enabled = true;
                id = "weather-card";
              }
              {
                enabled = true;
                id = "media-sysmon-card";
              }
            ];
            position = "close_to_bar_button";
            shortcuts = {
              left = [
                {id = "WiFi";}
                {id = "Bluetooth";}
                {id = "ScreenRecorder";}
              ];
              right = [
                {id = "Notifications";}
                {id = "PowerProfile";}
              ];
            };
          };
          desktopWidgets = {
            enabled = false;
            gridSnap = false;
          };
          dock = {
            animationSpeed = 2;
            backgroundOpacity = 1;
            colorizeIcons = false;
            deadOpacity = 0.6;
            displayMode = "auto_hide";
            enabled = false;
            floatingRatio = 1;
            inactiveIndicators = false;
            onlySameOutput = true;
            pinnedApps = [];
            pinnedStatic = false;
            size = 1;
          };
          general = {
            allowPanelsOnScreenWithoutBar = true;
            animationDisabled = false;
            animationSpeed = 1;
            boxRadiusRatio = 1;
            compactLockScreen = false;
            dimmerOpacity = 0.15;
            enableShadows = true;
            forceBlackScreenCorners = false;
            iRadiusRatio = 1;
            language = "";
            lockOnSuspend = true;
            radiusRatio = 1;
            scaleRatio = 1;
            screenRadiusRatio = 1;
            shadowDirection = "bottom_right";
            shadowOffsetX = 2;
            shadowOffsetY = 3;
            showHibernateOnLockScreen = false;
            showScreenCorners = false;
            showSessionButtonsOnLockScreen = true;
          };
          hooks = {
            darkModeChange = "";
            enabled = false;
            performanceModeDisabled = "";
            performanceModeEnabled = "";
            screenLock = "";
            screenUnlock = "";
            wallpaperChange = "";
          };
          location = {
            analogClockInCalendar = false;
            firstDayOfWeek = -1;
            showCalendarEvents = true;
            showCalendarWeather = true;
            showWeekNumberInCalendar = false;
            use12hourFormat = false;
            useFahrenheit = false;
            weatherEnabled = true;
            weatherShowEffects = true;
          };
          network = {wifiEnabled = true;};
          nightLight = {
            autoSchedule = true;
            dayTemp = "6500";
            enabled = false;
            forced = false;
            manualSunrise = "06:30";
            manualSunset = "18:30";
            nightTemp = "4000";
          };
          notifications = {
            backgroundOpacity = 1;
            criticalUrgencyDuration = 15;
            enableKeyboardLayoutToast = true;
            enabled = true;
            location = "top_right";
            lowUrgencyDuration = 8;
            monitors = [];
            normalUrgencyDuration = 8;
            overlayLayer = true;
            respectExpireTimeout = false;
            sounds = {
              criticalSoundFile = "";
              enabled = false;
              excludedApps = "discord,firefox,chrome,chromium,edge";
              lowSoundFile = "";
              normalSoundFile = "";
              separateSounds = false;
              volume = 0.5;
            };
          };
          osd = {
            autoHideMs = 3000;
            backgroundOpacity = 1;
            enabled = true;
            enabledTypes = [
              0
              1
              2
              4
            ];
            location = "bottom";
            monitors = [];
            overlayLayer = true;
          };
          screenRecorder = {
            audioCodec = "opus";
            audioSource = "default_output";
            colorRange = "limited";
            directory = "/home/yurii/Videos";
            frameRate = 60;
            quality = "very_high";
            showCursor = true;
            videoCodec = "h264";
            videoSource = "portal";
          };
          sessionMenu = {
            countdownDuration = 10000;
            enableCountdown = true;
            largeButtonsStyle = false;
            position = "center";
            powerOptions = [
              {
                action = "lock";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
              {
                action = "suspend";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
              {
                action = "hibernate";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
              {
                action = "reboot";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
              {
                action = "logout";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
              {
                action = "shutdown";
                command = "";
                countdownEnabled = true;
                enabled = true;
              }
            ];
            showHeader = true;
          };
          settingsVersion = 32;
          systemMonitor = {
            cpuCriticalThreshold = 90;
            cpuPollingInterval = 3000;
            cpuWarningThreshold = 80;
            criticalColor = "";
            diskCriticalThreshold = 90;
            diskPollingInterval = 3000;
            diskWarningThreshold = 80;
            enableDgpuMonitoring = false;
            gpuCriticalThreshold = 90;
            gpuPollingInterval = 3000;
            gpuWarningThreshold = 80;
            memCriticalThreshold = 90;
            memPollingInterval = 3000;
            memWarningThreshold = 80;
            networkPollingInterval = 3000;
            tempCriticalThreshold = 90;
            tempPollingInterval = 3000;
            tempWarningThreshold = 80;
            useCustomColors = false;
            warningColor = "";
          };
          templates = {
            alacritty = false;
            cava = false;
            code = false;
            discord = false;
            emacs = false;
            enableUserTemplates = false;
            foot = false;
            fuzzel = true;
            ghostty = false;
            gtk = true;
            helix = false;
            hyprland = false;
            kcolorscheme = false;
            kitty = true;
            mango = false;
            niri = true;
            pywalfox = false;
            qt = false;
            spicetify = false;
            telegram = false;
            vicinae = false;
            walker = false;
            wezterm = false;
            yazi = false;
            zed = false;
          };
          ui = {
            bluetoothDetailsViewMode = "grid";
            bluetoothHideUnnamedDevices = false;
            fontDefault = "Sans Serif";
            fontDefaultScale = 1;
            fontFixed = "monospace";
            fontFixedScale = 1;
            panelBackgroundOpacity = 1;
            panelsAttachedToBar = true;
            settingsPanelMode = "attached";
            tooltipsEnabled = true;
            wifiDetailsViewMode = "grid";
          };
          wallpaper = {
            # bye bye
            enabled = false;
          };
        };
      };
    };
  };
}
