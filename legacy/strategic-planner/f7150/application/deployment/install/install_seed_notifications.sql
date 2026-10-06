prompt --application/deployment/install/install_seed_notifications
begin
--   Manifest
--     INSTALL: INSTALL-seed notifications
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
 p_id=>wwv_flow_imp.id(40990505405611320712)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed notifications'
,p_sequence=>870
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_NOTIFICATIONS ( ID, name, static_id, description, is_active_YN ) ',
'    values (1, ''My Weekly Summary'', ''WEEKLY_SUMMARY'', ''Weekly user projects and activities summary.'',''Y'');',
'insert into SP_NOTIFICATIONS ( ID, name, static_id, description, is_active_YN ) ',
'    values (2, ''Release Exceptions'', ''RELEASE_EXCEPTIONS'', ''Weekly review of exceptions for a selected release.'',''Y'');',
'insert into SP_NOTIFICATIONS ( ID, name, static_id, description, is_active_YN ) ',
'    values (3, ''My Project Exceptions'', ''PROJECT_EXCEPTIONS'', ''Weekly report of exceptions within projects the user is associated with.'',''Y''); ',
'insert into SP_NOTIFICATIONS ( ID, name, static_id, description, is_active_YN ) ',
'    values (4, ''My Project Changes'', ''PROJECT_CHANGES'', ''Report of changes to projects you own or have favorited.'',''Y''); '))
);
wwv_flow_imp.component_end;
end;
/
