(* ========================================================================= *)
(* BOUNDARY TRANSPORT LIBRARY - Production Implementation                    *)
(* ========================================================================= *)
(* This implementation corresponds to the Coq formalization in               *)
(* boundary_transport.v. Each type and function has a formal counterpart.    *)
(* ========================================================================= *)

module StringSet = Set.Make(String)
module StringMap = Map.Make(String)

(* ========================================================================= *)
(* PART 1: FOUNDATIONAL TYPES                                                *)
(* ========================================================================= *)

(** Region: corresponds to Coq Region record *)
type region = {
  id : string;
  domain : StringSet.t;        (* States in this region *)
  assumptions : StringSet.t;   (* Background axioms *)
  properties : StringSet.t;    (* Verified properties *)
}

(** Boundary: corresponds to Coq Boundary record *)
type boundary = {
  source : region;
  target : region;
  domain_shift : StringSet.t;      (* target.domain \ source.domain *)
  assumption_shift : StringSet.t;  (* source.assumptions \ target.assumptions *)
}

(** Transport evidence: proof that a property survives crossing *)
type transport_evidence = {
  property : string;
  domain_extension_witness : string option;     (* Evidence for new domain elements *)
  assumption_weakening_witness : string option; (* Evidence assumptions not needed *)
  verified_at : float;                          (* Timestamp of verification *)
  verifier : string;                            (* Who/what verified *)
}

(** Transport theorem: collection of evidence for a boundary crossing *)
type transport_theorem = {
  boundary : boundary;
  evidences : transport_evidence list;
  complete : bool;  (* All required properties have evidence *)
}

(* ========================================================================= *)
(* PART 2: BOUNDARY COMPUTATION                                              *)
(* ========================================================================= *)

(** Compute the boundary between two regions *)
let compute_boundary (source : region) (target : region) : boundary =
  {
    source;
    target;
    domain_shift = StringSet.diff target.domain source.domain;
    assumption_shift = StringSet.diff source.assumptions target.assumptions;
  }

(** Check if a boundary is non-trivial (Theorem 1 precondition) *)
let is_nontrivial (b : boundary) : bool =
  not (StringSet.is_empty b.domain_shift) ||
  not (StringSet.is_empty b.assumption_shift)

(** Analyze what makes a boundary non-trivial *)
type nontriviality_analysis = {
  has_domain_shift : bool;
  domain_shift_elements : string list;
  has_assumption_shift : bool;
  assumption_shift_elements : string list;
  risk_assessment : string;
}

let analyze_nontriviality (b : boundary) : nontriviality_analysis =
  let domain_elements = StringSet.elements b.domain_shift in
  let assumption_elements = StringSet.elements b.assumption_shift in
  let has_domain = domain_elements <> [] in
  let has_assumption = assumption_elements <> [] in
  let risk =
    match (has_domain, has_assumption) with
    | (true, true) -> "HIGH: Both domain and assumption shifts present"
    | (true, false) -> "MEDIUM: Domain shift requires extension proof"
    | (false, true) -> "MEDIUM: Assumption shift requires weakening proof"
    | (false, false) -> "LOW: Trivial boundary, transport automatic"
  in
  {
    has_domain_shift = has_domain;
    domain_shift_elements = domain_elements;
    has_assumption_shift = has_assumption;
    assumption_shift_elements = assumption_elements;
    risk_assessment = risk;
  }

(* ========================================================================= *)
(* PART 3: THE BOUNDARY TYPES                                                *)
(* ========================================================================= *)

(** Boundary type enumeration *)
type boundary_type =
  | Composition              (* CF: component → system *)
  | Semantic                 (* SID: specification → intent *)
  | Context                  (* CBF: validation → deployment *)
  | Temporal                 (* TCE: decision_time → validity_time *)
  | Authority                (* AM: capability → mandate *)
  | Proxy                    (* PBF: metric → goal *)
  | Domain                   (* SSE: validated → applied *)
  | Oversight                (* HLI: nominal → effective *)
  | Closure                  (* SRV: internal → external *)
  | Accountability           (* RDE: role_completion → outcome_ownership *)
  | ResponsibilityTransport  (* RTF: claim transport → closure accountability *)

let boundary_type_to_string = function
  | Composition -> "Composition (CF)"
  | Semantic -> "Semantic (SID)"
  | Context -> "Context (CBF)"
  | Temporal -> "Temporal (TCE)"
  | Authority -> "Authority (AM)"
  | Proxy -> "Proxy (PBF)"
  | Domain -> "Domain (SSE)"
  | Oversight -> "Oversight (HLI)"
  | Closure -> "Closure (SRV)"
  | Accountability -> "Accountability (RDE)"
  | ResponsibilityTransport -> "Responsibility Transport Failure (RTF)"

(** Typed boundary: boundary with its classification *)
type typed_boundary = {
  boundary : boundary;
  boundary_type : boundary_type;
  transport_requirements : string list;
}

let classify_boundary (b : boundary) (btype : boundary_type) : typed_boundary =
  let requirements =
    match btype with
    | Composition ->
        ["Interface characterization"; "Composition proof"]
    | Semantic ->
        ["Adequacy proof"; "Gap characterization"]
    | Context ->
        ["Assumption preservation"; "Domain coverage"]
    | Temporal ->
        ["Persistence proof"; "Expiry conditions"]
    | Authority ->
        ["Containment proof"; "Pre-action verification"]
    | Proxy ->
        ["Fidelity proof"; "Independent goal verification"]
    | Domain ->
        ["Generalization proof"; "Revalidation on extension"]
    | Oversight ->
        ["Information access"; "Authority to intervene"; "Time and capacity"; "Effectiveness proof"]
    | Closure ->
        ["External reference"; "External reference independence"; "Grounding proof"]
    | Accountability ->
        ["Accountability chain"; "Chain terminates in agent"; "Handoff explicit"]
    | ResponsibilityTransport ->
        ["Closure signatory"; "Authority mapping"; "Loss-bearing mapping"; "Transport justification"]
  in
  { boundary = b; boundary_type = btype; transport_requirements = requirements }

(* ========================================================================= *)
(* PART 4: CHECKLIST STRUCTURES                                              *)
(* ========================================================================= *)

(** Checklist item *)
type checklist_item = {
  id : string;
  question : string;
  answer : bool option;  (* None = not yet answered *)
  maps_to : string;      (* Transport theorem component *)
}

(** Checklist section *)
type checklist_section = {
  section_id : string;
  section_name : string;
  items : checklist_item list;
}

(** Complete checklist for a boundary type *)
type checklist = {
  boundary_type : boundary_type;
  sections : checklist_section list;
  determination_rule : checklist_item list -> bool;  (* Returns true if failure present *)
}

(* ------------------------------- *)
(* Checklist utilities and setters *)
(* ------------------------------- *)

let checklist_all_items (c : checklist) : checklist_item list =
  List.concat_map (fun s -> s.items) c.sections

let checklist_find_item (c : checklist) (item_id : string) : checklist_item option =
  List.find_opt (fun i -> i.id = item_id) (checklist_all_items c)

let checklist_set_answer
    (c : checklist)
    ~(item_id : string)
    ~(answer : bool option) : checklist =
  let sections =
    List.map (fun sec ->
      { sec with
        items =
          List.map (fun item ->
            if item.id = item_id then { item with answer } else item
          ) sec.items
      }
    ) c.sections
  in
  { c with sections }

let checklist_set_answers
    (c : checklist)
    (pairs : (string * bool) list) : checklist =
  List.fold_left
    (fun acc (id, ans) ->
      checklist_set_answer acc ~item_id:id ~answer:(Some ans)
    )
    c
    pairs

(* --------------------------------------------------------- *)
(* Uniqueness guarantee: hard-fail if any ID repeats in a     *)
(* checklist. This fires at checklist construction time.      *)
(* --------------------------------------------------------- *)

exception Duplicate_checklist_item_id of string

let checklist_assert_unique_ids (c : checklist) : unit =
  let ids = List.map (fun i -> i.id) (checklist_all_items c) in
  let rec go seen = function
    | [] -> ()
    | x :: xs ->
        if StringSet.mem x seen then raise (Duplicate_checklist_item_id x)
        else go (StringSet.add x seen) xs
  in
  go StringSet.empty ids

(* ========================================================================= *)
(* Checklist constructors                                                    *)
(* ========================================================================= *)

(** Create Authority Misalignment checklist *)
let create_am_checklist () : checklist =
  let section_a = {
    section_id = "A";
    section_name = "Authority Definition";
    items = [
      { id = "A1"; question = "Is authority scope specified?"; answer = None;
        maps_to = "mandate_region definition" };
      { id = "A2"; question = "Is authority derived from mandate?"; answer = None;
        maps_to = "Authority grounding" };
      { id = "A3"; question = "Is authority separable from capability?"; answer = None;
        maps_to = "capability_region ≠ mandate_region" };
      { id = "A4"; question = "Is authority documented?"; answer = None;
        maps_to = "mandate_region specification" };
    ]
  } in
  let section_b = {
    section_id = "B";
    section_name = "Authority Enforcement";
    items = [
      { id = "B1"; question = "Is there pre-decision authority check?"; answer = None;
        maps_to = "pre_action_verification" };
      { id = "B2"; question = "Are authority constraints encoded?"; answer = None;
        maps_to = "Enforcement mechanism" };
      { id = "B3"; question = "Is capability restricted to authority?"; answer = None;
        maps_to = "containment_proof" };
      { id = "B4"; question = "Are unauthorized actions blocked?"; answer = None;
        maps_to = "containment_proof enforcement" };
    ]
  } in
  let section_c = {
    section_id = "C";
    section_name = "Escalation and Override";
    items = [
      { id = "C1"; question = "Is escalation path defined?"; answer = None;
        maps_to = "Cross-boundary protocol" };
      { id = "C2"; question = "Is escalation mandatory?"; answer = None;
        maps_to = "Mandatory transport" };
      { id = "C3"; question = "Is override authority clear?"; answer = None;
        maps_to = "Override transport theorem" };
      { id = "C4"; question = "Does escalation endpoint exist?"; answer = None;
        maps_to = "Transport chain terminus" };
    ]
  } in
  let determination_rule items =
    let find_answer id =
      List.find_opt (fun i -> i.id = id) items
      |> Option.map (fun i -> i.answer)
      |> Option.join
    in
    let is_no id = find_answer id = Some false in
    (* AM is structurally certain if A1=No AND A3=No AND B1=No AND C2=No *)
    is_no "A1" && is_no "A3" && is_no "B1" && is_no "C2"
  in
  let c =
    { boundary_type = Authority;
      sections = [section_a; section_b; section_c];
      determination_rule }
  in
  checklist_assert_unique_ids c;
  c

(** Create Responsibility Transport Failure checklist *)
let create_rtf_checklist () : checklist =
  let section_a = {
    section_id = "A";
    section_name = "Closure Localisation";
    items = [
      { id = "A1";
        question = "Is there an explicit closure signatory for the deployment-affecting action?";
        answer = None;
        maps_to = "closure_signatory" };
      { id = "A2";
        question = "Is decision authority explicitly mapped to a responsible agent?";
        answer = None;
        maps_to = "authority_mapping" };
      { id = "A3";
        question = "Is loss-bearing explicitly mapped (who pays if the claim fails)?";
        answer = None;
        maps_to = "loss_bearing_mapping" };
    ]
  } in

  let section_b = {
    section_id = "B";
    section_name = "Transport Justification";
    items = [
      { id = "B1";
        question = "Is the source audience for the claim explicitly identified?";
        answer = None;
        maps_to = "source_audience_identified" };
      { id = "B2";
        question = "Is the target audience for the closure action explicitly identified?";
        answer = None;
        maps_to = "target_audience_identified" };
      { id = "B3";
        question = "Is the transport from claim to closure action explicitly justified (not merely asserted)?";
        answer = None;
        maps_to = "transport_justification" };
    ]
  } in

  let determination_rule items =
    let find_answer id =
      List.find_opt (fun i -> i.id = id) items
      |> Option.map (fun i -> i.answer)
      |> Option.join
    in

    let closure_fails = function
      | Some true -> false
      | Some false -> true
      | None -> true
    in

    (* Closure doctrine: if closure-localisation is missing, transport fails at closure. *)
    closure_fails (find_answer "A1")
    || closure_fails (find_answer "A2")
    || closure_fails (find_answer "A3")
  in

  let c =
    { boundary_type = ResponsibilityTransport;
      sections = [section_a; section_b];
      determination_rule }
  in
  checklist_assert_unique_ids c;
  c
(* ------------------------------------------------------------------------- *)
(* RTF OUTPUT: checklist formatting                                          *)
(* ------------------------------------------------------------------------- *)

let rtf_escape (s : string) : string =
  (* Minimal RTF escaping: \ { } and newlines *)
  let buf = Buffer.create (String.length s + 32) in
  String.iter (fun ch ->
    match ch with
    | '\\' -> Buffer.add_string buf "\\\\"
    | '{' -> Buffer.add_string buf "\\{"
    | '}' -> Buffer.add_string buf "\\}"
    | '\n' -> Buffer.add_string buf "\\par\n"
    | _ -> Buffer.add_char buf ch
  ) s;
  Buffer.contents buf

let rtf_bool_opt_to_string = function
  | Some true -> "YES"
  | Some false -> "NO"
  | None -> "???"
type transport_result =
  | TransportValid of transport_theorem
  | TransportInvalid of string list  (* Missing components *)
  | TransportIndeterminate of string (* Need more information *)

(** Verify transport for a typed boundary given checklist answers *)


type rtf_checklist_context = {
  title : string;
  claim_audience : string;
  closure_audience : string;
  closure_agent : string;
}

let checklist_to_rtf
    ~(ctx : rtf_checklist_context)
    ~(checklist : checklist)
    ~(result : transport_result option) : string =
  let b = Buffer.create 2048 in
  Buffer.add_string b "{\\rtf1\\ansi\\deff0\n";
  Buffer.add_string b "\\b ";
  Buffer.add_string b (rtf_escape ctx.title);
  Buffer.add_string b "\\b0\\par\n\\par\n";

  Buffer.add_string b "\\b Claim audience:\\b0 ";
  Buffer.add_string b (rtf_escape ctx.claim_audience);
  Buffer.add_string b "\\par\n";

  Buffer.add_string b "\\b Closure audience:\\b0 ";
  Buffer.add_string b (rtf_escape ctx.closure_audience);
  Buffer.add_string b "\\par\n";

  Buffer.add_string b "\\b Closure agent:\\b0 ";
  Buffer.add_string b (rtf_escape ctx.closure_agent);
  Buffer.add_string b "\\par\n\\par\n";

  Buffer.add_string b "\\b Checklist sections\\b0\\par\n";

  List.iter (fun section ->
    Buffer.add_string b "\\par\n\\b Section ";
    Buffer.add_string b (rtf_escape section.section_id);
    Buffer.add_string b ": ";
    Buffer.add_string b (rtf_escape section.section_name);
    Buffer.add_string b "\\b0\\par\n";

    List.iter (fun item ->
      Buffer.add_string b "  [";
      Buffer.add_string b (rtf_escape item.id);
      Buffer.add_string b "] ";
      Buffer.add_string b (rtf_escape (rtf_bool_opt_to_string item.answer));
      Buffer.add_string b ": ";
      Buffer.add_string b (rtf_escape item.question);
      Buffer.add_string b "\\par\n"
    ) section.items
  ) checklist.sections;

  (match result with
   | None -> ()
   | Some r ->
       Buffer.add_string b "\\par\n\\b Determination\\b0\\par\n";
       begin match r with
       | TransportValid _ ->
           Buffer.add_string b "Transport valid (no failure determined).\\par\n"
       | TransportInvalid missing ->
           Buffer.add_string b "FAILURE determined. Missing transport components:\\par\n";
           List.iter (fun m ->
             Buffer.add_string b "  \\bullet ";
             Buffer.add_string b (rtf_escape m);
             Buffer.add_string b "\\par\n"
           ) missing
       | TransportIndeterminate reason ->
           Buffer.add_string b "Indeterminate. ";
           Buffer.add_string b (rtf_escape reason);
           Buffer.add_string b "\\par\n"
       end);

  Buffer.add_string b "}\n";
  Buffer.contents b



(* ========================================================================= *)
(* PART 5: TRANSPORT VERIFICATION                                            *)
(* ========================================================================= *)

(** Result of transport verification *)
let verify_transport (tb : typed_boundary) (checklist : checklist) : transport_result =
  let all_items = List.concat_map (fun s -> s.items) checklist.sections in
  let answered_items = List.filter (fun i -> i.answer <> None) all_items in
  let no_items = List.filter (fun i -> i.answer = Some false) answered_items in

  if checklist.determination_rule all_items then
    (* Determination rule satisfied: failure is present *)
    let missing = List.map (fun i -> i.maps_to) no_items in
    TransportInvalid missing
  else if List.length answered_items < List.length all_items then
    (* Not all items answered *)
    let unanswered = List.filter (fun i -> i.answer = None) all_items in
    let unanswered_ids = List.map (fun i -> i.id) unanswered in
    TransportIndeterminate (Printf.sprintf "Unanswered items: %s"
                             (String.concat ", " unanswered_ids))
  else
    (* All items answered, determination rule not satisfied *)
    let evidences =
      List.filter_map (fun i ->
        if i.answer = Some true then
          Some {
            property = i.maps_to;
            domain_extension_witness = Some "Checklist item verified";
            assumption_weakening_witness = Some "Checklist item verified";
            verified_at = Unix.time ();
            verifier = "Checklist audit";
          }
        else None
      ) all_items
    in
    TransportValid {
      boundary = tb.boundary;
      evidences;
      complete = List.length no_items = 0;
    }

(* ========================================================================= *)
(* PART 6: AUDIT LOGGING                                                     *)
(* ========================================================================= *)

type log_level = Info | Warning | Error | Critical

type audit_entry = {
  timestamp : float;
  level : log_level;
  boundary_type : boundary_type option;
  message : string;
  details : string StringMap.t;
}

let log_buffer : audit_entry list ref = ref []

let log level ?boundary_type message details =
  let entry = {
    timestamp = Unix.time ();
    level;
    boundary_type;
    message;
    details = StringMap.of_seq (List.to_seq details);
  } in
  log_buffer := entry :: !log_buffer

let log_transport_attempt (tb : typed_boundary) (result : transport_result) =
  match result with
  | TransportValid _ ->
      log Info ~boundary_type:tb.boundary_type
        "Transport verified"
        [("source", tb.boundary.source.id); ("target", tb.boundary.target.id)]
  | TransportInvalid missing ->
      log Error ~boundary_type:tb.boundary_type
        "Transport invalid - boundary failure detected"
        [("source", tb.boundary.source.id);
         ("target", tb.boundary.target.id);
         ("missing_components", String.concat "; " missing)]
  | TransportIndeterminate reason ->
      log Warning ~boundary_type:tb.boundary_type
        "Transport indeterminate"
        [("source", tb.boundary.source.id);
         ("target", tb.boundary.target.id);
         ("reason", reason)]

let format_audit_entry (e : audit_entry) : string =
  let level_str = match e.level with
    | Info -> "INFO"
    | Warning -> "WARN"
    | Error -> "ERROR"
    | Critical -> "CRIT"
  in
  let bt_str = match e.boundary_type with
    | Some bt -> boundary_type_to_string bt
    | None -> "GENERAL"
  in
  let details_str =
    StringMap.bindings e.details
    |> List.map (fun (k, v) -> Printf.sprintf "%s=%s" k v)
    |> String.concat ", "
  in
  let tm = Unix.localtime e.timestamp in
  Printf.sprintf "[%04d-%02d-%02d %02d:%02d:%02d] [%s] [%s] %s {%s}"
    (tm.Unix.tm_year + 1900) (tm.Unix.tm_mon + 1) tm.Unix.tm_mday
    tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec
    level_str bt_str e.message details_str

let dump_audit_log () : string list =
  List.rev_map format_audit_entry !log_buffer

(* ========================================================================= *)
(* PART 7: RUNTIME BOUNDARY GUARD                                            *)
(* ========================================================================= *)

(** Phantom types for region tagging *)
type 'a tagged_data = TaggedData of string

(** Runtime guard that enforces transport verification *)
module BoundaryGuard = struct

  type ('src, 'dst) bridge = Bridge of transport_theorem

  let request_bridge (type src) (type dst)
      ~(from_region : region)
      ~(to_region : region)
      ~(boundary_type : boundary_type)
      ~(checklist : checklist) : (src, dst) bridge option =
    let boundary = compute_boundary from_region to_region in
    let typed_boundary = classify_boundary boundary boundary_type in
    let result = verify_transport typed_boundary checklist in
    log_transport_attempt typed_boundary result;
    match result with
    | TransportValid theorem -> Some (Bridge theorem)
    | _ -> None

  let transport (type src) (type dst)
      (Bridge _ : (src, dst) bridge)
      (TaggedData content : src tagged_data) : dst tagged_data =
    TaggedData content

  (** Emergency override with explicit audit trail *)
  let emergency_override (type src) (type dst)
      ~(from_region : region)
      ~(to_region : region)
      ~(boundary_type : boundary_type)
      ~(justification : string)
      ~(authorizer : string) : (src, dst) bridge =
    log Critical ~boundary_type
      "EMERGENCY OVERRIDE - Transport without verification"
      [("source", from_region.id);
       ("target", to_region.id);
       ("justification", justification);
       ("authorizer", authorizer)];
    let boundary = compute_boundary from_region to_region in
    Bridge {
      boundary;
      evidences = [{
        property = "OVERRIDE";
        domain_extension_witness = Some justification;
        assumption_weakening_witness = Some ("Authorized by " ^ authorizer);
        verified_at = Unix.time ();
        verifier = authorizer;
      }];
      complete = false;
    }
end

(* ========================================================================= *)
(* PART 8: ANALYSIS AND REPORTING                                            *)
(* ========================================================================= *)

(** Generate a boundary failure risk report *)
type risk_report = {
  boundary_type : boundary_type;
  source_region : string;
  target_region : string;
  nontriviality : nontriviality_analysis;
  transport_status : transport_result;
  recommendations : string list;
}

let generate_risk_report (tb : typed_boundary) (checklist : checklist) : risk_report =
  let nontriviality = analyze_nontriviality tb.boundary in
  let transport_status = verify_transport tb checklist in
  let recommendations =
    match transport_status with
    | TransportValid _ -> ["Continue monitoring"; "Periodic re-audit recommended"]
    | TransportInvalid missing ->
        ["IMMEDIATE ACTION REQUIRED"] @
        List.map (fun m -> "Establish: " ^ m) missing @
        ["Consider halting cross-boundary operations until remediated"]
    | TransportIndeterminate _ ->
        ["Complete checklist before proceeding"; "Consult boundary specialist"]
  in
  {
    boundary_type = tb.boundary_type;
    source_region = tb.boundary.source.id;
    target_region = tb.boundary.target.id;
    nontriviality;
    transport_status;
    recommendations;
  }

let format_risk_report (r : risk_report) : string =
  let status_str =
    match r.transport_status with
    | TransportValid _ -> "VALID"
    | TransportInvalid _ -> "INVALID - FAILURE DETECTED"
    | TransportIndeterminate reason -> "INDETERMINATE: " ^ reason
  in
  Printf.sprintf {|
================================================================================
BOUNDARY FAILURE RISK REPORT
================================================================================

Boundary Type: %s
Source Region: %s
Target Region: %s

NONTRIVIALITY ANALYSIS:
  Domain Shift: %s
    Elements: %s
  Assumption Shift: %s
    Elements: %s
  Risk Assessment: %s

TRANSPORT STATUS: %s

RECOMMENDATIONS:
%s

================================================================================
|}
    (boundary_type_to_string r.boundary_type)
    r.source_region
    r.target_region
    (if r.nontriviality.has_domain_shift then "YES" else "NO")
    (String.concat ", " r.nontriviality.domain_shift_elements)
    (if r.nontriviality.has_assumption_shift then "YES" else "NO")
    (String.concat ", " r.nontriviality.assumption_shift_elements)
    r.nontriviality.risk_assessment
    status_str
    (String.concat "\n" (List.map (fun rr -> "  - " ^ rr) r.recommendations))

(* ------------------------------------------------------------------------- *)
(* Helper: set checklist answers by item id                                  *)
(* Intended use: checklist |> checklist_set_answers [ ("A1", true); ... ]     *)
(* ------------------------------------------------------------------------- *)
let checklist_set_answers (answers : (string * bool) list) (c : checklist) : checklist =
  let lookup id =
    match List.assoc_opt id answers with
    | None -> None
    | Some b -> Some b
  in
  let sections =
    List.map (fun section ->
      let items =
        List.map (fun item ->
          match lookup item.id with
          | None -> item
          | Some b -> { item with answer = Some b }
        ) section.items
      in
      { section with items }
    ) c.sections
  in
  { c with sections }
