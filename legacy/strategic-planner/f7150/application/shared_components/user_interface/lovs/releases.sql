prompt --application/shared_components/user_interface/lovs/releases
begin
--   Manifest
--     RELEASES
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
 p_id=>wwv_flow_imp.id(68721582673686415103)
,p_lov_name=>'RELEASES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       id,',
'       RELEASE_TRAIN||'' ''||release release,',
'       to_char(release_open_date,''YYYY.MM.DD'')||'' - ''||',
'       to_char(release_target_date,''YYYY.MM.DD'') window',
'from SP_RELEASE_TRAINS',
'order by release_target_date'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_owner=>'APPDEV_COMMUNITY'
,p_return_column_name=>'ID'
,p_display_column_name=>'RELEASE'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>1
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(68727378145496514570)
,p_query_column_name=>'ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(68727378387411514572)
,p_query_column_name=>'RELEASE'
,p_heading=>'Release'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(68727378855036514572)
,p_query_column_name=>'WINDOW'
,p_heading=>'Window'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp.component_end;
end;
/
