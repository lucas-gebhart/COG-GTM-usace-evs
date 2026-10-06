prompt --application/deployment/install/install_external_system_names
begin
--   Manifest
--     INSTALL: INSTALL-external system names
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
 p_id=>wwv_flow_imp.id(41354903907449581401)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'external system names'
,p_sequence=>340
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_EXTERNAL_TICKETING_SYSTEMS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_EXTERNAL_TICKETING_SYS_PK primary key,',
'    --',
'    external_system_name           varchar2(30 char)   not null,',
'    description                    varchar2(4000 char),',
'    is_active_yn                   varchar2(1 char)    not null,',
'    link_pattern                   varchar2(4000 char) not null,',
'    min_id_length                  integer,',
'    max_id_length                  integer,',
'    --',
'    must_contain                   varchar2(255 char),',
'    ticket_id_regex                varchar2(255 char) not null,',
'    evaulation_sequence            number,',
'    --',
'    required_initiative_id         number',
'                                   constraint sp_external_ticketing_system_ini_fk ',
'                                   references sp_initiatives (id)',
'                                   on delete cascade,',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'',
'create or replace trigger SP_EXTERNAL_TICKETING_SYSTEMS_biu',
'    before insert or update',
'    on SP_EXTERNAL_TICKETING_SYSTEMS',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    -- default values',
'    --',
'    if :new.evaulation_sequence is null then',
'       :new.evaulation_sequence := 100;',
'    end if;',
'    if :new.is_active_yn is null then',
'       :new.is_active_yn := ''N'';',
'    end if;',
'end SP_EXTERNAL_TICKETING_SYSTEMS_biu;',
'/',
'',
''))
);
wwv_flow_imp.component_end;
end;
/
