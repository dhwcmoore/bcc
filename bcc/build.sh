#!/usr/bin/env bash
set -Eeuo pipefail

# -------- configuration --------
BIG="boundary_transport_all.ml"
# --------------------------------

if [ ! -f "$BIG" ]; then
  echo "ERROR: cannot find $BIG in $(pwd)"
  echo "Files here are:"
  ls -la
  exit 1
fi

echo "Using BIG file: $BIG"

mkdir -p src bin

# Library
sed -n '1,/BOUNDARY TRANSPORT DEMONSTRATION/{
  /BOUNDARY TRANSPORT DEMONSTRATION/ q
  p
}' "$BIG" > src/boundary_transport.ml

# Demo
sed -n '/BOUNDARY TRANSPORT DEMONSTRATION/,/AI LAB BOUNDARY AUDIT/{
  /AI LAB BOUNDARY AUDIT/ q
  p
}' "$BIG" > bin/demo_boundary_transport.ml

# Audit
sed -n '/AI LAB BOUNDARY AUDIT/,$p' "$BIG" > bin/audit_ai_labs.ml

# Add set_of_list helper
perl -0777 -i -pe 's/(module StringMap = Map\.Make\(String\)\n\n)/$1let set_of_list (xs : string list) : StringSet.t =\n  List.fold_left (fun acc x -> StringSet.add x acc) StringSet.empty xs\n\n/sg' src/boundary_transport.ml

# Replace StringSet.of_list
sed -i 's/\bStringSet\.of_list\b/set_of_list/g' \
  src/boundary_transport.ml \
  bin/demo_boundary_transport.ml \
  bin/audit_ai_labs.ml

# Create dune files
cat > dune-project <<EOF
(lang dune 3.10)
(name boundary_transport)
EOF

cat > src/dune <<EOF
(library
 (name boundary_transport)
 (public_name boundary_transport))
EOF

cat > bin/dune <<EOF
(executable
 (name demo_boundary_transport)
 (modules demo_boundary_transport)
 (libraries boundary_transport unix))

(executable
 (name audit_ai_labs)
 (modules audit_ai_labs)
 (libraries boundary_transport unix))
EOF

echo "Running dune build…"
dune build
echo "Build complete."
