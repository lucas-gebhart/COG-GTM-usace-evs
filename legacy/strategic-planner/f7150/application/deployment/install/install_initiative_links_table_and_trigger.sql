prompt --application/deployment/install/install_initiative_links_table_and_trigger
begin
--   Manifest
--     INSTALL: INSTALL-INITIATIVE_LINKS table and trigger
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
 p_id=>wwv_flow_imp.id(41624791985210862950)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'INITIATIVE_LINKS table and trigger'
,p_sequence=>690
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_INITIATIVE_LINKS (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_initiative_links_PK primary key,',
'    initiative_id                  number ',
'                                   constraint sp_initiative_links_to_int_fk',
'                                   references sp_initiatives (id)',
'                                   on delete cascade,',
'    link_name                      varchar2(255 char)   not null,',
'    link_url                       varchar2(4000 char),',
'    important_yn                   varchar2(1 char) default on null ''N''',
'                                   constraint sp_initiative_links_imp_ck',
'                                   check (important_yn in (''Y'',''N'')),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create index SP_INITIATIVE_LINKS_i1 on SP_INITIATIVE_LINKS(initiative_id);',
'create unique index SP_INITIATIVE_LINKS_U1 on SP_INITIATIVE_LINKS(initiative_id,link_name);',
'create unique index SP_INITIATIVE_LINKS_U2 on SP_INITIATIVE_LINKS(initiative_id, LINK_URL);',
'',
'',
'create or replace trigger SP_INITIATIVE_LINKS_biu',
'    before insert or update',
'    on SP_INITIATIVE_LINKS',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'   --',
'   -- touch parent table',
'   --',
'   update sp_initiatives set updated = sysdate, updated_by = :new.updated_by where id = :new.initiative_id;',
'end SP_INITIATIVE_LINKS_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
