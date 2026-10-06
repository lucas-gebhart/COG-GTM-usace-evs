prompt --application/shared_components/workflow/workflows/project_review
begin
--   Manifest
--     WORKFLOW: Project Review
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_workflow(
 p_id=>wwv_flow_imp.id(42765986457466148805)
,p_name=>'Project Review'
,p_static_id=>'PROJECT-REVIEW'
,p_title=>'&P_APPROVAL_TYPE. Review for &P_NOMENCLATURE_PROJECT. "&P_PROJECT_NAME."'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(17885008776626678871)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_SUBMITTER_TM_ID'
,p_static_id=>'P_SUBMITTER_TM_ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(45694914706157981383)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_PROJECT_ID'
,p_static_id=>'P_PROJECT_ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(45694916507419981401)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_NOMENCLATURE_PROJECT'
,p_static_id=>'P_NOMENCLATURE_PROJECT'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(45694916852188981404)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_PROJECT_LINK'
,p_static_id=>'P_PROJECT_LINK'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(45694917837996981414)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_PROJECT_NAME'
,p_static_id=>'P_PROJECT_NAME'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(46404487517638694979)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_APP_NAME'
,p_static_id=>'P_APP_NAME'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(46404489076453694995)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_APPROVAL_TYPE'
,p_static_id=>'P_APPROVAL_TYPE'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(47428148578787206185)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_PROJECT_APPROVAL_ID'
,p_static_id=>'P_PROJECT_APPROVAL_ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(48139342769096521280)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_label=>'P_APP_ID'
,p_static_id=>'P_APP_ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_version(
 p_id=>wwv_flow_imp.id(17885008870396678872)
,p_workflow_id=>wwv_flow_imp.id(42765986457466148805)
,p_version=>'1.2'
,p_state=>'ACTIVE'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201345680854565)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'Approver'
,p_static_id=>'APPROVER'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201475172854566)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'TaskOutcome'
,p_static_id=>'TASK_OUTCOME'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201491699854567)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_APPROVAL_STATUS'
,p_static_id=>'V_APPROVAL_STATUS'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201642230854568)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_EMAIL_BODY'
,p_static_id=>'V_EMAIL_BODY'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201701104854569)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_EMAIL_SUBJECT'
,p_static_id=>'V_EMAIL_SUBJECT'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201833628854570)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_PROJECT_APPROVAL_CHAIN_ID'
,p_static_id=>'V_PROJECT_APPROVAL_CHAIN_ID'
,p_direction=>'VARIABLE'
,p_data_type=>'NUMBER'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201966396854571)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_REVIEWER_EMAIL'
,p_static_id=>'V_REVIEWER_EMAIL'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397201996848854572)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_REVIEWER_TM_ID'
,p_static_id=>'V_REVIEWER_TM_ID'
,p_direction=>'VARIABLE'
,p_data_type=>'NUMBER'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(18397202369553854575)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_label=>'V_WORKFLOW_TASK_ID'
,p_static_id=>'V_WORKFLOW_TASK_ID'
,p_direction=>'VARIABLE'
,p_data_type=>'NUMBER'
,p_is_required=>false
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(17885008968366678873)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Start'
,p_static_id=>'New'
,p_display_sequence=>10
,p_activity_type=>'NATIVE_WORKFLOW_START'
,p_diagram=>'{"position":{"x":70,"y":850},"z":1}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(17885009118234678875)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Identify Next Reviewer'
,p_static_id=>'identify-next-reviewer'
,p_display_sequence=>20
,p_activity_type=>'NATIVE_INVOKE_API'
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'SP_APPROVALS'
,p_attribute_04=>'IDENTIFY_NEXT_REVIEWER'
,p_diagram=>'{"position":{"x":250,"y":850},"z":2}'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(17885009293473678877)
,p_workflow_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_name=>'p_project_approval_id'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_has_default=>false
,p_display_sequence=>10
,p_value_type=>'ITEM'
,p_value=>'P_PROJECT_APPROVAL_ID'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(17885009412129678878)
,p_workflow_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_name=>'p_project_approval_chain_id'
,p_direction=>'OUT'
,p_data_type=>'NUMBER'
,p_ignore_output=>false
,p_display_sequence=>20
,p_value_type=>'ITEM'
,p_value=>'V_PROJECT_APPROVAL_CHAIN_ID'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(18397197696275854529)
,p_workflow_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_name=>'p_reviewer_email'
,p_direction=>'OUT'
,p_data_type=>'VARCHAR2'
,p_ignore_output=>false
,p_display_sequence=>30
,p_value_type=>'ITEM'
,p_value=>'V_REVIEWER_EMAIL'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(18397197783770854530)
,p_workflow_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_name=>'p_reviewer_tm_id'
,p_direction=>'OUT'
,p_data_type=>'NUMBER'
,p_ignore_output=>false
,p_display_sequence=>40
,p_value_type=>'ITEM'
,p_value=>'V_REVIEWER_TM_ID'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397197981419854531)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Is there another Review?'
,p_static_id=>'another-review'
,p_display_sequence=>30
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'ROWS_RETURNED'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from sp_project_approval_chain',
' where project_approval_id = :P_PROJECT_APPROVAL_ID',
'   and status = ''PENDING'''))
,p_diagram=>'{"position":{"x":250,"y":980},"z":3}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397198244798854534)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Grab data for Reviewer Notif'
,p_static_id=>'grab-data-for-review-notif'
,p_display_sequence=>40
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
':V_EMAIL_SUBJECT := ''Workflow Approval Request, ''||:P_APPROVAL_TYPE||'' review needed for ''||:P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME;',
'',
'for c1 in (',
'    select justification',
'      from sp_project_approvals',
'     where id = :P_PROJECT_APPROVAL_ID',
') loop',
'    :V_EMAIL_BODY := ''<strong>Workflow pending your approval</strong><br/><br/>''||:P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' requires your review for ''||:P_APPROVAL_TYPE||''.<br/>''||',
'                     ''Justification: ''|| substr(c1.justification,1,3000);',
'end loop;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":570,"y":980},"z":4}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397198403688854536)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Request Review'
,p_static_id=>'request-review'
,p_display_sequence=>50
,p_activity_type=>'NATIVE_CREATE_TASK'
,p_attribute_01=>wwv_flow_imp.id(44927997875548194336)
,p_attribute_04=>'V_WORKFLOW_TASK_ID'
,p_attribute_05=>'V_PROJECT_APPROVAL_CHAIN_ID'
,p_attribute_08=>'V_APPROVAL_STATUS'
,p_diagram=>'{"position":{"x":850,"y":980},"z":5}'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397198661126854538)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(48269124071814976789)
,p_value_type=>'ITEM'
,p_value=>'P_APP_ID'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397198703596854539)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46409062298226079734)
,p_value_type=>'ITEM'
,p_value=>'P_APP_NAME'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397198785482854540)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(48155015399792375314)
,p_value_type=>'ITEM'
,p_value=>'P_APPROVAL_TYPE'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397198896663854541)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46407167183673935831)
,p_value_type=>'ITEM'
,p_value=>'V_EMAIL_BODY'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199005833854542)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46407166799917935831)
,p_value_type=>'ITEM'
,p_value=>'V_EMAIL_SUBJECT'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199117115854543)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(48155015027589375313)
,p_value_type=>'ITEM'
,p_value=>'P_NOMENCLATURE_PROJECT'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199213944854544)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46259381709560024685)
,p_value_type=>'ITEM'
,p_value=>'V_PROJECT_APPROVAL_CHAIN_ID'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199347333854545)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(48269124428494976791)
,p_value_type=>'ITEM'
,p_value=>'P_PROJECT_ID'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199476125854546)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46407166023206935830)
,p_value_type=>'ITEM'
,p_value=>'P_PROJECT_LINK'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199548955854547)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46407165762802935830)
,p_value_type=>'ITEM'
,p_value=>'P_PROJECT_NAME'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199619966854548)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46149792599948047661)
,p_value_type=>'ITEM'
,p_value=>'V_REVIEWER_EMAIL'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(18397199704078854549)
,p_workflow_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_task_def_param_id=>wwv_flow_imp.id(46253910000453725443)
,p_value_type=>'ITEM'
,p_value=>'V_REVIEWER_TM_ID'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397199871976854550)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Approve?'
,p_static_id=>'New_3'
,p_display_sequence=>60
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'CHECK_WF_VARIABLE'
,p_attribute_10=>'V_APPROVAL_STATUS'
,p_diagram=>'{"position":{"x":1140,"y":970},"z":6}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397200154653854553)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Approve Request'
,p_static_id=>'approve-review'
,p_display_sequence=>70
,p_activity_type=>'NATIVE_INVOKE_API'
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'SP_APPROVALS'
,p_attribute_04=>'APPROVE_REQUEST'
,p_diagram=>'{"position":{"x":250,"y":1130},"z":7}'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(18397200315998854555)
,p_workflow_activity_id=>wwv_flow_imp.id(18397200154653854553)
,p_name=>'p_project_approval_id'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_has_default=>false
,p_display_sequence=>10
,p_value_type=>'ITEM'
,p_value=>'P_PROJECT_APPROVAL_ID'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397200465351854556)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Grab data for Approval Notif'
,p_static_id=>'grab-data-for-approval'
,p_display_sequence=>80
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
':V_EMAIL_SUBJECT := :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' Approved for ''||:P_APPROVAL_TYPE;',
'',
':V_EMAIL_BODY := :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' was just approved for ''||:P_APPROVAL_TYPE;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":250,"y":1250},"z":8}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397200676804854558)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Notify Approval to Submitter (and project owner)'
,p_static_id=>'approval-notif'
,p_display_sequence=>90
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.assignment_notification (',
'    p_team_member_id    => :P_SUBMITTER_TM_ID,',
'    p_app_name          => :P_APP_NAME,',
'    p_app_id            => :P_APP_ID,',
'    p_project_id        => :P_PROJECT_ID,',
'    p_link              => :P_PROJECT_LINK,',
'    p_view_what         => :P_NOMENCLATURE_PROJECT,',
'    p_title             => :V_EMAIL_SUBJECT,',
'    p_email_contents    => :V_EMAIL_BODY,',
'    p_notification_type => ''APPROVAL'' );',
'',
'for c1 in (',
'    select owner_id',
'      from sp_projects',
'     where id = :P_PROJECT_ID',
'       and owner_id is not null',
') loop',
'    if c1.owner_id != :P_SUBMITTER_TM_ID then',
'        sp_util.assignment_notification (',
'            p_team_member_id    => c1.owner_id,',
'            p_app_name          => :P_APP_NAME,',
'            p_app_id            => :P_APP_ID,',
'            p_project_id        => :P_PROJECT_ID,',
'            p_link              => :P_PROJECT_LINK,',
'            p_view_what         => :P_NOMENCLATURE_PROJECT,',
'            p_title             => :V_EMAIL_SUBJECT,',
'            p_email_contents    => :V_EMAIL_BODY,',
'            p_notification_type => ''APPROVAL'' );',
'    end if;',
'end loop;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":250,"y":1370},"z":9}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397200793493854560)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Grab data for Rejection Notif'
,p_static_id=>'grab-data-for-rejection'
,p_display_sequence=>100
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
':V_EMAIL_SUBJECT := :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' Rejected for ''||:P_APPROVAL_TYPE;',
'',
'for c1 in (',
'    select comments',
'      from sp_project_approval_chain',
'     where project_approval_id = :P_PROJECT_APPROVAL_ID',
'       and status = ''REJECTED''',
'       and final_yn = ''Y''',
') loop',
'    :V_EMAIL_BODY := :P_NOMENCLATURE_PROJECT||'' ''||:P_PROJECT_NAME||'' was just rejected for ''||:P_APPROVAL_TYPE||''.<br/>''||',
'                      ''Comments: ''|| c1.comments;',
'end loop;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":1130,"y":1110},"z":10}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397201057657854562)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'Notify about Rejection'
,p_static_id=>'rejection-notif'
,p_display_sequence=>110
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.assignment_notification (',
'    p_team_member_id    => :P_SUBMITTER_TM_ID,',
'    p_app_name          => :P_APP_NAME,',
'    p_app_id            => :P_APP_ID,',
'    p_project_id        => :P_PROJECT_ID,',
'    p_link              => :P_PROJECT_LINK,',
'    p_view_what         => :P_NOMENCLATURE_PROJECT,',
'    p_title             => :V_EMAIL_SUBJECT,',
'    p_email_contents    => :V_EMAIL_BODY,',
'    p_notification_type => ''APPROVAL'' );'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":1140,"y":1240},"z":11}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(18397201258848854564)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_name=>'End'
,p_static_id=>'New_2'
,p_display_sequence=>120
,p_activity_type=>'NATIVE_WORKFLOW_END'
,p_attribute_01=>'COMPLETED'
,p_diagram=>'{"position":{"x":1210,"y":1370},"z":12}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(17885009081637678874)
,p_name=>'Submit Request'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(17885008968366678873)
,p_to_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_diagram=>'{"source":{"name":"topLeft","args":{"dx":"66.667%","dy":"50%","rotate":true}},"target":{},"vertices":[],"z":13,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(17885009277828678876)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_to_activity_id=>wwv_flow_imp.id(18397197981419854531)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":14,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397198064596854532)
,p_name=>'another review'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(18397197981419854531)
,p_to_activity_id=>wwv_flow_imp.id(18397198244798854534)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":22,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397198175621854533)
,p_name=>'no more reviews'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(18397197981419854531)
,p_to_activity_id=>wwv_flow_imp.id(18397200154653854553)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{"name":"bottom","args":{"dx":0,"dy":-10}},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":23,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397198314075854535)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397198244798854534)
,p_to_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":15,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397198539290854537)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397198403688854536)
,p_to_activity_id=>wwv_flow_imp.id(18397199871976854550)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"50.003%","dy":"66.66%","rotate":true}},"vertices":[],"z":16,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397199947687854551)
,p_name=>'Rejected'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(18397199871976854550)
,p_to_activity_id=>wwv_flow_imp.id(18397200793493854560)
,p_condition_type=>'EQUALS'
,p_condition_expr1=>'REJECTED'
,p_diagram=>'{"source":{"name":"bottom","args":{"dx":0,"dy":-10}},"target":{},"vertices":[],"z":24,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397200058793854552)
,p_name=>'Approved'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(18397199871976854550)
,p_to_activity_id=>wwv_flow_imp.id(17885009118234678875)
,p_condition_type=>'EQUALS'
,p_condition_expr1=>'APPROVED'
,p_diagram=>'{"source":{"name":"topLeft","args":{"dx":"50.003%","dy":"0.019%","rotate":true}},"target":{"name":"topLeft","args":{"dx":"100%","dy":"33.333%","rotate":true}},"vertices":[{"x":1250,"y":870},{"x":530,"y":870}],"z":25,"label":{"distance":0.5,"offset":0'
||'}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397200201750854554)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397200154653854553)
,p_to_activity_id=>wwv_flow_imp.id(18397200465351854556)
,p_diagram=>'{"source":{"name":"topLeft","args":{"dx":"50%","dy":"83.333%","rotate":true}},"target":{},"vertices":[],"z":17,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397200571668854557)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397200465351854556)
,p_to_activity_id=>wwv_flow_imp.id(18397200676804854558)
,p_diagram=>'{"source":{"name":"bottom","args":{"dx":0,"dy":-10}},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":18,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397200717234854559)
,p_name=>'Send Approval'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397200676804854558)
,p_to_activity_id=>wwv_flow_imp.id(18397201258848854564)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"16.667%","dy":"66.667%","rotate":true}},"vertices":[],"z":19,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397200948493854561)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397200793493854560)
,p_to_activity_id=>wwv_flow_imp.id(18397201057657854562)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":20,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(18397201139193854563)
,p_name=>'Send Rejection Email'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(18397201057657854562)
,p_to_activity_id=>wwv_flow_imp.id(18397201258848854564)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"66.667%","dy":"50%","rotate":true}},"vertices":[],"z":21,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_participant(
 p_id=>wwv_flow_imp.id(18397202465005854576)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_participant_type=>'ADMIN'
,p_name=>'admin query'
,p_identity_type=>'USER'
,p_value_type=>'SQL_QUERY'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select user_name_lc',
'  from APEX_APPL_ACL_USERS',
' where APPLICATION_ID = :APP_ID',
'   and role_names = ''Administrator'''))
);
wwv_flow_imp_shared.create_workflow_participant(
 p_id=>wwv_flow_imp.id(18397202489427854577)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_participant_type=>'OWNER'
,p_name=>'owner'
,p_identity_type=>'USER'
,p_value_type=>'SQL_QUERY'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(user_name_lc)',
'  from APEX_APPL_ACL_USERS',
' where APPLICATION_ID = :APP_ID',
'   and role_names = ''Administrator'''))
);
wwv_flow_imp_shared.create_workflow_participant(
 p_id=>wwv_flow_imp.id(20634796872616428138)
,p_workflow_version_id=>wwv_flow_imp.id(17885008870396678872)
,p_participant_type=>'ADMIN'
,p_name=>'admin query upper'
,p_identity_type=>'USER'
,p_value_type=>'SQL_QUERY'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(user_name_lc)',
'  from APEX_APPL_ACL_USERS',
' where APPLICATION_ID = :APP_ID',
'   and role_names = ''Administrator'''))
);
wwv_flow_imp.component_end;
end;
/
