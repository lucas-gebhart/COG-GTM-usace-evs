prompt --application/shared_components/navigation/lists/admin_project_interactions
begin
--   Manifest
--     LIST: Admin - Project Interactions
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
 p_id=>wwv_flow_imp.id(24797171413502708441)
,p_name=>'Admin - Project Interactions'
,p_list_status=>'PUBLIC'
,p_version_scn=>45648445175572
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24798381925296916158)
,p_list_item_display_sequence=>5
,p_list_item_link_text=>'Initiative Views'
,p_list_item_link_target=>'f?p=&APP_ID.:81:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-lightbulb-o'
,p_list_text_01=>'Views of &NOMENCLATURE_INITIATIVES. by user over the last 90 days '
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797171781721708443)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&NOMENCLATURE_PROJECTS. Views by User'
,p_list_item_link_target=>'f?p=&APP_ID.:80:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-package'
,p_list_text_01=>'Views of &NOMENCLATURE_PROJECTS. by user over the last 90 days'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797172101597708444)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&NOMENCLATURE_PROJECTS. Views by User by Month'
,p_list_item_link_target=>'f?p=&APP_ID.:89:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-table'
,p_list_text_01=>'Views of &NOMENCLATURE_PROJECTS. by User by Month over the last 4 months'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797172500470708444)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Most Viewed &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:97:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-eye'
,p_list_text_01=>'Most Viewed &NOMENCLATURE_PROJECTS. over the last 90 days'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797173301755708445)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Favorite &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:91:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-table-heart'
,p_list_text_01=>'Count of times each &NOMENCLATURE_PROJECT. has been favorited'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797172899589708444)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Favorited &NOMENCLATURE_PROJECTS. by User'
,p_list_item_link_target=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user-heart'
,p_list_text_01=>'Each &NOMENCLATURE_PROJECT. a user has favorited'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24797260286289724604)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Interactions by User'
,p_list_item_link_target=>'f?p=&APP_ID.:610:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-edit'
,p_list_text_01=>'Each time a user viewed, or interacted in any way, with a &NOMENCLATURE_PROJECT. or something related to a &NOMENCLATURE_PROJECT. (Milestone, Review or Task)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
