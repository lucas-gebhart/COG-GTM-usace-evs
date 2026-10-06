prompt --application/deployment/install/install_sp_default_people_tags_table
begin
--   Manifest
--     INSTALL: INSTALL-SP_DEFAULT_PEOPLE_TAGS table
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
 p_id=>wwv_flow_imp.id(40990329254424679827)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'SP_DEFAULT_PEOPLE_TAGS table'
,p_sequence=>640
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_DEFAULT_PEOPLE_TAGS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_DEFAULT_PEOPLE_TAGS_pk primary key,',
'    display_sequence               number             not null,',
'    tag                            varchar2(30 char)  not null,',
'    description                    varchar2(512 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index SP_DEFAULT_PEOPLE_TAGS_u1 on SP_DEFAULT_PEOPLE_TAGS (tag);'))
);
wwv_flow_imp.component_end;
end;
/
