prompt --application/deployment/install/install_project_comments_triggers
begin
--   Manifest
--     INSTALL: INSTALL-project comments triggers
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
 p_id=>wwv_flow_imp.id(38225433198426711513)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'project comments triggers'
,p_sequence=>460
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_project_comments_biu',
'    before insert or update',
'    on sp_project_comments',
'    for each row',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'',
'    --',
'    -- private',
'    --',
'    if :new.private_yn is null then ',
'       :new.private_yn := ''N'';',
'    end if;',
'',
'    --',
'    -- touch parent table',
'    --',
'    update sp_projects set updated = sysdate, updated_by = :new.updated_by where id = :new.project_id;',
'    --',
'    -- history',
'    --',
'    if inserting and :new.private_yn = ''N'' then',
'        insert into sp_project_history',
'            (project_id, attribute_column, change_type, new_value, new_value_clob, changed_on, changed_by)',
'        values',
'            (:new.project_id, ''COMMENT'', ''CREATE'', dbms_lob.substr(:new.body_no_images,500,1), :new.body_no_images, sysdate, lower(:new.created_by));',
'    elsif updating and :old.private_yn = ''N'' and :new.private_yn = ''N'' then',
'        if not sp_value_compare.is_equal(:old.body_no_images,:new.body_no_images) then',
'            insert into sp_project_history',
'                (project_id, attribute_column, change_type, old_value, new_value, old_value_clob, new_value_clob, changed_on, changed_by)',
'            values',
'                (:new.project_id, ''COMMENT'', ''UPDATE'', dbms_lob.substr(:old.body_no_images,500,1), dbms_lob.substr(:new.body_no_images,500,1), :old.body_no_images, :new.body_no_images, sysdate, lower(:new.updated_by));',
'        end if;',
'    end if;',
'end sp_project_comments_biu;',
'/',
'',
'create or replace trigger sp_project_comments_bd',
'    before delete',
'    on sp_project_comments',
'    for each row',
'begin',
'    if :old.private_yn = ''N'' then',
'    --',
'    -- touch parent table',
'    --',
'    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;',
'    --',
'    -- history',
'    --',
'    insert into sp_project_history',
'        (project_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)',
'    values',
'        (:old.project_id, ''COMMENT'', ''DELETE'', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user)));',
'    end if;',
'end sp_project_comments_bd;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
