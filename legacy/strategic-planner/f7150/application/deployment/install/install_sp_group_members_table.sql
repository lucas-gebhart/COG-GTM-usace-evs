prompt --application/deployment/install/install_sp_group_members_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_group_members table
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
 p_id=>wwv_flow_imp.id(45887965336285784633)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_group_members table'
,p_sequence=>140
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_GROUP_MEMBERS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_GROUP_MEMBERS_pk primary key,',
'    --',
'    group_id                       number not null',
'                                   constraint SP_GROUPS_FK',
'                                   references SP_GROUPS (id),',
'    team_member_id                 number not null',
'                                   constraint sp_team_group_members_tmfk',
'                                   references sp_team_members(id),',
'    assignment                     varchar2(255 char),',
'    full_time_yn                   varchar2(1 char),',
'    group_leader_yn                varchar2(1 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create index SP_GROUP_MEMBERS_i1 on SP_GROUP_MEMBERS (group_id);',
'create unique index SP_GROUP_MEMBERS_u1 on SP_GROUP_MEMBERS (team_member_id, group_id);'))
);
wwv_flow_imp.component_end;
end;
/
