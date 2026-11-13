{ ... }:

{
  perSystem = { pkgs, ... }: {
    packages.fish = pkgs.fish;
  };

  flake.nixosModules.fish = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.fish
      pkgs.zoxide
      pkgs.eza
    ];
    users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        rebuild = "sudo nixos-rebuild switch --flake /home/nixos/nix-config";

        ns = "nix-shell";
        ls = "eza --group-directories-first";
        ll = "eza -lah --group-directories-first";
        la = "eza -a --group-directories-first";
        lt = "eza --tree --level=2";
      };
      interactiveShellInit = ''
          set -g fish_greeting
          set -g fish_history main
          set -g fish_private_mode 0

          function mkcd
              mkdir -p $argv[1]
              and cd $argv[1]
            end
            function rebuild
          if test (count $argv) -ne 1
            echo "Usage: rebuild <host>"
            return 1
          end

          sudo nixos-rebuild switch --flake "$HOME/nix-config#$argv[1]"
        end
      '';

    };
  };
}
