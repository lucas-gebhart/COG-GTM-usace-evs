prompt --application/deployment/install/install_sp_tag_diff_function
begin
--   Manifest
--     INSTALL: INSTALL-sp_tag_diff function
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
 p_id=>wwv_flow_imp.id(38136426598784565449)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_tag_diff function'
,p_sequence=>600
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace function sp_tag_diff (',
'    p_old_tags in varchar2,',
'    p_new_tags in varchar2)',
'    return varchar2 ',
'is',
'    --',
'    -- Example:',
'    --',
'    -- begin dbms_output.put_line(sp_tag_diff (p_old_tags => ''A,C'',p_new_tags => ''B,C,D'')); end;',
'    --',
'    l_return        varchar2(32767);',
'    l_vc_arr_old    APEX_APPLICATION_GLOBAL.VC_ARR2;',
'    l_vc_arr_new    APEX_APPLICATION_GLOBAL.VC_ARR2;',
'    l_plus_string   varchar2(32767);',
'    l_minus_string  varchar2(32767);',
'    l_old_tags      varchar2(32767) := upper('',''||replace(p_old_tags,'' '','''')||'','');',
'    l_new_tags      varchar2(32767) := upper('',''||replace(p_new_tags,'' '','''')||'','');',
'begin',
'    l_vc_arr_old := APEX_UTIL.STRING_TO_TABLE(upper(replace(p_old_tags,'' '',null)),'','');',
'    l_vc_arr_new := APEX_UTIL.STRING_TO_TABLE(upper(replace(p_new_tags,'' '',null)),'','');',
'    --',
'    -- look for removed tags',
'    --',
'    for i in 1..l_vc_arr_old.count loop',
'        if instr(l_new_tags,'',''||l_vc_arr_old(i)||'','') = 0 then',
'            l_return := l_return||''<span class="t-Badge u-danger">''||apex_escape.html(l_vc_arr_old(i))||''</span> '';',
'        end if;',
'    end loop;',
'    --',
'    -- look for new tags',
'    --',
'    for i in 1..l_vc_arr_new.count loop',
'        if instr(l_old_tags,'',''||l_vc_arr_new(i)||'','') = 0 then',
'            l_return := l_return||''<span class="t-Badge u-success">''||apex_escape.html(l_vc_arr_new(i))||''</span> '';',
'        end if;',
'    end loop;',
'    --',
'    --',
'    --',
'    return l_return;',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
