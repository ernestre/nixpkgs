{ lib
, aiohttp
, aresponses
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pytest-asyncio
, pytest-freezer
, pytestCheckHook
, pythonOlder
, yarl
}:

buildPythonPackage rec {
  pname = "energyzero";
  version = "0.4.1";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "klaasnicolaas";
    repo = "python-energyzero";
    rev = "refs/tags/v${version}";
    hash = "sha256-qBtsNqmGLCUGTYJ8iPL/Ie3yGX7Ocs4e+yp0tRAhK8g=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"0.0.0"' '"${version}"' \
      --replace 'addopts = "--cov"' ""
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    yarl
  ];

  nativeCheckInputs = [
    aresponses
    pytest-asyncio
    pytest-freezer
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "energyzero"
  ];

  meta = with lib; {
    description = "Module for getting the dynamic prices from EnergyZero";
    homepage = "https://github.com/klaasnicolaas/python-energyzero";
    changelog = "https://github.com/klaasnicolaas/python-energyzero/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
