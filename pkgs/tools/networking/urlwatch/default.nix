{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "urlwatch";
  version = "2.26";

  src = fetchFromGitHub {
    owner = "thp";
    repo = "urlwatch";
    rev = version;
    hash = "sha256-EdRHwUHnAwum7UIgzmETeuQSyisb4zrmWGPgo7RewWQ=";
  };

  propagatedBuildInputs = with python3Packages; [
    appdirs
    cssselect
    jq
    keyring
    lxml
    markdown2
    matrix-client
    minidb
    pushbullet-py
    pycodestyle
    pyppeteer
    pyyaml
    requests
  ];

  # no tests
  doCheck = false;

  meta = with lib; {
    description = "A tool for monitoring webpages for updates";
    homepage = "https://thp.io/2008/urlwatch/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ kmein tv ];
  };
}
