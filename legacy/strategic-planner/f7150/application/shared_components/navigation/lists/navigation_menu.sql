prompt --application/shared_components/navigation/lists/navigation_menu
begin
--   Manifest
--     LIST: Navigation Menu
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
 p_id=>wwv_flow_imp.id(176221935434062897479)
,p_name=>'Navigation Menu'
,p_list_status=>'PUBLIC'
,p_version_scn=>46466991852613
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(176222239557046897839)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(148863530100795002382)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&NOMENCLATURE_AREAS. [&P1_AREAS.]'
,p_list_item_link_target=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-folder-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'17,9'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(148866442263516363291)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'&NOMENCLATURE_INITIATIVES. [&P1_INITIATIVES.]'
,p_list_item_link_target=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-lightbulb-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'21,66,94,53,160,164,11,33,57,59,62,68,127,170,171,172,173,174,175,112,4,135'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(148866570448658099378)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'&NOMENCLATURE_PROJECTS. [&P1_PROJECTS.]'
,p_list_item_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-package'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3,23,300,113,64,29,30,502,507,505,160,60,116,121,98,126'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(44406418384821610900)
,p_list_item_display_sequence=>45
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Groups [&P1_PROJECT_GROUPS.]'
,p_list_item_link_target=>'f?p=&APP_ID.:70:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-package'
,p_required_patch=>wwv_flow_imp.id(51655467048481750655)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'70,119'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(51152988168971925592)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Activities [&P1_ACTIVITIES.]'
,p_list_item_link_target=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-badge-check'
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'96,102'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(68798930152926399581)
,p_list_item_display_sequence=>77
,p_list_item_link_text=>'Releases [&P1_RELEASES.]'
,p_list_item_link_target=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-ship'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'63,77,38,76,8,117,202,42,69,133,14'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(176242162858706591048)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'&NOMENCLATURE_USERS. [&P1_PEOPLE.]'
,p_list_item_link_target=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-user'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'5,19,20,74,61,148,153'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(46019929097001026867)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'&NOMENCLATURE_USERS. Groups [&P1_GROUPS.]'
,p_list_item_link_target=>'f?p=&APP_ID.:103:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-users'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'150,151,152,103'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(47015348480991045871)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Reports'
,p_list_item_link_target=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'41,14,46,31,78,7,45,51,86,26,500,79,4,80,81,89,15,91,111,122,65,134,146,156,157,158,159,157,37,55,167,710'
);
wwv_flow_imp.component_end;
end;
/
