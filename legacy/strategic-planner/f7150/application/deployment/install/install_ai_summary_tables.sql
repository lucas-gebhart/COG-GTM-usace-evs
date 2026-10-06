prompt --application/deployment/install/install_ai_summary_tables
begin
--   Manifest
--     INSTALL: INSTALL-ai summary tables
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
 p_id=>wwv_flow_imp.id(31604219652309972630)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'ai summary tables'
,p_sequence=>735
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_ai_summaries (',
'   id                 number  default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                          constraint sp_project_ai_summaries_pk primary key,',
'   --',
'   project_id         number constraint sp_project_ai_summaries_proj_fk',
'                                   references sp_projects on delete cascade,',
'   summary_type       varchar2(30),  -- full or update',
'   prompt_sent        clob, ',
'   details_sent       clob,',
'   data_received      clob,',
'   --',
'   summary            clob,',
'   risk               varchar2(100),',
'   highlights         varchar2(4000),',
'   --',
'   created            date  default on null sysdate',
'   )',
'/',
'',
'create index sp_project_ai_summaries_i1 on sp_project_ai_summaries (project_id);',
'create index sp_project_ai_summaries_i2 on sp_project_ai_summaries (created);',
'',
'',
'create table sp_release_ai_summaries (',
'   id                 number  default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                          constraint sp_release_ai_summaries_pk primary key,',
'   --',
'   release_id         number constraint sp_release_ai_summaries_rel_fk',
'                                   references sp_release_trains on delete cascade,',
'   prompt_sent        clob, ',
'   details_sent       clob,',
'   data_received      clob,',
'   --',
'   summary            clob,',
'   highlights         varchar2(4000),',
'   --',
'   created            date  default on null sysdate',
'   )',
'/',
'',
'create index sp_release_ai_summaries_i1 on sp_release_ai_summaries (release_id);',
'create index sp_release_ai_summaries_i2 on sp_release_ai_summaries (created);'))
);
wwv_flow_imp.component_end;
end;
/
