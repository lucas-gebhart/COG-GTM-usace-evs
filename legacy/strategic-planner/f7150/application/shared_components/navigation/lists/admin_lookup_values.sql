prompt --application/shared_components/navigation/lists/admin_lookup_values
begin
--   Manifest
--     LIST: Admin - Lookup Values
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
 p_id=>wwv_flow_imp.id(40583452023793001648)
,p_name=>'Admin - Lookup Values'
,p_list_status=>'PUBLIC'
,p_version_scn=>45890286576339
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40583453004043001655)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Activity Types'
,p_list_item_link_target=>'f?p=&APP_ID.:10700:&SESSION.::&DEBUG.:RP,10700:::'
,p_list_item_icon=>'fa-address-card-o'
,p_list_text_01=>'Used to further describe logged activities'
,p_list_text_02=>'&P10000_ACTIVITY_TYPES.'
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(47935349842973394315)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Default Competencies'
,p_list_item_link_target=>'f?p=&APP_ID.:154:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-users-alt'
,p_list_text_01=>'Associated with people and displayed under their profile'
,p_list_text_02=>'&P10000_COMPETENCIES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40583452606089001655)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Contributor Roles'
,p_list_item_link_target=>'f?p=&APP_ID.:10600:&SESSION.::&DEBUG.:RP,10600:::'
,p_list_item_icon=>'fa-address-card-o'
,p_list_text_01=>'How a person can be associated with a &NOMENCLATURE_PROJECT.'
,p_list_text_02=>'&P10000_RESOURCE_TYPES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55634553286061569921)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Team Member Default Tags'
,p_list_item_link_target=>'f?p=&APP_ID.:10520:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-tag'
,p_list_text_01=>'Configure default quick picks for tags'
,p_list_text_02=>'&P10000_TEAM_MBR_DEFAULT_TAGS.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(62377202437787301219)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Countries'
,p_list_item_link_target=>'f?p=&APP_ID.:43:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-globe'
,p_list_text_01=>'Configure default quick picks for tags'
,p_list_text_02=>'&P10000_COUNTRIES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40583452230661001652)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Completeness Scales'
,p_list_item_link_target=>'f?p=&APP_ID.:10200:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-badge-check'
,p_list_text_01=>'Details of available completeness scales (from 0% to 100% in 10% increments) used for &NOMENCLATURE_PROJECTS.'
,p_list_text_02=>'&P10000_PROJECT_STATUS_SCALES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(53088492529857258013)
,p_list_item_display_sequence=>75
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Statuses'
,p_list_item_link_target=>'f?p=&APP_ID.:10110:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-wizard'
,p_list_text_01=>'Available statuses for &NOMENCLATURE_PROJECTS., used when active (as defined by selected completeness scale) and not 100% complete'
,p_list_text_02=>'&P10000_PROJECT_STATUSES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40583453384249001656)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Priorities'
,p_list_item_link_target=>'f?p=&APP_ID.:10800:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-arrows-v'
,p_list_text_01=>'Available &NOMENCLATURE_PROJECT. priorities'
,p_list_text_02=>'&P10000_PROJECT_PRIORITIES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40583454636769001657)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Sizes'
,p_list_item_link_target=>'f?p=&APP_ID.:10100:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-users-alt'
,p_list_text_01=>'Sizes for &NOMENCLATURE_PROJECTS. with associated level of effort'
,p_list_text_02=>'&P10000_PROJECT_SIZES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(61573704997713052949)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Default Tags'
,p_list_item_link_target=>'f?p=&APP_ID.:10500:&SESSION.::&DEBUG.:RP,10500:::'
,p_list_item_icon=>'fa-tag'
,p_list_text_01=>'Configure default quick picks for tags'
,p_list_text_02=>'&P10000_DEFAULT_TAGS.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40322102651642268927)
,p_list_item_display_sequence=>115
,p_list_item_link_text=>'&NOMENCLATURE_INITIATIVE. Focus Areas'
,p_list_item_link_target=>'f?p=&APP_ID.:10150:&SESSION.::&DEBUG.:RP,10150:::'
,p_list_item_icon=>'fa-user-magnifying-glass'
,p_list_text_01=>'Focus Areas that can be associated with &NOMENCLATURE_PROJECTS. (selection is limited by &NOMENCLATURE_INITIATIVE.)'
,p_list_text_02=>'&P10000_FOCUS_AREAS.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55235498157896469431)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Task Types'
,p_list_item_link_target=>'f?p=&APP_ID.:10064:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-clipboard-list'
,p_list_text_01=>'Available &NOMENCLATURE_PROJECT. task types'
,p_list_text_02=>'&P10000_TASK_TYPES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55235787497127489056)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Task Statuses'
,p_list_item_link_target=>'f?p=&APP_ID.:10061:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-wizard'
,p_list_text_01=>'Available statuses for tasks'
,p_list_text_02=>'&P10000_TASK_STATUSES.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(43087240665930299366)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>'Release Milestone Types'
,p_list_item_link_target=>'f?p=&APP_ID.:10090:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-clipboard-check-alt'
,p_list_text_01=>'Used to describe Release Milestones'
,p_list_text_02=>'&P10000_REL_MILESTONE_TYPES.'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(31286173314585682522)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Release Milestone Default Tags'
,p_list_item_link_target=>'f?p=&APP_ID.:10515:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-tag'
,p_list_text_01=>'Configure quick picks for release milestone tags'
,p_list_text_02=>'&P10000_RM_DEFAULT_TAGS.'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
