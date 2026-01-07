# Specification–Intent Divergence (SID)

## Canonical Error Class

**Formal name:** Semantic Boundary Failure

### Definition

Specification–Intent Divergence occurs when a system satisfies the formal specification of a rule, policy, or requirement while violating the underlying purpose or intent for which the rule exists.

### Diagnostic hallmark

- All specifications are met
- All tests pass
- All audits confirm compliance
- The underlying purpose is defeated
- No formal violation can be identified

### Boundary status

- **Boundary type:** Semantic boundary
- **Error class:** Syntax-semantics mismatch
- **Risk level:** High
- **Detectability without intent audit:** Very low

This is the formalisation of "letter versus spirit" failures. The system optimises the letter while violating the spirit.

---

## Specification–Intent Audit

### Audit-Grade Instrument (SID-A01)

This instrument is designed for regulatory compliance, policy implementation, contractual performance, and any system where formal rules are meant to achieve normative purposes.

---

### Section A: Intent Documentation (Baseline)

**A1. Purpose Statement Exists**
Is there explicit documentation of the purpose or intent behind each specification?
☐ Yes ☐ No

**A2. Intent Separable from Specification**
Is intent documented separately from the formal specification, not merely embedded in preambles?
☐ Yes ☐ No

**A3. Intent Testable**
Can violation of intent be detected independently of specification compliance?
☐ Yes ☐ No

**A4. Intent Ownership**
Is there a designated role responsible for judging whether intent is satisfied?
☐ Yes ☐ No

*(If A1 = No, SID is structurally probable. Intent exists only in the minds of drafters, unreachable by implementers.)*

---

### Section B: Specification Completeness

**B1. Specification Derived from Intent**
Was the specification explicitly derived from intent through a documented process?
☐ Yes ☐ No

**B2. Gap Analysis Performed**
Has the gap between what the specification covers and what the intent requires been analysed?
☐ Yes ☐ No

**B3. Edge Cases Mapped**
Have edge cases where specification compliance might defeat intent been identified?
☐ Yes ☐ No

**B4. Adversarial Review**
Has the specification been reviewed for ways it could be satisfied while defeating intent?
☐ Yes ☐ No

---

### Section C: Compliance Incentives

**C1. Incentive Structure**
Are rewards or penalties attached to specification compliance?
☐ Yes ☐ No
*(A "Yes" with weak intent enforcement indicates SID risk.)*

**C2. Gaming Pathways**
Can specifications be satisfied through means that defeat intent?
☐ Yes ☐ No ☐ Unknown
*(A "Yes" or "Unknown" indicates SID risk.)*

**C3. Compliance Sophistication**
Are agents actively seeking efficient paths to compliance?
☐ Yes ☐ No
*(A "Yes" with B4 = No indicates SID risk.)*

**C4. Intent Monitoring**
Is intent satisfaction monitored independently of specification compliance?
☐ Yes ☐ No

---

### Section D: Remediation Mechanisms

**D1. Intent Override**
Can intent considerations override specification compliance in edge cases?
☐ Yes ☐ No

**D2. Specification Amendment**
Is there a process for amending specifications when they diverge from intent?
☐ Yes ☐ No

**D3. Counterfactual Testing**
Is there a check asking "would this outcome defeat the purpose even if compliant?"
☐ Yes ☐ No

**D4. Bad Faith Detection**
Is there a mechanism to detect compliance that is technically correct but purposefully evasive?
☐ Yes ☐ No

---

### Section E: Determination

**SID is present if:**

- Section A has two or more "No" (intent not operationalised), AND
- Section B has two or more "No" (specification-intent gap unexamined), AND
- Section C indicates gaming pathways exist with incentives for compliance

**SID is structurally certain if:**

- Intent is undocumented (A1 = No)
- Specifications have not been adversarially reviewed (B4 = No)
- Strong incentives exist for compliance (C1 = Yes)
- No counterfactual testing exists (D3 = No)

This rule reflects the theorem: optimisation against a finite specification will find states in Spec \ Intent.

---

## One-Page Portfolio Memo

### Specification–Intent Divergence
**Why Perfect Compliance Produces Perfect Failure**

#### Problem

Rules are written to achieve purposes. But rules are finite approximations. Purposes are often infinite in scope, contextual, and resist formalisation. When systems optimise for rule compliance, they navigate the space of rule-satisfying states—which includes states that defeat the purpose entirely.

This is not cheating. This is not bad faith (though bad faith exploits it). This is a boundary error.

#### The Failure Pattern

Specification–Intent Divergence occurs when:

- A purpose P is formalised as specification S
- S ⊂ P (the specification is a subset of all purpose-satisfying states)
- Agents optimise for S
- Agents find states in S \ P (specification-satisfying but purpose-violating)
- No mechanism detects or corrects this

Typical post-failure explanations include:

- "We followed all the rules"
- "The audit found no violations"
- "We met every requirement"
- "The contract was fulfilled"

All true. The purpose was still defeated.

#### The Core Insight

The specification occupies a syntactic region: what is written. The intent occupies a semantic region: what is meant. The boundary between them is assumed transparent—that satisfying the letter achieves the spirit. This is almost never true under optimisation pressure.

The letter killeth because optimisers find the gaps between letter and spirit.

#### Detection

SID is invisible to:

- Compliance audits (which check specifications)
- Test suites (which encode specifications)
- Performance reviews (which measure specification metrics)
- Legal review (which verifies specification adherence)

It is visible only when intent is operationalised as a separate check.

#### Remediation

- Document intent separately from specification
- Perform adversarial specification review
- Institute counterfactual testing: "Is the purpose achieved?"
- Allow intent to override specification in edge cases
- Monitor for gaming pathways
- Amend specifications when divergence is detected

#### Canonical Example

A regulation requires banks to "assess customer creditworthiness before lending." Banks develop automated scoring systems that technically assess creditworthiness but optimise for loan volume. Assessments occur. Creditworthiness is not meaningfully evaluated. The specification is satisfied. The intent—preventing loans to those who cannot repay—is defeated. Defaults rise. The rule was followed. The purpose was destroyed.

---

*Boundary Consultant — Specification–Intent Divergence Checklist v1.0*
