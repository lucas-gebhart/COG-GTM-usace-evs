prompt --application/pages/page_16011
begin
--   Manifest
--     PAGE: 16011
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
 p_id=>16011
,p_name=>'Job Run Details'
,p_alias=>'JOB-RUN-DETAILS'
,p_page_mode=>'MODAL'
,p_step_title=>'Job Run Details'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_protection_level=>'C'
,p_help_text=>'<p>This report includes the run details about the jobs selected to be monitored by this application.</p>'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47992713752881585040)
,p_plug_name=>'Job Run Details'
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select LOG_ID,',
'       JOB_NAME,',
'       LOG_DATE,',
'       OWNER,',
'       JOB_SUBNAME,',
'       STATUS,',
'       ERROR#,',
'       REQ_START_DATE,',
'       ACTUAL_START_DATE,',
'       RUN_DURATION,',
'       INSTANCE_ID,',
'       SESSION_ID,',
'       SLAVE_PID,',
'       CPU_USED,',
'       CREDENTIAL_OWNER,',
'       CREDENTIAL_NAME,',
'       DESTINATION_OWNER,',
'       DESTINATION,',
'       ADDITIONAL_INFO,',
'       ERRORS,',
'       OUTPUT',
'  from user_scheduler_job_run_details ',
' where job_name in (''SP_NOTIF_SUBSCRIPTIONS'',''SP_GENERATE_AI_SUMMARIES_JOB'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Job Run Details'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(47992715315543585050)
,p_name=>'Job Run Details'
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
,p_owner=>'SBKENNED'
,p_internal_uid=>11093357450141617281
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992715805196585055)
,p_db_column_name=>'LOG_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Log ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992716244571585057)
,p_db_column_name=>'JOB_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Job Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992716600350585058)
,p_db_column_name=>'LOG_DATE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Log Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992716994616585058)
,p_db_column_name=>'OWNER'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992717415526585059)
,p_db_column_name=>'JOB_SUBNAME'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Job Subname'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992717828980585059)
,p_db_column_name=>'STATUS'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992718228078585060)
,p_db_column_name=>'ERROR#'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Error Number'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992718638250585060)
,p_db_column_name=>'REQ_START_DATE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Requested Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992718983141585061)
,p_db_column_name=>'ACTUAL_START_DATE'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Actual Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992719420639585061)
,p_db_column_name=>'RUN_DURATION'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Run Duration'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992719798062585062)
,p_db_column_name=>'INSTANCE_ID'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Instance ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992720242142585062)
,p_db_column_name=>'SESSION_ID'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Session ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992720630391585062)
,p_db_column_name=>'SLAVE_PID'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Slave PID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992720976154585063)
,p_db_column_name=>'CPU_USED'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'CPU Used'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992721463470585063)
,p_db_column_name=>'CREDENTIAL_OWNER'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Credential Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992721795316585064)
,p_db_column_name=>'CREDENTIAL_NAME'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Credential Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992722214918585064)
,p_db_column_name=>'DESTINATION_OWNER'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Destination Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992722597323585065)
,p_db_column_name=>'DESTINATION'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Destination'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992723062084585065)
,p_db_column_name=>'ADDITIONAL_INFO'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Additional Information'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992723379785585066)
,p_db_column_name=>'ERRORS'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Errors'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992723856647585067)
,p_db_column_name=>'OUTPUT'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Output'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(47992731075029585086)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'110933733'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'JOB_NAME:LOG_DATE:STATUS:ERROR#:RUN_DURATION:ERRORS'
,p_sort_column_1=>'JOB_NAME'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'LOG_DATE'
,p_sort_direction_2=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47992732314487585092)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(47992713752881585040)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&APP_SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp.component_end;
end;
/
