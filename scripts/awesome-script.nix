{pkgs, ...}:
pkgs.writeShellScriptBin "my-awesome-script" ''
  echo "hello world" | ${pkgs.cowsay}/bon/cowsay | ${pkgs.lolcat}/bin/lolcat
''
