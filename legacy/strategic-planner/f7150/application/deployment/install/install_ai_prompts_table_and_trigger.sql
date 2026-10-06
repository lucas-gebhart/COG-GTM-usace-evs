prompt --application/deployment/install/install_ai_prompts_table_and_trigger
begin
--   Manifest
--     INSTALL: INSTALL-ai_prompts table and trigger
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
 p_id=>wwv_flow_imp.id(27805009561242890514)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'ai_prompts table and trigger'
,p_sequence=>75
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_ai_prompts (',
'    id                             number ',
'                                      default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                      constraint sp_ai_prompts_pk primary key,',
'    --',
'    static_id                      varchar2(255)  not null',
'                                      constraint sp_ai_prompts_uk unique,',
'    description                    varchar2(4000) not null,',
'    prompt                         clob,',
'    --',
'    created                        date            not null,',
'    created_by                     varchar2(255)   not null,',
'    updated                        date            not null,',
'    updated_by                     varchar2(255)   not null',
');',
'',
'create or replace trigger sp_ai_prompts_biu',
'    before insert or update ',
'    on sp_ai_prompts',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated    := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.static_id  := upper(:new.static_id);',
'end sp_ai_prompts_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
