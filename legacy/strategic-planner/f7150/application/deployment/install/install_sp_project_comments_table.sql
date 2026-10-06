prompt --application/deployment/install/install_sp_project_comments_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_project_comments table
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
 p_id=>wwv_flow_imp.id(38669223054247548818)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_project_comments table'
,p_sequence=>270
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_comments (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_project_comments_id_pk primary key,',
'    project_id                     number',
'                                   constraint sp_project_comm_proj_id_fk',
'                                   references sp_projects on delete cascade,',
'    body                           clob,',
'    body_html                      clob,',
'    body_no_images                 clob,',
'    image_ref_id                   number,',
'    private_yn                     varchar2(1 char)',
'                                   default on null ''Y''',
'                                   constraint sp_project_comm_private_ck',
'                                   check (private_yn in (''Y'',''N'')),',
'    author_id                      number,',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create index sp_project_comments_i1 on sp_project_comments (project_id);',
'create index sp_project_comments_i2 on sp_project_comments (author_id);',
'create index sp_project_comments_i3 on sp_project_comments (updated);',
'create index sp_project_comments_i4 on sp_project_comments (image_ref_id);',
'',
'create table sp_project_comments_emails (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_proj_comment_em_id_pk primary key,',
'    comment_id                     number',
'                                   constraint sp_proj_comment_em_id_fk',
'                                   references sp_project_comments (id)',
'                                   on delete cascade,',
'    email                          varchar2(255 char)',
');',
'',
'create index sp_project_comm_emails_i1 on sp_project_comments_emails (comment_id);',
'create index sp_project_comm_emails_i2 on sp_project_comments_emails (email);'))
);
wwv_flow_imp.component_end;
end;
/
