prompt --application/deployment/install/install_seed_project_statuses
begin
--   Manifest
--     INSTALL: INSTALL-seed project statuses
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
 p_id=>wwv_flow_imp.id(26241403208352066253)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed project statuses'
,p_sequence=>815
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into sp_project_statuses (ID, STATUS, STATIC_ID, INCLUDE_YN, DISPLAY_SEQ) ',
'    values (1, ''On Track'', ''ON-TRACK'', ''Y'', 1);',
'insert into sp_project_statuses (ID, STATUS, STATIC_ID, INCLUDE_YN, DISPLAY_SEQ) ',
'    values (2, ''At Risk'', ''AT-RISK'', ''Y'', 2);',
'insert into sp_project_statuses (ID, STATUS, STATIC_ID, INCLUDE_YN, DISPLAY_SEQ) ',
'    values (4, ''Paused'', ''PAUSED'', ''Y'', 4);',
'insert into sp_project_statuses (ID, STATUS, STATIC_ID, INCLUDE_YN, DISPLAY_SEQ) ',
'    values (5, ''Blocked'', ''BLOCKED'', ''Y'', 5);'))
);
wwv_flow_imp.component_end;
end;
/
