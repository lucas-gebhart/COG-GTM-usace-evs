prompt --application/deployment/install/install_project_links_triggers
begin
--   Manifest
--     INSTALL: INSTALL-project links triggers
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
 p_id=>wwv_flow_imp.id(38225998417294754233)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'project links triggers'
,p_sequence=>500
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_project_links_biu',
'    before insert or update',
'    on sp_project_links',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    -- touch parent table',
'    --',
'    update sp_projects set updated = sysdate, updated_by = :new.updated_by where id = :new.project_id;',
'    --',
'    -- history',
'    --',
'    if inserting then',
'       if :new.project_id is not null then',
'           insert into sp_project_history',
'               (project_id, attribute_column, change_type, new_value, changed_on, changed_by)',
'           values',
'               (:new.project_id, ''LINK'', ''CREATE'', :new.link_url, sysdate, lower(:new.created_by));',
'       elsif updating then',
'          if not sp_value_compare.is_equal(:old.link_url,:new.link_url) then',
'              insert into sp_project_history',
'                  (project_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)',
'              values',
'                  (:new.project_id, ''LINK'', ''UPDATE'', :old.link_url, :new.link_url, sysdate, lower(:new.updated_by));',
'          end if;',
'       end if;',
'    end if;',
'end sp_project_links_biu;',
'/',
'',
'create or replace trigger sp_project_links_bd',
'    before delete',
'    on sp_project_links',
'    for each row',
'begin',
'    if :old.project_id is not null then',
'        --',
'        -- touch parent table',
'        --',
'        update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;',
'        --',
'        insert into sp_project_history',
'            (project_id, attribute_column, change_type, old_value, changed_on, changed_by)',
'        values',
'            (:old.project_id, ''LINK'', ''DELETE'', :old.link_url, sysdate, lower(coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user)));',
'    end if;',
'end sp_project_links_bd;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
