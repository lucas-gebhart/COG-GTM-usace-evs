prompt --application/deployment/install/install_configurable_text_table
begin
--   Manifest
--     INSTALL: INSTALL-configurable_text table
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
 p_id=>wwv_flow_imp.id(39189522287868101678)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'configurable_text table'
,p_sequence=>630
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_CONFIGURABLE_TEXT (',
'    id                   number default on null to_number(sys_guid(), ''xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'') not null, ',
'    config_ID            varchar2(50 char) not null,',
'    description          varchar2(4000 char) not null,',
'    --',
'    configurable_content clob,',
'    --',
'    created              date not null, ',
'    created_by           varchar2(255 char) not null, ',
'    updated              date not null, ',
'    updated_by           varchar2(255 char) not null',
'    ) ',
';',
'',
'create or replace trigger sp_configurable_text_biu',
'    before insert or update',
'    on SP_CONFIGURABLE_TEXT',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end sp_configurable_text_biu;',
'/',
'',
'begin',
'insert into SP_CONFIGURABLE_TEXT (id, config_ID, description) values (1, ''ABOUT-PRIMARY-TEXT'',''Primary text displayed on application about page.'');',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
