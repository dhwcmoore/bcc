# Proxy Boundary Failure (PBF)

## Canonical Error Class

**Formal name:** Proxy Divergence / Metric Substitution Error

### Definition

Proxy Boundary Failure occurs when an optimisable metric is substituted for a goal it was intended to represent, and optimisation pressure drives the system to maximise the proxy while diverging from or actively undermining the underlying goal.

### Diagnostic hallmark

- Proxy metrics improve consistently
- Underlying outcomes stagnate or degrade
- No direct measurement of the goal exists
- Optimisation pressure is high
- The proxy was "valid" under normal conditions

### Boundary status

- **Boundary type:** Proxy boundary
- **Error class:** Measure-goal divergence
- **Risk level:** High to Extreme
- **Detectability without outcome audit:** Very low

This is the formal instantiation of Goodhart's Law: "When a measure becomes a target, it ceases to be a good measure."

---

## Proxy Boundary Audit

### Audit-Grade Instrument (PBF-A01)

This instrument is designed for any system where measurable proxies stand in for goals that are difficult or impossible to measure directly: performance management, machine learning, policy compliance, educational assessment, financial targets.

---

### Section A: Proxy-Goal Relationship (Baseline)

**A1. Goal Explicitly Defined**
Is the underlying goal (the thing you actually want) explicitly stated in non-metric terms?
☐ Yes ☐ No

**A2. Proxy Derivation Documented**
Is there explicit documentation of why this proxy was chosen to represent the goal?
☐ Yes ☐ No

**A3. Validity Conditions Stated**
Are the conditions under which the proxy tracks the goal explicitly specified?
☐ Yes ☐ No

**A4. Divergence Acknowledged**
Is it acknowledged that proxy and goal can diverge?
☐ Yes ☐ No

*(If A1 = No, proxy failure is structurally certain. The system optimises a number disconnected from any articulable purpose.)*

---

### Section B: Optimisation Pressure

**B1. Incentive Magnitude**
Are significant rewards or penalties attached to proxy performance?
☐ Yes ☐ No
*(A "Yes" indicates PBF risk.)*

**B2. Optimisation Sophistication**
Are agents (human or algorithmic) actively searching for ways to improve proxy scores?
☐ Yes ☐ No
*(A "Yes" indicates PBF risk.)*

**B3. Gaming Pathways**
Can the proxy be improved without improving the underlying goal?
☐ Yes ☐ No ☐ Unknown
*(A "Yes" or "Unknown" indicates PBF risk.)*

**B4. Iteration Frequency**
Is proxy performance measured and responded to frequently?
☐ Yes ☐ No
*(Higher frequency = higher PBF risk.)*

---

### Section C: Goal Measurement

**C1. Direct Goal Measurement**
Is the underlying goal ever measured directly, independent of the proxy?
☐ Yes ☐ No

**C2. Goal Measurement Frequency**
If yes, is goal measurement frequent enough to detect divergence?
☐ Yes ☐ No ☐ N/A

**C3. Divergence Detection**
Is there a mechanism to detect when proxy and goal diverge?
☐ Yes ☐ No

**C4. Divergence Response**
Is there a defined response when divergence is detected?
☐ Yes ☐ No

---

### Section D: Proxy Robustness

**D1. Adversarial Testing**
Has the proxy been tested against deliberate gaming attempts?
☐ Yes ☐ No

**D2. Edge Case Behaviour**
Is proxy behaviour at extreme values understood?
☐ Yes ☐ No

**D3. Multi-Proxy Triangulation**
Are multiple independent proxies used to cross-validate?
☐ Yes ☐ No

**D4. Proxy Rotation**
Is there a mechanism to change or update proxies over time?
☐ Yes ☐ No

---

### Section E: Determination

**Proxy Boundary Failure is probable if:**

- Section A has any "No" (proxy-goal relationship unclear), AND
- Section B has two or more risk indicators (high optimisation pressure), AND
- Section C has two or more "No" (goal not independently measured)

**Proxy Boundary Failure is structurally certain if:**

- Goal is never measured directly (C1 = No), AND
- Optimisation pressure is high (B1 or B2 = Yes), AND
- Gaming pathways exist or are unknown (B3 = Yes or Unknown)

This rule reflects the theorem: under high optimisation pressure, maximising proxy P is statistically guaranteed to diverge from utility U when P ≠ U.

---

## One-Page Portfolio Memo

### Proxy Boundary Failure
**Why Hitting Targets Misses Goals**

#### Problem

Most important outcomes cannot be measured directly. So we measure proxies: test scores for learning, citations for research quality, KPIs for performance, metrics for success.

This works until it doesn't. When optimisation pressure rises, agents find ways to improve the proxy that don't improve—or actively harm—the underlying goal. The better the optimisation, the worse the divergence.

This is not cheating. This is not bad faith. This is a boundary error.

#### The Failure Pattern

Proxy Boundary Failure occurs when:

- A measurable proxy P is established for an unmeasurable goal U
- The proxy is valid under normal conditions: |P(s) - U(s)| < ε for typical states s
- Optimisation pressure drives the system toward states that maximise P
- At high P values, the proxy diverges from the goal: E[U(s) | P(s) = k] << k for large k

Typical post-failure explanations include:

- "We hit all our targets"
- "The metrics looked great"
- "Everyone was performing well"
- "The model achieved state-of-the-art"

All true. The outcome can still be failure.

#### The Core Insight

The proxy can be decomposed as P(s) = U(s) + N(s), where N captures noise, gaming, and shortcut exploitation. Under low optimisation pressure, N is small and mean-zero. Under high optimisation pressure, the system selects for states where N is large—because N is easier to optimise than U.

The boundary error is treating P as if it were U. The map is not the territory; the score is not the outcome.

#### Detection

Proxy Boundary Failure is invisible to:

- Dashboards (which display proxies)
- Performance reviews (which evaluate proxies)
- Optimisers (which maximise proxies)
- Audits (which verify proxy compliance)

It is visible only when the underlying goal is measured independently of the proxy.

#### Remediation

- Articulate goals in non-metric terms
- Measure goals directly, even if infrequently
- Monitor proxy-goal correlation over time
- Reduce optimisation pressure where possible
- Use multiple uncorrelated proxies
- Rotate metrics to prevent gaming lock-in
- Accept that some goals cannot be safely proxied

#### Canonical Example

A hospital optimises for "patient satisfaction scores" as a proxy for "quality of care." Satisfaction scores rise. Prescription of patient-requested opioids rises. Overdose deaths rise. The metric improved. The goal was destroyed. The boundary between "what we measure" and "what we want" was never enforced.

---

*Boundary Consultant — Proxy Boundary Failure Checklist v1.0*
