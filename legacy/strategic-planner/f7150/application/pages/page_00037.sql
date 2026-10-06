prompt --application/pages/page_00037
begin
--   Manifest
--     PAGE: 00037
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
 p_id=>37
,p_name=>'All Project Summaries'
,p_alias=>'ALL-PROJECT-SUMMARIES'
,p_step_title=>'All &NOMENCLATURE_PROJECT. Summaries'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(27803842998100767814)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(132113427859129478327)
,p_plug_name=>'Summaries'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.ID,',
'       s.PROJECT_ID,',
'       s.PROMPT_SENT,',
'       sys.dbms_lob.substr(s.DETAILS_SENT,3000)||',
'           case when length(s.details_sent) > 3000',
'            then '' ...''',
'            end details_sent,',
'       s.SUMMARY_TYPE,',
'       s.DATA_RECEIVED,',
'       s.SUMMARY,',
'       s.RISK,',
'       s.HIGHLIGHTS,',
'       s.CREATED,',
'       p.project',
'  from SP_PROJECT_AI_SUMMARIES s,',
'       sp_projects p',
' where p.id = s.project_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Countries'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(132113427912562478327)
,p_name=>'Countries'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_report_saving=>'N'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_control_break=>'N'
,p_show_computation=>'N'
,p_show_aggregate=>'N'
,p_show_chart=>'N'
,p_show_group_by=>'N'
,p_show_pivot=>'N'
,p_show_flashback=>'N'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>132111888330694420199
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(132113428308953478336)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752288952590527096)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>10
,p_column_identifier=>'Q'
,p_column_label=>'Project ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289723571527104)
,p_db_column_name=>'PROJECT'
,p_display_order=>20
,p_column_identifier=>'Y'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:36:P36_ID:#PROJECT_ID#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752288991339527097)
,p_db_column_name=>'PROMPT_SENT'
,p_display_order=>50
,p_column_identifier=>'R'
,p_column_label=>'Prompt Sent'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289523483527102)
,p_db_column_name=>'SUMMARY_TYPE'
,p_display_order=>70
,p_column_identifier=>'W'
,p_column_label=>'Summary Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289200027527099)
,p_db_column_name=>'DATA_RECEIVED'
,p_display_order=>80
,p_column_identifier=>'T'
,p_column_label=>'Data Received'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289311116527100)
,p_db_column_name=>'SUMMARY'
,p_display_order=>90
,p_column_identifier=>'U'
,p_column_label=>'Summary'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289371981527101)
,p_db_column_name=>'RISK'
,p_display_order=>100
,p_column_identifier=>'V'
,p_column_label=>'Risk'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289561128527103)
,p_db_column_name=>'HIGHLIGHTS'
,p_display_order=>120
,p_column_identifier=>'X'
,p_column_label=>'Highlights'
,p_column_type=>'STRING'
,p_display_text_as=>'STRIP_HTML_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(132113430904041478341)
,p_db_column_name=>'CREATED'
,p_display_order=>130
,p_column_identifier=>'G'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55752289758847527105)
,p_db_column_name=>'DETAILS_SENT'
,p_display_order=>140
,p_column_identifier=>'Z'
,p_column_label=>'Details Sent'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(132113515429759056510)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'108310478'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>1000
,p_report_columns=>'PROJECT:SUMMARY_TYPE:SUMMARY:RISK:HIGHLIGHTS:CREATED'
,p_sort_column_1=>'CREATED'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'STATIC_ID'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'COUNTRY_NAME'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'UPDATED'
,p_sort_direction_4=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(132113435025087478350)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28636590688242820580)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(132113435025087478350)
,p_button_name=>'reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:37:&SESSION.::&DEBUG.:RP,37,CIR,RIR::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28636590347017820580)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(132113435025087478350)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28636591651366820584)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(132113427859129478327)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28636592122523820584)
,p_event_id=>wwv_flow_imp.id(28636591651366820584)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(132113427859129478327)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
