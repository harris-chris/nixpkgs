{
  lib,
  buildPythonPackage,
  fetchPypi,
  fetchpatch2,
  jsonschema,
  mwcli,
  mwtypes,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "mwxml";
  format = "setuptools";
  version = "0.3.4";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ejf3RfdwcEp0Ge+96dORuHS5Bx28GSs7H4HD1LUnde4=";
  };

  patches = [
    # https://github.com/mediawiki-utilities/python-mwxml/pull/21
    (fetchpatch2 {
      name = "nose-to-pytest.patch";
      url = "https://github.com/mediawiki-utilities/python-mwxml/compare/2b477be6aa9794064d03b5be38c7759d1570488b...71bbfd2b309e0720a34a4e783b71169aebc571ef.patch";
      hash = "sha256-4XxNvda1Dj+kFbD9t9gzucrMjdfXcoqYlvecXO2B2R0=";
    })
  ];

  dependencies = [
    jsonschema
    mwcli
    mwtypes
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "mwxml" ];

  meta = with lib; {
    description = "Set of utilities for processing MediaWiki XML dump data";
    mainProgram = "mwxml";
    homepage = "https://github.com/mediawiki-utilities/python-mwxml";
    license = licenses.mit;
    maintainers = with maintainers; [ GaetanLepage ];
  };
}
