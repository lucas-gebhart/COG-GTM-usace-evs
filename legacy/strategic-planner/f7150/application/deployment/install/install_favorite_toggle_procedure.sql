prompt --application/deployment/install/install_favorite_toggle_procedure
begin
--   Manifest
--     INSTALL: INSTALL-favorite_toggle procedure
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
 p_id=>wwv_flow_imp.id(38981787744941615770)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'favorite_toggle procedure'
,p_sequence=>620
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace procedure sp_favorite_toggle (',
'   p_project_id  in number,',
'   p_app_user_id in number)',
'is  ',
'   is_favorite  boolean := false;',
'   l_count      int;',
'begin',
'    if p_project_id is null then ',
'        raise_application_error(-20001,''p_project_id is null'');',
'    elsif p_app_user_id is null then',
'        raise_application_error(-20001,''p_app_user_id is null'');',
'    else',
'        select count (*) into l_count from sp_projects where id = p_project_id;',
'        if l_count = 0 then',
'           raise_application_error(-20001,''p_project_id ''||p_project_id||'' not found'');',
'        end if;',
'    end if;',
'',
'    --',
'    -- If a row is returned then this project is a favorate of the user identified',
'    --',
'    for c1 in (select 1 from SP_FAVORITES where team_member_id = p_app_user_id and project_id = p_project_id) loop',
'        is_favorite := true;',
'    end loop;',
'',
'    --',
'    -- toggle current setting',
'    -- if is currently favorite then unfavorite by deleting row',
'    -- if not currently a favorite then favorate by inserting a row',
'    --',
'',
'    if is_favorite then',
'        delete from SP_FAVORITES where team_member_id = p_app_user_id and project_id = p_project_id;',
'    else',
'        insert into SP_FAVORITES (team_member_id, PROJECT_ID) values (p_app_user_id, p_project_id);',
'    end if;',
'',
'end sp_favorite_toggle;',
'/',
'',
'',
''))
);
wwv_flow_imp.component_end;
end;
/
