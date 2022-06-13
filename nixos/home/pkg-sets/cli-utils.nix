{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    gitAndTools.diff-so-fancy
    asciinema
    # qrencode
    # w3m
    yq
    jq
  ];
}
