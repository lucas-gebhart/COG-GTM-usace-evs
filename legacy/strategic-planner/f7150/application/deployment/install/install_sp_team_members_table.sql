prompt --application/deployment/install/install_sp_team_members_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_team_members table
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
 p_id=>wwv_flow_imp.id(38667820956390404949)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_team_members table'
,p_sequence=>130
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_team_members (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_team_members_id_pk primary key,',
'    first_name                     varchar2(255 char) not null,',
'    last_name                      varchar2(255 char) not null,',
'    initials                       varchar2(3 char)   not null,',
'    screen_name                    varchar2(50 char),',
'    email                          varchar2(255 char) not null,',
'    email_domain                   varchar2(255 char),',
'    notification_pref              varchar2(255 char), -- colon separated list of APP, EMAIL, TEXT, SLACK',
'    comment_notif_pref             varchar2(255 char), -- colon separated list of APP, EMAIL, TEXT, SLACK',
'    tags                           varchar2(4000 char),',
'    hash_tag_reference             varchar2(30 char),',
'    --',
'    photo                          blob,',
'    photo_filename                 varchar2(512 char),',
'    photo_mimetype                 varchar2(512 char),',
'    photo_charset                  varchar2(512 char),',
'    photo_lastupd                  date,',
'    --',
'    is_current_yn                  varchar2(1 char) constraint sp_team_members_is_current_ck',
'                                   check (is_current_yn in (''Y'',''N'')),',
'    auto_created_yn                varchar2(1 char) constraint sp_team_members_auto_cr_ck',
'                                   check (auto_created_yn in (''Y'',''N'')),',
'    location                       varchar2(500 char),',
'    country_id                     number,',
'    --',
'    app_role                       varchar2(255 char), -- derived',
'    --',
'    competencies                   varchar2(4000 char),',
'    --',
'    -- audit columns',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index sp_team_members_u1 on sp_team_members (email);',
'create unique index sp_team_members_u2 on sp_team_members (hash_tag_reference);',
'create unique index sp_team_members_u4 on sp_team_members (screen_name);',
'create index sp_team_members_i1 on sp_team_members (country_id);',
''))
);
wwv_flow_imp.component_end;
end;
/
