prompt --application/deployment/install/install_release_trains_triggers
begin
--   Manifest
--     INSTALL: INSTALL-release trains triggers
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
 p_id=>wwv_flow_imp.id(39234244178692381373)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'release trains triggers'
,p_sequence=>390
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace trigger sp_release_trains_biu',
'    before insert or update',
'    on sp_release_trains',
'    for each row',
'declare',
'    l_old_value   varchar2(4000) := null;',
'    l_new_value   varchar2(4000) := null;',
'    l_changed_by  varchar2(255)  := null;',
'begin',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    --',
'    -- defaults',
'    --',
'    if :new.release_completed is null then ',
'       :new.release_completed := ''N'';',
'    end if;',
'    if :new.RELEASE_OPEN_COMPLETED is null then',
'       :new.RELEASE_OPEN_COMPLETED := ''N'';',
'    end if;',
'    --',
'    -- change history tracking',
'    --',
'    if updating then',
'        l_changed_by := lower(:new.updated_by);',
'        --',
'        if not sp_value_compare.is_equal(:old.release_train,:new.release_train) then',
'           insert into sp_release_history',
'               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'           values',
'               (:new.id, ''RELEASE_TRAIN'', ''UPDATE'', :old.release_train, :new.release_train, sysdate, l_changed_by);',
'        end if;',
'        if not sp_value_compare.is_equal(:old.release,:new.release) then',
'           insert into sp_release_history',
'               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'           values',
'               (:new.id, ''RELEASE'', ''UPDATE'', :old.release, :new.release, sysdate, l_changed_by);',
'        end if;',
'        if not sp_value_compare.is_equal(:old.RELEASE_OWNER_ID,:new.RELEASE_OWNER_ID) then',
'           for c1 in (select email v from sp_team_members x where x.id = :old.RELEASE_OWNER_ID) loop l_old_value := c1.v; end loop;',
'           for c1 in (select email v from sp_team_members x where x.id = :new.RELEASE_OWNER_ID) loop l_new_value := c1.v; end loop;',
'           insert into sp_release_history',
'               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'           values',
'               (:new.id, ''RELEASE_OWNER'', ''UPDATE'', l_old_value, l_new_value, sysdate, l_changed_by);',
'        end if;',
'       --',
'       --',
'       if not sp_value_compare.is_equal(:old.RELEASE_OPEN_DATE,:new.RELEASE_OPEN_DATE) then',
'          insert into sp_release_history',
'              (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'          values',
'              (:new.id, ''RELEASE_OPEN_DATE'', ''UPDATE'', to_char(:old.RELEASE_OPEN_DATE,''DD-MON-YYYY''), to_char(:new.RELEASE_OPEN_DATE,''DD-MON-YYYY''), sysdate, l_changed_by);',
'       end if;',
'       if not sp_value_compare.is_equal(:old.RELEASE_OPEN_COMPLETED,:new.RELEASE_OPEN_COMPLETED) then',
'          insert into sp_release_history',
'              (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'          values',
'              (:new.id, ''RELEASE_OPEN_COMPLETED'', ''UPDATE'', :old.RELEASE_OPEN_COMPLETED, :new.RELEASE_OPEN_COMPLETED, sysdate, l_changed_by);',
'       end if;',
'       --',
'       if not sp_value_compare.is_equal(:old.RELEASE_TARGET_DATE,:new.RELEASE_TARGET_DATE) then',
'          insert into sp_release_history',
'              (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'          values',
'              (:new.id, ''RELEASE_TARGET_DATE'', ''UPDATE'', to_char(:old.RELEASE_TARGET_DATE,''DD-MON-YYYY''), to_char(:new.RELEASE_TARGET_DATE,''DD-MON-YYYY''), sysdate, l_changed_by);',
'       end if;',
'       if not sp_value_compare.is_equal(:old.RELEASE_COMPLETED,:new.RELEASE_COMPLETED) then',
'          insert into sp_release_history',
'              (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)',
'          values',
'              (:new.id, ''RELEASE_COMPLETED'', ''UPDATE'', :old.RELEASE_COMPLETED, :new.RELEASE_COMPLETED, sysdate, l_changed_by);',
'       end if;',
'    end if;',
'end sp_release_trains_biu;',
'/',
'',
'create or replace trigger sp_release_trains_ai',
'    after insert',
'    on sp_release_trains',
'    for each row',
'begin',
'    insert into sp_release_history',
'        (release_id, attribute_column, change_type, new_value, changed_on, changed_by)',
'    values',
'        (:new.id, ''RELEASE'', ''CREATE'', :new.release_train || '' '' ||:new.release, sysdate, lower(:new.created_by));',
'end sp_release_trains_ai;',
'/',
'',
'create or replace trigger sp_release_trains_bd',
'    before delete',
'    on sp_release_trains',
'    for each row',
'begin',
'    insert into sp_release_history',
'        (release_id, attribute_column, change_type, old_value, changed_on, changed_by)',
'    values',
'        (:old.id, ''RELEASE'', ''DELETE'', :old.release_train || '' '' ||:old.release, sysdate, lower(coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user)));',
'end sp_release_trains_bd;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
