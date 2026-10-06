prompt --application/deployment/install/install_sp_resource_types_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_resource_types table
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
 p_id=>wwv_flow_imp.id(38667772054455394695)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_resource_types table'
,p_sequence=>100
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_resource_types (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_resource_types_id_pk primary key,',
'    resource_type                  varchar2(50 char) not null,',
'    upper_resource_type            varchar2(50 char) not null,',
'    resource_description           varchar2(4000 char),',
'    is_default_yn                  varchar2(1 char)',
'                                   constraint sp_res_t_is_default_ck ',
'                                   check (is_default_yn in (''Y'',''N'')),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index sp_resource_types_u1 on sp_resource_types (resource_type);',
'create unique index sp_resource_types_u2 on sp_resource_types (upper_resource_type);'))
);
wwv_flow_imp.component_end;
end;
/
