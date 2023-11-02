{
  stdenv,
  fetchFromGitHub,
  lib,
  meson,
  ninja,
  cmake,
  pkg-config,
  qtbase,
  qttools,
  wrapQtAppsHook,
  libopenrazer,
  enableExperimental ? false,
  includeMatrixDiscovery ? false,
}: let
  version = "1.1.0";
  pname = "razergenie";
in
  stdenv.mkDerivation {
    inherit pname version;

    dontUseCmakeConfigure = true;

    src = fetchFromGitHub {
      owner = "z3ntu";
      repo = "RazerGenie";
      rev = "v${version}";
      hash = "sha256-eVo3gCaKUoEZM5Zp1d+1XFu2LxdRo50GQBPy85RbxCo=";
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
      libopenrazer
    ];

    # mesonFlags = [
    #   "-Denable_experimental=${lib.boolToString enableExperimental}"
    #   "-Dinclude_matrix_discovery=${lib.boolToString includeMatrixDiscovery}"
    # ];

    meta = with lib; {
      homepage = "https://github.com/z3ntu/RazerGenie";
      description = "Qt application for configuring your Razer devices under GNU/Linux";
      license = licenses.gpl3;
      maintainers = with maintainers; [f4814n Mogria];
      platforms = platforms.linux;
    };
  }
