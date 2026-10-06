prompt --application/deployment/install/install_sp_notifications_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_notifications table
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
 p_id=>wwv_flow_imp.id(40986068509065963668)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_notifications table'
,p_sequence=>360
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_NOTIFICATIONS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_notifications_id_pk primary key,',
'',
'    name                           varchar2(150 char)  not null,',
'    static_id                      varchar2(30 char)   not null,',
'    description                    varchar2(4000 char) not null,',
'    is_active_yn                   varchar2(1 char)    not null,',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index sp_notifications_u1 on sp_notifications(name);',
'',
'',
'create or replace trigger sp_notifications_biu',
'    before insert or update',
'    on sp_notifications',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.static_id := upper(:new.static_id);',
'end sp_notifications_biu;',
'/',
''))
);
wwv_flow_imp.component_end;
end;
/
