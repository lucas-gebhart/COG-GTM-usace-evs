prompt --application/deployment/install/install_sp_app_settings
begin
--   Manifest
--     INSTALL: INSTALL-sp_app_settings
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
 p_id=>wwv_flow_imp.id(47920892769192146239)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_app_settings'
,p_sequence=>70
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_app_settings (',
'    id                             number ',
'                                      default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                      constraint sp_app_settings_pk primary key,',
'    --',
'    static_id                      varchar2(255)  not null',
'                                      constraint sp_app_settings_uk unique,',
'    description                    varchar2(4000) not null,',
'    setting_value                  varchar2(4000),',
'    is_numeric_yn                  varchar2(1)    not null    -- used in validation',
'                                      constraint sp_app_settings_is_numeric_cc',
'                                      check (is_numeric_yn in (''Y'',''N'')),',
'    is_yn                          varchar2(1)    not null    -- used in validation',
'                                      constraint sp_app_settings_is_yn_cc',
'                                      check (is_yn in (''Y'',''N'')),',
'    --',
'    created                        date            not null,',
'    created_by                     varchar2(255)   not null,',
'    updated                        date            not null,',
'    updated_by                     varchar2(255)   not null',
');',
'',
'create or replace trigger sp_app_settings_biu',
'    before insert or update ',
'    on sp_app_settings',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated    := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.static_id  := upper(:new.static_id);',
'end sp_app_settings_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
