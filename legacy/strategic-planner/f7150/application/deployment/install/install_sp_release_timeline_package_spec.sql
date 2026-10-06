prompt --application/deployment/install/install_sp_release_timeline_package_spec
begin
--   Manifest
--     INSTALL: INSTALL-sp_release_timeline package spec
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
 p_id=>wwv_flow_imp.id(41458862346630206807)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_release_timeline package spec'
,p_sequence=>50
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package sp_release_timeline',
'as',
'',
'function show_week (',
'    p_release_id           in number,',
'    p_show_past_yn         in varchar2 default ''N'',',
'    p_exclude_complete_yn  in varchar2 default ''N'')',
'    return clob;',
'',
'function release_exceptions (',
'    p_release_id               in number,',
'    p_links                    in varchar2 default ''NONE'',',
'    p_apex_session             in varchar2 default null )',
'    return clob;',
'',
'end sp_release_timeline;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
