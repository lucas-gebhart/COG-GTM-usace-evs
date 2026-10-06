prompt --application/shared_components/navigation/lists/admin_approval_options
begin
--   Manifest
--     LIST: Admin - Approval Options
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
 p_id=>wwv_flow_imp.id(48656700750658988902)
,p_name=>'Admin - Approval Options'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_version_scn=>44593809453875
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(48656700878004988905)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Approval Types'
,p_list_item_link_target=>'f?p=&APP_ID.:4010:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-check'
,p_list_text_01=>'Types of Approvals that can be associated with an &NOMENCLATURE_INITIATIVE. (and therefore able to be requested for a &NOMENCLATURE_PROJECT. within that &NOMENCLATURE_INITIATIVE.)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(48656701341802988906)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&NOMENCLATURE_INITIATIVE. Approval Types'
,p_list_item_link_target=>'f?p=&APP_ID.:4012:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-lightbulb-o'
,p_list_text_01=>'The approval types associated with each &NOMENCLATURE_INITIATIVE. (and therefore able to be requested for a &NOMENCLATURE_PROJECT. within that &NOMENCLATURE_INITIATIVE.)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
