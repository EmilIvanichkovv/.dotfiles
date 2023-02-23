{pkgs, ...}: {
  home.packages = with pkgs; [
    asciinema
    # qrencode
    # w3m
    yq
    jq
    pv
  ];
}
