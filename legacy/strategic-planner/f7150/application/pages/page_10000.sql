prompt --application/pages/page_10000
begin
--   Manifest
--     PAGE: 10000
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_page.create_page(
 p_id=>10000
,p_name=>'Administration'
,p_alias=>'ADMIN'
,p_step_title=>'Administration'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_deep_linking=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The administration page allows application owners (Administrators) to configure the application and maintain common data used across the application.',
'By selecting one of the available settings, administrators can potentially change how the application is displayed and/or features available to the end users.</p>',
'<p>Access to this page should be limited to Administrators only.</p>'))
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45076796308555940872)
,p_plug_name=>'Column 1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>180
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24797173764233708446)
,p_plug_name=>'&NOMENCLATURE_PROJECT. Interactions'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>90
,p_location=>null
,p_list_id=>wwv_flow_imp.id(24797171413502708441)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40986351522943013964)
,p_plug_name=>'Notifications'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_region_template_options=>'t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>110
,p_location=>null
,p_list_id=>wwv_flow_imp.id(40986350509757013960)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
,p_plug_required_role=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44914294501856619017)
,p_plug_name=>'Monitoring'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>80
,p_location=>null
,p_list_id=>wwv_flow_imp.id(45056624299861432636)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45083553542557703685)
,p_plug_name=>'Feedback'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_imp.id(45083514827823703609)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(45083553914773703685)
,p_name=>'Report'
,p_parent_plug_id=>wwv_flow_imp.id(45083553542557703685)
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody:t-Region--noPadding'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.display_value feedback_status, ',
'(select count(*) from apex_team_feedback f where f.application_id = :APP_ID and f.feedback_status = l.return_value) feedback_count ',
'from apex_application_lov_entries l',
'where l.application_id = :APP_ID',
'and l.list_of_values_name = ''FEEDBACK_STATUS''',
'order by 2 desc, 1'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2100515124465797522
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(45083554583075703694)
,p_query_column_id=>1
,p_column_alias=>'FEEDBACK_STATUS'
,p_column_display_sequence=>1
,p_column_heading=>'Feedback Status'
,p_heading_alignment=>'LEFT'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(45083555044146703695)
,p_query_column_id=>2
,p_column_alias=>'FEEDBACK_COUNT'
,p_column_display_sequence=>2
,p_column_heading=>'Feedback Count'
,p_column_format=>'999G999G999G999G999G999G990'
,p_heading_alignment=>'LEFT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45083578266729704196)
,p_plug_name=>'Feedback'
,p_parent_plug_id=>wwv_flow_imp.id(45083553542557703685)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>100
,p_list_id=>wwv_flow_imp.id(45083552843625703683)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
,p_plug_query_num_rows=>15
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48254040840349570899)
,p_plug_name=>'Utilities'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>100
,p_location=>null
,p_list_id=>wwv_flow_imp.id(48254040206211570894)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176222299756145898496)
,p_plug_name=>'Access Control Content'
,p_parent_plug_id=>wwv_flow_imp.id(45076796308555940872)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>20
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176222400101962898497)
,p_plug_name=>'Access Control'
,p_parent_plug_id=>wwv_flow_imp.id(176222299756145898496)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_imp.id(176222232227855897789)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(29014887557242880738)
,p_plug_name=>'Warning'
,p_parent_plug_id=>wwv_flow_imp.id(176222400101962898497)
,p_region_css_classes=>'margin-sm'
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--noIcon:t-Alert--warning:t-Alert--accessibleHeading'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_user_not_people_cnt   number;',
'    l_people_not_users_cnt  number;',
'begin',
'    select count(*) cnt',
'      into l_user_not_people_cnt',
'      from APEX_APPL_ACL_USERS',
'     where APPLICATION_ID = :APP_ID',
'       and user_name_lc not in (select lower(email)',
'                                  from SP_TEAM_MEMBERS);',
'',
'    select count(*) cnt',
'      into l_people_not_users_cnt',
'      from SP_TEAM_MEMBERS',
'     where lower(email) not in (select user_name_lc',
'                                  from APEX_APPL_ACL_USERS',
'                                 where APPLICATION_ID = :APP_ID);',
'',
'    if l_user_not_people_cnt > 0 or l_people_not_users_cnt > 0 then',
'       sys.htp.p(''Please note:<br/>'');',
'    end if;',
'',
'    if l_user_not_people_cnt > 0 then',
'       sys.htp.p(''<a href="''||apex_util.prepare_url(',
'                              p_url => ''f?p=''||:APP_ID||'':10015:''||:APP_SESSION||''::NO:CIR,RIR'',',
'                              p_checksum_type => ''3'' )||''">''||l_user_not_people_cnt||''</a>'');',
'    end if;',
'    if l_user_not_people_cnt = 1 then',
'       sys.htp.p('' User is not registered as a ''||:NOMENCLATURE_USER||'' within this application'');',
'    elsif l_user_not_people_cnt > 1 then',
'       sys.htp.p('' Users are not registered as ''||:NOMENCLATURE_USERS||'' within this application'');',
'    end if;',
'',
'    if l_user_not_people_cnt > 0 and l_people_not_users_cnt > 0 then',
'       sys.htp.p(''<br/>'');',
'    end if;',
'',
'    if l_people_not_users_cnt > 0 then',
'       sys.htp.p(''<a href="''||apex_util.prepare_url(',
'                              p_url => ''f?p=''||:APP_ID||'':10016:''||:APP_SESSION||''::NO:CIR,RIR'',',
'                              p_checksum_type => ''3'' )||''">''||l_people_not_users_cnt||''</a>'');',
'    end if;',
'    if l_people_not_users_cnt = 1 then',
'       sys.htp.p('' ''||:NOMENCLATURE_USER ||'' is not defined as a User within this application'');',
'    elsif l_people_not_users_cnt > 1 then',
'       sys.htp.p('' ''||:NOMENCLATURE_USERS || '' are not defined as Users within this application'');',
'    end if;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from APEX_APPL_ACL_USERS',
' where APPLICATION_ID = :APP_ID',
'   and user_name_lc not in (select lower(email)',
'                              from SP_TEAM_MEMBERS)',
'union all',
'select 1',
'  from SP_TEAM_MEMBERS',
' where lower(email) not in (select user_name_lc',
'                              from APEX_APPL_ACL_USERS',
'                             where APPLICATION_ID = :APP_ID)'))
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176222400883519898498)
,p_plug_name=>'ACL Information'
,p_parent_plug_id=>wwv_flow_imp.id(176222400101962898497)
,p_region_css_classes=>'margin-sm'
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--noIcon:t-Alert--warning:t-Alert--accessibleHeading'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_acl_scope varchar2(45);',
'begin',
'    l_acl_scope := apex_app_setting.get_value( p_name => ''ACCESS_CONTROL_SCOPE'' );',
'',
'    if l_acl_scope = ''ALL_USERS'' then',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ALL_USERS'') );',
'    elsif l_acl_scope = ''ACL_ONLY'' then',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ACL_ONLY'') );',
'    else',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ACL_VALUE_INVALID'', l_acl_scope) );',
'    end if;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(176222401307925898498)
,p_name=>'User Counts Report'
,p_parent_plug_id=>wwv_flow_imp.id(176222400101962898497)
,p_template=>4072358936313175081
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--stacked:t-Region--scrollBody:t-Region--noPadding'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.role_name, (select count(*) from apex_appl_acl_user_roles ur where r.role_id = ur.role_id) user_count, r.role_id',
'from apex_appl_acl_roles r',
'where r.application_id = :APP_ID',
'group by r.role_name, r.role_id',
'order by 2 desc, 1'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2100515124465797522
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(176222402056764898506)
,p_query_column_id=>1
,p_column_alias=>'ROLE_NAME'
,p_column_display_sequence=>1
,p_column_heading=>'Role Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(176222402400569898506)
,p_query_column_id=>2
,p_column_alias=>'USER_COUNT'
,p_column_display_sequence=>2
,p_column_heading=>'User Count'
,p_column_format=>'999G999G999G999G999G999G990'
,p_heading_alignment=>'LEFT'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(176222402813053898506)
,p_query_column_id=>3
,p_column_alias=>'ROLE_ID'
,p_column_display_sequence=>3
,p_column_heading=>'Role Id'
,p_heading_alignment=>'LEFT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176222442215745898989)
,p_plug_name=>'Access Control Actions'
,p_parent_plug_id=>wwv_flow_imp.id(176222400101962898497)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_location=>null
,p_list_id=>wwv_flow_imp.id(176222298567641898495)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
,p_plug_query_num_rows=>15
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45076796404144940873)
,p_plug_name=>'Column 2'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>190
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40397379156596202993)
,p_plug_name=>'Look Up Values'
,p_parent_plug_id=>wwv_flow_imp.id(45076796404144940873)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>65
,p_location=>null
,p_list_id=>wwv_flow_imp.id(40583452023793001648)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48653980386614826597)
,p_plug_name=>'Approval Options'
,p_parent_plug_id=>wwv_flow_imp.id(45076796404144940873)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>75
,p_location=>null
,p_list_id=>wwv_flow_imp.id(48656700750658988902)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176229727605146951069)
,p_plug_name=>'Configuration'
,p_parent_plug_id=>wwv_flow_imp.id(45076796404144940873)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>85
,p_location=>null
,p_list_id=>wwv_flow_imp.id(176233242615865399099)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2067994871570597190
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176222298058585898494)
,p_plug_name=>'Administration'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176222400537535898498)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176222400101962898497)
,p_button_name=>'ADD_USER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add User'
,p_button_position=>'EDIT'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:10012:&SESSION.::&DEBUG.:RP,10012::'
,p_icon_css_classes=>'fa-user-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41217571360673479217)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176222298058585898494)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29014886857286880731)
,p_name=>'P10000_USER_COUNTS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(176222442215745898989)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(30944278150006136854)
,p_name=>'P10000_RM_DEFAULT_TAGS'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40293451022204691807)
,p_name=>'P10000_FOCUS_AREAS'
,p_item_sequence=>150
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40965297875138321305)
,p_name=>'P10000_PROJECT_STATUS_SCALES'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40965298134891321307)
,p_name=>'P10000_RESOURCE_TYPES'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40965298337815321309)
,p_name=>'P10000_PROJECT_PRIORITIES'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41376453647980866277)
,p_name=>'P10000_SYSTEM_NOTIFICATIONS'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42241921626847430811)
,p_name=>'P10000_PROJECT_SIZES'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42765983732395148778)
,p_name=>'P10000_REL_MILESTONE_TYPES'
,p_item_sequence=>170
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46927339131240774893)
,p_name=>'P10000_DEFAULT_TAGS'
,p_item_sequence=>130
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47393924489649158990)
,p_name=>'P10000_COMPETENCIES'
,p_item_sequence=>30
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47728213479425889973)
,p_name=>'P10000_COUNTRIES'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50330188575174852617)
,p_name=>'P10000_TEAM_MBR_DEFAULT_TAGS'
,p_item_sequence=>50
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50493824092762761109)
,p_name=>'P10000_ACTIVITY_TYPES'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52590899278030963419)
,p_name=>'P10000_PROJECT_STATUSES'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55177377520606247793)
,p_name=>'P10000_TASK_TYPES'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55177377791825247796)
,p_name=>'P10000_TASK_STATUSES'
,p_item_sequence=>110
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41376453698421866278)
,p_computation_sequence=>20
,p_computation_item=>'P10000_SYSTEM_NOTIFICATIONS'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_APPLICATION_NOTIFICATIONS where IS_ACTIVE_YN = ''Y'''
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(50330188671973852618)
,p_computation_sequence=>30
,p_computation_item=>'P10000_TEAM_MBR_DEFAULT_TAGS'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_DEFAULT_PEOPLE_TAGS'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40965298047747321306)
,p_computation_sequence=>10
,p_computation_item=>'P10000_PROJECT_STATUS_SCALES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_PROJECT_SCALES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40965298222488321308)
,p_computation_sequence=>20
,p_computation_item=>'P10000_RESOURCE_TYPES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_RESOURCE_TYPES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40965298459285321310)
,p_computation_sequence=>30
,p_computation_item=>'P10000_PROJECT_PRIORITIES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_PROJECT_PRIORITIES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46927339255251774894)
,p_computation_sequence=>60
,p_computation_item=>'P10000_DEFAULT_TAGS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_DEFAULT_TAGS'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(30944278227697136855)
,p_computation_sequence=>70
,p_computation_item=>'P10000_RM_DEFAULT_TAGS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_release_milestone_default_tags'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40293451069977691808)
,p_computation_sequence=>80
,p_computation_item=>'P10000_FOCUS_AREAS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_INITIATIVE_FOCUS_AREAS'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(47728213619267889974)
,p_computation_sequence=>90
,p_computation_item=>'P10000_COUNTRIES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(distinct country_code) from SP_COUNTRIES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(55177377725440247795)
,p_computation_sequence=>100
,p_computation_item=>'P10000_TASK_STATUSES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_task_statuses;'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(53088313955826006970)
,p_computation_sequence=>110
,p_computation_item=>'P10000_PROJECT_STATUSES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_project_statuses;'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(55177377610828247794)
,p_computation_sequence=>120
,p_computation_item=>'P10000_TASK_TYPES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_task_types;'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(42241921699171430812)
,p_computation_sequence=>130
,p_computation_item=>'P10000_PROJECT_SIZES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) c from SP_PROJECT_SIZES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(50493824178640761110)
,p_computation_sequence=>140
,p_computation_item=>'P10000_ACTIVITY_TYPES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_activity_types'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(42765983819187148779)
,p_computation_sequence=>160
,p_computation_item=>'P10000_REL_MILESTONE_TYPES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from sp_release_milestone_types'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(47393924587990158991)
,p_computation_sequence=>170
,p_computation_item=>'P10000_COMPETENCIES'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select count(*) from SP_COMPETENCIES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(29014886885398880732)
,p_computation_sequence=>180
,p_computation_item=>'P10000_USER_COUNTS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_counts  varchar2(4000);',
'begin',
'',
'for c1 in (',
'    select r.role_name, ',
'           (select count(*) from apex_appl_acl_user_roles ur where r.role_id = ur.role_id) user_count',
'      from apex_appl_acl_roles r',
'     where r.application_id = :APP_ID',
'     group by r.role_name, r.role_id',
'     order by 2 desc, 1',
') loop',
'    if l_counts is not null then',
'        l_counts := l_counts ||'', '';',
'    end if;',
'    l_counts := l_counts || to_char(c1.user_count,''999G999G999G999G999G999G990'') ||'' ''|| c1.role_name ||',
'                case when c1.user_count != 1 ',
'                     then ''s''',
'                     end;',
'end loop;',
'',
'return l_counts;',
'',
'end;'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(176222441354636898988)
,p_name=>'Refresh Report'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(176222400537535898498)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(176222441799900898988)
,p_event_id=>wwv_flow_imp.id(176222441354636898988)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(176222401307925898498)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
