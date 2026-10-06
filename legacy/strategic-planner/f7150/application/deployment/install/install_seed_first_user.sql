prompt --application/deployment/install/install_seed_first_user
begin
--   Manifest
--     INSTALL: INSTALL-seed first user
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
 p_id=>wwv_flow_imp.id(47699150286557590654)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed first user'
,p_sequence=>920
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_app_user  varchar2(255) := apex_custom_auth.get_username;',
'begin',
'    --',
'    -- get email of developer installing the app',
'    -- if no email, see if app_user is an email',
'    -- (first autonomous user may not have an email)',
'    --',
'    for u in (',
'        select first_name, last_name,',
'               case when email is null and regexp_like(l_app_user,''[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}'')',
'                    then l_app_user',
'                    else email',
'                    end email',
'          from apex_workspace_apex_users',
'         where user_name = l_app_user',
'    ) loop',
'      if u.email is not null then',
'        --',
'        -- most recent install of Strategic Planner',
'        --',
'        for a in (',
'            select application_id',
'              from apex_applications',
'             where application_name = ''Strategic Planner''',
'             order by last_updated_on desc',
'        ) loop',
'            --',
'            -- determine admin app role id',
'            --',
'            for r in (',
'                select role_id',
'                  from apex_appl_acl_roles',
'                 where application_id = a.application_id ',
'                   and role_static_id = ''ADMINISTRATOR''',
'            ) loop',
'                --',
'                -- make installer an app admin',
'                --',
'                apex_acl.add_user_role (',
'            	    p_application_id => a.application_id,',
'            	    p_user_name      => u.email,',
'           	    p_role_id        => r.role_id );',
'                commit;',
'                --',
'                -- also add this first user as a Team Member',
'                --',
'                insert into SP_TEAM_MEMBERS ',
'                    (email, first_name, last_name) ',
'                values ',
'                    (u.email, u.first_name, u.last_name);',
'                commit;',
'                exit;',
'            end loop;',
'            exit;',
'        end loop;',
'      end if;',
'    end loop;',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
