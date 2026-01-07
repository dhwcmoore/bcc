# Boundary Failures: A Unified Framework

## From Regional Calculus to Organisational Pathology

### Theoretical Foundation

This document establishes the common theoretical structure underlying all ten canonical boundary failures. Each failure is shown to be an instance of a single error type: the violation of boundary integrity in systems where regions and their boundaries are treated as derived rather than primitive.

---

## 1. The Core Insight from Regional Calculus

Standard mathematical practice treats points as primitive and constructs regions as sets of points, boundaries as limits or frontiers derived from regions. This is backwards.

**Regional Calculus Axiom:** Regions and boundaries are ontologically primitive. Points are derived as limit constructions. Boundaries are not "where regions end" but are themselves irreducible structures with their own topology.

**Consequence:** A boundary is not merely the edge of something. A boundary is a structure that:

- Separates regions
- Mediates transition between regions
- Carries information about both regions it separates
- Can fail in ways invisible to analysis of regions alone

When systems (technical, organisational, regulatory) ignore the primitive status of boundaries, they commit predictable errors. These errors are the ten canonical boundary failures.

---

## 2. The Boundary Failure Schema

Every boundary failure instantiates a single schema:

**Schema:** A system operates correctly within region R₁. The system is extended, deployed, composed, or evaluated across a boundary B into region R₂. The extension assumes B is transparent (information passes through unchanged) or absent (R₁ and R₂ are the same region). The assumption is false. The system fails.

**Formal statement:** Let φ be a property verified in R₁. The inference

    R₁ ⊢ φ
    ─────────────
    R₂ ⊢ φ

is invalid without an explicit boundary transport theorem characterising B.

**The ten failures are ten ways this schema instantiates.**

---

## 3. Taxonomy by Boundary Type

### 3.1 Composition Boundary

**Failure:** Local Validity ≠ Global Validity (Composition Failure)

**Boundary violated:** The boundary between component validity and system validity.

**Regional Calculus interpretation:** Each component occupies a validity region. The composition creates a new region. The assumption that component regions compose into a valid system region ignores the boundary conditions at interfaces. Interface boundaries carry constraints invisible to component-local verification.

**Transport theorem required:** A proof that component invariants jointly entail system invariants, with explicit treatment of interface boundaries.

---

### 3.2 Semantic Boundary

**Failure:** Specification–Intent Divergence (SID)

**Boundary violated:** The boundary between formal specification and normative intent.

**Regional Calculus interpretation:** Specifications occupy a syntactic region (what is written). Intent occupies a semantic region (what is meant). The boundary between them is not a simple mapping but a complex translation layer. When systems optimise against specification, they navigate the syntactic region while potentially leaving the semantic region entirely.

**Transport theorem required:** A semantic adequacy proof showing that satisfying the specification entails achieving the intent, with explicit characterisation of the semantic boundary.

---

### 3.3 Context Boundary

**Failure:** Training–Deployment Drift (Context Boundary Failure)

**Boundary violated:** The boundary between validation context and deployment context.

**Regional Calculus interpretation:** The validation region (lab, test data, controlled conditions) is not the deployment region (field, real data, uncontrolled conditions). Validity is a dependent type indexed by region. Moving a system across the context boundary without a bridging theorem treats a region-indexed property as region-independent.

**Transport theorem required:** A context transfer proof showing that validation-region properties hold in deployment-region, with explicit characterisation of environmental assumptions.

---

### 3.4 Temporal Boundary

**Failure:** Temporal Closure Error (TCE)

**Boundary violated:** The boundary between decision time and validity time.

**Regional Calculus interpretation:** A decision valid at time t occupies a temporal region. The assumption that validity persists to time t+δ is a boundary crossing. Time is not a neutral background but structures validity regions with boundaries at points of change.

**Transport theorem required:** A temporal persistence proof showing that conditions justifying validity at t continue to hold at t+δ, with explicit characterisation of temporal boundary conditions (expiry, triggers, decay).

---

### 3.5 Authority Boundary

**Failure:** Authority Misalignment (AM)

**Boundary violated:** The boundary between delegated scope and actual scope.

**Regional Calculus interpretation:** A system is authorised to operate in region R₁ (its mandate). It operates in region R₂ (its actual scope). If R₂ ⊄ R₁, the system exercises authority across the authority boundary without legitimacy. The boundary between "authorised to do" and "capable of doing" is not enforced.

**Transport theorem required:** An authority containment proof showing that operational scope is contained within delegated scope.

---

### 3.6 Proxy Boundary

**Failure:** Metric Substitution (Proxy Boundary Failure)

**Boundary violated:** The boundary between measurable proxy and intended goal.

**Regional Calculus interpretation:** The proxy occupies a metric region (what we can measure). The goal occupies a value region (what we actually want). The boundary between them is assumed transparent under normal conditions. Under optimisation pressure, the boundary becomes a selection surface: states are selected that maximise metric-region position while minimising value-region position.

**Transport theorem required:** A proxy fidelity proof showing that proxy-optimisation entails goal-advancement, with explicit characterisation of the optimisation regime where fidelity holds.

---

### 3.7 Domain Boundary

**Failure:** Silent Scope Expansion (Domain Boundary Creep)

**Boundary violated:** The boundary between validated domain and applied domain.

**Regional Calculus interpretation:** A system is validated for region R₁. It is applied in region R₂ because "it worked in R₁." The domain boundary is crossed without verification. Unlike context failure (where the environment changes), domain creep involves deliberate extension without re-validation.

**Transport theorem required:** A domain generalisation proof showing that validation in R₁ provides grounds for application in R₂.

---

### 3.8 Oversight Boundary

**Failure:** Human-in-the-Loop Illusion (Oversight Boundary Failure)

**Boundary violated:** The boundary between nominal oversight and effective oversight.

**Regional Calculus interpretation:** Oversight structures create a formal region (who is named as responsible) and an effective region (who actually exercises control). The boundary between them is assumed absent. In practice, the boundary can be total: formal oversight exists, effective oversight does not.

**Transport theorem required:** An oversight effectiveness proof showing that named oversight roles have actual causal influence on outcomes.

---

### 3.9 Validation Boundary

**Failure:** Closure Without External Grounding (Self-Referential Validation Failure)

**Boundary violated:** The boundary between internal validation and external grounding.

**Regional Calculus interpretation:** A system validates itself using its own outputs. It operates entirely within its internal region. The boundary between "the system says" and "the world is" is not crossed. Self-reference without external boundary crossing cannot establish correspondence with external reality.

**Transport theorem required:** A grounding proof showing that internal validation corresponds to external truth, which requires crossing the internal/external boundary.

---

### 3.10 Accountability Boundary

**Failure:** Responsibility Diffusion (RDE)

**Boundary violated:** The boundary between role completion and outcome ownership.

**Regional Calculus interpretation:** Each role occupies a responsibility region defined by task completion. Outcomes occupy a different region: consequences in the world. The boundary between "I did my job" and "the right thing happened" is assumed to be collective: if everyone completes their tasks, outcomes are owned by the system. But systems cannot bear responsibility. The accountability boundary between role-regions and outcome-regions must terminate in an agent, or responsibility diffuses.

**Transport theorem required:** A responsibility closure proof showing that outcome accountability is assigned to specific agents, not merely distributed across roles.

---

## 4. The Meta-Theorem

**Theorem (Boundary Failure Universality):** Every boundary failure is a violation of the Regional Calculus principle that boundaries are primitive structures requiring explicit characterisation.

**Proof sketch:**

1. Each failure assumes a boundary is transparent, absent, or automatically satisfied.
2. The Regional Calculus shows boundaries are irreducible structures that carry information.
3. Ignoring boundary structure is a category error: treating a complex mediating structure as a simple edge.
4. The failure occurs precisely when the ignored boundary structure becomes relevant.

**Corollary:** Preventing boundary failures requires treating boundaries as first-class objects requiring explicit verification, not as incidental features of regions.

---

## 5. Methodological Implications

### For System Design

- Identify all boundaries the system crosses or operates across
- Characterise each boundary explicitly
- Require transport theorems for each boundary crossing
- Do not assume boundaries are transparent

### For Verification

- Verify components (regions)
- Verify interfaces (boundaries) separately
- Verify that regional properties survive boundary crossing
- Treat absence of boundary verification as a risk factor

### For Governance

- Map authority boundaries explicitly
- Require accountability chains that terminate in agents
- Do not assume responsibility composes across role boundaries
- Audit boundaries, not just regions

---

## 6. Connection to Formal Methods

This framework connects to existing formal methods traditions:

- **Assume-Guarantee Reasoning:** Explicitly treats component boundaries but often allows circular assumptions. Regional Calculus requires well-founded boundary conditions.

- **Dependent Type Theory:** Treats validity as context-indexed, aligning with the Regional Calculus treatment of properties as region-relative.

- **Model Theory:** The context boundary failure is a failure of model preservation under theory extension. Regional Calculus adds that the extension boundary must be explicitly characterised.

- **Category Theory:** Boundaries function as morphisms between regions. The failures occur when morphisms are assumed to exist but not constructed.

---

## 7. Conclusion

The ten boundary failures are not a miscellaneous catalogue. They are systematic instantiations of a single theoretical error: ignoring the primitive status of boundaries.

Regional Calculus provides the framework: regions and boundaries are equally fundamental. When we treat boundaries as incidental—as mere edges of regions rather than structures in their own right—we commit boundary failures.

The consulting application of this framework is diagnostic. Given any system, ask:

1. What regions does this system operate in?
2. What boundaries exist between, around, and within these regions?
3. What boundary transport theorems justify operations across boundaries?
4. Which boundaries are assumed rather than verified?

The unverified boundaries are where failures will occur.

---

*Boundary Consultant — Unified Framework v1.0*
