prompt --application/shared_components/user_interface/lovs/task_names_for_display_lovs
begin
--   Manifest
--     TASK NAMES FOR DISPLAY LOVS
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
 p_id=>wwv_flow_imp.id(49337211581599759857)
,p_lov_name=>'TASK NAMES FOR DISPLAY LOVS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.id r,',
'       (select task_type from sp_task_types rt where rt.id = r.task_type_id)||',
'           case when r.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = r.task_sub_type_id) ||',
'           case when r.task is not null then '' - ''||r.task end d',
'  from sp_tasks r'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_query_owner=>'APPDEV_COMMUNITY'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
,p_version_scn=>44557212941115
);
wwv_flow_imp.component_end;
end;
/
