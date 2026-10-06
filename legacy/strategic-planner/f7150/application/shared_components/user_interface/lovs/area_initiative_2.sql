prompt --application/shared_components/user_interface/lovs/area_initiative_2
begin
--   Manifest
--     AREA INITIATIVE 2
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
 p_id=>wwv_flow_imp.id(41718916868377083652)
,p_lov_name=>'AREA INITIATIVE 2'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative, ',
'       a.area,',
'       i.id initiative_id',
'from sp_initiatives i, sp_areas a',
'where i.area_id = a.id',
'order by 2, 1'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_owner=>'APPDEV_COMMUNITY'
,p_return_column_name=>'INITIATIVE_ID'
,p_display_column_name=>'INITIATIVE'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>41430208760493
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(41718996273838085476)
,p_query_column_name=>'AREA'
,p_heading=>'Area'
,p_display_sequence=>10
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(41718996738649085477)
,p_query_column_name=>'INITIATIVE_ID'
,p_display_sequence=>20
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(41718997122157085477)
,p_query_column_name=>'INITIATIVE'
,p_heading=>'Initiative'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp.component_end;
end;
/
