prompt --application/shared_components/user_interface/lovs/event_recurrence
begin
--   Manifest
--     EVENT RECURRENCE
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
 p_id=>wwv_flow_imp.id(31825158258755673223)
,p_lov_name=>'EVENT RECURRENCE'
,p_lov_query=>'.'||wwv_flow_imp.id(31825158258755673223)||'.'
,p_location=>'STATIC'
,p_version_scn=>45859298822715
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(31825158567479673225)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Daily'
,p_lov_return_value=>'D'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(31825159143760673610)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Every Weekday (M-F)'
,p_lov_return_value=>'WD'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(31825159395181673610)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Every Week (same day of week)'
,p_lov_return_value=>'W'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(31825159856823673610)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'Every 2 Weeks (same day of week)'
,p_lov_return_value=>'2W'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(31825160249572673611)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'Each Month (same date)'
,p_lov_return_value=>'M'
);
wwv_flow_imp.component_end;
end;
/
