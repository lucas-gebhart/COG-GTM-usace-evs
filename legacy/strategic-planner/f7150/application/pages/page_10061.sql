prompt --application/pages/page_10061
begin
--   Manifest
--     PAGE: 10061
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
 p_id=>10061
,p_name=>'Task Statuses'
,p_alias=>'TASK-STATUSES'
,p_step_title=>'Task Statuses'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56836648363059390256)
,p_plug_name=>'Task Statuses'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.ID,',
'       s.task_type_id,',
'       t.task_type,',
'       s.STATUS,',
'       s.STATIC_ID,',
'       s.DISPLAY_SEQ,',
'       s.CREATED,',
'       s.CREATED_BY,',
'       s.UPDATED,',
'       s.UPDATED_BY,',
'       decode(s.is_default_yn,''Y'',''Yes'',''N'',''No'',s.is_default_yn) is_default,',
'       decode(s.indicates_complete_yn,''Y'',''Yes'',''N'',''No'',s.indicates_complete_yn) indicates_complete,',
'       decode(s.include_yn,''Y'',''Yes'',''N'',''No'',s.include_yn) include,',
'       (select count(*) from SP_TASKS where status_id = s.id) references',
'  from SP_TASK_STATUSES s,',
'       sp_task_types t',
' where task_type_id = t.id (+)'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Review Types'
,p_plug_header=>'These can be customized to meet your needs but retain an entry with the Static ID of COMPLETED.  That is used to ensure that a complete date is provided for tasks of that status.'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(56836648456637390256)
,p_name=>'Review Types'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10062:&SESSION.::&DEBUG.:RP,10062:P10062_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>19937290591235422487
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836648885054390264)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836650030071390266)
,p_db_column_name=>'DISPLAY_SEQ'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Display Seq'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836650459399390266)
,p_db_column_name=>'CREATED'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836650860818390267)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836651235647390267)
,p_db_column_name=>'UPDATED'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56836651675652390267)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(58632181876877631569)
,p_db_column_name=>'INCLUDE'
,p_display_order=>19
,p_column_identifier=>'J'
,p_column_label=>'Include'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(58632182029004631571)
,p_db_column_name=>'REFERENCES'
,p_display_order=>29
,p_column_identifier=>'K'
,p_column_label=>'References'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55059014072331694790)
,p_db_column_name=>'STATUS'
,p_display_order=>39
,p_column_identifier=>'L'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55059014249534694791)
,p_db_column_name=>'INDICATES_COMPLETE'
,p_display_order=>49
,p_column_identifier=>'M'
,p_column_label=>'Indicates Complete'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55177378364130247801)
,p_db_column_name=>'STATIC_ID'
,p_display_order=>59
,p_column_identifier=>'N'
,p_column_label=>'Static ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40972230901282736103)
,p_db_column_name=>'TASK_TYPE'
,p_display_order=>69
,p_column_identifier=>'O'
,p_column_label=>'Task Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40972231255381736106)
,p_db_column_name=>'IS_DEFAULT'
,p_display_order=>79
,p_column_identifier=>'P'
,p_column_label=>'Is Default'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40972231816485736112)
,p_db_column_name=>'TASK_TYPE_ID'
,p_display_order=>89
,p_column_identifier=>'Q'
,p_column_label=>'Selected Task Type'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(56836655589934391584)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'17024967'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TASK_TYPE:STATUS:STATIC_ID:DISPLAY_SEQ:REFERENCES:IS_DEFAULT:INDICATES_COMPLETE:INCLUDE:UPDATED:'
,p_sort_column_1=>'TASK_TYPE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'DISPLAY_SEQ'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'STATUS'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56836654291648390275)
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
 p_id=>wwv_flow_imp.id(57057204314388072312)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into sp_task_statuses (ID, TASK_TYPE_ID, STATUS, STATIC_ID, INCLUDE_YN, IS_DEFAULT_YN, INDICATES_COMPLETE_YN, DISPLAY_SEQ) values (''||',
'       id||'', ''||',
'       task_type_id||'', ''''''||',
'       status||'''''', ''''''||',
'       static_id||'''''', ''''''||',
'       include_yn||'''''', ''''''||',
'       is_default_yn||'''''', ''''''||',
'       indicates_complete_yn||'''''', ''||',
'       DISPLAY_SEQ||'');'' sql',
'  from sp_task_statuses',
'order by display_seq'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55134163075418396332)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55134365488190396334)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56836654291648390275)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10061:&SESSION.::&DEBUG.:RP,10061::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55134368003427396335)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56836654291648390275)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Task Status'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10062:&SESSION.::&DEBUG.:10062::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55134366548474396334)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56836654291648390275)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55134380091881396342)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56836648363059390256)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55134380821869396342)
,p_event_id=>wwv_flow_imp.id(55134380091881396342)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56836648363059390256)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55134381527237396343)
,p_name=>'refresh report on dialog close'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56836654291648390275)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55134382360916396343)
,p_event_id=>wwv_flow_imp.id(55134381527237396343)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56836648363059390256)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
