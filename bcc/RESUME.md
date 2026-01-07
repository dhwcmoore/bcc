
```markdown
# Duston Moore, PhD

**Edmonton, Canada**  
dhwcmoore@gmail.com  
[GitHub: dhwcmoore/bcc](https://github.com/dhwcmoore/bcc)

## Summary

Independent researcher at the intersection of formal logic, verification, and AI safety. Creator of **Boundary Closure Calculus (BCC)**, a proof-to-execution framework that makes boundary assumptions explicit and machine-checkable. BCC demonstrates when safety, alignment, or governance claims fail because the boundaries they must cross were never formally justified.

## Primary Research Artefact: Boundary Closure Calculus

**Repository:** [github.com/dhwcmoore/bcc](https://github.com/dhwcmoore/bcc)

BCC addresses failures that occur even when internal validation succeeds—failures arising from implicit boundary crossings in:
- validation → deployment
- component → system
- internal metrics → external guarantees
- nominal oversight → effective control

The framework treats boundary crossings as proof obligations rather than informal assumptions.

### What BCC Demonstrates

- Certain safety and governance claims cannot be validly transported without additional structure
- These failures are structural, not statistical
- Failures are detected constructively: required proofs cannot be built

**Implementation:**
- Machine-checked formalisation in Coq
- OCaml runtime enforcement layer
- Executable audits with explicit failure traces

## Key Technical Contributions

- **Boundary Transport Theorem:** Claims crossing non-trivial boundaries require explicit transport proofs
- **Canonical Failure Modes:** Self-referential validation, silent scope expansion, composition failure, human-in-the-loop illusions
- **Proof-to-Execution Pipeline:** Coq formalism operationalised as OCaml runtime enforcement
- **Reflexive Application:** Framework applies to institutions and processes producing AI systems

## Technical Skills

- **Formal methods:** Coq, theorem-driven specification
- **Programming:** OCaml, Python
- **Verification:** Executable specifications, audit generation
- **Mathematics:** Boundary-based reasoning, region-based logic, point-free formalisms

## Education

**PhD, Philosophy** — KU Leuven, Belgium  
Dissertation on process philosophy and boundary logic, providing conceptual foundations for BCC.

## Publications

Peer-reviewed work in *Process Studies*, *Journal of Classical Sociology*, *Ethical Perspectives*.  
Technical papers accompanying BCC repository.

## Getting Started

- **README:** Problem statement and structure
- **boundary_transport.v:** Formal boundary logic
- **Demos:** Observe boundary failures as proof breakdowns
```
