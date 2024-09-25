{ lib, stdenv, fetchFromGitHub, postgresql, gnumake, python311 }:

stdenv.mkDerivation rec {
  pname = "pguint";
  version = "1.20231206";

  buildInputs = [ gnumake postgresql python311 ];

  src = fetchFromGitHub {
    owner  = "harris-chris";
    repo   = "pguint";
    rev    = "d30a099c69480b79ae038edfc17debc34f024ce4";
    sha256 = "sha256-PgZzwpN5UIcpSgqYtblJ0bbPCfKkzKOjIPz0RIrWjZU=";
  };

  buildPhase = ''
    make
  '';

  installPhase = ''
    install -D uint.so             -t $out/lib
    install -D uint--0.sql         -t $out/share/postgresql/extension
    install -D uint.control        -t $out/share/postgresql/extension
  '';

  meta = with lib; {
    description = "Unsigned and other extra integer types for PostgreSQL";
  };
}
