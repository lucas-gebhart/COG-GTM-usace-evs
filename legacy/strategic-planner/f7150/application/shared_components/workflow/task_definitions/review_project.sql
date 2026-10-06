prompt --application/shared_components/workflow/task_definitions/review_project
begin
--   Manifest
--     TASK_DEF: Review Project
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_task_def(
 p_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'Review Project'
,p_static_id=>'REVIEW-PROJECT'
,p_subject=>'Review Project'
,p_task_type=>'APPROVAL'
,p_priority=>3
,p_expiration_policy=>'NONE'
,p_max_renewal_count=>3
,p_details_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_WF_TASK_ID:&TASK_ID.'
,p_initiator_can_complete=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46149792599948047661)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Reviewer Email'
,p_static_id=>'P_REVIEWER_EMAIL'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46253910000453725443)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Reviewer Team Member ID'
,p_static_id=>'P_REVIEWER_TM_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46259381709560024685)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Project Approval Chain ID'
,p_static_id=>'V_PROJECT_APPROVAL_CHAIN_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46407165762802935830)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Project Name'
,p_static_id=>'P_PROJECT_NAME'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46407166023206935830)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Project Link'
,p_static_id=>'P_PROJECT_LINK'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46407166799917935831)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Email Subject'
,p_static_id=>'V_EMAIL_SUBJECT'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46407167183673935831)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Email Body'
,p_static_id=>'V_EMAIL_BODY'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(46409062298226079734)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'App Name'
,p_static_id=>'P_APP_NAME'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(48155015027589375313)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Nomenclature Project'
,p_static_id=>'P_NOMENCLATURE_PROJECT'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(48155015399792375314)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Approval Type'
,p_static_id=>'P_APPROVAL_TYPE'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(48269124071814976789)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'App ID'
,p_static_id=>'P_APP_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(48269124428494976791)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_label=>'Project ID'
,p_static_id=>'P_PROJECT_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(44927998561418194342)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'APPROVE'
,p_execution_sequence=>20
,p_outcome=>'APPROVED'
,p_on_event=>'COMPLETE'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>'sp_approvals.approve ( p_project_approval_chain_id => :V_PROJECT_APPROVAL_CHAIN_ID );'
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_log_message_type=>'FAILURE'
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(44927998988826194342)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'REJECT'
,p_execution_sequence=>30
,p_outcome=>'REJECTED'
,p_on_event=>'COMPLETE'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>'sp_approvals.reject( p_project_approval_chain_id => :V_PROJECT_APPROVAL_CHAIN_ID );'
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_log_message_type=>'FAILURE'
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(44927999423128194342)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'REQUEST_CLARIFICATION'
,p_execution_sequence=>40
,p_on_event=>'REQUEST_INFO'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.request_clarification (',
'    p_project_approval_chain_id => :V_PROJECT_APPROVAL_CHAIN_ID,',
'    p_comments                  => :APEX$TASK_TEXT );'))
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_log_message_type=>'FAILURE'
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(46506084858359640378)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'Add Comment (comments are passed after the action...)'
,p_execution_sequence=>60
,p_on_event=>'UPDATE_COMMENT'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.add_comments (',
'    p_project_approval_chain_id => :V_PROJECT_APPROVAL_CHAIN_ID,',
'    p_comments                  => :APEX$TASK_TEXT );'))
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_log_message_type=>'FAILURE'
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(47668707005215880463)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'Notify Submitter for more info'
,p_execution_sequence=>80
,p_on_event=>'REQUEST_INFO'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select a.submitted_by_team_member_id submitter_tm_id, ',
'       :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' - Clarification Request for ''||:P_APPROVAL_TYPE||'' review'' email_subject,',
'       ''There is a clarification request for the ''||:P_APPROVAL_TYPE||'' review of ''||:P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||''.<br/>''||',
'                          ''Request: ''|| c.comments email_body',
'  from sp_project_approval_chain c,',
'       sp_project_approvals a',
' where c.id = :V_PROJECT_APPROVAL_CHAIN_ID',
'   and c.project_approval_id = a.id',
'   and c.status = ''CLARIFICATION-REQUESTED''',
'   and c.final_yn = ''Y''',
') loop',
'',
'sp_util.assignment_notification (',
'    p_team_member_id    => c1.submitter_tm_id,',
'    p_app_name          => :P_APP_NAME,',
'    p_app_id            => :P_APP_ID,',
'    p_project_id        => :P_PROJECT_ID,',
'    p_link              => :P_PROJECT_LINK,',
'    p_view_what         => :P_NOMENCLATURE_PROJECT,',
'    p_title             => c1.email_subject,',
'    p_email_contents    => c1.email_body,',
'    p_notification_type => ''APPROVAL-CLARIFICATION'' );',
'',
'end loop;'))
,p_action_clob_language=>'PLSQL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'&SUBMITTER_EMAIL.'
,p_attribute_10=>'N'
,p_attribute_11=>'3817734126973524610'
,p_attribute_12=>'{    "APP_NAME":"&P_APP_NAME.",    "SUBJECT":"&EMAIL_SUBJECT.",    "SUMMARY":"&EMAIL_BODY.",    "PROJECT_LINK":"&P_PROJECT_LINK.",    "VIEW_WHAT":"&P_NOMENCLATURE_PROJECT."}'
,p_attribute_14=>'HTML'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(48269093422227967439)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'Notify Reviewer'
,p_execution_sequence=>100
,p_on_event=>'CREATE'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.assignment_notification (',
'    p_team_member_id    => :P_REVIEWER_TM_ID,',
'    p_app_name          => :P_APP_NAME,',
'    p_app_id            => :P_APP_ID,',
'    p_project_id        => :P_PROJECT_ID,',
'    p_link              => :P_PROJECT_LINK,',
'    p_view_what         => :P_NOMENCLATURE_PROJECT,',
'    p_title             => :V_EMAIL_SUBJECT,',
'    p_email_contents    => :V_EMAIL_BODY,',
'    p_notification_type => ''APPROVAL'' );'))
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(49580945053171500844)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_name=>'Notify Reviewer of Clarification Provided'
,p_execution_sequence=>110
,p_on_event=>'SUBMIT_INFO'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select team_member_id reviewer_tm_id, ',
'       :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' - Clarification Provided for ''||:P_APPROVAL_TYPE||'' review'' email_subject,',
'       ''Clarification has been provided for the ''||:P_APPROVAL_TYPE||'' review of ''||:P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||''.<br/>''||',
'                          ''Clarification: ''|| :APEX$TASK_TEXT email_body',
'  from sp_project_approval_chain',
' where id = :V_PROJECT_APPROVAL_CHAIN_ID',
'   and status = ''PENDING''',
') loop',
'',
'sp_util.assignment_notification (',
'    p_team_member_id    => c1.reviewer_tm_id,',
'    p_app_name          => :P_APP_NAME,',
'    p_app_id            => :P_APP_ID,',
'    p_project_id        => :P_PROJECT_ID,',
'    p_link              => :P_PROJECT_LINK,',
'    p_view_what         => :P_NOMENCLATURE_PROJECT,',
'    p_title             => c1.email_subject,',
'    p_email_contents    => c1.email_body,',
'    p_notification_type => ''APPROVAL'' );',
'',
'end loop;'))
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(46253933715137730085)
,p_task_def_id=>wwv_flow_imp.id(44927997875548194336)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'SQL_QUERY'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(email)',
'  from sp_team_members',
' where id = :P_REVIEWER_TM_ID'))
);
wwv_flow_imp.component_end;
end;
/
