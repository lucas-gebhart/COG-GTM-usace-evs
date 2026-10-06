prompt --application/shared_components/user_interface/lovs/projects_detail
begin
--   Manifest
--     PROJECTS DETAIL
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(36931634799233187817)
,p_lov_name=>'PROJECTS DETAIL'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'     p.id, ',
'     decode(rt.release,null,p.project,rt.release_train||'' ''||rt.release||'': ''||project)|| '' - ''||pct_complete||''%'' display',
'from SP_PROJECTS p,',
'     SP_RELEASE_TRAINS rt',
'where p.release_id = rt.id(+) and',
'      p.ARCHIVED_YN = ''N'' and',
'      p.DUPLICATE_OF_PROJECT_ID is null',
'order by p.project'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'ID'
,p_display_column_name=>'DISPLAY'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>44445820407248
);
wwv_flow_imp.component_end;
end;
/
