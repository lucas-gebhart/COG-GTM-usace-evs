prompt --application/deployment/install/install_sp_groups_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_groups table
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
 p_id=>wwv_flow_imp.id(45806618445158942495)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_groups table'
,p_sequence=>120
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_GROUPS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_GROUPS_pk primary key,',
'    --',
'    group_name                     varchar2(100  char) not null,',
'    group_name_upper               varchar2(100  char) not null,',
'    description                    varchar2(4000 char),',
'    group_tag                      varchar2(100 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index SP_GROUPS_i1 on SP_GROUPS (group_name_upper);'))
);
wwv_flow_imp.component_end;
end;
/
