prompt --application/pages/page_00039
begin
--   Manifest
--     PAGE: 00039
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
 p_id=>39
,p_name=>'Page Views'
,p_alias=>'PAGE-VIEWS'
,p_step_title=>'Page Views'
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
 p_id=>wwv_flow_imp.id(45994478977524977889)
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
 p_id=>wwv_flow_imp.id(45994479591563977891)
,p_plug_name=>'Page Performance'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select step_id page,',
'    USERID_LC username,',
'    nvl((   select p.page_title||'' (''||p.PAGE_FUNCTION||'')'' page_name',
'        from apex_application_pages p',
'        where p.page_id = l.step_id',
'            and p.application_id = :app_id ),''Unknown'') page_name,',
'    elap                  elapsed,',
'    session_id,',
'    nvl(num_rows,0)       num_rows,',
'    decode(page_mode,''P'',''Partial Page'',''D'',''Full Page'',''Other - ''||page_mode) page_mode,',
'    time_stamp,',
'    time_stamp time_stamp_since',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and userid is not null'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Page Performance'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(45994479692657977891)
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
,p_internal_uid=>9095121827256010122
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45994480052376977895)
,p_db_column_name=>'PAGE'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45994480489556977896)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Page Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199331667736412946)
,p_db_column_name=>'ELAPSED'
,p_display_order=>12
,p_column_identifier=>'O'
,p_column_label=>'Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D000'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199331753256412947)
,p_db_column_name=>'SESSION_ID'
,p_display_order=>22
,p_column_identifier=>'P'
,p_column_label=>'Session ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199331782319412948)
,p_db_column_name=>'NUM_ROWS'
,p_display_order=>32
,p_column_identifier=>'Q'
,p_column_label=>'Num Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199331969779412949)
,p_db_column_name=>'PAGE_MODE'
,p_display_order=>42
,p_column_identifier=>'R'
,p_column_label=>'Page Mode'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199332069848412950)
,p_db_column_name=>'TIME_STAMP'
,p_display_order=>52
,p_column_identifier=>'S'
,p_column_label=>'Time Stamp'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY HH24:MI:SS'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43199332168653412951)
,p_db_column_name=>'TIME_STAMP_SINCE'
,p_display_order=>62
,p_column_identifier=>'T'
,p_column_label=>'Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43821883600884656156)
,p_db_column_name=>'USERNAME'
,p_display_order=>72
,p_column_identifier=>'U'
,p_column_label=>'Username'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(18849805038577275112)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Users Active in last hour'
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'188482655'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE:PAGE_NAME:ELAPSED:USERNAME:NUM_ROWS:PAGE_MODE:TIME_STAMP_SINCE'
,p_sort_column_1=>'TIME_STAMP_SINCE'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'ELAPSED'
,p_sort_direction_2=>'DESC'
,p_count_distnt_col_on_break=>'USERNAME'
,p_chart_type=>'bar'
,p_chart_label_column=>'USERNAME'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(18849805385951275115)
,p_report_id=>wwv_flow_imp.id(18849805038577275112)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'TIME_STAMP_SINCE'
,p_operator=>'is in the last'
,p_expr_type=>'VALUE'
,p_expr=>'1'
,p_expr2=>'hours'
,p_condition_sql=>'"TIME_STAMP_SINCE" between sysdate - numtodsinterval(1 * #APXWS_EXPR#,  ''hour'') and sysdate'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 1 #APXWS_EXPR2_NAME#'
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(45994487578504978546)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'27689094'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE:PAGE_NAME:ELAPSED:USERNAME:NUM_ROWS:PAGE_MODE:TIME_STAMP_SINCE'
,p_sort_column_1=>'TIME_STAMP_SINCE'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'ELAPSED'
,p_sort_direction_2=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40288904357335420805)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(45994478977524977889)
,p_button_name=>'refresh'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Refresh'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:39:&SESSION.::&DEBUG.:RP,39::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40432338310979203132)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(45994478977524977889)
,p_button_name=>'page_performance'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Page Performance'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:71:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40444240224732221777)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(45994478977524977889)
,p_button_name=>'user_interactions'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'User Interactions'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:72:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40432337952241203130)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(45994478977524977889)
,p_button_name=>'up'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
