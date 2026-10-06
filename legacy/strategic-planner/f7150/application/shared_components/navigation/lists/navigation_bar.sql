prompt --application/shared_components/navigation/lists/navigation_bar
begin
--   Manifest
--     LIST: Navigation Bar
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
 p_id=>wwv_flow_imp.id(176222229951413897764)
,p_name=>'Navigation Bar'
,p_list_status=>'PUBLIC'
,p_version_scn=>45775928669870
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(43012165058877849015)
,p_list_item_display_sequence=>1
,p_list_item_link_text=>'Recent Projects'
,p_list_item_icon=>'fa-folder-clock'
,p_list_text_02=>'icon-only'
,p_list_text_04=>'Recent Projects'
,p_list_item_current_type=>'TARGET_PAGE'
,p_sub_list_id=>wwv_flow_imp.id(43011995762114151155)
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40717632234633872807)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Alerts'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:2:::'
,p_list_item_icon=>'fa-bell'
,p_list_item_disp_cond_type=>'EXISTS'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_team_member_notifications',
' where team_member_id = :APP_USER_ID',
'   and dismissed_yn = ''N''',
'   and instr('':''||notification_pref||'':'','':APP:'') > 0'))
,p_list_text_02=>'icon-only'
,p_list_text_04=>'Alerts'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(53827674713221149732)
,p_list_item_display_sequence=>15
,p_list_item_link_text=>'Approval Requests'
,p_list_item_link_target=>'f?p=&APP_ID.:132:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-workflow'
,p_list_item_disp_cond_type=>'EXPRESSION'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':APPROVALS_PENDING_CNT > 0 or',
':APPROVALS_MORE_INFO_CNT > 0'))
,p_list_item_disp_condition2=>'PLSQL'
,p_list_text_02=>'icon-only'
,p_list_text_04=>'Approval Requests'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&APP_USER_FIRST_NAME.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(60482434296383844423)
,p_list_item_display_sequence=>1
,p_list_item_link_text=>'My &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:113:&SESSION.::&DEBUG.:113:::'
,p_list_item_icon=>'fa-package'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(60482434748650844423)
,p_list_item_display_sequence=>2
,p_list_item_link_text=>'My Favorite &NOMENCLATURE_PROJECTS.'
,p_list_item_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FAVORITE:Yes:'
,p_list_item_icon=>'fa-heart'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(60482435222774844424)
,p_list_item_display_sequence=>3
,p_list_item_link_text=>'My Tasks'
,p_list_item_link_target=>'f?p=&APP_ID.:65:&SESSION.::&DEBUG.:65,CIR,RIR:IR_ASSIGNED_TO_OWNER_ID: &APP_USER_ID.:'
,p_list_item_icon=>'fa-clipboard-list'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(60482435606983844424)
,p_list_item_display_sequence=>4
,p_list_item_link_text=>'My Activities'
,p_list_item_link_target=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:102:P102_PERSON:&APP_USER_FIRST_LAST_NAME.:'
,p_list_item_icon=>'fa-badge-check'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(30243873615510594037)
,p_list_item_display_sequence=>5
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(41339607017761788913)
,p_list_item_display_sequence=>12
,p_list_item_link_text=>'My Profile'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP:P5_ID:&APP_USER_ID.:'
,p_list_item_icon=>'fa-user'
,p_list_item_disp_cond_type=>'ITEM_IS_NOT_NULL'
,p_list_item_disp_condition=>'APP_USER_ID'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40988297140502311410)
,p_list_item_display_sequence=>15
,p_list_item_link_text=>'My Subscriptions'
,p_list_item_link_target=>'f?p=&APP_ID.:139:&SESSION.::&DEBUG.:139:::'
,p_list_item_icon=>'fa-sliders'
,p_list_item_disp_cond_type=>'EXPRESSION'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':APP_USER_ID is not null and',
'apex_util.get_build_option_status (',
'    p_application_id    => :APP_ID,',
'    p_build_option_name => ''Email Configured'') = ''INCLUDE'' and',
'apex_util.get_build_option_status (',
'    p_application_id    => :APP_ID,',
'    p_build_option_name => ''Subscriptions'') = ''INCLUDE'''))
,p_list_item_disp_condition2=>'PLSQL'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(18860086221488510666)
,p_list_item_display_sequence=>17
,p_list_item_link_text=>'My Approval Configuration'
,p_list_item_link_target=>'f?p=&APP_ID.:147:&SESSION.::&DEBUG.:147:::'
,p_list_item_icon=>'fa-workflow'
,p_list_item_disp_cond_type=>'EXISTS'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain c,',
'       sp_initiative_approvals a',
' where a.id = c.initiative_approval_id',
'   and c.team_member_id = :APP_USER_ID',
'   and a.active_yn = ''Y'''))
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(30243122828509472621)
,p_list_item_display_sequence=>45
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(39029966950725885169)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'About this App'
,p_list_item_link_target=>'f?p=&APP_ID.:10820:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-info'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_required_patch=>wwv_flow_imp.id(39029755398907879859)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(40572485441683093996)
,p_list_item_display_sequence=>75
,p_list_item_link_text=>'Administration'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-users'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(176222296508060898488)
,p_list_item_display_sequence=>78
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(176222296942114898488)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_imp.id(176222295973977898487)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(45083552549129703681)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:12120:&SESSION.::&DEBUG.:12120:P12120_PAGE_ID:&APP_PAGE_ID.:'
,p_list_item_icon=>'fa-comment-o'
,p_list_item_disp_cond_type=>'EXPRESSION'
,p_list_item_disp_condition=>'apex_util.feedback_enabled'
,p_list_item_disp_condition2=>'PLSQL'
,p_list_text_02=>'icon-only'
,p_security_scheme=>wwv_flow_imp.id(176222234009685897793)
,p_required_patch=>wwv_flow_imp.id(45083514827823703609)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
