{ ... }: {
    flake.nixosModules.common = { pkgs, ... }: {
      time.timeZone = "Australia/Brisbane";
      i18n.defaultLocale = "en_AU.UTF-8";
      nix.settings.experimental-features = [ "nix-command" "flakes"];
      programs.git.enable = true;
      environment.systemPackages = with pkgs; [
          neovim
	  git
	  curl
	  wget
	  btop
      ];
    };
}
