prompt --application/deployment/install/install_sp_activities_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_activities table
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
 p_id=>wwv_flow_imp.id(50992673021633943639)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_activities table'
,p_sequence=>570
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_activities (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_activities_pk ',
'                                   primary key,',
'    --',
'    activity_type_id               number ',
'                                   constraint sp_activities_type_fk',
'                                   references sp_activity_types (id),',
'    project_id                     number ',
'                                   constraint sp_activities_project_fk',
'                                   references sp_projects (id),',
'    team_member_id                 number',
'                                   constraint sp_activities_person_fk',
'                                   references sp_team_members (id),',
'    initiative_id                  number',
'                                   constraint sp_activities_initiative_fk',
'                                   references sp_initiatives (id),',
'    --',
'    start_date                     date not null,',
'    end_date                       date not null,',
'    comments                       varchar2(4000 char),',
'    ticket_number                  varchar2(50 char),',
'    url                            varchar2(500 char),',
'    activity_status                varchar2(30 char),',
'    --',
'    tags                           varchar2(4000 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create index sp_activities_i1 on sp_activities (activity_type_id);',
'create index sp_activities_i2 on sp_activities (project_id);',
'create index sp_activities_i3 on sp_activities (team_member_id);',
'create index sp_activities_i4 on sp_activities (end_date);',
'create index sp_activities_i5 on sp_activities (start_date);',
'create index sp_activities_i6 on sp_activities (initiative_id);'))
);
wwv_flow_imp.component_end;
end;
/
