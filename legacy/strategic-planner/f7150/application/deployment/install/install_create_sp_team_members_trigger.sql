prompt --application/deployment/install/install_create_sp_team_members_trigger
begin
--   Manifest
--     INSTALL: INSTALL-create sp_team_members trigger
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
 p_id=>wwv_flow_imp.id(41436917428779286775)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'create sp_team_members trigger'
,p_sequence=>400
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_team_members_biu',
'    before insert or update',
'    on sp_team_members',
'    for each row',
'declare',
'    b integer := 0; -- first dot occurrance',
'    e integer := 0; -- first at sign occurrance',
'    l integer := 0; -- length between dot and at sign',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.email := lower(:new.email);',
'    --',
'    :new.screen_name := lower(:new.screen_name);',
'    --',
'    if :new.is_current_yn is null then',
'       :new.is_current_yn := ''Y'';',
'    end if;',
'    b := instr(:new.email,''.'');',
'    e := instr(:new.email,''@'');',
'    --',
'    :new.email_domain := substr(:new.email,e+1);',
'    --',
'    if e > 2 and b > 1 and :new.first_name is null and :new.last_name is null then',
'       l := (e - b) - 1;',
'       if b < e and l > 0 then',
'           :new.first_name := initcap(substr(:new.email,1,b-1));',
'           :new.last_name  := initcap(substr(:new.email,b+1,l));',
'       end if;',
'    end if;',
'    if :new.initials is null and :new.first_name is not null and :new.last_name is not null then',
'        :new.initials := nvl(substr(:new.first_name,1,1)||substr(:new.last_name,1,1),''X'');',
'    end if;',
'    if :new.initials is null then',
'       :new.initials := ''AA'';',
'    end if;',
'    if :new.first_name is null then ',
'       :new.first_name := ''unknown'';',
'    end if;',
'    if :new.last_name is null then',
'       :new.last_name := ''unknown'';',
'    end if;',
'    --',
'    -- tags',
'    --',
'    :new.tags := upper(:new.tags);',
'',
'end sp_team_members_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
