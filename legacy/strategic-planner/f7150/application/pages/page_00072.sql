prompt --application/pages/page_00072
begin
--   Manifest
--     PAGE: 00072
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
 p_id=>72
,p_name=>'Page Views by User'
,p_alias=>'PAGE-VIEWS-BY-USER'
,p_step_title=>'Page Views by User'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40444239848690221773)
,p_plug_name=>'FIlter'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49539090999740835493)
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49539091613779835495)
,p_plug_name=>'Page Performance'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    USERID_LC username,',
'    count(*)                   page_views,',
'    count(distinct step_id)    pages_viewed,',
'    min(elap)                  min_elapsed,',
'    max(elap)                  max_elapsed,',
'    median(elap)               median_elapsed,',
'    sum(decode(page_mode,''P'',1,0)) partial_page_views,',
'    sum(decode(page_mode,''D'',1,0)) full_page_views,',
'    min(time_stamp)            first_view,',
'    max(time_stamp)            most_recent_view',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and userid is not null',
'    and userid_lc != ''nobody''',
'    and time_stamp > nvl(to_date(:P72_SINCE,''DD-MON-YYYY''),sysdate - 7)',
'group by userid_lc'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Page Performance'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(49539091714873835495)
,p_name=>'Page Performance'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>12639733849471867726
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47366495623100513760)
,p_db_column_name=>'USERNAME'
,p_display_order=>72
,p_column_identifier=>'U'
,p_column_label=>'Username'
,p_column_link=>'f?p=&APP_ID.:39:&SESSION.::&DEBUG.:RR,39:IR_USERNAME:#USERNAME#'
,p_column_linktext=>'#USERNAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905228509420814)
,p_db_column_name=>'PAGE_VIEWS'
,p_display_order=>82
,p_column_identifier=>'V'
,p_column_label=>'Page Events'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40444239757030221772)
,p_db_column_name=>'PAGES_VIEWED'
,p_display_order=>92
,p_column_identifier=>'AD'
,p_column_label=>'Pages Viewed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905336742420815)
,p_db_column_name=>'MIN_ELAPSED'
,p_display_order=>102
,p_column_identifier=>'W'
,p_column_label=>'Min Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D0000'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905441612420816)
,p_db_column_name=>'MAX_ELAPSED'
,p_display_order=>112
,p_column_identifier=>'X'
,p_column_label=>'Max Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D0000'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905472401420817)
,p_db_column_name=>'MEDIAN_ELAPSED'
,p_display_order=>122
,p_column_identifier=>'Y'
,p_column_label=>'Median Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D0000'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905610243420818)
,p_db_column_name=>'PARTIAL_PAGE_VIEWS'
,p_display_order=>132
,p_column_identifier=>'Z'
,p_column_label=>'Partial Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40288905690468420819)
,p_db_column_name=>'FULL_PAGE_VIEWS'
,p_display_order=>142
,p_column_identifier=>'AA'
,p_column_label=>'Full Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40444239496634221770)
,p_db_column_name=>'FIRST_VIEW'
,p_display_order=>152
,p_column_identifier=>'AB'
,p_column_label=>'First View'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40444239621392221771)
,p_db_column_name=>'MOST_RECENT_VIEW'
,p_display_order=>162
,p_column_identifier=>'AC'
,p_column_label=>'Most Recent'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(49539099600720836150)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'27689094'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'USERNAME:PAGE_VIEWS:PAGES_VIEWED:MOST_RECENT_VIEW:MAX_ELAPSED:MEDIAN_ELAPSED:MIN_ELAPSED'
,p_sort_column_1=>'PAGE_VIEWS'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'MOST_RECENT_VIEW'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'TIME_STAMP_SINCE'
,p_sort_direction_3=>'DESC'
,p_sort_column_4=>'ELAPSED'
,p_sort_direction_4=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40444239981503221775)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(40444239848690221773)
,p_button_name=>'Go'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--gapTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Go'
,p_button_alignment=>'RIGHT'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40443970518320825398)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(49539090999740835493)
,p_button_name=>'refresh'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Refresh'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:72:&SESSION.::&DEBUG.:RP,72::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40443970830835825400)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(49539090999740835493)
,p_button_name=>'page_performance'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Page Performance'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:71:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40444240272942221778)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(49539090999740835493)
,p_button_name=>'page_views'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Page Views'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:39:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40443971179839825401)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(49539090999740835493)
,p_button_name=>'up'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Up'
,p_button_position=>'UP'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40444239955917221774)
,p_name=>'P72_SINCE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40444239848690221773)
,p_item_default=>'select to_char(sysdate-7,''DD-MON-YYYY'') from dual'
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Since'
,p_format_mask=>'DD-MON-YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40444240076644221776)
,p_computation_sequence=>10
,p_computation_item=>'P72_SINCE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select to_char(sysdate - 7,''DD-MON-YYYY'') x from dual'
,p_compute_when=>'P72_SINCE'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp.component_end;
end;
/
