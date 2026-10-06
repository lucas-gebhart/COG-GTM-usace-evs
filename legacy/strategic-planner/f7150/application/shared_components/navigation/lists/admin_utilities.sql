prompt --application/shared_components/navigation/lists/admin_utilities
begin
--   Manifest
--     LIST: Admin - Utilities
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
 p_id=>wwv_flow_imp.id(48254040206211570894)
,p_name=>'Admin - Utilities'
,p_list_status=>'PUBLIC'
,p_version_scn=>45890284530493
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(48521316105783783734)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Manage Archived Projects'
,p_list_item_link_target=>'f?p=&APP_ID.:11300:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-gear'
,p_list_text_01=>'All archived &NOMENCLATURE_PROJECTS., with the ability to permanently delete'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(50983482094465896358)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Manage Duplicate Projects'
,p_list_item_link_target=>'f?p=&APP_ID.:11320:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-gear'
,p_list_text_01=>'All &NOMENCLATURE_PROJECTS. marked as duplicates, with the ability to permanently delete'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
