{
  stdenv,
  fetchFromGitHub,
  lib,
  meson,
  ninja,
  cmake,
  openrazer-daemon,
  pkg-config,
  qtbase,
  qttools,
  wrapQtAppsHook,
  enableExperimental ? false,
  includeMatrixDiscovery ? false,
}: let
  version = "0.2.0";
  pname = "libopenrazer";
in
  stdenv.mkDerivation {
    inherit pname version;

    dontUseCmakeConfigure = true;

    src = fetchFromGitHub {
      owner = "z3ntu";
      repo = "libopenrazer";
      rev = "v${version}";
      hash = "sha256-ZoSzKP6G1y/StcVhVg0qRT/Gm+jpcKUUA6/7R/zXJZE=";
    };

    nativeBuildInputs = [
      cmake
      pkg-config
      meson
      ninja
      wrapQtAppsHook
    ];

    buildInputs = [
      qtbase
      qttools
      openrazer-daemon
    ];

    meta = with lib; {
      homepage = "https://github.com/z3ntu/RazerGenie";
      description = "Qt application for configuring your Razer devices under GNU/Linux";
      license = licenses.gpl3;
      maintainers = with maintainers; [f4814n Mogria];
      platforms = platforms.linux;
    };
  }
