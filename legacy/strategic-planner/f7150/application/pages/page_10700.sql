prompt --application/pages/page_10700
begin
--   Manifest
--     PAGE: 10700
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
 p_id=>10700
,p_name=>'Activity Types'
,p_alias=>'MANAGE-ACTIVITY-TYPES'
,p_step_title=>'Activity Types'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(38311123863894769230)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51100019512572408859)
,p_plug_name=>'Activity Types'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       DISPLAY_SEQUENCE,',
'       ACTIVITY_TYPE,',
'       ACTIVITY_TYPE_DESCRIPTION,',
'       decode(is_project_yn,''Y'',''Yes'',''N'',''No'',''Unknown'') is_project_related,',
'       static_id,',
'       decode(is_default_yn,''Y'',''Yes'',''N'',''No'',''Unknown'') is_default,',
'       decode(is_active_yn,''Y'',''Yes'',''N'',''No'',''Unknown'') is_active,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       (select count(*) from sp_activities a where a.activity_type_id = at.id ) activities',
'  from SP_ACTIVITY_TYPES at'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Activity Types'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(51100019618531408859)
,p_name=>'Manage Activity Types'
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
,p_detail_link=>'f?p=&APP_ID.:10710:&APP_SESSION.::&DEBUG.:RP:P10710_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>14200661753129441090
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51100020005768408863)
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
 p_id=>wwv_flow_imp.id(51100020366181408864)
,p_db_column_name=>'DISPLAY_SEQUENCE'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51100020822568408864)
,p_db_column_name=>'ACTIVITY_TYPE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Activity Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51100021234780408865)
,p_db_column_name=>'ACTIVITY_TYPE_DESCRIPTION'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Activity Type Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51100021585082408865)
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
 p_id=>wwv_flow_imp.id(51100021984645408865)
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
 p_id=>wwv_flow_imp.id(51100022405989408866)
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
 p_id=>wwv_flow_imp.id(51100022804292408866)
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
 p_id=>wwv_flow_imp.id(51243451678998848178)
,p_db_column_name=>'STATIC_ID'
,p_display_order=>28
,p_column_identifier=>'J'
,p_column_label=>'Static ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51243451830356848179)
,p_db_column_name=>'IS_DEFAULT'
,p_display_order=>38
,p_column_identifier=>'K'
,p_column_label=>'Is Default'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(36966112038541502593)
,p_db_column_name=>'ACTIVITIES'
,p_display_order=>48
,p_column_identifier=>'L'
,p_column_label=>'Activities'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40397381160060203013)
,p_db_column_name=>'IS_PROJECT_RELATED'
,p_display_order=>58
,p_column_identifier=>'M'
,p_column_label=>'Is Project Related'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40397381260607203014)
,p_db_column_name=>'IS_ACTIVE'
,p_display_order=>68
,p_column_identifier=>'N'
,p_column_label=>'Is Active'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(51100454804755444067)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'142010970'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DISPLAY_SEQUENCE:ACTIVITY_TYPE:STATIC_ID:IS_ACTIVE:IS_DEFAULT:IS_PROJECT_RELATED:ACTIVITIES:UPDATED:'
,p_sort_column_1=>'DISPLAY_SEQUENCE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'ACTIVITIES'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'DESC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(80918202935287499985)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into SP_ACTIVITY_TYPES ''||chr(10)||',
' ''    (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, is_active_yn, static_id ) values (''||chr(10)||',
'       id||'', ''||',
'       DISPLAY_SEQUENCE||'', ''||',
'       ''''''''||ACTIVITY_TYPE||'''''', ''||',
'       ''''''''||replace(ACTIVITY_TYPE_DESCRIPTION,'''''''','''''''''''')||'''''', ''||',
'       ''''''''||IS_DEFAULT_YN||'''''', ''||',
'       ''''''''||nvl(IS_ACTIVE_YN,''Y'')||'''''', ''||',
'       ''''''''||STATIC_ID||'''''');'' sql',
'',
'  from SP_ACTIVITY_TYPES ',
'  order by display_sequence'))
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
 p_id=>wwv_flow_imp.id(51250550462989708983)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(190442107309727612574)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51100499176484456337)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(190442107309727612574)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Activity Type'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10710:&SESSION.::&DEBUG.:10710::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51100499566929456338)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(190442107309727612574)
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
 p_id=>wwv_flow_imp.id(51100023654000408867)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(51100019512572408859)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51100024103645408868)
,p_event_id=>wwv_flow_imp.id(51100023654000408867)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51100019512572408859)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51182574219922902583)
,p_name=>'refresh on dialog closed'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(190442107309727612574)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51182574323701902584)
,p_event_id=>wwv_flow_imp.id(51182574219922902583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51100019512572408859)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
