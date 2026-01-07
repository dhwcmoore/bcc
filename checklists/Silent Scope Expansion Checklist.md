# Silent Scope Expansion (SSE)

## Canonical Error Class

**Formal name:** Domain Boundary Creep

### Definition

Silent Scope Expansion occurs when a system validated for a specific domain is gradually or suddenly applied beyond that domain without re-validation, treating validated applicability as general applicability.

### Diagnostic hallmark

- System was validated for domain D₁
- System is applied in domain D₂ where D₂ ⊄ D₁
- No explicit validation for D₂ occurred
- Expansion appeared incremental or convenient
- No mechanism flagged the domain crossing

### Boundary status

- **Boundary type:** Domain boundary
- **Error class:** Applicability overextension
- **Risk level:** Medium to High
- **Detectability without domain audit:** Low

This differs from Context Boundary Failure (where the environment changes) in that Silent Scope Expansion involves deliberate extension without re-validation. The system is actively reused, not passively deployed.

---

## Domain Boundary Audit

### Audit-Grade Instrument (SSE-A01)

This instrument is designed for any system that might be reused: models, policies, tools, processes, regulations, software. It applies wherever validated applicability might be stretched beyond its bounds.

---

### Section A: Domain Definition (Baseline)

**A1. Validated Domain Specified**
Is the domain for which the system was validated explicitly documented?
☐ Yes ☐ No

**A2. Domain Boundaries Defined**
Are the boundaries of validated applicability explicitly stated?
☐ Yes ☐ No

**A3. Out-of-Scope Conditions Listed**
Are conditions or contexts where the system should not be applied explicitly listed?
☐ Yes ☐ No

**A4. Domain Assumptions Documented**
Are the assumptions that hold within the validated domain documented?
☐ Yes ☐ No

*(If A1 = No and A2 = No, SSE is structurally probable. The system has no defined scope to exceed.)*

---

### Section B: Reuse Controls

**B1. Reuse Approval Required**
Is explicit approval required before applying the system to a new domain?
☐ Yes ☐ No

**B2. Domain Registry Maintained**
Is there a registry of domains where the system is currently applied?
☐ Yes ☐ No

**B3. Reuse Validation Mandated**
Is re-validation required before reuse in new domains?
☐ Yes ☐ No

**B4. Domain Owner Identified**
Is there a designated owner responsible for each domain of application?
☐ Yes ☐ No

---

### Section C: Boundary Enforcement

**C1. Scope Gate Exists**
Is there a mechanism that prevents application outside validated domains?
☐ Yes ☐ No

**C2. Domain Check at Application**
When the system is applied, is the application domain verified against validated scope?
☐ Yes ☐ No

**C3. Edge Cases Flagged**
Are edge cases at domain boundaries flagged for review?
☐ Yes ☐ No

**C4. Creep Detection**
Is there monitoring for gradual domain expansion beyond validated scope?
☐ Yes ☐ No

---

### Section D: Expansion Justification

**D1. Expansion Documented**
When the system is applied to new domains, is this expansion documented?
☐ Yes ☐ No

**D2. Similarity Analysis**
Is there analysis of whether the new domain is sufficiently similar to validated domains?
☐ Yes ☐ No

**D3. Risk Assessment**
Is there risk assessment for application outside validated scope?
☐ Yes ☐ No

**D4. Rollback Capability**
Can domain expansions be rolled back if problems emerge?
☐ Yes ☐ No

---

### Section E: Determination

**SSE is present if:**

- Section A has two or more "No" (domain not defined), AND
- Section B has two or more "No" (reuse not controlled), AND
- Section C has two or more "No" (boundary not enforced)

**SSE is structurally certain if:**

- Validated domain not specified (A1 = No)
- No approval required for reuse (B1 = No)
- No scope gate exists (C1 = No)
- No creep detection (C4 = No)

This rule reflects the structural error: past success creates pressure for reuse, but success in D₁ provides no evidence for D₂ without explicit domain transfer analysis.

---

## One-Page Portfolio Memo

### Silent Scope Expansion
**Why Success Becomes Failure Through Reuse**

#### Problem

Systems that work are reused. The pressure to extend successful systems to new contexts is enormous. But validation is domain-specific. A system proven correct in domain D₁ has no automatic validity in domain D₂. When reuse proceeds without re-validation, past success becomes future failure.

This is not laziness. It is not corner-cutting (though it enables both). It is a boundary error: the boundary between validated and unvalidated domains was never enforced.

#### The Failure Pattern

Silent Scope Expansion occurs when:

- A system is validated for domain D₁
- The system succeeds in D₁
- Someone decides to apply it in D₂
- D₂ is assumed to be "close enough" to D₁
- No validation for D₂ occurs
- The system fails in D₂ in ways not possible in D₁

Typical post-failure explanations include:

- "It worked in the pilot"
- "We just extended it slightly"
- "The cases seemed similar"
- "No one said we couldn't use it there"

All true. The domain boundary was still crossed without validation.

#### The Core Insight

Validation is a domain-indexed property. "System S is valid" is incomplete. "System S is valid in domain D" is the correct formulation. Treating validation as a portable property—as if success transfers automatically—is a type error.

The convenience of reuse creates pressure to ignore domain boundaries. Each incremental extension seems small. The aggregate expansion can be enormous.

#### Detection

SSE is invisible to:

- Performance metrics (which may look fine in new domains, initially)
- Compliance audits (which verify original validation, not current application)
- Success stories (which document where things worked)
- Users (who may not know the validation scope)

It is visible only when current application domains are compared to validated domains.

#### Remediation

- Define validated domain explicitly
- Maintain a registry of application domains
- Require approval and re-validation for new domains
- Implement scope gates that prevent out-of-scope application
- Monitor for domain creep
- Perform similarity analysis before extension
- Document all domain expansions with justification

#### Canonical Example

A credit scoring model is validated on prime borrowers in stable economic conditions. The model works well. It is extended to subprime borrowers. It is extended again to new geographic regions. It is extended again to different product types. Each extension seems incremental. No re-validation occurs. The model is now operating far outside its validated domain. When conditions change, it fails catastrophically—in ways that could not have occurred in the original validated domain.

---

*Boundary Consultant — Silent Scope Expansion Checklist v1.0*
