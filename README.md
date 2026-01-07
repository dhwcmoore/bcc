# Boundary Consultant

**A Formal Framework for Detecting and Preventing Boundary Failures**

---

## Overview

This repository contains the complete Boundary Consultant framework: a mathematically grounded methodology for identifying structural failures that occur when claims, validations, or guarantees are transported across contextual boundaries.

The framework addresses a precise question: when is a safety, alignment, or governance claim invalid because the boundary it must cross was never formally justified?

---

## Repository Structure

```
boundaryconsultant/
├── papers/
│   ├── A_Formal_Boundary_Logic.pdf
│   │   Foundational logic of boundary transport and closure.
│   │
│   ├── Boundary_Discipline_ML.pdf
│   │   Structural limits of machine learning for scientific understanding.
│   │   Establishes Production-Closure Separation and Measure-Partition Mismatch theorems.
│   │
│   └── Boundary_Conditions_Reward.pdf
│       Axiom-Boundary Correspondence for reward maximisation.
│       Proves that axiom violations in the Markov Reward Theorem
│       correspond to boundary conditions requiring external certification.
│
├── checklists/
│   ├── Authority Misalignment Checklist.md
│   ├── Context Boundary Failure Checklist.md
│   ├── Human-in-the-Loop Illusion Checklist.md
│   ├── Proxy Boundary Failure Checklist.md
│   ├── Self-Referential Validation Checklist.md
│   ├── Silent Scope Expansion Checklist.md
│   ├── Specification-Intent Divergence Checklist.md
│   ├── Temporal Closure Error Checklist.md
│   ├── Grounding Theorem.md
│   └── Unified Framework - Regional Calculus to Boundary Failures.md
│
└── bcc/
    ├── boundary_transport.v      Rocq formalisation of Boundary Transport Theorem
    ├── boundary_transport.ml     OCaml extraction from Rocq
    ├── boundary_transport_build.ml   Runtime boundary enforcement engine
    ├── ai_lab_audit.ml           Reflexive audits of AI lab claims
    ├── demo.ml                   Demonstration scenarios
    └── (build scripts, binaries, documentation)
```

---

## Core Contributions

### 1. Theoretical Foundations (papers/)

Three rigorous academic papers establish the mathematical basis:

**A Formal Boundary Logic** develops the logic of boundary transport, establishing when claims can and cannot be validly transported across contextual boundaries.

**Boundary Discipline and ML** proves that machine learning systems are structurally incapable of recognising certain classes of error, including boundary failures outside their event algebra. Key results include the Production-Closure Separation Theorem and the Measure-Partition Mismatch Theorem.

**Boundary Conditions for Reward Maximisation** establishes the Axiom-Boundary Correspondence: the reward hypothesis holds for a goal specification if and only if the specification contains no boundary conditions requiring external certification. This provides formal justification for neuro-symbolic safety architectures.

### 2. Audit Checklists (checklists/)

Ten canonical boundary failure types with structured audit checklists mapping directly to formal proof obligations. Each checklist item tests for the presence of a specific component required for valid transport.

### 3. Executable Implementation (bcc/)

A working OCaml implementation that enforces boundary transport requirements at runtime, producing audit-grade determinations and missing-component lists suitable for governance review.

---

## Ten Canonical Boundary Failures

1. **Self-Referential Validation (SRV)**: Internal validation treated as external validity
2. **Silent Scope Expansion (SSE)**: Scope expands without revalidation
3. **Composition Failure (CF)**: Component safety fails to compose at system level
4. **Human-in-the-Loop Illusion (HLI)**: Nominal oversight without effective control
5. **Responsibility Transport Failure (RTF)**: Responsibility diffuses across boundaries
6. **Authority Misalignment (AM)**: Capability exceeds mandate
7. **Context Boundary Failure (CBF)**: Context assumptions violated at deployment
8. **Proxy Boundary Failure (PBF)**: Proxy metrics diverge from target properties
9. **Specification-Intent Divergence (SID)**: Formal specification misses intent
10. **Temporal Closure Error (TCE)**: Temporal assumptions violated at boundary

---

## Key Theorems

**Boundary Transport Theorem**: If a claim must cross a non-trivial boundary, then a transport proof is required. If any required component of that proof is missing, the claim cannot be validly transported.

**Production-Closure Separation Theorem**: Closure cannot be internalised as a finite composition of productive operations in systems of sufficient expressive power.

**Measure-Partition Mismatch Theorem**: Probabilistic methods cannot repair boundary misalignment when the relevant distinctions are absent from the probability space.

**Axiom-Boundary Correspondence**: The reward hypothesis holds for a goal specification if and only if the specification contains no boundary conditions requiring external certification.

---

## Author

Duston Moore, PhD  
Formal logic, AI safety, boundary-aware verification  
Edmonton, Canada

---

## License

MIT License
