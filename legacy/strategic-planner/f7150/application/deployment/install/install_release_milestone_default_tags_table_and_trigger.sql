prompt --application/deployment/install/install_release_milestone_default_tags_table_and_trigger
begin
--   Manifest
--     INSTALL: INSTALL-release_milestone_default_tags table and trigger
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
 p_id=>wwv_flow_imp.id(31285755559565573524)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'release_milestone_default_tags table and trigger'
,p_sequence=>305
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_release_milestone_default_tags (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_release_milestone_default_tags_pk primary key,',
'    display_sequence               number            not null,',
'    tag                            varchar2(30 char) not null,',
'    description                    varchar2(512 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'alter table sp_release_milestone_default_tags ',
'    add constraint sp_release_milestone_default_tags_uk unique(tag);',
'',
'create or replace trigger sp_release_milestone_default_tags_biu',
'    before insert or update',
'    on sp_release_milestone_default_tags',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.tag := upper(:new.tag);',
'end sp_release_milestone_default_tags_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
