prompt --application/deployment/install/install_activity_types_table
begin
--   Manifest
--     INSTALL: INSTALL-activity types table
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
 p_id=>wwv_flow_imp.id(50992513714056896204)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'activity types table'
,p_sequence=>550
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_activity_types (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_activity_types_pk primary key,',
'    --',
'    display_sequence               number not null,',
'    activity_type                  varchar2(50 char) not null,',
'    activity_type_description      varchar2(4000 char),',
'    is_project_yn                  varchar2(1 char),',
'    static_id                      varchar2(30 char),',
'    is_default_yn                  varchar2(1 char),',
'    is_active_yn                   varchar2(1 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';'))
);
wwv_flow_imp.component_end;
end;
/
