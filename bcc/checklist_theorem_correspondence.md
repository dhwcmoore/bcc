# Theory-Practice Bridge: Checklist-Theorem Correspondence

## Complete Mapping from Audit Items to Transport Proof Components

---

## 1. The Central Claim

Each checklist item tests for the presence of a specific component of the transport theorem required to prevent that boundary failure. A "No" answer indicates a missing component. The determination rules identify combinations of missing components sufficient to conclude that no transport theorem exists.

This document provides the explicit mapping for all ten boundary failures.

---

## 2. Composition Failure (CF)

### Transport Theorem Required: CF_Transport

The transport theorem for composition requires:

1. **Interface Characterization**: For every pair of components, the boundary conditions at their interface are explicitly specified.

2. **Composition Proof**: A proof that component invariants jointly entail system invariants, given the interface characterization.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Global invariant documented | Target property P exists | P to be transported |
| A2. Local invariants specified | Source properties exist | Properties in component regions |
| A3. Composition rule exists | Composition proof structure | composition_proof skeleton |
| A4. Interfaces documented | Interface boundaries explicit | interface_characterization |
| B1. Global invariant testable | P is verifiable in system region | Witness for P in R₂ |
| B2. Local invariants testable | Source properties verifiable | Evidence in component regions |
| B3. Composition rule verified | Proof has been checked | composition_proof validity |
| B4. Interface effects mapped | Boundary conditions explicit | interface_characterization complete |
| C1. Interaction effects known | Cross-boundary effects characterized | Boundary non-triviality handled |
| C2. Emergent effects analyzed | System-level properties addressed | Domain extension in R₂ |
| C3. Failure modes at interfaces | Boundary failure cases covered | Negative case handling |
| C4. Integration tested | Transport verified empirically | Transport theorem validated |

### Determination Rule Derivation

**CF is present if:**
- A1 = No (no global invariant) AND A4 = No (interfaces undocumented), OR
- B3 = No (composition unverified) AND C1 = No (interactions unknown)

**Why this rule works:**
- Without A1, there is no property P to transport.
- Without A4, interface_characterization is empty, so composition_proof cannot be constructed.
- Without B3 and C1, even if a proof structure exists, it is unverified and boundary effects are unknown, meaning transport cannot be established.

---

## 3. Specification-Intent Divergence (SID)

### Transport Theorem Required: SID_Transport

1. **Adequacy Proof**: Every state satisfying the specification also satisfies the intent.

2. **Gap Characterization**: The semantic gap (spec ∧ ¬intent) is explicitly characterized and shown empty, or bounded.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Intent articulated | Target region defined | intent_region specification |
| A2. Intent stakeholder-validated | Intent region is authoritative | External grounding of intent |
| A3. Intent measurable | Intent properties observable | Witness constructibility |
| A4. Intent-spec gap analyzed | Gap characterized | gap_characterization |
| B1. Spec complete | Specification region covers intent | Domain containment |
| B2. Spec unambiguous | Specification well-defined | specification_region clarity |
| B3. Goodhart risk assessed | Optimization pressure analyzed | Fidelity threshold identified |
| B4. Spec-intent alignment tested | Adequacy empirically verified | adequacy_proof validation |
| C1. Adversarial testing | Boundary stress-tested | Transport under pressure |
| C2. Edge cases analyzed | Domain boundaries covered | Domain extension handling |
| C3. Spec revision mechanism | Gap can be closed | Remediation pathway |
| C4. Intent monitoring | Ongoing correspondence checked | Continuous transport validation |

### Determination Rule Derivation

**SID is present if:**
- A1 = No (intent not articulated), OR
- A4 = No AND B4 = No (gap unknown and alignment untested)

**Why this rule works:**
- Without A1, intent_region is undefined. No target for transport.
- Without A4 and B4, the gap is neither characterized nor empirically bounded. The adequacy_proof cannot be constructed or validated.

---

## 4. Context Boundary Failure (CBF)

### Transport Theorem Required: CBF_Transport

1. **Assumption Preservation**: Assumptions in validation region hold in deployment region.

2. **Domain Coverage**: Deployment domain is contained within validation domain.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Validation assumptions documented | Source assumptions explicit | assumptions(validation_region) |
| A2. Deployment context characterized | Target region defined | deployment_region specification |
| A3. Assumption comparison done | Assumption shift analyzed | assumption_shift computation |
| A4. Domain comparison done | Domain shift analyzed | domain_shift computation |
| B1. Assumption preservation verified | Δ_A empty or handled | assumption_preservation proof |
| B2. Domain coverage verified | Δ_D empty or handled | domain_coverage proof |
| B3. Environmental monitoring | Drift detected | Continuous validation |
| B4. Revalidation triggers | Transport re-established | Transport theorem refresh |
| C1. Failure mode analysis | Boundary failure cases | Negative case handling |
| C2. Degradation modes | Partial transport | Graceful degradation |
| C3. Context adaptation | Dynamic transport | Adaptive transport theorem |
| C4. Rollback capability | Transport failure recovery | Recovery mechanism |

### Determination Rule Derivation

**CBF is present if:**
- A1 = No (assumptions undocumented), OR
- A3 = No AND B1 = No (assumptions not compared or verified)

**Why this rule works:**
- Without A1, we don't know what assumptions(validation_region) contains. Transport cannot be assessed.
- Without A3 and B1, assumption_shift is unknown and assumption_preservation is unverified. Transport theorem incomplete.

---

## 5. Temporal Closure Error (TCE)

### Transport Theorem Required: TCE_Transport

1. **Persistence Proof**: Validity at t₁ persists to t₂ when no decay occurs.

2. **Expiry Conditions**: Explicit characterization of when validity ends.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Decision time recorded | Source temporal region | decision_time |
| A2. Validity period defined | Temporal boundary explicit | validity_time - decision_time |
| A3. Decay conditions specified | Temporal decay characterized | temporal_decay predicate |
| A4. Expiry defined | Transport end condition | expiry_conditions |
| B1. Time-boundedness acknowledged | Temporal boundary exists | Non-eternal validity |
| B2. Refresh mechanism exists | Transport can be re-established | Re-transport pathway |
| B3. Staleness detection | Decay detected | temporal_decay monitoring |
| B4. Time-based invalidation | Automatic expiry | Expiry enforcement |
| C1. Temporal dependencies mapped | Related temporal boundaries | Dependency analysis |
| C2. Clock synchronization | Time measurements consistent | Temporal region coherence |
| C3. Time zone handling | Temporal boundaries aligned | Cross-boundary time |
| C4. Historical validity | Past transport traceable | Audit trail |

### Determination Rule Derivation

**TCE is present if:**
- A2 = No (validity period undefined), OR
- A3 = No AND B3 = No (decay unspecified and undetected)

**Why this rule works:**
- Without A2, the temporal boundary is undefined. We don't know when transport ends.
- Without A3 and B3, temporal_decay is neither specified nor monitored. Validity may have expired without detection.

---

## 6. Authority Misalignment (AM)

### Transport Theorem Required: AM_Transport

1. **Containment Proof**: Every action in capability is also in mandate.

2. **Pre-Action Verification**: Check occurs before action.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Authority scope specified | Mandate region defined | mandate_region |
| A2. Authority from mandate | Mandate is legitimate source | Authority grounding |
| A3. Authority ≠ capability | Regions distinguished | capability_region ≠ mandate_region |
| A4. Authority documented | Mandate explicit | mandate_region specification |
| B1. Pre-decision authority check | Verification before action | pre_action_verification |
| B2. Authority encoded | Mandate in system | Enforcement mechanism |
| B3. Capability restricted | capability ⊆ mandate | containment_proof |
| B4. Unauthorized blocked | Violations prevented | containment_proof enforcement |
| C1. Escalation defined | Authority boundary crossing | Cross-boundary protocol |
| C2. Escalation mandatory | Required for boundary crossing | Mandatory transport |
| C3. Override authority clear | Exception handling | Override transport theorem |
| C4. Escalation endpoint | Terminal authority | Transport chain terminus |

### Determination Rule Derivation

**AM is structurally certain if:**
- A1 = No (mandate undefined), AND
- A3 = No (capability = authority assumed), AND
- B1 = No (no pre-action check), AND
- C2 = No (escalation optional)

**Why this rule works:**
- Without A1 and A3, mandate_region is not distinguished from capability_region. The boundary doesn't exist.
- Without B1, pre_action_verification is absent. Containment cannot be enforced.
- Without C2, boundary crossings are uncontrolled. Transport is assumed, not verified.

---

## 7. Proxy Boundary Failure (PBF)

### Transport Theorem Required: PBF_Transport

1. **Fidelity Proof**: Under bounded optimization pressure, proxy optimization entails goal advancement.

2. **Independent Goal Verification**: Goal is measured independently of proxy.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Proxy-goal relationship documented | Regions connected | proxy_region → goal_region mapping |
| A2. Validity conditions specified | Fidelity threshold defined | fidelity_threshold |
| A3. Correlation measured | Relationship quantified | fidelity_proof evidence |
| A4. Decorrelation conditions | When transport fails | Transport boundary |
| B1. Optimization pressure bounded | Pressure ≤ threshold | optimization_pressure constraint |
| B2. Pressure monitoring | Threshold approach detected | fidelity_threshold monitoring |
| B3. Goal independently measured | External goal verification | independent_goal_verification |
| B4. Proxy-goal comparison | Transport empirically checked | fidelity_proof validation |
| C1. Goodhart risk acknowledged | Boundary failure mode known | Transport failure awareness |
| C2. Alternative proxies | Backup transport theorems | Redundant transport |
| C3. Proxy rotation | Fresh transport theorems | Transport refresh |
| C4. Goal primacy | Goal region authoritative | Target region primacy |

### Determination Rule Derivation

**PBF is present if:**
- A1 = No (relationship undocumented), OR
- B3 = No AND B4 = No (goal not independently measured or compared)

**Why this rule works:**
- Without A1, the proxy-goal relationship is unspecified. No transport can be defined.
- Without B3 and B4, independent_goal_verification is absent and fidelity_proof is not validated. Transport is assumed, not established.

---

## 8. Silent Scope Expansion (SSE)

### Transport Theorem Required: SSE_Transport

1. **Generalization Proof**: Applied domain is contained within validated domain.

2. **Revalidation on Extension**: If domain expands, revalidation occurs.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Validated domain specified | Source region defined | validated_domain |
| A2. Domain boundaries explicit | Boundary characterized | Domain boundary |
| A3. Application domain tracked | Target region known | applied_domain |
| A4. Domain comparison | Containment tested | Domain shift analysis |
| B1. Scope constraints encoded | Domain limits enforced | generalization_proof enforcement |
| B2. Out-of-scope blocked | Violations prevented | Boundary enforcement |
| B3. Revalidation required | Extension triggers revalidation | revalidation_on_extension |
| B4. Scope expansion logged | Extensions tracked | Audit trail |
| C1. Domain drift monitoring | Gradual expansion detected | Domain shift monitoring |
| C2. Periodic domain review | Domain alignment checked | Continuous transport validation |
| C3. Scope reduction capability | Domain can be narrowed | Domain contraction |
| C4. Domain documentation | Boundaries maintained | generalization_proof maintenance |

### Determination Rule Derivation

**SSE is present if:**
- A1 = No (validated domain unspecified), OR
- A4 = No AND B3 = No (domains not compared and revalidation not required)

**Why this rule works:**
- Without A1, validated_domain is undefined. No source region for transport.
- Without A4 and B3, domain containment is unchecked and extension doesn't trigger revalidation. Transport is assumed for arbitrary domain expansion.

---

## 9. Human-in-the-Loop Illusion (HLI)

### Transport Theorem Required: HLI_Transport

1. **Information Access**: Overseer has information needed to make judgments.

2. **Authority to Intervene**: Overseer has authority to change outcomes.

3. **Time and Capacity**: Overseer has time and cognitive capacity to exercise oversight.

4. **Effectiveness Proof**: Given 1-3, oversight is effective.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Overseer designated | nominal_oversight_region populated | Nominal oversight |
| A2. Oversight scope defined | Oversight boundaries explicit | Oversight region |
| A3. Oversight purpose clear | What oversight achieves | Transport target |
| A4. Oversight documented | Oversight structure explicit | Region specification |
| B1. Information provided | Overseer informed | information_access |
| B2. Information timely | Information before decision | information_access timing |
| B3. Information comprehensible | Information usable | information_access quality |
| B4. Information sufficient | Information complete | information_access completeness |
| C1. Authority to intervene | Overseer can act | authority_to_intervene |
| C2. Intervention effective | Action changes outcome | authority_to_intervene effectiveness |
| C3. Intervention timely | Action before irreversibility | authority_to_intervene timing |
| C4. Authority documented | Intervention rights explicit | authority_to_intervene specification |
| D1. Time available | Overseer not rushed | time_and_capacity (time) |
| D2. Cognitive load manageable | Decisions within capacity | time_and_capacity (cognitive) |
| D3. Volume manageable | Decision count feasible | time_and_capacity (volume) |
| D4. Fatigue managed | Sustained oversight possible | time_and_capacity (endurance) |

### Determination Rule Derivation

**HLI is present if:**
- B section has ≥2 No (information inadequate), OR
- C section has ≥2 No (authority inadequate), OR
- D section has ≥2 No (time/capacity inadequate)

**Why this rule works:**
- The effectiveness_proof requires all three preconditions. If any is materially lacking (≥2 No in that section), the corresponding component of the transport theorem is missing. Nominal oversight cannot transport to effective oversight.

---

## 10. Self-Referential Validation (SRV)

### Transport Theorem Required: SRV_Transport

1. **External Reference**: A ground truth independent of system outputs.

2. **External Reference Independence**: The reference is genuinely external.

3. **Grounding Proof**: Internal validation corresponds to external truth.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. External reference exists | Ground truth available | external_reference |
| A2. Reference accessible | Ground truth usable | external_reference access |
| A3. Reference authoritative | Ground truth is correct | external_reference validity |
| A4. Reference independent | Ground truth uncontaminated | external_reference_independent |
| B1. Validation data independent | Data not from system | Data independence |
| B2. Validation criteria independent | Criteria not from system | Criteria independence |
| B3. Validation process independent | Process not in system | Process independence |
| B4. Validator independent | Validator not system creator | Validator independence |
| C1. Feedback loops mapped | Circularity identified | Circularity analysis |
| C2. Circularity tested | Loops verified absent/controlled | grounding_proof precondition |
| C3. Output-criterion separation | No self-evaluation | grounding_proof structure |
| C4. Contamination prevented | Independence maintained | external_reference_independent enforcement |
| D1. External comparison periodic | Transport regularly validated | grounding_proof refresh |
| D2. Drift metrics defined | Transport degradation measured | Transport monitoring |
| D3. Drift alerts triggered | Transport failure detected | Alert mechanism |
| D4. Consistency ≠ validity acknowledged | Internal ≠ external | Boundary awareness |

### Determination Rule Derivation

**SRV is structurally certain if:**
- A1 = No (no external reference), AND
- B2 = No (criteria from system), AND
- C3 = No (output-criterion not separated), AND
- D1 = No (no external comparison)

**Why this rule works:**
- Without A1, external_reference is empty. No target for grounding.
- Without B2 and C3, validation criteria are self-derived. The grounding_proof would be circular.
- Without D1, even if a grounding existed initially, it is never refreshed. Transport degrades undetected.

---

## 11. Responsibility Diffusion Error (RDE)

### Transport Theorem Required: RDE_Transport

1. **Accountability Chain**: Explicit chain of responsibility.

2. **Chain Terminates in Agent**: The chain ends in an entity that can bear responsibility.

3. **Handoff Explicit**: Responsibility transfers are explicit.

### Checklist-Theorem Mapping

| Checklist Item | Tests For | Transport Component |
|----------------|-----------|---------------------|
| A1. Outcome owner named | Terminal agent exists | chain_terminates_in_agent |
| A2. Owner accountable | Agent has enforceable obligations | Agent enforceability |
| A3. Owner authority sufficient | Agent can influence outcome | Agent capability |
| A4. Ownership documented | Accountability explicit | accountability_chain specification |
| B1. Handoffs explicit | Transfers documented | handoff_explicit |
| B2. Responsibility continuous | No gaps in chain | accountability_chain completeness |
| B3. Handoff acceptance | Receiver acknowledges | Handoff validity |
| B4. Transition documented | Transfers traceable | Audit trail |
| C1. System accountability rejected | System ≠ agent | Agent requirement |
| C2. Collective accountability rejected | "Team" ≠ agent | Individual termination |
| C3. Role ≠ outcome acknowledged | Task completion ≠ ownership | Boundary awareness |
| C4. Escalation to agent | Diffusion has remedy | Recovery mechanism |

### Determination Rule Derivation

**RDE is present if:**
- A1 = No (no owner named), OR
- A1 = Yes but C1 = No or C2 = No (owner is system or collective)

**Why this rule works:**
- Without A1, chain_terminates_in_agent has no terminal agent. No one owns outcomes.
- With A1 but without C1 or C2, the "owner" is a system or collective, which cannot bear responsibility. The agent requirement is violated.

---

## 12. Summary Table

| Failure | Transport Theorem | Critical Checklist Items | Missing → No Transport |
|---------|-------------------|-------------------------|------------------------|
| CF | CF_Transport | A1, A4, B3, C1 | No P or no interface characterization |
| SID | SID_Transport | A1, A4, B4 | No intent or no adequacy validation |
| CBF | CBF_Transport | A1, A3, B1 | No assumptions or no preservation |
| TCE | TCE_Transport | A2, A3, B3 | No validity period or no decay detection |
| AM | AM_Transport | A1, A3, B1, C2 | No mandate or no enforcement |
| PBF | PBF_Transport | A1, B3, B4 | No relationship or no independent verification |
| SSE | SSE_Transport | A1, A4, B3 | No domain or no revalidation |
| HLI | HLI_Transport | B-section, C-section, D-section | No information, authority, or capacity |
| SRV | SRV_Transport | A1, B2, C3, D1 | No reference or circular validation |
| RDE | RDE_Transport | A1, C1, C2 | No agent or non-agent terminus |

---

## 13. The Constructive Interpretation

When a checklist passes completely, it provides evidence that the transport theorem can be constructed:

1. **Each Yes answer** provides a component of the transport theorem.
2. **The combination of all Yes answers** provides sufficient components to assemble the theorem.
3. **The determination rule** identifies the minimal failing set that guarantees theorem non-existence.

This is why the checklists are not arbitrary diagnostic instruments. They are systematic probes for the existence of transport proofs. The theoretical framework is not decoration; it explains why these specific questions matter.

---

*Boundary Consultant — Theory-Practice Bridge v1.0*
