# Boundary Closure Calculus (BCC)

**Executable Boundary Proofs for AI Safety, Validation, and Governance**

---

## What This Repository Is

This repository contains **Boundary Closure Calculus (BCC)**: a formal–to–executable framework for detecting **structural failures in AI safety and alignment claims** when those claims are transported from internal validation contexts into real-world deployment.

It answers a precise safety question:

> **When is a safety or alignment claim invalid because the boundary it must cross was never formally justified?**

BCC provides:

- a **formal logic of boundary transport** (machine-checked),
- an **executable audit engine** that enforces that logic at runtime,
- and **live demonstrations** applying it to modern AI labs.

This is **not** a policy checklist, benchmark suite, or governance narrative.  
It is a **proof-bearing boundary detector**.

---

## Why This Matters for AI Safety

Many high-impact AI failures are **not model failures**.  
They are **boundary failures**:

- validation → deployment  
- internal metrics → external outcomes  
- capability → authority  
- component safety → system safety  
- nominal oversight → effective control  

These failures occur **even when all internal checks pass**.

BCC makes these failures:

- formally explicit,
- structurally classifiable,
- and **machine-detectable**.

---

## Core Contributions

### 1. Boundary Transport Theorem (Formal)

The Coq development (`boundary_transport.v`) formalises the **Boundary Transport Theorem**:

> If a claim must cross a non-trivial boundary, then a transport proof is required.  
> If any required component of that proof is missing, the claim cannot be validly transported.

This theorem underpins canonical AI safety failure modes, including:

- Self-Referential Validation (SRV)
- Silent Scope Expansion (SSE)
- Composition Failure (CF)
- Human-in-the-Loop Illusions (HLI)
- Responsibility Transport Failure (RTF)

Each failure is a **constructive non-existence result**:  
a proof cannot be built given the available evidence.

---

### 2. Executable Boundary Audit Engine (OCaml)

The OCaml implementation (`boundary_transport_build.ml`, `ai_lab_audit.ml`) is a **runtime enforcement layer**, not documentation.

It provides:

- typed boundary representations,
- explicit domain and assumption shifts,
- determination rules **derived directly from theorem structure**,
- structured audit artefacts suitable for research, red-teaming, and governance review.

The engine **refuses unsafe boundary crossings**.

---

### 3. Reflexive AI Lab Audits (Live Demo)

The included binaries demonstrate **reflexive application** of the framework:

```bash
./audit_ai_labs
This performs boundary audits of:

Anthropic — Constitutional AI self-evaluation  
OpenAI — validation → deployment expansion  

The output is not an opinionated critique.  
It is a failed transport proof, with missing components explicitly identified.

---

## What Makes This Different from Existing AI Safety Work

Most AI safety work focuses on *models*.  
Boundary Closure Calculus focuses on *claims crossing contexts*.

Existing approaches typically emphasise:

models and benchmarks,  
policy frameworks and narratives,  
post-hoc critique and interpretation.

BCC instead provides:

proof obligations for claim transport,  
explicit boundary classes,  
constructive detection of failure cases.

This distinction matters because many high-impact failures occur **after** internal validation succeeds.

BCC does not replace alignment research, interpretability, or red-teaming.  
It guards the boundaries *between* them.

---

## Repository Structure

```
bcc/
├── boundary_transport.v           Coq formalisation of the Boundary Transport Theorem
├── boundary_transport.ml          OCaml extraction from Coq proofs
├── boundary_transport_build.ml    Runtime boundary enforcement engine
├── ai_lab_audit.ml                Reflexive audit scenarios for AI labs
├── demo.ml                        Demonstration scenarios
│
├── checklist_theorem_correspondence.md   Mapping: audit items ↔ proof obligations
├── Build_and_Run_Guide.pdf        Build and execution instructions
│
├── ai_lab_audit                   Compiled binary
├── audit_ai_labs                  Compiled binary
├── boundary_demo                  Compiled binary
│
├── build.sh                       Build script
└── README.md                      This document
```



The repository is intentionally compact.
Every file corresponds to a concrete role in the boundary-to-execution pipeline.

There are no hidden dependencies, benchmarks, or narrative layers.


## Status

This is a working research artefact.

- Formal proofs compile.
- Executable audits run.
- Outputs are reproducible.

The repository is intentionally small, explicit, and auditable.

## Author

Duston Moore, PhD  
Formal logic, AI safety, boundary-aware verification  
Edmonton, Canada

## License

MIT License.

The license is intentionally permissive to enable research reuse, critique, and extension.
