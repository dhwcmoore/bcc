# Duston Moore, PhD

**Edmonton, Canada**  
dhwcmoore@gmail.com  
[GitHub: dhwcmoore/bcc](https://github.com/dhwcmoore/bcc)

---

## Summary

Independent researcher working at the intersection of formal logic, verification, and AI safety. Creator of **Boundary Closure Calculus (BCC)**, a proof-to-execution framework that makes boundary assumptions explicit and machine-checkable when safety, alignment, or governance claims are transported from internal validation contexts into real-world deployment.

The core contribution is a **formal artefact**: a system that demonstrates, in executable form, when a safety or oversight claim fails because the boundary it must cross was never formally justified.

---

## Primary Research Artefact: Boundary Closure Calculus (BCC)

**Repository:** https://github.com/dhwcmoore/bcc

Boundary Closure Calculus addresses a class of failures that occur even when internal validation succeeds. These failures arise when claims about safety, alignment, or control are implicitly transported across boundaries such as:

- validation → deployment  
- component → system  
- internal metrics → external guarantees  
- nominal oversight → effective control  

BCC treats such boundary crossings as **proof obligations** rather than informal assumptions.

---

### What BCC Demonstrates

- Certain safety and governance claims cannot be validly transported without additional structure  
- These failures are **structural**, not statistical  
- Failures are detected **constructively**: required transport proofs cannot be built  

**Implementation:**

- Machine-checked formalisation in **Rocq**  
- OCaml runtime enforcement layer  
- Executable audits that refuse unsafe boundary crossings and emit explicit failure traces  

The output is not a critique or score.  
It is a **failed proof**, with missing components identified.

---

## Key Technical Contributions

- **Boundary Transport Theorem**  
  Claims crossing non-trivial boundaries require explicit transport proofs; absent these, validity does not transfer.

- **Canonical Boundary Failure Modes**  
  Self-referential validation, silent scope expansion, composition failure, and human-in-the-loop illusions, each represented as constructive non-existence results.

- **Proof-to-Execution Pipeline**  
  Formal boundary logic developed in **Rocq** and operationalised as an OCaml runtime enforcement layer.

- **Reflexive Application**  
  Demonstration scenarios showing how the framework applies even to the institutions or processes that produce AI systems, not just downstream users.

---

## Technical Skills

- **Formal methods:** Rocq, theorem-driven specification  
- **Programming:** OCaml, Python  
- **Verification:** Executable specifications, audit artefact generation  
- **Mathematics:** Boundary-based reasoning, region-based logic, point-free formalisms  

---

## Education

**PhD, Philosophy** — KU Leuven, Belgium  
Dissertation on process philosophy and boundary logic, providing conceptual foundations for BCC.

---

## Publications

Peer-reviewed work in *Process Studies*, *Journal of Classical Sociology*, *Ethical Perspectives*.  
Technical papers and formal notes accompanying the BCC artefact.

---

## How to Read the Repository

The repository is intentionally compact. Reviewers are encouraged to:

1. Read `README.md` for the motivating problem and structure  
2. Inspect `boundary_transport.v` for the formal boundary logic  
3. Run the executable demos to observe boundary failures as explicit proof breakdowns
