# Authority Misalignment (AM)

## Canonical Error Class

**Formal name:** Governance Boundary Failure

### Definition

Authority Misalignment occurs when a system makes or enacts decisions that exceed, bypass, or confuse the scope of authority originally granted to it, such that capability is exercised without legitimate mandate.

### Diagnostic hallmark

- System acted within technical capability
- No explicit authority constraint was violated
- Decision was made that should not have been made by this system
- Authority was inferred from access or capability
- Escalation was optional or absent

### Boundary status

- **Boundary type:** Authority boundary
- **Error class:** Capability-mandate confusion
- **Risk level:** High
- **Detectability without governance audit:** Low

This is the formalisation of "no one was supposed to decide that" failures. The system could act, so it did. Authority was assumed to follow capability.

---

## Authority Boundary Audit

### Audit-Grade Instrument (AM-A01)

This instrument is designed for any system where decisions are made: automated systems, delegated roles, algorithmic processes, distributed organisations. It applies wherever capability and authority might diverge.

---

### Section A: Authority Definition (Baseline)

**A1. Authority Scope Specified**
Is the scope of authority for each decision-making component explicitly defined?
☐ Yes ☐ No

**A2. Authority Derived from Mandate**
Is authority explicitly derived from a source of legitimate mandate (governance, delegation, law)?
☐ Yes ☐ No

**A3. Authority Separable from Capability**
Is authority defined independently of capability (what is permitted vs. what is possible)?
☐ Yes ☐ No

**A4. Authority Documented**
Is there a registry of what each component is authorised to do?
☐ Yes ☐ No

*(If A1 = No and A3 = No, AM is structurally probable. Authority defaults to capability.)*

---

### Section B: Authority Enforcement

**B1. Pre-Decision Authority Check**
Before decisions are made, is authority verified?
☐ Yes ☐ No

**B2. Authority Constraint Encoded**
Are authority constraints encoded in the system, not merely documented?
☐ Yes ☐ No

**B3. Capability Restricted to Authority**
Are capabilities restricted to match authority (cannot do what is not authorised)?
☐ Yes ☐ No

**B4. Unauthorised Action Blocked**
Are actions outside authority scope blocked, not just logged?
☐ Yes ☐ No

---

### Section C: Escalation and Override

**C1. Escalation Path Defined**
Is there a defined escalation path for decisions exceeding component authority?
☐ Yes ☐ No

**C2. Escalation Mandatory**
Is escalation mandatory for out-of-scope decisions, not optional?
☐ Yes ☐ No

**C3. Override Authority Clear**
Is the authority to override decisions clearly assigned?
☐ Yes ☐ No

**C4. Escalation Endpoint Exists**
Is there a terminal authority that cannot defer or diffuse?
☐ Yes ☐ No

---

### Section D: Authority Creep Detection

**D1. Authority Expansion Monitored**
Is there monitoring for gradual expansion of exercised authority beyond mandate?
☐ Yes ☐ No

**D2. De Facto Authority Tracked**
Is de facto authority (what is actually decided) compared to de jure authority (what is mandated)?
☐ Yes ☐ No

**D3. Precedent Accumulation**
Is there a mechanism to prevent past actions from becoming authority precedents?
☐ Yes ☐ No

**D4. Authority Audit Periodic**
Is authority alignment audited periodically?
☐ Yes ☐ No

---

### Section E: Determination

**AM is present if:**

- Section A has two or more "No" (authority not defined), AND
- Section B has two or more "No" (authority not enforced), OR
- Section C has two or more "No" (escalation absent or optional)

**AM is structurally certain if:**

- Authority scope not specified (A1 = No)
- Authority conflated with capability (A3 = No)
- No pre-decision authority check (B1 = No)
- Escalation optional or absent (C2 = No)

This rule reflects the structural error: capability is observable, authority is normative. Without explicit normative constraint, systems default to capability.

---

## One-Page Portfolio Memo

### Authority Misalignment
**Why Capability Is Not Permission**

#### Problem

Systems can do things. The question of whether they should is different. When authority is not explicitly defined and enforced, it defaults to capability: if the system can decide, it will decide. This creates decisions that are technically executed but normatively illegitimate.

This is not malice. It is not a bug. It is a boundary error: the boundary between what is possible and what is permitted was never drawn.

#### The Failure Pattern

Authority Misalignment occurs when:

- A system has capability C (what it can do)
- A system has authority A (what it should do), where A ⊂ C
- The boundary between A and C is not enforced
- The system exercises C, assuming C = A
- Decisions are made that exceed legitimate mandate

Typical post-failure explanations include:

- "The system was just doing its job"
- "No one told it not to"
- "It had access, so it acted"
- "There was no explicit prohibition"

All true. The decision was still illegitimate.

#### The Core Insight

Authority is a normative concept. Capability is a descriptive concept. Systems do not inherently distinguish them. Without explicit authority modelling, systems treat "can do" as "may do."

This is especially dangerous in automated systems, where capability can far exceed any reasonable mandate, and in distributed systems, where authority is fragmented and no single component knows the overall scope.

#### Detection

AM is invisible to:

- Technical audits (which verify capability, not authority)
- Access logs (which show what happened, not what should have)
- Performance metrics (which measure outputs, not legitimacy)
- Compliance checks (which verify documented authority, not actual exercise)

It is visible only when exercised authority is compared to mandated authority.

#### Remediation

- Define authority scope explicitly for each component
- Derive authority from legitimate mandate, not capability
- Encode authority constraints in the system
- Require pre-decision authority verification
- Make escalation mandatory for out-of-scope decisions
- Monitor for authority creep
- Audit exercised authority against mandated authority

#### Canonical Example

An automated trading system is designed to execute trades within defined parameters. The system has access to execute any trade. Parameters are treated as guidelines, not constraints. The system executes a trade that exceeds risk limits because no hard constraint prevented it. The system could do it. No one had decided it should. Authority was never separated from capability.

---

*Boundary Consultant — Authority Misalignment Checklist v1.0*
