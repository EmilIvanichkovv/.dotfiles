{config, ...}: {
  home.sessionVariables = rec {
    DIRENV_WARN_TIMEOUT = "30s";
    CODE = "${config.home.homeDirectory}/code";
    TMP = "${CODE}/tmp";
    REPOS = "${CODE}/repos";
    CFG = "${REPOS}/.dotfiles";
    DLANG = "${REPOS}/dlang";
    WORK = "${REPOS}/metacraft-labs";
    MINE = "${REPOS}mine";
  };
}
