prompt --application/deployment/install/install_sp_date_range_pct_comp_function
begin
--   Manifest
--     INSTALL: INSTALL-sp_date_range_pct_comp function
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
 p_id=>wwv_flow_imp.id(51248963777181594476)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_date_range_pct_comp function'
,p_sequence=>590
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace function sp_date_range_pct_comp (',
'    p_start_date in date,',
'    p_end_date   in date)',
'    return number',
'is',
'    l_pct_complete number := 0;',
'    l_days         number := null;',
'    l_days_elapsed number := null;',
'    l_sysdate      date   := trunc(sysdate);',
'begin',
'    --',
'    -- this function return 0, 10, 20 .. 100 based days elapsed between two dates',
'    --',
'    if p_start_date is null or p_end_date is null then',
'       l_pct_complete := 0; -- required both dates be not null',
'    else',
'       if p_start_date > p_end_date then ',
'           l_pct_complete := 0; -- invalid condition',
'       elsif p_start_date > l_sysdate then ',
'           l_pct_complete := 0; ',
'       elsif p_start_date = p_end_date then ',
'           l_pct_complete := 100;',
'       elsif l_sysdate > p_end_date then',
'           l_pct_complete := 100;',
'       else ',
'           l_days := p_end_date - p_start_date; ',
'           if l_days > 0 then ',
'               l_days_elapsed := p_end_date - l_sysdate;',
'               l_pct_complete := 100 * l_days_elapsed / l_days;',
'               l_pct_complete := round(l_pct_complete,-1);',
'               l_pct_complete := 100 - l_pct_complete;',
'           end if;',
'       end if;',
'    end if;',
'    return l_pct_complete;',
'end sp_date_range_pct_comp;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
