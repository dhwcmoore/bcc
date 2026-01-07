#!/usr/bin/env bash
set -Eeuo pipefail

echo "== cwd =="
pwd

echo "== clean build artefacts =="
rm -f *.cmi *.cmo boundary_demo audit_ai_labs demo_out.txt audit_out.txt

echo "== compile library =="
ocamlfind ocamlc -package unix -c boundary_transport_build.ml

echo "== compile demo + audit sources =="
ocamlfind ocamlc -package unix -c -I . demo.ml
ocamlfind ocamlc -package unix -c -I . ai_lab_audit.ml

echo "== link executables =="
ocamlfind ocamlc -package unix -linkpkg boundary_transport_build.cmo demo.cmo -o boundary_demo
ocamlfind ocamlc -package unix -linkpkg boundary_transport_build.cmo ai_lab_audit.cmo -o audit_ai_labs

echo "OK: built boundary_demo + audit_ai_labs"
