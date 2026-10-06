prompt --application/deployment/install/install_sp_project_priorities_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_project_priorities table
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
 p_id=>wwv_flow_imp.id(45803560078767555529)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_project_priorities table'
,p_sequence=>200
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_priorities (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_project_priority_id_pk primary key,',
'    priority                       number not null,',
'    description                    varchar2(40 char) not null,',
'    --',
'    is_default_yn                  varchar2(1 char)',
'                                   constraint sp_is_default_ck ',
'                                   check (is_default_yn in (''Y'',''N'')),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'',
'create unique index sp_project_priorities_u1 on sp_project_priorities (priority);'))
);
wwv_flow_imp.component_end;
end;
/
