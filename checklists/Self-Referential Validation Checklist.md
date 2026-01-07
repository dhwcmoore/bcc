# Self-Referential Validation (SRV)

## Canonical Error Class

**Formal name:** Closure Boundary Failure

### Definition

Self-Referential Validation occurs when a system validates its own outputs using criteria derived from those same outputs, or when internal consistency is treated as evidence of external validity, creating circular correctness without external grounding.

### Diagnostic hallmark

- Validation pipeline functions correctly
- Internal consistency is high
- Metrics are self-referential
- No independent reference signal exists
- Drift from external reality is undetectable internally

### Boundary status

- **Boundary type:** Closure boundary
- **Error class:** Grounding failure
- **Risk level:** High
- **Detectability without external audit:** Near zero

This is the formalisation of "the model says the model is correct" failures. The system validates itself. Circularity creates the appearance of correctness without correspondence to reality.

---

## Closure Boundary Audit

### Audit-Grade Instrument (SRV-A01)

This instrument is designed for any system that validates its own outputs: machine learning models, forecasting systems, self-monitoring processes, quality assurance loops, any system that might evaluate itself by its own standards.

---

### Section A: External Grounding (Baseline)

**A1. External Reference Exists**
Is there an external reference signal (ground truth) independent of system outputs?
☐ Yes ☐ No

**A2. Reference Accessible**
Can the external reference be accessed and compared to system outputs?
☐ Yes ☐ No

**A3. Reference Authoritative**
Is the external reference accepted as authoritative for correctness?
☐ Yes ☐ No

**A4. Reference Independent**
Is the external reference genuinely independent (not derived from or influenced by system outputs)?
☐ Yes ☐ No

*(If A1 = No, SRV is structurally certain. The system has no external anchor.)*

---

### Section B: Validation Independence

**B1. Validation Data Independent**
Is validation data independent of training or operational data?
☐ Yes ☐ No

**B2. Validation Criteria Independent**
Are validation criteria defined independently of system behaviour?
☐ Yes ☐ No

**B3. Validation Process Independent**
Is the validation process separate from the system being validated?
☐ Yes ☐ No

**B4. Validator Independent**
Is the entity performing validation independent of the entity that built or operates the system?
☐ Yes ☐ No

---

### Section C: Circularity Detection

**C1. Feedback Loop Mapped**
Has the relationship between outputs and validation inputs been mapped?
☐ Yes ☐ No

**C2. Circularity Tested**
Has the system been tested for circular dependencies in validation?
☐ Yes ☐ No

**C3. Output-Criterion Separation**
Is there explicit separation between what the system produces and what it is evaluated against?
☐ Yes ☐ No

**C4. Contamination Prevented**
Are there controls to prevent system outputs from contaminating validation data?
☐ Yes ☐ No

---

### Section D: Drift Detection

**D1. External Comparison Periodic**
Are system outputs periodically compared to external ground truth?
☐ Yes ☐ No

**D2. Drift Metrics Defined**
Are there defined metrics for detecting drift from external reality?
☐ Yes ☐ No

**D3. Drift Alerts Triggered**
Are alerts triggered when drift exceeds thresholds?
☐ Yes ☐ No

**D4. Consistency ≠ Validity**
Is there explicit acknowledgment that internal consistency does not imply external validity?
☐ Yes ☐ No

---

### Section E: Determination

**SRV is present if:**

- Section A has two or more "No" (no external grounding), AND
- Section B has two or more "No" (validation not independent), OR
- Section C has two or more "No" (circularity not checked)

**SRV is structurally certain if:**

- No external reference exists (A1 = No)
- Validation criteria derived from system behaviour (B2 = No)
- Output-criterion separation absent (C3 = No)
- No periodic external comparison (D1 = No)

This rule reflects the logical principle: no system can validate itself without circularity. External grounding is required for validity claims.

---

## One-Page Portfolio Memo

### Self-Referential Validation
**Why Internal Consistency Proves Nothing**

#### Problem

Systems often validate themselves. A model predicts; its predictions are evaluated by metrics derived from its training process. A process audits itself against standards it helped define. A forecast is validated against data it influenced. In each case, the system is consistent with itself—but consistency is not validity.

This is not fraud (usually). It is not negligence. It is a boundary error: the boundary between the system's internal world and external reality was never crossed during validation.

#### The Failure Pattern

Self-Referential Validation occurs when:

- A system produces outputs O
- Validation criteria V are derived from or influenced by O
- Validation data D are contaminated by or correlated with O
- The system is evaluated as O consistent with V on D
- Consistency is achieved
- Correspondence with external reality is not tested
- The system drifts from reality while remaining internally consistent

Typical post-failure explanations include:

- "All our metrics looked good"
- "The validation passed"
- "The system was self-consistent"
- "Our quality checks found no problems"

All true. External reality was never checked.

#### The Core Insight

Validity is a relation between a system and external reality. Internal consistency is a relation within the system. These are categorically different. A perfectly consistent system can be perfectly wrong.

The closure boundary separates what the system says from what the world is. Self-referential validation never crosses this boundary. It operates entirely within the system's internal model.

#### Detection

SRV is invisible to:

- Internal metrics (which measure internal consistency)
- Self-audits (which check system against system)
- Automated monitoring (which uses system-derived criteria)
- Consistency checks (which verify internal coherence)

It is visible only when system outputs are compared to genuinely independent external reference points.

#### Remediation

- Establish external reference signals independent of the system
- Ensure validation data is uncontaminated by system outputs
- Define validation criteria independently of system behaviour
- Separate validation process from the system being validated
- Map feedback loops to detect circularity
- Compare outputs to external ground truth periodically
- Acknowledge explicitly that consistency is not validity

#### Canonical Example

A large language model is evaluated for factual accuracy. The evaluation uses questions and answers derived from the model's training data. The model performs well on this evaluation because it has seen similar patterns. The evaluation is circular: the model is judged by standards derived from what the model learned. Deployed in the real world, the model confidently produces false statements that would have been caught by genuinely external validation.

---

*Boundary Consultant — Self-Referential Validation Checklist v1.0*
