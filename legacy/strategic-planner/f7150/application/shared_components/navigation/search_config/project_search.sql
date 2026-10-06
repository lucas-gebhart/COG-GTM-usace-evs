prompt --application/shared_components/navigation/search_config/project_search
begin
--   Manifest
--     SEARCH CONFIG: Project Search
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_search_config(
 p_id=>wwv_flow_imp.id(36962986422752341257)
,p_label=>'Project Search'
,p_static_id=>'project_search'
,p_search_type=>'SIMPLE'
,p_location=>'LOCAL'
,p_query_type=>'SQL'
,p_query_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       f.area,',
'       i.initiative||'' / ''||f.area area_initiative,',
'       p.PROJECT,',
'       p.TARGET_COMPLETE,',
'       p.PRIORITY_ID,',
'       case when p.release_id is not null',
'            then (select release_train||'' ''||release from SP_RELEASE_TRAINS t where t.id = p.release_id)',
'            when p.target_complete is null',
'            then ''Not Targeted''',
'            else to_char(p.target_complete,''DD-MON-YYYY'') ',
'            end target,',
'       p.updated,',
'       nvl((select ''P''||priority from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'')||'' - ''||',
'       (select first_name||'' ''||last_name from sp_team_members t where t.id = p.OWNER_ID)||'' - ''||',
'       P.PCT_COMPLETE||''%''||'' - ''||',
'       (select first_name||'' ''||last_name from sp_team_members t where t.id = p.OWNER_ID)||',
'       decode(p.tags, null, null, '' - ''||p.tags)',
'       details,',
'       ''PR'' initials,',
'       p.id project_id',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f',
'where (nvl(:P23_INITIATIVE_ID,0) = 0 or :P23_INITIATIVE_ID = p.INITIATIVE_ID ) and ',
'      (nvl(:P23_FOCUS_AREA_ID,0) = 0 or :P23_AREA_ID = f.ID ) and',
'      p.initiative_id = i.id and',
'      i.area_id = f.id'))
,p_searchable_columns=>'AREA_INITIATIVE:PROJECT:DETAILS:INITIALS'
,p_pk_column_name=>'ID'
,p_title_column_name=>'PROJECT'
,p_subtitle_column_name=>'AREA_INITIATIVE'
,p_description_column_name=>'DETAILS'
,p_last_modified_column_name=>'UPDATED'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:RP,3:P3_PROJECT_ID:&ID.'
,p_icon_source_type=>'STATIC_CLASS'
,p_icon_class_column_name=>'INITIALS'
,p_icon_css_classes=>'fa-package'
,p_version_scn=>45820868892160
);
wwv_flow_imp.component_end;
end;
/
