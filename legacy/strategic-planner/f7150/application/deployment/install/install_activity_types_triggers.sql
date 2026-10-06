prompt --application/deployment/install/install_activity_types_triggers
begin
--   Manifest
--     INSTALL: INSTALL-activity_types triggers
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
 p_id=>wwv_flow_imp.id(50992521043921899257)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'activity_types triggers'
,p_sequence=>560
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_activity_types_biu',
'    before insert or update',
'    on sp_activity_types',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    if :new.is_active_yn is null then',
'       :new.is_active_yn := ''Y'';',
'    end if;',
'    --',
'    -- history',
'    --',
'    if inserting then',
'        insert into sp_app_log',
'            (activity, details)',
'        values',
'            (''Added Activity Type'' , :new.activity_type);',
'    elsif updating then',
'        if not sp_value_compare.is_equal(:old.activity_type,:new.activity_type) then',
'            insert into sp_app_log',
'                (activity, details)',
'            values',
'                (''Updated Activity Type'' , ''Changed "''||:old.activity_type ||''" to "''||:new.activity_type||''"'');',
'        end if;',
'        if not sp_value_compare.is_equal(:old.STATIC_ID,:new.STATIC_ID) then',
'            insert into sp_app_log',
'                (activity, details)',
'            values',
'                (''Updated Activity Type'' , :new.activity_type||'': changed STATIC_ID from "''||:old.STATIC_ID||''" to "''||:new.STATIC_ID||''"'');',
'        end if; ',
'        if not sp_value_compare.is_equal(:old.IS_PROJECT_YN,:new.IS_PROJECT_YN) then',
'            insert into sp_app_log',
'                (activity, details)',
'            values',
'                (''Updated Activity Type'' , :new.activity_type||'': changed IS_PROJECT from "''||:old.IS_PROJECT_YN||''" to "''||:new.IS_PROJECT_YN||''"'');',
'        end if;        ',
'        if not sp_value_compare.is_equal(:old.IS_DEFAULT_YN,:new.IS_DEFAULT_YN) then',
'            insert into sp_app_log',
'                (activity, details)',
'            values',
'                (''Updated Activity Type'' , :new.activity_type||'': changed IS_DEFAULT from "''||:old.IS_DEFAULT_YN||''" to "''||:new.IS_DEFAULT_YN||''"'');',
'        end if;   ',
'        if not sp_value_compare.is_equal(:old.IS_ACTIVE_YN,:new.IS_ACTIVE_YN) then',
'            insert into sp_app_log',
'                (activity, details)',
'            values',
'                (''Updated Activity Type'' , :new.activity_type||'': changed IS_ACTIVE from "''||:old.IS_ACTIVE_YN||''" to "''||:new.IS_ACTIVE_YN||''"'');',
'        end if;       ',
'    end if;',
'end sp_activity_types_biu;',
'/',
'',
'create or replace trigger sp_activity_types_bd',
'    before delete',
'    on sp_activity_types',
'    for each row',
'begin',
'    insert into sp_app_log',
'        (activity, details)',
'    values',
'        (''Deleted Activity Type'', :old.activity_type);',
'end sp_activity_types_bd;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
