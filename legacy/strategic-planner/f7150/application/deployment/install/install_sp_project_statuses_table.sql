prompt --application/deployment/install/install_sp_project_statuses_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_project_statuses table
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
 p_id=>wwv_flow_imp.id(53092802189939589470)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_project_statuses table'
,p_sequence=>215
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_statuses (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_project_statuses_pk primary key,',
'    --',
'    status                         varchar2(100 char) not null,',
'    static_id                      varchar2(30 char) not null,',
'    display_seq                    number,',
'    include_yn                     varchar2(1 char) ',
'                                   default on null ''Y''',
'                                   constraint sp_project_statuses_include_cc ',
'                                   check (include_yn in (''Y'',''N'')),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'create unique index sp_project_statuses_u1 on sp_project_statuses (status);',
'create unique index sp_project_statuses_u2 on sp_project_statuses (static_id);',
'',
'create or replace trigger sp_project_statuses_biu',
'    before insert or update',
'    on sp_project_statuses',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    :new.static_id := upper(:new.static_id);',
'end sp_project_statuses_biu;',
'/',
''))
);
wwv_flow_imp.component_end;
end;
/
