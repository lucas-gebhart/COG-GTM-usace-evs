prompt --application/deployment/install/install_sp_approvals_spec
begin
--   Manifest
--     INSTALL: INSTALL-sp_approvals spec
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(52072078761136510084)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_approvals spec'
,p_sequence=>55
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package sp_approvals',
'as',
'',
'------------------',
'-- called by UI',
'------------------',
'',
'procedure submit_for_approval (',
'    p_project_id           in  number,',
'    p_approval_type_id     in  number,',
'    p_team_member_id       in  number,',
'    p_justification        in  varchar2,',
'    p_project_approval_id  out number );',
'',
'procedure clarify (',
'    p_project_approval_chain_id  number,',
'    p_team_member_id             number,',
'    p_response                   varchar2 );',
'',
'procedure withdraw (',
'    p_project_approval_id  in  number,',
'    p_team_member_id       in  number );',
'',
'function approval_pending (',
'    p_project_id      in  number,',
'    p_team_member_id  in  number',
') return number;',
'',
'function more_info_pending (',
'    p_project_id      in  number,',
'    p_team_member_id  in  number',
') return number;',
'',
'function approval_pending_cnt (',
'    p_team_member_id  in  number',
') return number;',
'',
'function more_info_pending_cnt (',
'    p_team_member_id  in  number',
') return number;',
'',
'',
'---------------------------------',
'-- only used within workflow',
'---------------------------------',
'',
'procedure identify_next_reviewer (',
'    p_project_approval_id        in   number,',
'    p_project_approval_chain_id  out  number,',
'    p_reviewer_email             out  varchar2,',
'    p_reviewer_tm_id             out  number );',
'',
'procedure approve (',
'    p_project_approval_chain_id  in  number );',
'',
'procedure reject (',
'    p_project_approval_chain_id  in  number );',
'',
'-- for approve and reject, the comments are not available to the task until after the action',
'procedure add_comments (',
'    p_project_approval_chain_id  in  number,',
'    p_comments                   in  varchar2 );',
'',
'procedure request_clarification (',
'    p_project_approval_chain_id  in  number,',
'    p_comments                   in  varchar2 );',
'',
'procedure approve_request (',
'    p_project_approval_id  in  number );',
'',
'end sp_approvals;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
