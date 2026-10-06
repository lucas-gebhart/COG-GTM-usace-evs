prompt --application/pages/page_00064
begin
--   Manifest
--     PAGE: 00064
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
 p_id=>64
,p_name=>'Project Change History'
,p_alias=>'CHANGE-HISTORY'
,p_step_title=>'Change History'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38173863368175508793)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38173863877574508809)
,p_name=>'Search Results'
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--inline:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select :NOMENCLATURE_PROJECT change_to,',
'       :NOMENCLATURE_PROJECT parent_type,',
'       PROJECT_ID             project_id,',
'       CHANGED_ON             ATTRIBUTE_CHANGE_DATE,',
'       to_char(CHANGED_ON,''YYYY.MM'') ATTRIBUTE_CHANGE_Month,',
'       case change_type when ''CREATE'' then ''Added''',
'                        when ''UPDATE'' then ''Updated''',
'                        when ''DELETE'' then ''Deleted''',
'                        else change_type',
'            end change_type,',
'       --',
'       initcap(replace(attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       changed_by',
'  from SP_PROJECT_HISTORY',
'where  project_id = :P64_PROJECT_ID',
'union all',
'select tt.task_type ||',
'       case when t.task_sub_type_id is not null',
'            then (select '': ''||task_type from sp_task_types where t.task_sub_type_id = id)',
'            end change_to,',
'       tt.task_type parent_type,',
'       t.PROJECT_ID             project_id,',
'       h.CHANGED_ON             ATTRIBUTE_CHANGE_DATE,',
'       to_char(h.CHANGED_ON,''YYYY.MM'') ATTRIBUTE_CHANGE_Month,',
'       case h.change_type when ''CREATE'' then ''Added''',
'                        when ''UPDATE'' then ''Updated''',
'                        when ''DELETE'' then ''Deleted''',
'                        else change_type',
'            end change_type,',
'       --',
'       initcap(replace(h.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(h.old_value,''Y'',''Yes'',''N'',''No'',h.old_value) OLD_VALUE,',
'       decode(h.new_value,''Y'',''Yes'',''N'',''No'',h.new_value) NEW_VALUE,',
'       h.changed_by',
'  from sp_task_history h,',
'       sp_tasks t,',
'       sp_task_types tt',
' where h.task_id = t.id',
'   and t.task_type_id = tt.id',
'   and t.project_id = :P64_PROJECT_ID'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P64_PROJECT_ID'
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
 p_id=>wwv_flow_imp.id(40972227735716736071)
,p_query_column_id=>1
,p_column_alias=>'CHANGE_TO'
,p_column_display_sequence=>12
,p_column_heading=>'Change To'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40972227775449736072)
,p_query_column_id=>2
,p_column_alias=>'PARENT_TYPE'
,p_column_display_sequence=>102
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38173867326959508972)
,p_query_column_id=>3
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38173867665941508972)
,p_query_column_id=>4
,p_column_alias=>'ATTRIBUTE_CHANGE_DATE'
,p_column_display_sequence=>72
,p_column_heading=>'When'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37935482464128005598)
,p_query_column_id=>5
,p_column_alias=>'ATTRIBUTE_CHANGE_MONTH'
,p_column_display_sequence=>82
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330187786819852609)
,p_query_column_id=>6
,p_column_alias=>'CHANGE_TYPE'
,p_column_display_sequence=>32
,p_column_heading=>'Change'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38173868125939508973)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_COLUMN'
,p_column_display_sequence=>22
,p_column_heading=>'Attribute'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38173868924196508973)
,p_query_column_id=>8
,p_column_alias=>'OLD_VALUE'
,p_column_display_sequence=>42
,p_column_heading=>'Old Value'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38173869321418508974)
,p_query_column_id=>9
,p_column_alias=>'NEW_VALUE'
,p_column_display_sequence=>52
,p_column_heading=>'New Value'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37935482185013005596)
,p_query_column_id=>10
,p_column_alias=>'CHANGED_BY'
,p_column_display_sequence=>62
,p_column_heading=>'Changed By'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38173864019502508809)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(38173863877574508809)
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
 p_id=>wwv_flow_imp.id(38173865185910508824)
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
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(69653488153962782688)
,p_name=>'&NOMENCLATURE_PROJECTS.'
,p_template=>4501440665235496320
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:margin-left-md:margin-right-md'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'REGION_POSITION_01'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.INITIATIVE_ID,',
'       f.area focus_area,',
'       f.id focus_area_id,',
'       i.initiative,',
'       p.PROJECT,',
'       (select t.first_name||'' ''||t.last_name',
'       from SP_TEAM_MEMBERS t ',
'       where t.id = p.OWNER_ID) project_owner,',
'       p.owner_id,',
'       p.created,',
'       lower(p.created_by) created_by',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f',
'where ',
'      p.initiative_id = i.id and',
'      i.area_id = f.id and',
'      p.id = :P64_PROJECT_ID'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175592999650864768)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175593456734864768)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175593841951864769)
,p_query_column_id=>3
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>30
,p_column_heading=>'Area'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FOCUS_AREA:#FOCUS_AREA#'
,p_column_linktext=>'#FOCUS_AREA#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175594264942864769)
,p_query_column_id=>4
,p_column_alias=>'FOCUS_AREA_ID'
,p_column_display_sequence=>230
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175594624406864769)
,p_query_column_id=>5
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>40
,p_column_heading=>'Initiative'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.::P23_INITIATIVE,P23_FOCUS_AREA:#INITIATIVE#,#FOCUS_AREA#'
,p_column_linktext=>'#INITIATIVE#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175586243434864760)
,p_query_column_id=>6
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175586583999864761)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_OWNER'
,p_column_display_sequence=>60
,p_column_heading=>'Owner'
,p_column_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RR,5:P5_ID:#OWNER_ID#'
,p_column_linktext=>'#PROJECT_OWNER#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38175587042242864762)
,p_query_column_id=>8
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37935482652674005600)
,p_query_column_id=>9
,p_column_alias=>'CREATED'
,p_column_display_sequence=>250
,p_column_heading=>'Created'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37935482709136005601)
,p_query_column_id=>10
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>260
,p_column_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46709713992124593092)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_button_name=>'Tag-History'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Tag History'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:82:&SESSION.::&DEBUG.:RP,82:P82_ID:&P64_PROJECT_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38175898338977280458)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_button_name=>'refresh'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Refresh'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RR,64:P64_PROJECT_ID:&P64_PROJECT_ID.'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38174251513752591260)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&P64_PROJECT_FI.,&P64_PROJECT_PN.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37935481744215005591)
,p_name=>'P64_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37935481834676005592)
,p_name=>'P64_PROJECT_FI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37935481934692005593)
,p_name=>'P64_PROJECT_PN'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38173863368175508793)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37935482304950005597)
,p_name=>'P64_CHANGED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Changed By'
,p_source=>'CHANGED_BY'
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
 p_id=>wwv_flow_imp.id(37935482536619005599)
,p_name=>'P64_ATTRIBUTE_CHANGE_MONTH'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Month'
,p_source=>'ATTRIBUTE_CHANGE_MONTH'
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
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38173864564407508818)
,p_name=>'P64_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Search'
,p_source=>'ATTRIBUTE_DATATYPE,PROJECT_ID,ATTRIBUTE_COLUMN,OLD_VALUE,NEW_VALUE'
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
 p_id=>wwv_flow_imp.id(38173864875744508824)
,p_name=>'P64_ATTRIBUTE_COLUMN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Attribute'
,p_source=>'ATTRIBUTE_COLUMN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'D'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40972227917245736073)
,p_name=>'P64_PARENT_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Type'
,p_source=>'PARENT_TYPE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'D'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50330187964222852610)
,p_name=>'P64_CHANGE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(38173864019502508809)
,p_prompt=>'Change'
,p_source=>'CHANGE_TYPE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'D'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(37935482013693005594)
,p_computation_sequence=>10
,p_computation_item=>'P64_PROJECT_FI'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select FRIENDLY_IDENTIFIER',
'from sp_projects',
'where id = :P64_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(37935482068029005595)
,p_computation_sequence=>20
,p_computation_item=>'P64_PROJECT_PN'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROJECT_URL_NAME',
'from sp_projects',
'where id = :P64_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38252336701321094170)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P64_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1352978835919126401
);
wwv_flow_imp.component_end;
end;
/
