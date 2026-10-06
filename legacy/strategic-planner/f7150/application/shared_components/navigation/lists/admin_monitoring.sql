prompt --application/shared_components/navigation/lists/admin_monitoring
begin
--   Manifest
--     LIST: Admin - Monitoring
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
 p_id=>wwv_flow_imp.id(45056624299861432636)
,p_name=>'Admin - Monitoring'
,p_list_status=>'PUBLIC'
,p_version_scn=>45677925413342
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40433059612759848271)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Page Views'
,p_list_item_link_target=>'f?p=&APP_ID.:39:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_text_01=>'Application page view details'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40433501284065283860)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Page Performance'
,p_list_item_link_target=>'f?p=&APP_ID.:71:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_text_01=>'Application page view details'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40444809618324913319)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Page Views by User'
,p_list_item_link_target=>'f?p=&APP_ID.:72:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_text_01=>'Application page view details'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(28206111933204835062)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Error Log'
,p_list_item_link_target=>'f?p=&APP_ID.:16000:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-alert'
,p_list_text_01=>'Errors raised by the packaged used by this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(60646580346818909980)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Email Reporting'
,p_list_item_link_target=>'f?p=&APP_ID.:16020:&SESSION.::&DEBUG.:16020:::'
,p_list_item_icon=>'fa-envelope-chart'
,p_list_text_01=>'Report of all email queued to be sent and those already sent'
,p_required_patch=>wwv_flow_imp.id(53728659243476523541)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(59866280990998278185)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Job Reporting'
,p_list_item_link_target=>'f?p=&APP_ID.:16010:&SESSION.::&DEBUG.:16010:::'
,p_list_item_icon=>'fa-user-chart'
,p_list_text_01=>'View status and run details of jobs supporting this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(42365652904993160399)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Application Log'
,p_list_item_link_target=>'f?p=&APP_ID.:10050:&SESSION.::&DEBUG.:10050:::'
,p_list_item_icon=>'fa-table-wrench'
,p_list_text_01=>'Log of all changes to administrative data (users, settings, valid values)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(18064401744513929234)
,p_list_item_display_sequence=>75
,p_list_item_link_text=>'Team Member Notifications'
,p_list_item_link_target=>'f?p=&APP_ID.:10790:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bell'
,p_list_text_01=>'All notifications sent from this application.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(46415571338008537418)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Workflow Console'
,p_list_item_link_target=>'f?p=&APP_ID.:4000:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-gears'
,p_list_text_01=>'Monitor the Workflow that manages approval of &NOMENCLATURE_PROJECTS.'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
