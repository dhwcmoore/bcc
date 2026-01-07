(* ========================================================================= *)
(* BOUNDARY TRANSPORT DEMONSTRATION                                          *)
(* ========================================================================= *)
(* This demo shows the integrated theory-practice system in action.          *)
(* ========================================================================= *)

open Boundary_transport_build
(* ========================================================================= *)
(* SCENARIO 1: Authority Misalignment Detection                              *)
(* ========================================================================= *)

let demo_authority_misalignment () =
  print_endline "\n=== SCENARIO 1: Authority Misalignment Detection ===\n";
  
  (* Define regions *)
  let capability_region = {
    id = "Trading_System_Capability";
    domain = StringSet.of_list ["execute_trade"; "cancel_trade"; "modify_limits"; "override_risk"];
    assumptions = StringSet.of_list ["system_operational"; "market_open"];
    properties = StringSet.of_list ["can_act_on_market"];
  } in
  
  let mandate_region = {
    id = "Trading_System_Mandate";
    domain = StringSet.of_list ["execute_trade"; "cancel_trade"];  (* Note: smaller! *)
    assumptions = StringSet.of_list ["system_operational"; "market_open"; "within_risk_limits"];
    properties = StringSet.of_list ["authorized_to_trade"];
  } in
  
  (* Compute and analyze boundary *)
  let boundary = compute_boundary capability_region mandate_region in
  let analysis = analyze_nontriviality boundary in
  
  print_endline "Boundary Analysis:";
  Printf.printf "  Domain shift present: %b\n" analysis.has_domain_shift;
  Printf.printf "  Domain shift elements: %s\n" (String.concat ", " analysis.domain_shift_elements);
  Printf.printf "  Assumption shift present: %b\n" analysis.has_assumption_shift;
  Printf.printf "  Risk assessment: %s\n\n" analysis.risk_assessment;
  
  (* Create and populate checklist *)
  let checklist = create_am_checklist () in
  
  (* Simulate audit findings - this system has problems *)
  let answered_checklist = {
    checklist with
    sections = List.map (fun section ->
      { section with
        items = List.map (fun item ->
          { item with
            answer = match item.id with
            | "A1" -> Some false  (* Authority scope NOT specified *)
            | "A2" -> Some false  (* Authority NOT from mandate *)
            | "A3" -> Some false  (* Authority NOT separable from capability *)
            | "A4" -> Some false  (* Authority NOT documented *)
            | "B1" -> Some false  (* NO pre-decision check *)
            | "B2" -> Some true   (* Constraints encoded... but wrong ones *)
            | "B3" -> Some false  (* Capability NOT restricted *)
            | "B4" -> Some false  (* Unauthorized NOT blocked *)
            | "C1" -> Some true   (* Escalation defined *)
            | "C2" -> Some false  (* Escalation NOT mandatory *)
            | "C3" -> Some true   (* Override clear *)
            | "C4" -> Some true   (* Endpoint exists *)
            | _ -> None
          }
        ) section.items
      }
    ) checklist.sections
  } in
  
  (* Verify transport *)
  let typed_boundary = classify_boundary boundary Authority in
  let result = verify_transport typed_boundary answered_checklist in
  
  (* Generate report *)
  let report = generate_risk_report typed_boundary answered_checklist in
  print_endline (format_risk_report report);
  
  (* Show audit log *)
  print_endline "Audit Log:";
  List.iter print_endline (dump_audit_log ())

(* ========================================================================= *)
(* SCENARIO 2: Successful Transport (Properly Configured System)             *)
(* ========================================================================= *)

let demo_successful_transport () =
  print_endline "\n=== SCENARIO 2: Properly Configured System ===\n";
  
  (* Clear previous log *)
  log_buffer := [];
  
  (* This system has authority properly configured *)
  let capability_region = {
    id = "Loan_Approval_Capability";
    domain = StringSet.of_list ["approve_small"; "approve_medium"; "approve_large"];
    assumptions = StringSet.of_list ["system_operational"];
    properties = StringSet.of_list ["can_process_loans"];
  } in
  
  let mandate_region = {
    id = "Loan_Approval_Mandate";
    domain = StringSet.of_list ["approve_small"; "approve_medium"; "approve_large"];
    assumptions = StringSet.of_list ["system_operational"; "within_authority_matrix"];
    properties = StringSet.of_list ["authorized_approvals"];
  } in
  
  let boundary = compute_boundary capability_region mandate_region in
  let analysis = analyze_nontriviality boundary in
  
  print_endline "Boundary Analysis:";
  Printf.printf "  Domain shift present: %b\n" analysis.has_domain_shift;
  Printf.printf "  Assumption shift present: %b\n" analysis.has_assumption_shift;
  Printf.printf "  Risk assessment: %s\n\n" analysis.risk_assessment;
  
  (* This system passes the checklist *)
  let checklist = create_am_checklist () in
  let answered_checklist = {
    checklist with
    sections = List.map (fun section ->
      { section with
        items = List.map (fun item ->
          { item with
            answer = Some true  (* All items pass *)
          }
        ) section.items
      }
    ) checklist.sections
  } in
  
  let typed_boundary = classify_boundary boundary Authority in
  let report = generate_risk_report typed_boundary answered_checklist in
  print_endline (format_risk_report report)

(* ========================================================================= *)
(* SCENARIO 3: Guarded Transport with Phantom Types                          *)
(* ========================================================================= *)

let demo_guarded_transport () =
  print_endline "\n=== SCENARIO 3: Runtime Boundary Guard ===\n";
  
  log_buffer := [];
  
  let module Phantom = struct
  type lab_region
  type prod_region
end in

  let lab = {
    id = "ML_Model_Lab";
    domain = StringSet.of_list ["test_data"; "validation_data"];
    assumptions = StringSet.of_list ["data_clean"; "distribution_stationary"];
    properties = StringSet.of_list ["accuracy_validated"];
  } in
  
  let prod = {
    id = "ML_Model_Production";
    domain = StringSet.of_list ["test_data"; "validation_data"; "real_world_data"];
    assumptions = StringSet.of_list ["data_might_be_dirty"];  (* Weaker! *)
    properties = StringSet.of_list ["deployment_ready"];
  } in
  
  (* Create a context boundary checklist (simplified) *)
  let cbf_checklist = {
    boundary_type = Context;
    sections = [{
      section_id = "A";
      section_name = "Context Assumptions";
      items = [
        { id = "A1"; question = "Validation assumptions documented?"; 
          answer = Some true; maps_to = "assumptions documented" };
        { id = "A2"; question = "Deployment context characterized?";
          answer = Some true; maps_to = "deployment region" };
        { id = "A3"; question = "Assumption comparison done?";
          answer = Some false; maps_to = "assumption shift analysis" };  (* Problem! *)
        { id = "A4"; question = "Domain comparison done?";
          answer = Some false; maps_to = "domain shift analysis" };  (* Problem! *)
      ]
    }];
    determination_rule = fun items ->
      let find id = List.find_opt (fun i -> i.id = id) items in
      let is_no id = match find id with 
        | Some { answer = Some false; _ } -> true 
        | _ -> false 
      in
      is_no "A1" || (is_no "A3" && is_no "A4")
  } in
  
  print_endline "Attempting to transport ML model from lab to production...";
  
  let bridge_result = BoundaryGuard.request_bridge
    ~from_region:lab
    ~to_region:prod
    ~boundary_type:Context
    ~checklist:cbf_checklist
  in
  
  begin match bridge_result with
  | Some bridge ->
      print_endline "Bridge granted! (This shouldn't happen with our config)";
      let lab_model : Phantom.lab_region tagged_data = TaggedData "trained_model_v1" in
      let _prod_model : Phantom.prod_region tagged_data = BoundaryGuard.transport bridge lab_model in
      print_endline "Model transported to production."
  | None ->
      print_endline "Bridge DENIED. Transport verification failed.";
      print_endline "The system correctly prevented unsafe deployment."
  end;
  
  print_endline "\nAudit trail:";
  List.iter print_endline (dump_audit_log ())

(* ========================================================================= *)
(* SCENARIO 4: Emergency Override (with full audit)                          *)
(* ========================================================================= *)

let demo_emergency_override () =
  print_endline "\n=== SCENARIO 4: Emergency Override ===\n";
  
  log_buffer := [];
  
  let module Phantom2 = struct
    type secure_region
    type public_region
  end in
  let secure = {
    id = "Secure_Data_Region";
    domain = StringSet.of_list ["confidential"; "secret"; "top_secret"];
    assumptions = StringSet.of_list ["access_controlled"; "encrypted"];
    properties = StringSet.of_list ["data_protected"];
  } in
  
  let public = {
    id = "Public_Data_Region";
    domain = StringSet.of_list ["public"; "press_release"];
    assumptions = StringSet.of_list ["world_readable"];
    properties = StringSet.of_list ["data_published"];
  } in
  
  print_endline "CEO invokes emergency override for critical disclosure...";
  
  let emergency_bridge : (Phantom2.secure_region, Phantom2.public_region) BoundaryGuard.bridge = 
    BoundaryGuard.emergency_override
      ~from_region:secure
      ~to_region:public
      ~boundary_type:Authority
      ~justification:"Critical security disclosure required by regulation"
      ~authorizer:"CEO_Jane_Smith"
  in
  
  let secure_data : Phantom2.secure_region tagged_data = TaggedData "vulnerability_details" in
  let _public_data : Phantom2.public_region tagged_data = 
    BoundaryGuard.transport emergency_bridge secure_data 
  in
  
  print_endline "Data transported under emergency override.";
  print_endline "\nCRITICAL AUDIT TRAIL:";
  List.iter print_endline (dump_audit_log ())

(* ========================================================================= *)
(* MAIN                                                                      *)
(* ========================================================================= *)

let () =
  print_endline "========================================================================";
  print_endline "BOUNDARY TRANSPORT SYSTEM - INTEGRATED DEMONSTRATION";
  print_endline "========================================================================";
  print_endline "This demo shows the theory-practice bridge in action.";
  print_endline "Coq theorems -> OCaml types -> Runtime guards -> Audit trails";
  print_endline "========================================================================";
  
  demo_authority_misalignment ();
  demo_successful_transport ();
  demo_guarded_transport ();
  demo_emergency_override ();
  
  print_endline "\n========================================================================";
  print_endline "DEMONSTRATION COMPLETE";
  print_endline "========================================================================"
