prompt --application/deployment/install/install_sp_project_links_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_project_links table
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
 p_id=>wwv_flow_imp.id(38668057745381798016)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_project_links table'
,p_sequence=>260
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_links (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_project_links_pk primary key,',
'    project_id                     number',
'                                   constraint sp_project_links_proj_fk',
'                                   references sp_projects on delete cascade,',
'    --',
'    link_name                      varchar2(255 char)   not null,',
'    link_url                       varchar2(4000 char) not null,',
'    important_yn                   varchar2(1 char) default on null ''N''',
'                                   constraint sp_project_links_imp_ck',
'                                   check (important_yn in (''Y'',''N'')),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'create index sp_project_links_i1 on sp_project_links (project_id);',
'create index sp_project_links_i2 on sp_project_links (updated);'))
);
wwv_flow_imp.component_end;
end;
/
