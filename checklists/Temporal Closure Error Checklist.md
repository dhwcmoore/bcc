# Temporal Closure Error (TCE)

## Canonical Error Class

**Formal name:** Time Boundary Failure

### Definition

Temporal Closure Error occurs when a system treats a decision, classification, authorisation, or validation as final despite the conditions that justified it being time-dependent.

### Diagnostic hallmark

- Decision was correct when made
- Conditions have changed since issuance
- Decision continues to be applied
- No mechanism triggered re-evaluation
- Failure appears as gradual drift or sudden invalidity

### Boundary status

- **Boundary type:** Temporal boundary
- **Error class:** Validity persistence failure
- **Risk level:** Medium to High
- **Detectability without temporal audit:** Low

This is the formalisation of "it was right once" failures. Time is not a neutral background but structures validity with boundaries at points of change.

---

## Temporal Closure Audit

### Audit-Grade Instrument (TCE-A01)

This instrument is designed for any system where decisions, authorisations, classifications, or validations are made at one time and applied at another: credentials, risk assessments, compliance determinations, model validations, access controls.

---

### Section A: Temporal Assumptions (Baseline)

**A1. Validity Duration Specified**
Is the expected validity duration of decisions explicitly stated?
☐ Yes ☐ No

**A2. Underlying Conditions Identified**
Are the conditions that justify the decision explicitly documented?
☐ Yes ☐ No

**A3. Condition Stability Assessed**
Has the expected stability of these conditions been evaluated?
☐ Yes ☐ No

**A4. Time Treated as Variable**
Is time treated as a relevant variable in the decision framework, not an external constant?
☐ Yes ☐ No

*(If A1 = No and A2 = No, TCE is structurally probable. Decisions are treated as eternal by default.)*

---

### Section B: Expiry and Review Mechanisms

**B1. Explicit Expiry**
Do decisions have explicit expiry dates or review horizons?
☐ Yes ☐ No

**B2. Review Triggers Defined**
Are there defined events that trigger re-evaluation before expiry?
☐ Yes ☐ No

**B3. Decay Model**
Is there a model for how decision validity degrades over time?
☐ Yes ☐ No

**B4. Automatic Invalidation**
Do decisions automatically invalidate at expiry, requiring positive renewal?
☐ Yes ☐ No

---

### Section C: Condition Monitoring

**C1. Condition Change Detection**
Is there a mechanism to detect when underlying conditions change?
☐ Yes ☐ No

**C2. Monitoring Frequency**
Is monitoring frequency matched to expected condition volatility?
☐ Yes ☐ No

**C3. Change Notification**
Do condition changes trigger notifications to decision holders?
☐ Yes ☐ No

**C4. Retroactive Review**
When conditions change, are past decisions reviewed for continued validity?
☐ Yes ☐ No

---

### Section D: Decision Application

**D1. Application Time Checked**
When decisions are applied, is validity at application time verified?
☐ Yes ☐ No

**D2. Staleness Threshold**
Is there a maximum age beyond which decisions cannot be applied without refresh?
☐ Yes ☐ No

**D3. Context Match**
Is the application context compared to the decision context for continued relevance?
☐ Yes ☐ No

**D4. Burden of Currency**
Is the burden on the decision holder to prove continued validity, not on challengers to prove invalidity?
☐ Yes ☐ No

---

### Section E: Determination

**TCE is present if:**

- Section A has two or more "No" (temporal assumptions implicit), AND
- Section B has two or more "No" (no expiry mechanism), AND
- Section C has two or more "No" (conditions not monitored)

**TCE is structurally certain if:**

- Decisions have no expiry (B1 = No)
- Condition changes are not detected (C1 = No)
- Application does not check validity time (D1 = No)

This rule reflects the theorem: K_t(φ) does not imply K_{t+δ}(φ) when conditions are not stable.

---

## One-Page Portfolio Memo

### Temporal Closure Error
**Why Being Right Once Means Being Wrong Later**

#### Problem

Decisions are made at a point in time based on conditions at that time. But decisions persist. Conditions change. When decisions are applied after conditions have changed, they are applied on false premises—even though they were correct when issued.

This is not negligence. It is not oversight. It is a boundary error: time was not modelled as part of the validity structure.

#### The Failure Pattern

Temporal Closure Error occurs when:

- A decision D is made at time t based on conditions C_t
- D is treated as valid indefinitely
- At time t+δ, conditions have changed to C_{t+δ}
- D is applied as if C_t still held
- No mechanism detects or corrects the temporal mismatch

Typical post-failure explanations include:

- "The assessment was valid when we made it"
- "Nothing flagged it for review"
- "The certification was still current"
- "We had no indication things had changed"

All true. The decision was still wrong at the time of application.

#### The Core Insight

Decisions are not eternal facts. They are time-indexed claims: "At time t, given conditions C, conclusion D is warranted." The temporal boundary between decision time and application time is often ignored. Time is treated as an external concern rather than a structural variable.

The frame problem in AI formalises this: without explicit tracking of what changes, systems assume everything persists. This assumption is almost always false.

#### Detection

TCE is invisible to:

- Decision records (which show issuance, not current validity)
- Compliance checks (which verify decision existence, not currency)
- Audits (which examine decision quality at time of decision)
- Systems without temporal metadata

It is visible only when application time is compared to validity time with condition tracking.

#### Remediation

- Specify validity duration for all decisions
- Document underlying conditions explicitly
- Model condition stability and decay
- Implement automatic expiry requiring renewal
- Monitor conditions and trigger re-evaluation on change
- Check validity at application time, not just issuance time
- Place burden of currency on decision holder

#### Canonical Example

A credit check is performed on a loan applicant. The applicant is creditworthy at time of check. Three months later, the loan is issued based on this check. In the interim, the applicant has lost their job. The credit check was correct when performed. The loan was issued on a false premise. The temporal boundary between check and issuance was not enforced.

---

*Boundary Consultant — Temporal Closure Error Checklist v1.0*
