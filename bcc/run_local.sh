#!/usr/bin/env bash
set -Eeuo pipefail

rm -f demo_out.txt audit_out.txt

./boundary_demo > demo_out.txt
echo "demo exit code = $?"

./audit_ai_labs > audit_out.txt
echo "audit exit code = $?"

echo "== tail demo_out.txt =="
tail -n 5 demo_out.txt

echo "== tail audit_out.txt =="
tail -n 5 audit_out.txt
