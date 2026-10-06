prompt --application/deployment/install/install_sp_group_members_trigger
begin
--   Manifest
--     INSTALL: INSTALL-SP_GROUP_MEMBERS trigger
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
 p_id=>wwv_flow_imp.id(45887838192322432154)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'SP_GROUP_MEMBERS trigger'
,p_sequence=>410
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger SP_GROUP_MEMBERS_biu',
'    before insert or update',
'    on SP_GROUP_MEMBERS',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end SP_GROUP_MEMBERS_biu;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
