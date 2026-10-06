prompt --application/shared_components/logic/application_processes/set_app_home_url_if_null
begin
--   Manifest
--     APPLICATION PROCESS: set APP_HOME_URL (if null)
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
 p_id=>wwv_flow_imp.id(47649771759482523993)
,p_process_sequence=>1
,p_process_point=>'ON_NEW_INSTANCE'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set APP_HOME_URL (if null)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if sp_util.get_setting(p_static_id => ''APP_HOME_URL'') is null then',
'   sp_util.set_setting (p_static_id     => ''APP_HOME_URL'',   ',
'                        p_setting_value => APEX_UTIL.HOST_URL(''SCRIPT'')); ',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_version_scn=>45188591067853
);
wwv_flow_imp.component_end;
end;
/
