prompt --application/deployment/install/install_sp_initiatives_tables
begin
--   Manifest
--     INSTALL: INSTALL-sp_initiatives tables
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
 p_id=>wwv_flow_imp.id(38667881896468416821)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_initiatives tables'
,p_sequence=>190
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_initiatives (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_initiatives_id_pk primary key,',
'    area_id                        number not null',
'                                   constraint sp_initiatives_focus_area_i_fk',
'                                   references sp_areas on delete cascade,',
'    initiative                     varchar2(255 char) not null,',
'    objective                      varchar2(4000 char),',
'    sponsor_ID                     number',
'                                   constraint sp_initiatives_sponsor_fk',
'                                   references sp_team_members,',
'    --',
'    friendly_identifier            varchar2(30), ',
'    initiative_url_name            varchar2(255),',
'    --',
'    status_scale                   varchar2(1) ',
'                                   constraint sp_initiative_status_scale_ck',
'                                   check (status_scale in (''A'',''B'',''C'',''D'',''E'')),',
'    --',
'    tags                           varchar2(4000 char),',
'    hidden_by_default_yn           varchar2(1 char),',
'    --',
'    image                          blob,',
'    image_name                     varchar2(512 char),',
'    image_mimetype                 varchar2(512 char),',
'    image_last_updated             date,',
'    --',
'    -- Archived, soft delete',
'    --',
'    archived_yn                    varchar2(1 char)',
'                                   constraint sp_initiatives_archived_ck',
'                                   check (archived_yn in (''Y'',''N'')),',
'    archived_date                  date,',
'    archived_by                    varchar2(255 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create index sp_initiatives_i1 on sp_initiatives (area_id);',
'create index sp_initiatives_i2 on sp_initiatives (sponsor_ID);',
'create index sp_initiatives_i3 on sp_initiatives (status_scale);',
'create unique index sp_initiatives_u1 on sp_initiatives (area_id, initiative);',
'',
'alter table sp_initiatives add constraint sp_initiatives_scale_fk ',
'            foreign key (status_scale) references sp_project_scales;',
'',
'create table sp_initiative_history (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_initiative_history_pk primary key,',
'    initiative_id                  number  not null,',
'    --',
'    attribute_column               varchar2(255 char) not null, ',
'    change_type                    varchar2(30 char)  not null',
'                                   constraint sp_initiative_history_type_cc ',
'                                   check (change_type in (''CREATE'',''UPDATE'',''DELETE'')),',
'    old_value                      varchar2(4000 char),',
'    new_value                      varchar2(4000 char),',
'    old_value_clob                 clob,',
'    new_value_clob                 clob,',
'    --',
'    changed_on                     date  not null,',
'    changed_by                     varchar2(255 char)',
');',
'',
'create index sp_initiative_history_i1 on sp_initiative_history (initiative_id);',
'create index sp_initiative_history_i2 on sp_initiative_history (changed_by);'))
);
wwv_flow_imp.component_end;
end;
/
