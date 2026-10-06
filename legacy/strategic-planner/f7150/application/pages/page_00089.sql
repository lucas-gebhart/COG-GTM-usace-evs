prompt --application/pages/page_00089
begin
--   Manifest
--     PAGE: 00089
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
 p_id=>89
,p_name=>'Project Views by User'
,p_alias=>'PROJECT-VIEWS-BY-USER'
,p_step_title=>'&NOMENCLATURE_PROJECT. Views by User'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2526643373347724467
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(76736285543824323567)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(91813899886010803195)
,p_name=>'Search Results'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--inline:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.APP_USER,',
'       t.FIRST_NAME||'' ''||t.last_name name,',
'       max(l.PAGE_RENDERED) most_recent,',
'       count(*) view_count,',
'       sum(case when trunc(l.page_rendered,''Month'') >= add_months(trunc(sysdate,''Month''),-3) and',
'                     trunc(l.page_rendered,''Month'') < add_months(trunc(sysdate,''Month''),-2)',
'                then 1',
'                else 0',
'                end) first_month,',
'       sum(case when trunc(l.page_rendered,''Month'') >= add_months(trunc(sysdate,''Month''),-2) and',
'                     trunc(l.page_rendered,''Month'') < add_months(trunc(sysdate,''Month''),-1)',
'                then 1',
'                else 0',
'                end) second_month,',
'       sum(case when trunc(l.page_rendered,''Month'') >= add_months(trunc(sysdate,''Month''),-1) and',
'                     trunc(l.page_rendered,''Month'') < trunc(sysdate,''Month'')',
'                then 1',
'                else 0',
'                end) third_month,',
'       sum(case when trunc(l.page_rendered,''Month'') >= trunc(sysdate,''Month'')',
'                then 1',
'                else 0',
'                end) current_month,        ',
'       t.tags',
'  from SP_PROJ_INTERACTIONS_LOG l,',
'       sp_projects p,',
'       SP_TEAM_MEMBERS t',
'where l.project_id = p.id and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.archived_yn = ''N'' and',
'      trunc(l.page_rendered,''Month'') >= add_months(trunc(sysdate,''Month''),-3) and',
'      t.email = l.app_user',
'group by ',
'       l.APP_USER,',
'       t.FIRST_NAME||'' ''||t.last_name,',
'       t.tags'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>'{"orderBys":[{"key":"VIEW_COUNT","expr":"view_count desc"},{"key":"APP_USER","expr":"app_user"},{"key":"MOST_RECENT","expr":"most_recent desc"}],"itemName":"P89_ORDER_BY"}'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>100000
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_report_total_text_format=>'&nbsp;'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083680598954389392)
,p_query_column_id=>1
,p_column_alias=>'APP_USER'
,p_column_display_sequence=>94
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53205377835731421211)
,p_query_column_id=>2
,p_column_alias=>'NAME'
,p_column_display_sequence=>14
,p_column_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55205717912806996815)
,p_query_column_id=>3
,p_column_alias=>'MOST_RECENT'
,p_column_display_sequence=>84
,p_column_heading=>'Last View'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55205718308415996815)
,p_query_column_id=>4
,p_column_alias=>'VIEW_COUNT'
,p_column_display_sequence=>64
,p_column_heading=>'Total Views'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083680787055389394)
,p_query_column_id=>5
,p_column_alias=>'FIRST_MONTH'
,p_column_display_sequence=>24
,p_column_heading=>'&P89_FIRST_MONTH.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083680920430389395)
,p_query_column_id=>6
,p_column_alias=>'SECOND_MONTH'
,p_column_display_sequence=>34
,p_column_heading=>'&P89_SECOND_MONTH.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083681021324389396)
,p_query_column_id=>7
,p_column_alias=>'THIRD_MONTH'
,p_column_display_sequence=>44
,p_column_heading=>'&P89_THIRD_MONTH.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083681108518389397)
,p_query_column_id=>8
,p_column_alias=>'CURRENT_MONTH'
,p_column_display_sequence=>54
,p_column_heading=>'&P89_CURRENT_MONTH.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53205377987230421213)
,p_query_column_id=>9
,p_column_alias=>'TAGS'
,p_column_display_sequence=>74
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(91813899942577803195)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(91813899886010803195)
,p_landmark_label=>'Filters'
,p_ai_enabled=>false
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
 p_id=>wwv_flow_imp.id(122130069652439385447)
,p_plug_name=>'Items'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI:margin-bottom-none'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>3
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_plug_source=>'<div id="active_facets"></div>'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55205721124645996820)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:89:&SESSION.::&DEBUG.:RR,89::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24496715857248436235)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(76736285543824323567)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53205378068030421214)
,p_name=>'P89_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(91813899942577803195)
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
,p_fc_show_more_count=>7
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
 p_id=>wwv_flow_imp.id(55083681187605389398)
,p_name=>'P89_FIRST_MONTH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083681347856389399)
,p_name=>'P89_SECOND_MONTH'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083681394443389400)
,p_name=>'P89_THIRD_MONTH'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083681503769389401)
,p_name=>'P89_CURRENT_MONTH'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(89816527050197467509)
,p_name=>'P89_ORDER_BY'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(122130069652439385447)
,p_item_display_point=>'NEXT'
,p_item_default=>'VIEW_COUNT'
,p_prompt=>'Order By'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Total View Count;VIEW_COUNT,User;APP_USER,Most Recent;MOST_RECENT'
,p_cHeight=>1
,p_tag_css_classes=>'w200 no-item-ui'
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-desc'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(91813910963229803226)
,p_name=>'P89_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(91813899942577803195)
,p_prompt=>'Search'
,p_source=>'APP_USER, NAME, COUNTRY'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55083681642575389402)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set headers'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select add_months(trunc(sysdate,''Month''),-3) first_month,',
'           add_months(trunc(sysdate,''Month''),-2) second_month,',
'           add_months(trunc(sysdate,''Month''),-1) third_month,',
'           trunc(sysdate,''Month'') current_month',
'      from dual',
') loop',
'    :P89_FIRST_MONTH   := to_char(c1.first_month,''Mon YYYY'');',
'    :P89_SECOND_MONTH  := to_char(c1.second_month,''Mon YYYY'');',
'    :P89_THIRD_MONTH   := to_char(c1.third_month,''Mon YYYY'');',
'    :P89_CURRENT_MONTH := to_char(c1.current_month,''Mon YYYY'');',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>18184323777173421633
);
wwv_flow_imp.component_end;
end;
/
