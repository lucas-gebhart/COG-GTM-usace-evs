prompt --application/deployment/install/install_sp_summary_util_spec
begin
--   Manifest
--     INSTALL: INSTALL-sp_summary_util spec
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
 p_id=>wwv_flow_imp.id(27820364884267309044)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_summary_util spec'
,p_sequence=>57
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package sp_summary_util as',
'',
'g_hrs_to_replace  number := 6;',
'',
'function ai_summary_info (',
'    p_type  in  varchar2 )',
'    return clob;',
'',
'-- can be run from APEX App UI (not SQL Commands) ',
'--  or from within a job (if session context is set)',
'procedure generate_project_summary (',
'    p_project_id    in   number,',
'    p_summary_type  in   varchar2,',
'    p_ai_id         out  number,',
'    p_error_yn      out  varchar2 );',
'',
'-- run as a job, once a week (cannot be run via SQL Commands)',
'procedure generate_project_summaries;',
'',
'-- TEMP - WILL BE REMOVED',
'procedure summarize_release (',
'    p_release_id  in   number,',
'    p_summary     out  clob );',
'',
'-- can be run from APEX App UI (not SQL Commands) or from within a job (if session context is set)',
'procedure generate_release_summary (',
'    p_release_id    in   number,',
'    p_error_yn      out  varchar2 );',
'',
'',
'end sp_summary_util;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
