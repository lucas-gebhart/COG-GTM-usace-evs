prompt --application/deployment/install/install_project_documents_triggers
begin
--   Manifest
--     INSTALL: INSTALL-project documents triggers
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
 p_id=>wwv_flow_imp.id(38225907358623732008)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'project documents triggers'
,p_sequence=>490
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_project_documents_biu',
'    before insert or update',
'    on sp_project_documents',
'    for each row',
'declare',
'    l_tags varchar2(4000) := null;',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    --',
'    --',
'    :new.tags := upper(:new.tags);',
'    --',
'    -- touch parent table',
'    --',
'    update sp_projects set updated = sysdate, updated_by = :new.updated_by where id = :new.project_id;',
'    --',
'    -- adjust tag data',
'    --',
'    if :new.tags is not null then',
'        l_tags := trim(upper(:new.tags));',
'        -- remove multiple spaces',
'        if instr(l_tags,''  '') > 0 then',
'            for j in 1..10 loop ',
'                l_tags := replace(l_tags,''  '','' ''); ',
'                if instr(l_tags,''  '') = 0 then',
'                   exit;',
'                end if;',
'            end loop; ',
'        end if;',
'        for i in 1..length(l_tags) loop',
'            if i > 2 and substr(l_tags,i,1) = '' '' and substr(l_tags,i-1,1) != '','' then',
'               l_tags := substr(l_tags,1,i-1)||''-''||substr(l_tags,i+1);',
'            end if;',
'        end loop;',
'        :new.tags := l_tags;',
'   end if;',
'    --',
'    -- history',
'    --',
'    if inserting then',
'        insert into sp_project_history',
'            (project_id, attribute_column, change_type, new_value, changed_on, changed_by)',
'        values',
'            (:new.project_id, ''DOCUMENT'', ''CREATE'', :new.DOCUMENT_FILENAME, sysdate, lower(:new.created_by));',
'    elsif updating then ',
'        insert into sp_project_history',
'            (project_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'        values',
'            (:new.project_id, ''DOCUMENT'', ''UPDATE'', :old.DOCUMENT_FILENAME, :new.DOCUMENT_FILENAME, sysdate, lower(:new.updated_by));',
'    end if;',
'end sp_project_documents_biu;',
'/',
'',
'create or replace trigger sp_project_documents_bd',
'    before delete',
'    on sp_project_documents',
'    for each row',
'begin',
'    --',
'    -- touch parent table',
'    --',
'    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;',
'    --',
'    insert into sp_project_history',
'        (project_id, attribute_column, change_type, old_value, changed_on, changed_by)',
'    values',
'        (:old.project_id, ''DOCUMENT'', ''DELETE'', :old.document_filename, sysdate, lower(coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user)));',
'end sp_project_documents_bd;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
