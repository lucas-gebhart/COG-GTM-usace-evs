prompt --application/shared_components/user_interface/lovs/sp_release_trains_release_train
begin
--   Manifest
--     SP_RELEASE_TRAINS.RELEASE_TRAIN
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
 p_id=>wwv_flow_imp.id(48564180897409220921)
,p_lov_name=>'SP_RELEASE_TRAINS.RELEASE_TRAIN'
,p_lov_query=>'select release_train||'' ''||release release_train, id from SP_RELEASE_TRAINS'
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'SP_RELEASE_TRAINS'
,p_return_column_name=>'ID'
,p_display_column_name=>'RELEASE_TRAIN'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>1
);
wwv_flow_imp.component_end;
end;
/
