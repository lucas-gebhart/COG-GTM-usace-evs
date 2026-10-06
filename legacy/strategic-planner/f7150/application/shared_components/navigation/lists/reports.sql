prompt --application/shared_components/navigation/lists/reports
begin
--   Manifest
--     LIST: Reports
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
 p_id=>wwv_flow_imp.id(47163355497317693718)
,p_name=>'Reports'
,p_list_status=>'PUBLIC'
,p_version_scn=>45890284265672
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(47163558127492693726)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Documents'
,p_list_item_link_target=>'f?p=&APP_ID.:156:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_text_01=>'Documents added to the system'
,p_list_text_08=>'documents, images'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'156'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(53575523149133311879)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Links'
,p_list_item_link_target=>'f?p=&APP_ID.:146:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-link'
,p_list_text_01=>'Links added to the system'
,p_list_text_08=>'documents, images'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24295247166594378748)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Images in Comments Graph'
,p_list_item_link_target=>'f?p=&APP_ID.:157:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-ai-sparkle-message'
,p_list_text_01=>'Count of images in comments vs count of comments with images, per month'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(50338150669888432859)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Comments'
,p_list_item_link_target=>'f?p=&APP_ID.:158:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-comment-o'
,p_list_text_01=>'All comments added to this system'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(46721415458959822434)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'&NOMENCLATURE_USERS. Screen Names'
,p_list_item_link_target=>'f?p=&APP_ID.:122:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user'
,p_list_text_01=>'Screen names and tags, useful to find and review screen names'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40822383275423239985)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Change History'
,p_list_item_link_target=>'f?p=&APP_ID.:79:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-clock-o'
,p_list_text_01=>'Change reporting across &NOMENCLATURE_INITIATIVES., &NOMENCLATURE_PROJECTS. and Releases'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(45485195845327781898)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'&NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:86:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-table-arrow-down'
,p_list_text_01=>'All active &NOMENCLATURE_PROJECTS. (not archived and not marked as duplicates)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(28636824721957936015)
,p_list_item_display_sequence=>105
,p_list_item_link_text=>'All AI &NOMENCLATURE_PROJECT. Summaries'
,p_list_item_link_target=>'f?p=&APP_ID.:37:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-ai-sparkle-generate-text'
,p_list_text_01=>'All the AI Summaries for all &NOMENCLATURE_PROJECTS.'
,p_required_patch=>wwv_flow_imp.id(27803842998100767814)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(38118949377513423327)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Contributors'
,p_list_item_link_target=>'f?p=&APP_ID.:159:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user'
,p_list_text_01=>'Cross &NOMENCLATURE_PROJECT. Contributor report'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(48857997088349144116)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Milestones, Reviews and Tasks'
,p_list_item_link_target=>'f?p=&APP_ID.:65:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-clipboard-search'
,p_list_text_01=>'Milestones, Reviews and Tasks across all unarchived &NOMENCLATURE_PROJECTS.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(51493041891193943533)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Past Due Tasks, Milestones and Reviews'
,p_list_item_link_target=>'f?p=&APP_ID.:99:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-warning'
,p_list_text_01=>'All &NOMENCLATURE_PROJECT. milestones, tasks and reviews that are past due'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(43861707805254173161)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>'&NOMENCLATURE_PROJECT. Milestone Calendar'
,p_list_item_link_target=>'f?p=&APP_ID.:111:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-calendar-month'
,p_list_text_01=>'Filterable calendar of &NOMENCLATURE_PROJECT. Milestones'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(50576460000720706724)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'All &NOMENCLATURE_PROJECT. Approvals'
,p_list_item_link_target=>'f?p=&APP_ID.:134:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-workflow'
,p_list_text_01=>'Cross &NOMENCLATURE_PROJECT. Approvals with current workflow status'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(50338382971426313298)
,p_list_item_display_sequence=>160
,p_list_item_link_text=>'Duplicate &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-copy'
,p_list_text_01=>'All &NOMENCLATURE_PROJECTS. marked as duplicates'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(50338358527474309177)
,p_list_item_display_sequence=>170
,p_list_item_link_text=>'Archived &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:45:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-package'
,p_list_text_01=>'All &NOMENCLATURE_PROJECTS. that are archived'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(29534736750890767862)
,p_list_item_display_sequence=>180
,p_list_item_link_text=>'Cross-Release Milestone Calendar'
,p_list_item_link_target=>'f?p=&APP_ID.:55:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-calendar-month'
,p_list_text_01=>'Filterable calendar of Milestones across All Releases'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(30777347862817450645)
,p_list_item_display_sequence=>185
,p_list_item_link_text=>'All Release Summaries'
,p_list_item_link_target=>'f?p=&APP_ID.:167:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-ai-sparkle-generate-text'
,p_list_text_01=>'All AI Summaries generated for All Releases'
,p_required_patch=>wwv_flow_imp.id(30769244999117825609)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
