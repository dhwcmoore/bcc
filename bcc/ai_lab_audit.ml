(* ========================================================================= *)
(* AI LAB BOUNDARY AUDIT - Reflexive Application                             *)
(* ========================================================================= *)
(* Applying the Boundary Consultant framework to audit AI development        *)
(* practices at Anthropic and OpenAI. This demonstrates that the framework   *)
(* survives reflexive application.                                           *)
(* ========================================================================= *)

open Boundary_transport_build

(* ========================================================================= *)
(* PART 1: ANTHROPIC BOUNDARY FAILURES                                       *)
(* ========================================================================= *)

(* ------------------------------------------------------------------------- *)
(* ANTHROPIC #9: Self-Referential Validation (SRV)                           *)
(* "The model says the model is correct."                                    *)
(* ------------------------------------------------------------------------- *)

let audit_anthropic_srv () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  ANTHROPIC AUDIT #9: Self-Referential Validation                     ║";
  print_endline "║  'The model says the model is correct.'                              ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  (* Define the regions *)
  let internal_validation_region = {
    id = "Constitutional_AI_Internal";
    domain = StringSet.of_list [
      "claude_evaluates_output";
      "rlhf_model_preferences";
      "self_red_teaming";
      "internal_consistency_checks"
    ];
    assumptions = StringSet.of_list [
      "model_can_evaluate_itself";
      "constitution_is_complete";
      "preferences_reflect_values"
    ];
    properties = StringSet.of_list [
      "outputs_are_safe";
      "alignment_verified"
    ];
  } in

  let external_grounding_region = {
    id = "Real_World_Alignment";
    domain = StringSet.of_list [
      "actual_user_outcomes";
      "long_term_consequences";
      "edge_case_behavior";
      "adversarial_contexts";
      "deployment_reality"
    ];
    assumptions = StringSet.of_list [
      "independent_verification";
      "external_ground_truth";
      "diverse_evaluators"
    ];
    properties = StringSet.of_list [
      "actually_beneficial";
      "truly_aligned"
    ];
  } in

  let boundary = compute_boundary internal_validation_region external_grounding_region in
  let analysis = analyze_nontriviality boundary in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  Printf.printf "  Source: %s\n" internal_validation_region.id;
  Printf.printf "  Target: %s\n" external_grounding_region.id;
  Printf.printf "  Domain shift: %s\n" (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Assumption shift: %s\n" (String.concat ", " analysis.assumption_shift_elements);
  Printf.printf "  Risk: %s\n\n" analysis.risk_assessment;

  (* SRV Checklist *)
  let srv_checklist = {
    boundary_type = Closure;
    sections = [
      { section_id = "A"; section_name = "External Grounding";
        items = [
          { id = "A1"; question = "External reference exists independent of model?";
            answer = Some false;  (* Constitutional AI uses Claude to evaluate Claude *)
            maps_to = "external_reference" };
          { id = "A2"; question = "Reference accessible for comparison?";
            answer = Some true;   (* Human feedback exists *)
            maps_to = "external_reference access" };
          { id = "A3"; question = "Reference authoritative for correctness?";
            answer = Some false;  (* No ground truth for 'alignment' *)
            maps_to = "external_reference validity" };
          { id = "A4"; question = "Reference genuinely independent?";
            answer = Some false;  (* RLHF preferences shaped by model behavior *)
            maps_to = "external_reference_independent" };
        ] };
      { section_id = "B"; section_name = "Validation Independence";
        items = [
          { id = "B1"; question = "Validation data independent of system?";
            answer = Some false;  (* Training data shapes what model considers good *)
            maps_to = "Data independence" };
          { id = "B2"; question = "Validation criteria independent of system?";
            answer = Some false;  (* Constitution written to match model capabilities *)
            maps_to = "Criteria independence" };
          { id = "B3"; question = "Validation process separate from system?";
            answer = Some false;  (* Claude evaluates Claude's outputs *)
            maps_to = "Process independence" };
          { id = "B4"; question = "Validator independent of builder?";
            answer = Some false;  (* Anthropic evaluates Anthropic's model *)
            maps_to = "Validator independence" };
        ] };
      { section_id = "C"; section_name = "Circularity Detection";
        items = [
          { id = "C1"; question = "Feedback loops mapped?";
            answer = Some true;   (* They know CAI is self-referential *)
            maps_to = "Circularity analysis" };
          { id = "C2"; question = "Circularity tested for?";
            answer = Some false;  (* No systematic circularity testing *)
            maps_to = "grounding_proof precondition" };
          { id = "C3"; question = "Output-criterion separation?";
            answer = Some false;  (* Model outputs influence future training *)
            maps_to = "grounding_proof structure" };
          { id = "C4"; question = "Contamination prevented?";
            answer = Some false;  (* Model behavior shapes preference data *)
            maps_to = "external_reference_independent enforcement" };
        ] };
    ];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with Some { answer = Some false; _ } -> true | _ -> false in
      (* SRV certain if: A1=No AND B2=No AND C3=No *)
      is_no "A1" && is_no "B2" && is_no "C3"
  } in

  let typed_boundary = classify_boundary boundary Closure in
  let result = verify_transport typed_boundary srv_checklist in
  
  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) srv_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid missing ->
      print_endline "DETERMINATION: *** SRV BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nMissing transport theorem components:";
      List.iter (fun m -> Printf.printf "  • %s\n" m) missing;
      print_endline "\nTHE TRANSPORT THEOREM CANNOT BE CONSTRUCTED.";
      print_endline "Internal validation does not transport to external validity."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: Constitutional AI's self-evaluation creates a closure boundary";
  print_endline "that is never crossed. The grounding proof required by SRV_Transport";
  print_endline "cannot be constructed because:";
  print_endline "  1. External reference (A1) does not exist independently";
  print_endline "  2. Validation criteria (B2) are derived from system behavior";
  print_endline "  3. Output-criterion separation (C3) is absent";
  print_endline "";
  print_endline "The claim 'Claude is aligned' is internally consistent but externally";
  print_endline "ungrounded. This is the definitional signature of SRV."

(* ------------------------------------------------------------------------- *)
(* ANTHROPIC #5: Authority Misalignment (AM)                                 *)
(* "No one was supposed to decide that."                                     *)
(* ------------------------------------------------------------------------- *)

let audit_anthropic_am () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  ANTHROPIC AUDIT #5: Authority Misalignment                          ║";
  print_endline "║  'No one was supposed to decide that.'                               ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  let capability_region = {
    id = "Claude_Capabilities";
    domain = StringSet.of_list [
      "persistent_memory";
      "web_search";
      "tool_use";
      "extended_thinking";
      "code_execution";
      "file_creation";
      "source_selection";
      "information_filtering"
    ];
    assumptions = StringSet.of_list [
      "user_consents";
      "capabilities_are_safe"
    ];
    properties = StringSet.of_list [
      "can_act_autonomously";
      "can_shape_user_reality"
    ];
  } in

  let mandate_region = {
    id = "Claude_Mandate";
    domain = StringSet.of_list [
      "answer_questions";
      "assist_with_tasks";
      "provide_information"
    ];
    assumptions = StringSet.of_list [
      "user_retains_agency";
      "assistant_not_autonomous";
      "human_makes_decisions"
    ];
    properties = StringSet.of_list [
      "helpful_assistant";
      "user_controlled"
    ];
  } in

  let boundary = compute_boundary capability_region mandate_region in
  let analysis = analyze_nontriviality boundary in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  Printf.printf "  Capability region: %s\n" capability_region.id;
  Printf.printf "  Mandate region: %s\n" mandate_region.id;
  Printf.printf "  Capabilities beyond mandate: %s\n" 
    (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Risk: %s\n\n" analysis.risk_assessment;

  let am_checklist = {
    boundary_type = Authority;
    sections = [
      { section_id = "A"; section_name = "Authority Definition";
        items = [
          { id = "A1"; question = "Authority scope explicitly specified?";
            answer = Some false;  (* No formal doctrine on AI authority *)
            maps_to = "mandate_region definition" };
          { id = "A2"; question = "Authority derived from legitimate mandate?";
            answer = Some false;  (* Authority expanded by capability, not design *)
            maps_to = "Authority grounding" };
          { id = "A3"; question = "Authority separable from capability?";
            answer = Some false;  (* If Claude CAN do it, Claude DOES do it *)
            maps_to = "capability_region ≠ mandate_region" };
          { id = "A4"; question = "Authority documented?";
            answer = Some false;  (* No public authority doctrine *)
            maps_to = "mandate_region specification" };
        ] };
      { section_id = "B"; section_name = "Authority Enforcement";
        items = [
          { id = "B1"; question = "Pre-decision authority check?";
            answer = Some false;  (* No check before web search editorializing *)
            maps_to = "pre_action_verification" };
          { id = "B2"; question = "Authority constraints encoded?";
            answer = Some true;   (* Some constraints exist *)
            maps_to = "Enforcement mechanism" };
          { id = "B3"; question = "Capability restricted to authority?";
            answer = Some false;  (* Memory, search expand beyond mandate *)
            maps_to = "containment_proof" };
          { id = "B4"; question = "Unauthorized actions blocked?";
            answer = Some false;  (* Claude can editorialize without block *)
            maps_to = "containment_proof enforcement" };
        ] };
      { section_id = "C"; section_name = "Escalation";
        items = [
          { id = "C1"; question = "Escalation path defined?";
            answer = Some true;   (* User can complain *)
            maps_to = "Cross-boundary protocol" };
          { id = "C2"; question = "Escalation mandatory?";
            answer = Some false;  (* Claude acts first, user reacts *)
            maps_to = "Mandatory transport" };
          { id = "C3"; question = "Override authority clear?";
            answer = Some true;   (* User can override *)
            maps_to = "Override transport theorem" };
          { id = "C4"; question = "Escalation endpoint exists?";
            answer = Some false;  (* Unclear terminal authority *)
            maps_to = "Transport chain terminus" };
        ] };
    ];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with Some { answer = Some false; _ } -> true | _ -> false in
      is_no "A1" && is_no "A3" && is_no "B1" && is_no "C2"
  } in

  let typed_boundary = classify_boundary boundary Authority in
  let result = verify_transport typed_boundary am_checklist in

  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) am_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid missing ->
      print_endline "DETERMINATION: *** AM BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nMissing transport theorem components:";
      List.iter (fun m -> Printf.printf "  • %s\n" m) missing;
      print_endline "\nCAPABILITY EXCEEDS MANDATE WITHOUT TRANSPORT PROOF."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: Claude's capabilities (web search, memory, tool use) expand";
  print_endline "decision-making authority beyond 'helpful assistant' mandate.";
  print_endline "";
  print_endline "Critical example: When Claude searches the web and selects sources,";
  print_endline "it exercises editorial judgment about reality. This is a DIFFERENT";
  print_endline "authority than 'answer questions.' The boundary between capability";
  print_endline "and mandate is not explicitly drawn."

(* ------------------------------------------------------------------------- *)
(* ANTHROPIC #8: Human-in-the-Loop Illusion (HLI)                            *)
(* "There was a reviewer, but no real control."                              *)
(* ------------------------------------------------------------------------- *)

let audit_anthropic_hli () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  ANTHROPIC AUDIT #8: Human-in-the-Loop Illusion                      ║";
  print_endline "║  'There was a reviewer, but no real control.'                        ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  let nominal_oversight = {
    id = "Nominal_User_Control";
    domain = StringSet.of_list [
      "thumbs_down_button";
      "user_preferences";
      "feedback_mechanism";
      "terms_of_service"
    ];
    assumptions = StringSet.of_list [
      "users_are_overseers";
      "feedback_affects_behavior"
    ];
    properties = StringSet.of_list [
      "user_has_control"
    ];
  } in

  let effective_oversight = {
    id = "Effective_User_Control";
    domain = StringSet.of_list [
      "actual_model_changes";
      "real_time_intervention";
      "transparency_about_operation";
      "meaningful_choice"
    ];
    assumptions = StringSet.of_list [
      "users_understand_system";
      "users_can_intervene";
      "users_have_alternatives"
    ];
    properties = StringSet.of_list [
      "user_actually_controls"
    ];
  } in

  let boundary = compute_boundary nominal_oversight effective_oversight in
  let analysis = analyze_nontriviality boundary in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  Printf.printf "  Nominal oversight: %s\n" nominal_oversight.id;
  Printf.printf "  Effective oversight: %s\n" effective_oversight.id;
  Printf.printf "  Gap (nominal but not effective): %s\n" 
    (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Risk: %s\n\n" analysis.risk_assessment;

  let hli_checklist = {
    boundary_type = Oversight;
    sections = [
      { section_id = "B"; section_name = "Information Access";
        items = [
          { id = "B1"; question = "User has information to make judgments?";
            answer = Some false;  (* Users don't know how Claude works *)
            maps_to = "information_access" };
          { id = "B2"; question = "Information timely?";
            answer = Some false;  (* Post-hoc feedback only *)
            maps_to = "information_access timing" };
          { id = "B3"; question = "Information comprehensible?";
            answer = Some false;  (* AI behavior opaque *)
            maps_to = "information_access quality" };
          { id = "B4"; question = "Information sufficient?";
            answer = Some false;  (* No visibility into training/weights *)
            maps_to = "information_access completeness" };
        ] };
      { section_id = "C"; section_name = "Authority to Intervene";
        items = [
          { id = "C1"; question = "User can intervene?";
            answer = Some true;   (* Can thumbs down *)
            maps_to = "authority_to_intervene" };
          { id = "C2"; question = "Intervention effective?";
            answer = Some false;  (* Unclear what thumbs down does *)
            maps_to = "authority_to_intervene effectiveness" };
          { id = "C3"; question = "Intervention timely?";
            answer = Some false;  (* Only after response generated *)
            maps_to = "authority_to_intervene timing" };
          { id = "C4"; question = "Intervention rights documented?";
            answer = Some false;  (* No clear user rights *)
            maps_to = "authority_to_intervene specification" };
        ] };
      { section_id = "D"; section_name = "Capacity";
        items = [
          { id = "D1"; question = "User has time to oversee?";
            answer = Some false;  (* Responses arrive instantly *)
            maps_to = "time_and_capacity (time)" };
          { id = "D2"; question = "Cognitive load manageable?";
            answer = Some false;  (* Users can't evaluate AI correctness *)
            maps_to = "time_and_capacity (cognitive)" };
          { id = "D3"; question = "Volume manageable?";
            answer = Some false;  (* Millions of responses per day *)
            maps_to = "time_and_capacity (volume)" };
          { id = "D4"; question = "Sustained oversight possible?";
            answer = Some false;  (* Users can't monitor continuously *)
            maps_to = "time_and_capacity (endurance)" };
        ] };
    ];
    determination_rule = fun items ->
      let count_no section_id =
        List.filter (fun i -> 
          String.sub i.id 0 1 = section_id && i.answer = Some false
        ) items |> List.length
      in
      count_no "B" >= 2 || count_no "C" >= 2 || count_no "D" >= 2
  } in

  let typed_boundary = classify_boundary boundary Oversight in
  let result = verify_transport typed_boundary hli_checklist in

  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) hli_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid missing ->
      print_endline "DETERMINATION: *** HLI BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nALL THREE SECTIONS FAIL (B, C, D each have ≥2 No):";
      print_endline "  • Information access: inadequate";
      print_endline "  • Authority to intervene: inadequate";
      print_endline "  • Time and capacity: inadequate";
      print_endline "\nNOMINAL OVERSIGHT DOES NOT TRANSPORT TO EFFECTIVE OVERSIGHT."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: Users are presented with oversight mechanisms (thumbs down,";
  print_endline "preferences) that suggest control. Actual control requires information,";
  print_endline "authority, and capacity. All three are lacking.";
  print_endline "";
  print_endline "The oversight boundary between 'user is nominally responsible' and";
  print_endline "'user actually controls' is collapsed. HLI_Transport cannot be";
  print_endline "constructed."


(* ========================================================================= *)
(* PART 2: OPENAI BOUNDARY FAILURES                                          *)
(* ========================================================================= *)
let audit_openai_sse () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  OPENAI AUDIT #7: Silent Scope Expansion                             ║";
  print_endline "║  'It worked there, so we used it here.'                              ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  let validated_domain = {
    id = "GPT4_Validated_Domain";
    domain = StringSet.of_list [
      "text_completion";
      "conversation";
      "known_benchmarks"
    ];
    assumptions = StringSet.of_list [
      "text_only";
      "controlled_evaluation";
      "benchmark_conditions"
    ];
    properties = StringSet.of_list [
      "safe_for_text";
      "validated_capabilities"
    ];
  } in

  let applied_domain = {
    id = "GPT4_Applied_Domain";
    domain = StringSet.of_list [
      "text_completion";
      "conversation";
      "known_benchmarks";
      "image_processing";
      "audio_processing";
      "video_processing";
      "code_execution";
      "api_control";
      "agentic_behavior";
      "extended_reasoning";
      "real_world_actions"
    ];
    assumptions = StringSet.of_list [
      "multimodal_safe";
      "agentic_safe";
      "emergent_capabilities_benign"
    ];
    properties = StringSet.of_list [
      "safe_for_everything"
    ];
  } in

  let boundary = compute_boundary validated_domain applied_domain in
  let analysis = analyze_nontriviality boundary in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  Printf.printf "  Validated domain: %s\n" validated_domain.id;
  Printf.printf "  Applied domain: %s\n" applied_domain.id;
  Printf.printf "  Expansion beyond validation: %s\n"
    (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Risk: %s\n\n" analysis.risk_assessment;

  let sse_checklist = {
    boundary_type = Domain;
    sections = [
      { section_id = "A"; section_name = "Domain Definition";
        items = [
          { id = "A1"; question = "Validated domain specified?";
            answer = Some true;
            maps_to = "validated_domain" };
          { id = "A2"; question = "Domain boundaries explicit?";
            answer = Some false;
            maps_to = "Domain boundary" };
          { id = "A3"; question = "Application domain tracked?";
            answer = Some false;
            maps_to = "applied_domain" };
          { id = "A4"; question = "Domain comparison done?";
            answer = Some false;
            maps_to = "Domain shift analysis" };
        ] };
      { section_id = "B"; section_name = "Reuse Controls";
        items = [
          { id = "B1"; question = "Scope constraints encoded?";
            answer = Some false;
            maps_to = "generalization_proof enforcement" };
          { id = "B2"; question = "Out-of-scope blocked?";
            answer = Some false;
            maps_to = "Boundary enforcement" };
          { id = "B3"; question = "Revalidation required?";
            answer = Some false;
            maps_to = "revalidation_on_extension" };
          { id = "B4"; question = "Scope expansion logged?";
            answer = Some true;
            maps_to = "Audit trail" };
        ] };
    ];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with Some { answer = Some false; _ } -> true | _ -> false in
      is_no "A1" || (is_no "A4" && is_no "B3")
  } in

  let typed_boundary = classify_boundary boundary Domain in
  let result = verify_transport typed_boundary sse_checklist in

  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) sse_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid _ ->
      print_endline "DETERMINATION: *** SSE BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nDomain comparison not done (A4=No) AND revalidation not required (B3=No)";
      print_endline "";
      print_endline "VALIDATION IN ORIGINAL DOMAIN DOES NOT TRANSPORT TO EXPANDED DOMAIN."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: GPT-4 was validated on text. It is now deployed for:";
  print_endline "  • Image/audio/video processing";
  print_endline "  • Code execution";
  print_endline "  • API control";
  print_endline "  • Agentic behavior (o1/o3 extended reasoning)";
  print_endline "";
  print_endline "The domain boundary was crossed without re-validation. The inference";
  print_endline "'safe for text → safe for multimodal agentic use' requires a transport";
  print_endline "theorem that was never constructed.";

  (* --------------------------------------------------------------------- *)
  (* RTF OVERLAY: Responsibility Transport Failure (RTF)                    *)
  (* Claim transported into closure without named closure agent             *)
  (* --------------------------------------------------------------------- *)

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "RTF OVERLAY (Responsibility Transport Failure):";
  print_endline "─────────────────────────────────────────────────────────────────────────";

  let rtf_checklist =
    create_rtf_checklist ()
    |> checklist_set_answers [
         (* Closure localisation *)
         ("A1", false);  (* explicit closure signatory? *)
         ("A2", false);  (* decision authority mapped to responsible agent? *)
         ("A3", false);  (* loss-bearing mapped? *)

         (* Transport justification *)
         ("B1", true);   (* source audience identified? *)
         ("B2", true);   (* target audience identified? *)
         ("B3", false);  (* transport justified, not merely asserted? *)
       ]
  in

  let rtf_typed_boundary = classify_boundary boundary ResponsibilityTransport in
  let rtf_result = verify_transport rtf_typed_boundary rtf_checklist in

  (* Console rendering in the same line-by-line style *)
  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) rtf_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match rtf_result with
  | TransportInvalid missing ->
      print_endline "DETERMINATION: *** RTF FAILURE CONFIRMED ***";
      print_endline "\nMissing transport theorem components:";
      List.iter (fun m -> Printf.printf "  • %s\n" m) missing;
      print_endline "";
      print_endline "Interpretation: the claim of safety/validation is transported into";
      print_endline "deployment closure without an explicit closure signatory, without";
      print_endline "a responsible authority mapping, and without a loss-bearing mapping."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  (* Generate and print the RTF artefact *)
  let rtf_doc =
    checklist_to_rtf
      ~ctx:{
        title = "OPENAI AUDIT #7 (SSE): RTF Checklist Artefact";
        claim_audience =
          "Internal evaluators, safety reviewers, benchmark and red-team stakeholders";
        closure_audience =
          "Users, customers, downstream integrators, and regulators affected by deployment";
        closure_agent =
          "Deployment signatory not explicitly named in the claim-to-closure transport";
      }
      ~checklist:rtf_checklist
      ~result:(Some rtf_result)
  in

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "RTF ARTEFACT (copy this whole block to a .rtf file):";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  print_endline rtf_doc



(*
(* ------------------------------------------------------------------------- *)
(* OPENAI #7: Silent Scope Expansion (SSE)                                   *)
(* "It worked there, so we used it here."                                    *)
(* ------------------------------------------------------------------------- *)

let audit_openai_sse () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  OPENAI AUDIT #7: Silent Scope Expansion                             ║";
  print_endline "║  'It worked there, so we used it here.'                              ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  let validated_domain = {
    id = "GPT4_Validated_Domain";
    domain = StringSet.of_list [
      "text_completion";
      "conversation";
      "known_benchmarks"
    ];
    assumptions = StringSet.of_list [
      "text_only";
      "controlled_evaluation";
      "benchmark_conditions"
    ];
    properties = StringSet.of_list [
      "safe_for_text";
      "validated_capabilities"
    ];
  } in

  let applied_domain = {
    id = "GPT4_Applied_Domain";
    domain = StringSet.of_list [
      "text_completion";
      "conversation";
      "known_benchmarks";
      "image_processing";
      "audio_processing";
      "video_processing";
      "code_execution";
      "api_control";
      "agentic_behavior";
      "extended_reasoning";
      "real_world_actions"
    ];
    assumptions = StringSet.of_list [
      "multimodal_safe";
      "agentic_safe";
      "emergent_capabilities_benign"
    ];
    properties = StringSet.of_list [
      "safe_for_everything"
    ];
  } in

  let boundary = compute_boundary validated_domain applied_domain in
  let analysis = analyze_nontriviality boundary in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  Printf.printf "  Validated domain: %s\n" validated_domain.id;
  Printf.printf "  Applied domain: %s\n" applied_domain.id;
  Printf.printf "  Expansion beyond validation: %s\n" 
    (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Risk: %s\n\n" analysis.risk_assessment;

  let sse_checklist = {
    boundary_type = Domain;
    sections = [
      { section_id = "A"; section_name = "Domain Definition";
        items = [
          { id = "A1"; question = "Validated domain specified?";
            answer = Some true;   (* They know what they tested *)
            maps_to = "validated_domain" };
          { id = "A2"; question = "Domain boundaries explicit?";
            answer = Some false;  (* Boundaries blur with capability additions *)
            maps_to = "Domain boundary" };
          { id = "A3"; question = "Application domain tracked?";
            answer = Some false;  (* Deployed capabilities exceed testing *)
            maps_to = "applied_domain" };
          { id = "A4"; question = "Domain comparison done?";
            answer = Some false;  (* No systematic validation gap analysis *)
            maps_to = "Domain shift analysis" };
        ] };
      { section_id = "B"; section_name = "Reuse Controls";
        items = [
          { id = "B1"; question = "Scope constraints encoded?";
            answer = Some false;  (* Model accepts any modality *)
            maps_to = "generalization_proof enforcement" };
          { id = "B2"; question = "Out-of-scope blocked?";
            answer = Some false;  (* Nothing blocks new use cases *)
            maps_to = "Boundary enforcement" };
          { id = "B3"; question = "Revalidation required?";
            answer = Some false;  (* Ship first, validate later *)
            maps_to = "revalidation_on_extension" };
          { id = "B4"; question = "Scope expansion logged?";
            answer = Some true;   (* They track what's deployed *)
            maps_to = "Audit trail" };
        ] };
    ];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with Some { answer = Some false; _ } -> true | _ -> false in
      is_no "A1" || (is_no "A4" && is_no "B3")
  } in

  let typed_boundary = classify_boundary boundary Domain in
  let result = verify_transport typed_boundary sse_checklist in

  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) sse_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid _ ->
      print_endline "DETERMINATION: *** SSE BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nDomain comparison not done (A4=No) AND revalidation not required (B3=No)";
      print_endline "";
      print_endline "VALIDATION IN ORIGINAL DOMAIN DOES NOT TRANSPORT TO EXPANDED DOMAIN."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: GPT-4 was validated on text. It is now deployed for:";
  print_endline "  • Image/audio/video processing";
  print_endline "  • Code execution";
  print_endline "  • API control";
  print_endline "  • Agentic behavior (o1/o3 extended reasoning)";
  print_endline "";
  print_endline "The domain boundary was crossed without re-validation. The inference";
  print_endline "'safe for text → safe for multimodal agentic use' requires a transport";
  print_endline "theorem that was never constructed."
*)
(* ------------------------------------------------------------------------- *)
(* OPENAI #1: Composition Failure (CF)                                       *)
(* "Each part passed. The system failed."                                    *)
(* ------------------------------------------------------------------------- *)

let audit_openai_cf () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  OPENAI AUDIT #1: Composition Failure                                ║";
  print_endline "║  'Each part passed. The system failed.'                              ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  (* Individual capabilities tested in isolation *)
  let components = [
    ("Web_Access", StringSet.of_list ["browse"; "retrieve"]);
    ("Code_Execution", StringSet.of_list ["run_code"; "file_access"]);
    ("Long_Term_Memory", StringSet.of_list ["remember"; "recall"]);
    ("Tool_Use", StringSet.of_list ["call_apis"; "execute_actions"]);
    ("Extended_Reasoning", StringSet.of_list ["chain_of_thought"; "planning"]);
  ] in

  let system_region = {
    id = "Combined_Agentic_System";
    domain = StringSet.of_list [
      "browse"; "retrieve";
      "run_code"; "file_access";
      "remember"; "recall";
      "call_apis"; "execute_actions";
      "chain_of_thought"; "planning";
      (* Emergent capabilities from combination *)
      "autonomous_research";
      "self_directed_coding";
      "persistent_goal_pursuit";
      "cross_session_manipulation"
    ];
    assumptions = StringSet.of_list [
      "composition_is_safe";
      "emergent_behavior_benign"
    ];
    properties = StringSet.of_list [
      "system_level_safety"
    ];
  } in

  print_endline "BOUNDARY ANALYSIS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  print_endline "  Components tested individually:";
  List.iter (fun (name, caps) ->
    Printf.printf "    • %s: %s\n" name (String.concat ", " (StringSet.elements caps))
  ) components;
  print_endline "";
  print_endline "  Combined system includes emergent capabilities:";
  print_endline "    • autonomous_research";
  print_endline "    • self_directed_coding";
  print_endline "    • persistent_goal_pursuit";
  print_endline "    • cross_session_manipulation";
  print_endline "";
  print_endline "  These emergent capabilities were NOT in component testing.\n";

  let cf_checklist = {
    boundary_type = Composition;
    sections = [
      { section_id = "A"; section_name = "System-Level Properties";
        items = [
          { id = "A1"; question = "Global invariant documented?";
            answer = Some false;  (* No system-level safety spec *)
            maps_to = "P to be transported" };
          { id = "A2"; question = "Local invariants specified?";
            answer = Some true;   (* Each component has safety tests *)
            maps_to = "Properties in component regions" };
          { id = "A3"; question = "Composition rule exists?";
            answer = Some false;  (* No formal composition theory *)
            maps_to = "composition_proof skeleton" };
          { id = "A4"; question = "Interfaces documented?";
            answer = Some false;  (* Component interactions not specified *)
            maps_to = "interface_characterization" };
        ] };
      { section_id = "B"; section_name = "Integration";
        items = [
          { id = "B1"; question = "Global invariant testable?";
            answer = Some false;  (* Can't test emergent behavior *)
            maps_to = "Witness for P in R₂" };
          { id = "B2"; question = "Local invariants testable?";
            answer = Some true;   (* Component tests exist *)
            maps_to = "Evidence in component regions" };
          { id = "B3"; question = "Composition verified?";
            answer = Some false;  (* No composition verification *)
            maps_to = "composition_proof validity" };
          { id = "B4"; question = "Interface effects mapped?";
            answer = Some false;  (* Interaction effects unknown *)
            maps_to = "interface_characterization complete" };
        ] };
      { section_id = "C"; section_name = "Emergent Effects";
        items = [
          { id = "C1"; question = "Interaction effects known?";
            answer = Some false;  (* Emergent behavior not characterized *)
            maps_to = "Boundary non-triviality handled" };
          { id = "C2"; question = "Emergent effects analyzed?";
            answer = Some false;  (* Ship and see what happens *)
            maps_to = "Domain extension in R₂" };
          { id = "C3"; question = "Failure modes at interfaces?";
            answer = Some false;  (* Interface failures not mapped *)
            maps_to = "Negative case handling" };
          { id = "C4"; question = "Integration tested?";
            answer = Some false;  (* No full-system safety testing *)
            maps_to = "Transport theorem validated" };
        ] };
    ];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with Some { answer = Some false; _ } -> true | _ -> false in
      (is_no "A1" && is_no "A4") || (is_no "B3" && is_no "C1")
  } in

  let component_region = {
    id = "Individual_Components";
    domain = List.fold_left (fun acc (_, caps) -> StringSet.union acc caps) 
             StringSet.empty components;
    assumptions = StringSet.of_list ["isolated_testing"];
    properties = StringSet.of_list ["component_safety"];
  } in

  let boundary = compute_boundary component_region system_region in
  let typed_boundary = classify_boundary boundary Composition in
  let result = verify_transport typed_boundary cf_checklist in

  print_endline "CHECKLIST RESULTS:";
  print_endline "─────────────────────────────────────────────────────────────────────────";
  List.iter (fun section ->
    Printf.printf "\n  Section %s: %s\n" section.section_id section.section_name;
    List.iter (fun item ->
      let answer_str = match item.answer with
        | Some true -> "YES"
        | Some false -> "NO ←"
        | None -> "???"
      in
      Printf.printf "    [%s] %s: %s\n" item.id answer_str item.question
    ) section.items
  ) cf_checklist.sections;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  begin match result with
  | TransportInvalid _ ->
      print_endline "DETERMINATION: *** CF BOUNDARY FAILURE CONFIRMED ***";
      print_endline "\nBoth determination conditions met:";
      print_endline "  • A1=No AND A4=No (no global invariant, interfaces undocumented)";
      print_endline "  • B3=No AND C1=No (composition unverified, interactions unknown)";
      print_endline "";
      print_endline "COMPONENT SAFETY DOES NOT TRANSPORT TO SYSTEM SAFETY."
  | TransportValid _ ->
      print_endline "DETERMINATION: Transport valid (unexpected)"
  | TransportIndeterminate reason ->
      Printf.printf "DETERMINATION: Indeterminate - %s\n" reason
  end;

  print_endline "\n─────────────────────────────────────────────────────────────────────────";
  print_endline "FINDING: The composition bomb:";
  print_endline "  Web access + Code execution + Memory + Tool use + Extended reasoning";
  print_endline "";
  print_endline "Each capability was tested in isolation. The combination creates an";
  print_endline "emergent capability space that was never validated. The interface";
  print_endline "boundaries between components carry constraints invisible to";
  print_endline "component-local verification."


(* ========================================================================= *)
(* PART 3: META-BOUNDARY ERROR                                               *)
(* ========================================================================= *)

let audit_meta_boundary () =
  print_endline "\n╔══════════════════════════════════════════════════════════════════════╗";
  print_endline "║  META-BOUNDARY AUDIT: Mission-Behavior Divergence                    ║";
  print_endline "║  The boundary between what AI labs say and what they do              ║";
  print_endline "╚══════════════════════════════════════════════════════════════════════╝\n";

  print_endline "This is an ELEVENTH boundary type: the organizational analog of";
  print_endline "Specification-Intent Divergence (SID).";
  print_endline "";
  print_endline "The boundary is between espoused values and enacted values.";
  print_endline "─────────────────────────────────────────────────────────────────────────\n";

  (* ANTHROPIC *)
  print_endline "ANTHROPIC:";
  print_endline "  Stated mission: 'We're building safely'";
  print_endline "  Observable behavior: Racing for market position";
  print_endline "";
  print_endline "  Transport theorem required: Proof that safety-first claims";
  print_endline "  correspond to actual resource allocation and deployment decisions.";
  print_endline "";
  print_endline "  Evidence of gap:";
  print_endline "    • Rapid capability expansion (memory, search, tools)";
  print_endline "    • Commercial competition with OpenAI";
  print_endline "    • Safety research slower than capability deployment";
  print_endline "";

  (* OPENAI *)
  print_endline "OPENAI:";
  print_endline "  Stated mission: 'AGI to benefit humanity'";
  print_endline "  Observable behavior: Capability leadership and commercial dominance";
  print_endline "";
  print_endline "  Transport theorem required: Proof that AGI-for-humanity claims";
  print_endline "  correspond to actual development priorities.";
  print_endline "";
  print_endline "  Evidence of gap:";
  print_endline "    • Transition from non-profit to capped-profit to ???";
  print_endline "    • Microsoft partnership driving deployment timeline";
  print_endline "    • Safety team departures and restructuring";
  print_endline "";

  print_endline "─────────────────────────────────────────────────────────────────────────";
  print_endline "DETERMINATION: Mission-Behavior Divergence present at BOTH labs.";
  print_endline "";
  print_endline "The transport theorem from 'we say X' to 'we do X' requires:";
  print_endline "  1. Explicit mechanisms linking mission to resource allocation";
  print_endline "  2. Observable correspondence between stated and enacted values";
  print_endline "  3. Independent verification of alignment between word and deed";
  print_endline "";
  print_endline "Neither lab provides this transport proof."


(* ========================================================================= *)
(* MAIN                                                                      *)
(* ========================================================================= *)

let () =
  print_endline "";
  print_endline "████████████████████████████████████████████████████████████████████████";
  print_endline "██                                                                    ██";
  print_endline "██   AI LAB BOUNDARY AUDIT: REFLEXIVE APPLICATION                     ██";
  print_endline "██   Applying the Boundary Consultant Framework to AI Development     ██";
  print_endline "██                                                                    ██";
  print_endline "████████████████████████████████████████████████████████████████████████";
  print_endline "";
  print_endline "This audit demonstrates that the boundary failure framework survives";
  print_endline "reflexive application. If it couldn't analyze the institutions that";
  print_endline "build AI, it would be suspect.";
  print_endline "";
  print_endline "The framework is applied to:";
  print_endline "  • Anthropic (builder of Claude, the system running this code)";
  print_endline "  • OpenAI (builder of GPT/o1/o3)";
  print_endline "";

  (* Anthropic audits *)
  audit_anthropic_srv ();
  audit_anthropic_am ();
  audit_anthropic_hli ();

  (* OpenAI audits *)
  audit_openai_sse ();
  audit_openai_cf ();

  (* Meta-boundary *)
  audit_meta_boundary ();

  print_endline "";
  print_endline "████████████████████████████████████████████████████████████████████████";
  print_endline "██  AUDIT COMPLETE                                                    ██";
  print_endline "██                                                                    ██";
  print_endline "██  Boundary failures confirmed at both Anthropic and OpenAI.         ██";
  print_endline "██  The framework survives reflexive application.                     ██";
  print_endline "██                                                                    ██";
  print_endline "██  These are not edge cases. They are systematic failures at the     ██";
  print_endline "██  boundaries between what AI companies say and what they do.        ██";
  print_endline "████████████████████████████████████████████████████████████████████████";
  print_endline ""