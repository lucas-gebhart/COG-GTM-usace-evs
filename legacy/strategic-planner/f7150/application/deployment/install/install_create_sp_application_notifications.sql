prompt --application/deployment/install/install_create_sp_application_notifications
begin
--   Manifest
--     INSTALL: INSTALL-create SP_APPLICATION_NOTIFICATIONS
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
 p_id=>wwv_flow_imp.id(41354801532966956757)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'create SP_APPLICATION_NOTIFICATIONS'
,p_sequence=>660
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_APPLICATION_NOTIFICATIONS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_APPLICATION_NOTIFICATIONS_PK primary key,',
'    notification_name              varchar2(128 char)   not null,',
'    notification_description       varchar2(4000 char),',
'    is_active_yn                   varchar2(1 char)    not null,',
'    required_user_tag              varchar2(30 char),',
'    from_date                      date,',
'    to_date                        date,',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index SP_APPLICATION_NOTIFICATIONS_U1 on SP_APPLICATION_NOTIFICATIONS(notification_name);',
'',
'',
'create or replace trigger SP_APPLICATION_NOTIFICATIONS_biu',
'    before insert or update',
'    on SP_APPLICATION_NOTIFICATIONS',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end SP_APPLICATION_NOTIFICATIONS_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
