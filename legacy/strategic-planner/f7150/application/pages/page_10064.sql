prompt --application/pages/page_10064
begin
--   Manifest
--     PAGE: 10064
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
 p_id=>10064
,p_name=>'Task Types'
,p_alias=>'TASK-TYPES'
,p_step_title=>'Task Types'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56846670403808638528)
,p_plug_name=>'Task Types'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       case when parent is not null then parent ||'': ''||task_type else task_type end task_type,',
'       DESCRIPTION,',
'       task_name_required,',
'       DISPLAY_SEQ,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       STATIC_ID,',
'       include,',
'       references,',
'       init_refs,',
'       status_count',
'  from (',
'select ID,',
'       task_type,',
'       (select task_type from sp_task_types where id = t.parent_type_id) parent,',
'       DESCRIPTION,',
'       decode(task_name_req_yn,''Y'',''Yes'',''N'',''No'',task_name_req_yn) task_name_required,',
'       DISPLAY_SEQ,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       STATIC_ID,',
'       decode(include_yn,''Y'',''Yes'',''N'',''No'',include_yn) include,',
'       (select count(*) from SP_TASKS where task_type_id = t.id or task_sub_type_id = t.id) references,',
'       (select count(*) from SP_INITIATIVE_DEFAULT_TASKS where type_id = t.id) init_refs,',
'       case when parent_type_id is null then (select count(*) from sp_task_statuses s',
'                                               where task_type_id = t.id) end status_count',
'  from SP_TASK_TYPES t',
'  )'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Review Types'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(56846670497386638528)
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
,p_detail_link=>'f?p=&APP_ID.:10065:&SESSION.::&DEBUG.:RP,10065:P10065_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>19947312631984670759
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846670925803638536)
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
 p_id=>wwv_flow_imp.id(55059015004659694799)
,p_db_column_name=>'TASK_TYPE'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Task Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846671729329638537)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846672070820638538)
,p_db_column_name=>'DISPLAY_SEQ'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Display Seq'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846672500148638538)
,p_db_column_name=>'CREATED'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846672901567638539)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846673276396638539)
,p_db_column_name=>'UPDATED'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846673716401638539)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56846674116463638540)
,p_db_column_name=>'STATIC_ID'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Static ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(58642203917626879841)
,p_db_column_name=>'INCLUDE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Include'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(58642204069753879843)
,p_db_column_name=>'REFERENCES'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Project References'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55451870088548187692)
,p_db_column_name=>'INIT_REFS'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Initiative Default References'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40972231684349736111)
,p_db_column_name=>'STATUS_COUNT'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'Status Count'
,p_column_link=>'f?p=&APP_ID.:10061:&SESSION.::&DEBUG.:CIR,RIR:IR_TASK_TYPE_ID:#ID#'
,p_column_linktext=>'#STATUS_COUNT#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46901091629678793910)
,p_db_column_name=>'TASK_NAME_REQUIRED'
,p_display_order=>140
,p_column_identifier=>'Q'
,p_column_label=>'Task Name Required'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(56846677630683639856)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'17024967'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TASK_TYPE:REFERENCES:STATUS_COUNT:INIT_REFS:INCLUDE:TASK_NAME_REQUIRED:UPDATED:'
,p_sort_column_1=>'TASK_TYPE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'DISPLAY_SEQ'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56846676332397638547)
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
 p_id=>wwv_flow_imp.id(57067226355137320584)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into sp_task_types (ID, STATIC_ID, TASK_TYPE, TASK_NAME_REQ_YN, INCLUDE_YN, DESCRIPTION, PARENT_TYPE_ID, DISPLAY_SEQ) values (''||',
'       id||'', ''''''||',
'       STATIC_ID||'''''', ''''''||',
'       TASK_TYPE||'''''', ''''''||',
'       task_name_req_yn||'''''', ''''''||',
'       include_yn||'''''', ''''''||',
'       description||'''''', ''||',
'       decode(parent_type_id,null,''null'',parent_type_id)||'', ''||',
'       DISPLAY_SEQ||'');'' sql',
'  from sp_task_types ',
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
 p_id=>wwv_flow_imp.id(55144181494404644603)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144182303862644604)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56846676332397638547)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10064:&SESSION.::&DEBUG.:RP,10064::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144183150672644605)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56846676332397638547)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Task Type'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10065:&SESSION.::&DEBUG.:10065::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144182723382644605)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56846676332397638547)
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
 p_id=>wwv_flow_imp.id(55144188046999644612)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56846670403808638528)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55144188575726644612)
,p_event_id=>wwv_flow_imp.id(55144188046999644612)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56846670403808638528)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55144188996868644612)
,p_name=>'refresh report after create'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56846676332397638547)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55144189489619644613)
,p_event_id=>wwv_flow_imp.id(55144188996868644612)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56846670403808638528)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
