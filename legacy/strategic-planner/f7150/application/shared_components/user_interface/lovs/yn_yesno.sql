prompt --application/shared_components/user_interface/lovs/yn_yesno
begin
--   Manifest
--     YN_YESNO
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
 p_id=>wwv_flow_imp.id(20424485437329426803)
,p_lov_name=>'YN_YESNO'
,p_lov_query=>'.'||wwv_flow_imp.id(20424485437329426803)||'.'
,p_location=>'STATIC'
,p_version_scn=>45013465152793
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(20424485871379426805)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Yes'
,p_lov_return_value=>'Y'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(20424486217895426806)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'No'
,p_lov_return_value=>'N'
);
wwv_flow_imp.component_end;
end;
/
