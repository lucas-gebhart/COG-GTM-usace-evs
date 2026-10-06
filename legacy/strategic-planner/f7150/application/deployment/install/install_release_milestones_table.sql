prompt --application/deployment/install/install_release_milestones_table
begin
--   Manifest
--     INSTALL: INSTALL-release milestones table
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
 p_id=>wwv_flow_imp.id(45057971276927902842)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'release milestones table'
,p_sequence=>300
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_release_milestones (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_release_milestone_pk primary key,',
'    --',
'    release_id                     number not null',
'                                   constraint sp_rel_milestone_to_release_fk ',
'                                   references SP_RELEASE_TRAINS (id)',
'                                   on delete cascade,',
'    milestone_name                 varchar2(255 char) not null,',
'    upper_milestone_name           varchar2(255 char) not null,',
'    milestone_type_id              number ',
'                                   constraint sp_rel_milestones_type_fk ',
'                                   references sp_release_milestone_types (id),',
'    milestone_start_date           date,',
'    milestone_date                 date not null,',
'    original_milestone_date        date,',
'    milestone_completed_yn         varchar2(1 char) default on null ''N'',',
'    milestone_description          varchar2(4000 char),',
'    tags                           varchar2(4000),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'create unique index sp_release_milestones_i1 on sp_release_milestones (upper_milestone_name, release_id, milestone_type_id);'))
);
wwv_flow_imp.component_end;
end;
/
