prompt --application/pages/page_00129
begin
--   Manifest
--     PAGE: 00129
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
 p_id=>129
,p_name=>'Developer Detail Views'
,p_alias=>'DEVELOPER-DETAIL-VIEWS'
,p_step_title=>'Developer Detail Views (31 Days)'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(47769086658539422762)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38891220483729586164)
,p_name=>'Search Results'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--inline:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select decode(t.first_name,null,l.app_user,t.first_name||'' ''||t.last_name) app_user, ',
'       p.id PROJECT_ID,',
'       p.project,',
'       p.RELEASE_ID,',
'       p.tags,',
'       count(*) interactions,',
'       i.initiative,',
'       a.area,',
'       p.FRIENDLY_IDENTIFIER,',
'       p.PROJECT_URL_NAME,',
'       t.id team_member_id',
'from   sp_proj_interactions_log l,',
'       sp_projects p,',
'       SP_INITIATIVES i,',
'       SP_AREAS a,',
'       sp_team_members t',
'where  l.PAGE_RENDERED > (sysdate - 31) and',
'       l.project_id = p.id and',
'       p.DUPLICATE_OF_PROJECT_ID is null and',
'       p.ARCHIVED_YN = ''N'' and',
'       p.initiative_id = i.id and',
'       i.area_id = a.id and',
'       l.app_user = t.email(+)',
'group  by decode(t.first_name,null,l.app_user,t.first_name||'' ''||t.last_name), p.id, p.project, p.release_id, p.tags, i.initiative, a.area, p.FRIENDLY_IDENTIFIER, p.PROJECT_URL_NAME, t.id'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>100000
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38891223035150586180)
,p_query_column_id=>1
,p_column_alias=>'APP_USER'
,p_column_display_sequence=>1
,p_column_heading=>'App User'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#TEAM_MEMBER_ID#'
,p_column_linktext=>'#APP_USER#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805634884466338697)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>12
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805634990457338698)
,p_query_column_id=>3
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>22
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805635237020338700)
,p_query_column_id=>4
,p_column_alias=>'RELEASE_ID'
,p_column_display_sequence=>42
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805635284104338701)
,p_query_column_id=>5
,p_column_alias=>'TAGS'
,p_column_display_sequence=>52
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38891223384731586181)
,p_query_column_id=>6
,p_column_alias=>'INTERACTIONS'
,p_column_display_sequence=>2
,p_column_heading=>'Interactions'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805635545260338703)
,p_query_column_id=>7
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>62
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805635825764338706)
,p_query_column_id=>8
,p_column_alias=>'AREA'
,p_column_display_sequence=>72
,p_column_heading=>'&NOMENCLATURE_AREA.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805636130572338709)
,p_query_column_id=>9
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>82
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38805636195586338710)
,p_query_column_id=>10
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>92
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39781250708110585511)
,p_query_column_id=>11
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>102
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38891220574312586164)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(38891220483729586164)
,p_landmark_label=>'Filters'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'current_facets_selector', '#active_facets',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'E',
  'show_total_row_count', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38891221813350586173)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>'<div id="active_facets"></div>'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42117921282608663850)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42982264637641678668)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(42117921282608663850)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', 'fa-user',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL_DISPLAY', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(42982265871147678680)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38891222353784586175)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38891221813350586173)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:129:&APP_SESSION.::&DEBUG.:RR,129::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39005019573261904886)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(42117921282608663850)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38805635651166338704)
,p_name=>'P129_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38891220574312586164)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38805635760589338705)
,p_name=>'P129_INITIATIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(38891220574312586164)
,p_prompt=>'Initiative'
,p_source=>'INITIATIVE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38805635959101338707)
,p_name=>'P129_AREA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(38891220574312586164)
,p_prompt=>'Area'
,p_source=>'AREA'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38891221075600586169)
,p_name=>'P129_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38891220574312586164)
,p_prompt=>'Search'
,p_source=>'APP_USER'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'collapsed_search_field', 'N',
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_collapsible=>false
,p_fc_initial_collapsed=>false
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38891221474754586172)
,p_name=>'P129_APP_USER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38891220574312586164)
,p_prompt=>'App User'
,p_source=>'APP_USER'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(42982264938220678671)
,p_region_id=>wwv_flow_imp.id(42982264637641678668)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38805635968557338708)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>120
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:129:&SESSION.::&DEBUG.:RP,129::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38991627572437857808)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'My Favorite &NOMENCLATURE_PROJECTS.'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,:P23_FAVORITE:Yes'
,p_icon_css_classes=>'fa-heart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38991627692391857809)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>100
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40229504441933265897)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View &NOMENCLATURE_PROJECTS.'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40229504501560265898)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Activity'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-badge-check'
,p_build_option_id=>wwv_flow_imp.id(51182682188183937291)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40229504759113265900)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Releases'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-ship'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40229504854167265901)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>50
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40229508479707265937)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View &NOMENCLATURE_USERS.'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42982265644127678678)
,p_component_action_id=>wwv_flow_imp.id(42982264938220678671)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>110
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:129:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp.component_end;
end;
/
