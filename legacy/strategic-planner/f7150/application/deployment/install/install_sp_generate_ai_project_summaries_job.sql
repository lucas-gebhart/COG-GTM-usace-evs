prompt --application/deployment/install/install_sp_generate_ai_project_summaries_job
begin
--   Manifest
--     INSTALL: INSTALL-SP_GENERATE_AI_PROJECT_SUMMARIES_JOB
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
 p_id=>wwv_flow_imp.id(31604004190480892527)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'SP_GENERATE_AI_PROJECT_SUMMARIES_JOB'
,p_sequence=>915
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- weekly, Sunday morning at 5am',
'begin',
'    dbms_scheduler.create_job (',
'        job_name   => ''SP_GENERATE_AI_PROJECT_SUMMARIES_JOB'',',
'        job_type   => ''STORED_PROCEDURE'',',
'        job_action => ''sp_summary_util.generate_project_summaries'',',
'        start_date => null,',
'        repeat_interval => ''FREQ=WEEKLY; BYTIME=050000; BYDAY=SUN'',',
'        enabled    => TRUE,',
'        auto_drop  => FALSE,',
'        comments   => ''Creates AI Summaries of active projects once a week'' );',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
