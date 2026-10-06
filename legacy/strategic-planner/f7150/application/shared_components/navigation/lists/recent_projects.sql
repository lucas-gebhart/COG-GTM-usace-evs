prompt --application/shared_components/navigation/lists/recent_projects
begin
--   Manifest
--     LIST: Recent Projects
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(43011995762114151155)
,p_name=>'Recent Projects'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select the_level,',
'       label, ',
'       target, ',
'       is_current_list_entry,',
'       image,',
'       image_attribute,',
'       image_alt_attribute,',
'       attribute1,',
'       attribute2,',
'       attribute3,',
'       attribute4,',
'       attribute5,',
'       attribute6,',
'       attribute7,',
'       attribute8,',
'       attribute9,',
'       attribute10',
'  from (',
'with recent_projects as (',
'    select l.project_id, ',
'           max(page_rendered) page_rendered ',
'    from SP_PROJ_INTERACTIONS_LOG l,',
'         sp_projects p',
'    where l.app_user = lower(:APP_USER) and',
'          l.project_id = p.id and',
'          p.ARCHIVED_YN = ''N'' and',
'          p.DUPLICATE_OF_PROJECT_ID is null and',
'          l.page_rendered is not null',
'    group by project_id, l.app_user',
'    order by 2 desc',
'    fetch first 10 rows only)',
'select distinct ',
'       1 as the_level,',
'       decode(',
'         greatest(length(project),70), ',
'         70, ',
'         project,',
'         substr(project,1,80)||''...'') as label, ',
'       apex_page.get_url(p_page => 3, p_items => ''fi'', p_clear_cache => ''3'', p_values => p.friendly_identifier) as target, ',
'       null    is_current_list_entry,',
'       ''fa-pie-chart-''||PCT_COMPLETE as image,',
'       null    image_attribute,',
'       null    image_alt_attribute,',
'       null    attribute1,',
'       null    attribute2,',
'       null    attribute3,',
'       null    attribute4,',
'       null    attribute5,',
'       null    attribute6,',
'       null    attribute7,',
'       null    attribute8,',
'       null    attribute9,',
'       null    attribute10,',
'       l.page_rendered',
'from  sp_projects p,',
'      recent_projects l',
'where p.id = l.project_id ',
')',
'order by page_rendered desc'))
,p_list_status=>'PUBLIC'
,p_version_scn=>44534598357828
);
wwv_flow_imp.component_end;
end;
/
