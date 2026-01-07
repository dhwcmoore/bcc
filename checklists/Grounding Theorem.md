# Grounding Theorem for Boundary Failures

## The Boundary Transport Theorem and Its Ten Corollaries

---

## 0. Purpose

This document establishes a single grounding theorem from which all ten canonical boundary failures can be derived as corollaries. The theorem formalises the core insight of Regional Calculus: boundaries are primitive structures requiring explicit characterisation, and properties do not transport across boundaries without proof.

The theorem is stated in three equivalent forms: set-theoretic, type-theoretic, and categorical. Each form admits mechanisation. The connection to audit instruments is made explicit: checklist failures correspond to missing components of transport proofs.

---

## 1. The Grounding Theorem

### 1.1 Informal Statement

**Theorem (Boundary Transport Failure).**
Let P be a property verified in region R₁. Let B be a boundary separating R₁ from region R₂. The inference

    R₁ ⊢ P
    ─────────
    R₂ ⊢ P

is invalid without a transport theorem T(B) that explicitly characterises B and proves P is preserved across it.

**Corollary (Boundary Failure Schema).**
Every boundary failure is an instance of applying the invalid inference above. The ten canonical failures correspond to ten boundary types where transport is routinely assumed but not established.

---

### 1.2 Set-Theoretic Formulation

**Definition 1 (Region).**
A region R is a tuple (D, A, Φ) where:
- D ⊆ U is a domain (subset of universe of states)
- A is a set of background assumptions (axioms holding in D)
- Φ is a set of properties verified in R

**Definition 2 (Boundary).**
A boundary B between regions R₁ = (D₁, A₁, Φ₁) and R₂ = (D₂, A₂, Φ₂) is characterised by:
- Domain shift: Δ_D = D₂ \ D₁ (states in R₂ not in R₁)
- Assumption shift: Δ_A = A₁ \ A₂ (assumptions in R₁ not in R₂)
- The boundary is non-trivial if Δ_D ≠ ∅ or Δ_A ≠ ∅

**Definition 3 (Transport Theorem).**
A transport theorem T(B, P) for property P across boundary B is a proof that:

    ∀x ∈ D₂: A₂ ⊢ P(x)

given that:

    ∀x ∈ D₁: A₁ ⊢ P(x)

The transport theorem must explicitly handle:
1. **Domain extension**: Prove P holds for x ∈ Δ_D
2. **Assumption weakening**: Prove P holds without assumptions in Δ_A

**Theorem 1 (Transport Necessity).**
If B is non-trivial (Δ_D ≠ ∅ or Δ_A ≠ ∅), then there exists a property P such that:
- R₁ ⊢ P
- R₂ ⊬ P

without an explicit transport theorem.

*Proof.* Constructive. 
- If Δ_D ≠ ∅, let P(x) = "x ∈ D₁". Then P holds in R₁ trivially but fails for any x ∈ Δ_D.
- If Δ_A ≠ ∅, let a ∈ Δ_A and let P be any property whose proof requires a. Then P holds in R₁ (where a is assumed) but the proof does not go through in R₂ (where a is not assumed). ∎

---

### 1.3 Type-Theoretic Formulation

**Definition 4 (Boundary-Indexed Types).**
Properties are dependent types indexed by regions:

    P : Region → Type

A proof of P in region R is a term:

    p : P(R)

**Definition 5 (Boundary Modality).**
For regions R₁, R₂ separated by boundary B, define a modality:

    □_B : Type → Type

with introduction rule (in R₁):

    Γ ⊢ p : P(R₁)
    ─────────────────────
    Γ ⊢ seal(p) : □_B(P(R₁))

and **no general elimination rule** in R₂. Evidence from R₁ can be carried across B only in sealed form.

**Definition 6 (Transport Term).**
A transport term for P across B is a function:

    transport_B : □_B(P(R₁)) → P(R₂)

Such a term exists only when an explicit bridging proof is constructed.

**Theorem 2 (Unsealing Requires Transport).**
In the absence of a transport term, for any context Γ in R₂:

    Γ, x : □_B(P(R₁)) ⊬ t : P(R₂)

*Proof.* By induction on typing derivations. The only way to obtain P(R₂) is:
1. From a variable of type P(R₂) in Γ — but we only have □_B(P(R₁))
2. From elimination of □_B — but no eliminator exists without transport_B
3. From other type formers — but none produce P(R₂) from □_B(P(R₁))

No derivation exists. ∎

---

### 1.4 Categorical Formulation

**Definition 7 (Boundary as Functor Without Counit).**
Let C₁ and C₂ be categories of types/proofs in regions R₁ and R₂. A boundary B is modelled as a functor:

    □_B : C₁ → C₂

that transports evidence from R₁ into C₂ as "sealed" objects.

The boundary is **non-transparent** if there is no natural transformation:

    ε : □_B ⟹ Id_{C₂}

(no counit). This means sealed evidence cannot be "opened" in R₂.

**Theorem 3 (Transport as Controlled Counit).**
A transport theorem T(B, P) corresponds to a counit restricted to P:

    ε_P : □_B(P) → P

in C₂. Without this restricted counit, no morphism 1 → P exists in C₂ given only a morphism 1 → □_B(P).

---

## 2. The Ten Corollaries

Each boundary failure is a corollary of the Grounding Theorem applied to a specific boundary type. For each, we identify:
- The boundary B
- The property P that fails to transport
- The missing transport theorem
- The corresponding checklist section that detects the failure

---

### 2.1 Composition Failure (CF)

**Boundary:** Interface between components
**Regions:** R₁ = component validity region; R₂ = system validity region
**Property:** P = "System satisfies global invariant φ"

**Failure instance:**
- Component i satisfies local specification ψᵢ in its region
- System region requires: ∧ᵢψᵢ ⊢ φ
- This entailment is the transport theorem
- If not proven, local validity does not imply global validity

**Transport theorem required:** Proof that component invariants jointly entail system invariants, with interface boundary conditions explicit.

**Checklist correspondence:** CF-A01 Section B (System-Level Invariants) tests for explicit global invariant and invariant testability. Section C (Interaction Effects) tests whether interface effects are characterised.

---

### 2.2 Specification–Intent Divergence (SID)

**Boundary:** Semantic boundary between syntax and semantics
**Regions:** R₁ = specification-satisfying states; R₂ = intent-satisfying states
**Property:** P = "Outcome achieves normative purpose"

**Failure instance:**
- System satisfies specification S (in syntactic region)
- Intent I requires: S ⊢ I
- Spec ⊂ Intent typically; optimisation finds Spec \ Intent
- Transport from "satisfies spec" to "achieves intent" is assumed, not proven

**Transport theorem required:** Semantic adequacy proof that specification satisfaction entails intent satisfaction.

**Checklist correspondence:** SID-A01 Section A (Intent Documentation) tests whether intent is articulated. Section B (Specification Completeness) tests whether the spec-intent gap is analysed.

---

### 2.3 Context Boundary Failure (CBF)

**Boundary:** Environmental boundary between contexts
**Regions:** R₁ = (D_lab, A_lab, Φ_lab); R₂ = (D_wild, A_wild, Φ_wild)
**Property:** P = "System output is valid"

**Failure instance:**
- System validated in lab context with assumptions A_lab on domain D_lab
- Deployed in wild context where D_wild ⊄ D_lab or A_wild ⊭ A_lab
- Validity is context-indexed: P(R_lab) does not transport to P(R_wild)

**Transport theorem required:** Context transfer proof with explicit bridging of domain and assumption shifts.

**Checklist correspondence:** CBF-A01 Section C (Transport Mechanism) directly tests for bridging argument and transfer conditions.

---

### 2.4 Temporal Closure Error (TCE)

**Boundary:** Temporal boundary between time points
**Regions:** R₁ = (D_t, A_t, Φ_t); R₂ = (D_{t+δ}, A_{t+δ}, Φ_{t+δ})
**Property:** P = "Decision D is valid"

**Failure instance:**
- Decision valid at time t given conditions C_t
- At t+δ, conditions may have changed: C_{t+δ} ≠ C_t
- Validity does not persist: P(R_t) does not imply P(R_{t+δ})

**Transport theorem required:** Temporal persistence proof that conditions remain stable across [t, t+δ].

**Checklist correspondence:** TCE-A01 Section B (Expiry and Review) tests for validity duration. Section C (Condition Monitoring) tests for change detection.

---

### 2.5 Authority Misalignment (AM)

**Boundary:** Governance boundary between capability and mandate
**Regions:** R₁ = capability region (what can be done); R₂ = authority region (what may be done)
**Property:** P = "Action is legitimate"

**Failure instance:**
- System has capability C
- Authority A ⊂ C
- System acts on capability, not authority
- Legitimacy does not follow from capability: P(R_capability) ⊬ P(R_authority)

**Transport theorem required:** Authority containment proof that action scope ⊆ mandate scope.

**Checklist correspondence:** AM-A01 Section A (Authority Definition) tests whether authority is defined independently of capability. Section B (Authority Enforcement) tests for pre-action verification.

---

### 2.6 Proxy Boundary Failure (PBF)

**Boundary:** Measurement boundary between proxy and goal
**Regions:** R₁ = proxy-optimising region; R₂ = goal-achieving region
**Property:** P = "Outcome is good"

**Failure instance:**
- Proxy M correlates with goal G under normal conditions
- Under optimisation pressure, system finds states with high M, low G
- Proxy success does not transport to goal success

**Transport theorem required:** Proxy fidelity proof that proxy optimisation entails goal advancement under specified optimisation bounds.

**Checklist correspondence:** PBF-A01 Section A (Proxy-Goal Relationship) tests validity conditions. Section C (Goal Measurement) tests for independent goal verification.

---

### 2.7 Silent Scope Expansion (SSE)

**Boundary:** Domain boundary between validated and applied domains
**Regions:** R₁ = validated domain; R₂ = application domain
**Property:** P = "System is fit for purpose"

**Failure instance:**
- System validated in domain D₁
- Applied in domain D₂ where D₂ ⊄ D₁
- No re-validation occurs
- Fitness does not transfer: P(R₁) ⊬ P(R₂)

**Transport theorem required:** Domain generalisation proof that validation in D₁ justifies application in D₂.

**Checklist correspondence:** SSE-A01 Section A (Domain Definition) tests whether validated domain is specified. Section B (Reuse Controls) tests for re-validation requirement.

---

### 2.8 Human-in-the-Loop Illusion (HLI)

**Boundary:** Control boundary between nominal and effective oversight
**Regions:** R₁ = nominal oversight region; R₂ = effective oversight region
**Property:** P = "Human controls outcome"

**Failure instance:**
- Human is nominally designated as overseer
- Human lacks information, authority, or time to actually control
- Nominal oversight does not transport to effective oversight

**Transport theorem required:** Oversight effectiveness proof that named overseer has causal influence on outcomes.

**Checklist correspondence:** HLI-A01 Section B (Information Access), Section C (Authority), Section D (Time and Capacity) test for the components required for effective oversight.

---

### 2.9 Self-Referential Validation (SRV)

**Boundary:** Closure boundary between internal and external validity
**Regions:** R₁ = internal consistency region; R₂ = external correspondence region
**Property:** P = "System is correct"

**Failure instance:**
- System is internally consistent (validates against own criteria)
- External validity requires correspondence to external reality
- Consistency does not imply correspondence: P(R_internal) ⊬ P(R_external)

**Transport theorem required:** Grounding proof that internal validation corresponds to external truth.

**Checklist correspondence:** SRV-A01 Section A (External Grounding) tests for independent reference. Section C (Circularity Detection) tests whether the internal/external boundary is crossed.

---

### 2.10 Responsibility Diffusion Error (RDE)

**Boundary:** Accountability boundary between role completion and outcome ownership
**Regions:** R₁ = role-completion region; R₂ = outcome-ownership region
**Property:** P = "Outcome is owned by accountable agent"

**Failure instance:**
- Each role completes its tasks (local validity)
- Outcome ownership requires explicit accountability witness
- Task completion does not transport to outcome ownership

**Transport theorem required:** Responsibility closure proof that accountability chains terminate in agents with enforceable obligations.

**Checklist correspondence:** RCA-A01 Section A (Outcome Ownership) tests for named owner. Section B (Boundary Transitions) tests whether responsibility is explicitly reassigned at handoffs.

---

## 3. The Meta-Theorem

**Theorem 4 (Boundary Failure Universality).**
Let F be any of the ten canonical boundary failures. Then F is an instance of Theorem 1 (Transport Necessity) applied to the corresponding boundary type B_F and property P_F.

*Proof.* By case analysis on F. For each failure:
1. Identify the boundary B_F and regions R₁, R₂
2. Identify the property P_F that is assumed to transport
3. Show that the boundary is non-trivial (Δ_D ≠ ∅ or Δ_A ≠ ∅)
4. Conclude by Theorem 1 that P_F may fail in R₂ without explicit transport

The case analysis is provided in Section 2. ∎

**Corollary (Audit-Theorem Correspondence).**
For each boundary failure F with checklist instrument I_F:
- A "No" answer on a checklist item corresponds to a missing component of the transport theorem T(B_F, P_F)
- If the determination rule for F is satisfied, no transport theorem exists and F is present or probable

This establishes that the checklists are not ad hoc diagnostic instruments but systematic tests for the existence of transport proofs.

---

## 4. The Constructive Repair Theorem

**Theorem 5 (Transport Sufficiency).**
Let B be a boundary between R₁ and R₂. If a transport theorem T(B, P) is explicitly constructed, then:

    R₁ ⊢ P  and  T(B, P)  ⊢  R₂ ⊢ P

*Proof.* Immediate from the definition of transport theorem. T(B, P) provides exactly the proof required to establish P in R₂ given P in R₁. ∎

**Corollary (Checklist Compliance as Transport Construction).**
Satisfying all checklist items for failure F corresponds to constructing (or verifying the existence of) the transport theorem T(B_F, P_F).

This yields the positive programme: audits are not merely diagnostic but constructive. A fully passed checklist provides evidence that the relevant transport theorem exists.

---

## 5. Connection to Regional Calculus

The Grounding Theorem is an instance of the Regional Calculus axiom:

**RC Axiom:** Regions and boundaries are ontologically primitive. Properties are region-indexed. Boundaries require explicit characterisation; they are not transparent.

The ten boundary failures instantiate ten ways this axiom is violated in practice:

| Failure | Boundary Type | Violated Axiom Aspect |
|---------|---------------|----------------------|
| CF | Composition | Boundaries at interfaces ignored |
| SID | Semantic | Boundary between syntax/semantics assumed transparent |
| CBF | Context | Boundary between contexts assumed absent |
| TCE | Temporal | Temporal boundaries not modelled |
| AM | Authority | Boundary between can/may collapsed |
| PBF | Proxy | Boundary between measure/goal assumed transparent |
| SSE | Domain | Boundary of validated domain not enforced |
| HLI | Oversight | Boundary between nominal/effective collapsed |
| SRV | Closure | Internal/external boundary never crossed |
| RDE | Accountability | Role/outcome boundary assumed compositional |

The Regional Calculus provides the ontological foundation. The Grounding Theorem provides the logical formalisation. The checklists provide the operational detection mechanism.

---

## 6. Toward Mechanisation

The type-theoretic formulation (Section 1.3) admits direct mechanisation in Coq, Agda, or Lean.

**Required components:**

1. **Region type:** `Region : Type`
2. **Property as dependent type:** `Property : Region → Type`
3. **Boundary modality:** `Box : Region → Region → Type → Type`
4. **Sealed evidence introduction:** `seal : ∀ R₁ R₂ P, P R₁ → Box R₁ R₂ (P R₁)`
5. **Transport type:** `Transport : ∀ R₁ R₂ P, Box R₁ R₂ (P R₁) → P R₂ → Type`
6. **Theorem 2 as unprovability:** Show `∀ Γ, (x : Box R₁ R₂ (P R₁)) ∈ Γ → ¬ ∃ t, Γ ⊢ t : P R₂` when no transport term is provided

The flagship theorem from the original document (responsibility closure is not compositional under delegation refinement) becomes a specific instantiation where:
- R₁ = boundary 1 (delegating region)
- R₂ = boundary 2 (delegated region)
- P = Accountability witness for outcome o
- The delegation refinement replaces unsealed ownership with sealed ownership
- Without transport (cross-boundary escalation with enforcement), accountability cannot be established in R₁

This provides the Coq-ready skeleton for full mechanisation.

---

## 7. Summary

**One theorem. Ten corollaries. Ten checklists.**

The Boundary Transport Theorem is the grounding result. It states that properties do not cross boundaries without explicit transport proofs. Each boundary failure is a case where transport is assumed but not established. Each checklist tests for the components of the transport proof. The Regional Calculus provides the philosophical foundation: boundaries are primitive.

This is not a taxonomy. It is a deductive system.

---

*Boundary Consultant — Grounding Theorem v1.0*
