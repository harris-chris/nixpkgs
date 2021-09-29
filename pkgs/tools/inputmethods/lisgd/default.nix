{ lib
, stdenv
, fetchFromSourcehut
, writeText
, libinput
, libX11
, wayland
, conf ? null
, patches ? [ ]
}:

stdenv.mkDerivation rec {
  pname = "lisgd";
  version = "0.3.2";

  src = fetchFromSourcehut {
    owner = "~mil";
    repo = "lisgd";
    rev = version;
    sha256 = "sha256-yE2CUv1XDvo8fW0bLS1O2oxgDUu4drCO3jFpxPgAYKU=";
  };

  inherit patches;

  postPatch = let
    configFile = if lib.isDerivation conf || lib.isPath conf then
      conf
    else
      writeText "config.def.h" conf;
  in lib.optionalString (conf != null) ''
    cp ${configFile} config.def.h
  '';

  buildInputs = [
    libinput
    libX11
    wayland
  ];

  makeFlags = [
    "PREFIX=${placeholder "out"}"
  ];

  meta = with lib; {
    description = "Bind gestures via libinput touch events";
    homepage = "https://git.sr.ht/~mil/lisgd";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ dotlambda ];
  };
}
