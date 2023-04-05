{pkgs, ...}: {
  home.packages = with pkgs; [
    asciinema
    gh
    # qrencode
    # w3m
    pv
    killall
  ];
}
