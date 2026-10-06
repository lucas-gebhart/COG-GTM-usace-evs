prompt --application/shared_components/logic/application_processes/set_navigation_strings
begin
--   Manifest
--     APPLICATION PROCESS: set navigation strings
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(151948151791668981746)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set navigation strings'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':FOCUS_AREA := ''Focus Areas'';',
':INITIATIVE := ''Initiatives'';',
':PROJECT := ''Projects'';'))
,p_process_clob_language=>'PLSQL'
,p_version_scn=>1
);
wwv_flow_imp.component_end;
end;
/
