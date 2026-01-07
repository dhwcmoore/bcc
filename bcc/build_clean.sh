#!/usr/bin/env bash
set -Eeuo pipefail

echo "== cwd =="
pwd
echo

echo "== patch ai_lab_audit.ml open =="
if rg -n "^\s*open\s+Boundary_transport\b" ai_lab_audit.ml >/dev/null 2>&1; then
  cp -a ai_lab_audit.ml ai_lab_audit.ml.bak
  perl -pi -e 's/^\s*open\s+Boundary_transport\b/open Boundary_transport_build/' ai_lab_audit.ml
  echo "patched: open Boundary_transport -> open Boundary_transport_build"
else
  echo "no Boundary_transport open found (maybe already patched)"
fi
echo

echo "== patch demo.ml local type declarations =="
# Replace:
#   type lab_region
#   type prod_region
# with a local module Phantom.
if rg -n "^\s*type\s+lab_region\s*$" demo.ml >/dev/null 2>&1; then
  cp -a demo.ml demo.ml.bak
  perl -0777 -pi -e 's/\n(\s*)type\s+lab_region\s*\n\1type\s+prod_region\s*\n/\n\1module Phantom = struct\n\1  type lab_region\n\1  type prod_region\n\1end\n\n/gs' demo.ml
  echo "patched: moved phantom types into local module Phantom"
else
  echo "no local 'type lab_region' found (maybe already patched)"
fi
echo

echo "== clean build artifacts =="
rm -f boundary_demo audit_ai_labs *.cmi *.cmo
echo

echo "== compile library =="
ocamlfind ocamlc -package unix -c boundary_transport_build.ml
echo

echo "== compile demo =="
ocamlfind ocamlc -package unix -c demo.ml
echo

echo "== link demo =="
ocamlfind ocamlc -package unix -linkpkg boundary_transport_build.cmo demo.cmo -o boundary_demo
echo

echo "== compile audit =="
ocamlfind ocamlc -package unix -c ai_lab_audit.ml
echo

echo "== link audit =="
ocamlfind ocamlc -package unix -linkpkg boundary_transport_build.cmo ai_lab_audit.cmo -o audit_ai_labs
echo

echo "== run (head) =="
./boundary_demo | head -n 30 || true
echo
./audit_ai_labs | head -n 30 || true
echo
echo "DONE."
