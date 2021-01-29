{ mkDerivation, base, stdenv, pure-json, pure-random-pcg, pure-time, pure-txt, text, hashable }:
mkDerivation {
  pname = "pure-marker";
  version = "0.8.0.0";
  src = ./.;
  libraryHaskellDepends = [ base pure-json pure-random-pcg pure-time pure-txt text hashable ];
  homepage = "github.com/grumply/pure-marker";
  license = stdenv.lib.licenses.bsd3;
}
