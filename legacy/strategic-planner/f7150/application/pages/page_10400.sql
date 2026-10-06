prompt --application/pages/page_10400
begin
--   Manifest
--     PAGE: 10400
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
 p_id=>10400
,p_name=>'Nomenclature'
,p_alias=>'NOMENCLATURE'
,p_step_title=>'Nomenclature'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44865515018369298194)
,p_plug_name=>'Nomenclature'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       static_id,',
'       default_order,',
'       DEFAULT_VALUE,',
'       --',
'       v(''NOMENCLATURE_''||STATIC_ID) current_label,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY',
'  from SP_APP_NOMENCLATURE'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Nomenclature'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Customize the application name and select primary attribute names to conform to your organization''s terminology.</p>',
'<p>Edit any of the attributes, changing the draft value.  ',
'    Once all changes have been made, use the Publish Draft Labels button to apply the changes to the application.</p>'))
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(44865515156752298194)
,p_name=>'Nomenclature'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10410:&APP_SESSION.::&DEBUG.:RP:P10410_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>7966157291350330425
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865515486483298195)
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
 p_id=>wwv_flow_imp.id(44865515918291298196)
,p_db_column_name=>'STATIC_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Static ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(66427331527417122578)
,p_db_column_name=>'CURRENT_LABEL'
,p_display_order=>12
,p_column_identifier=>'O'
,p_column_label=>'Current Label'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865516683603298196)
,p_db_column_name=>'DEFAULT_VALUE'
,p_display_order=>22
,p_column_identifier=>'D'
,p_column_label=>'Draft Label'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(66427331282782122576)
,p_db_column_name=>'DEFAULT_ORDER'
,p_display_order=>92
,p_column_identifier=>'N'
,p_column_label=>'Order'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865517065545298197)
,p_db_column_name=>'CREATED'
,p_display_order=>102
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865517499185298197)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>112
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865517933752298197)
,p_db_column_name=>'UPDATED'
,p_display_order=>122
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44865518348662298198)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>132
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(44865531501974319080)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'79661737'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEFAULT_ORDER:CURRENT_LABEL:DEFAULT_VALUE:UPDATED'
,p_sort_column_1=>'DEFAULT_ORDER'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'STATIC_ID'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'UPDATED'
,p_sort_direction_3=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44865520175740298199)
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
 p_id=>wwv_flow_imp.id(45200198763131234348)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(44865520175740298199)
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
 p_id=>wwv_flow_imp.id(45200199996637234360)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(66427335302195122616)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''||',
'       ''''''''||static_id||'''''', ''||',
'       default_order||'', ''||',
'       ''''''''||replace(default_value,'''''''','''''''''''')||''''''''||',
'       '');'' sql',
'  from SP_APP_NOMENCLATURE n'))
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
 p_id=>wwv_flow_imp.id(66427335446220122617)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(44864904982315745040)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(44865520175740298199)
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
 p_id=>wwv_flow_imp.id(44865519161194298198)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(44865515018369298194)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44865519645872298199)
,p_event_id=>wwv_flow_imp.id(44865519161194298198)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(44865515018369298194)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(44569493740879841397)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set_nomenclature'
,p_process_sql_clob=>'sp_util.set_nomenclature;'
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>7670135875477873628
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(44569493641482841396)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set_draft'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update SP_APP_NOMENCLATURE',
'   set CUSTOM_VALUE = DEFAULT_VALUE;',
'   ',
'sp_util.set_nomenclature;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'PUBLISH'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Application Nomenclature reset to Draft Values'
,p_internal_uid=>7670135776080873627
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(51825530131020349285)
,p_region_id=>wwv_flow_imp.id(45200198763131234348)
,p_position_id=>362316004162771045
,p_display_sequence=>5
,p_template_id=>362316605839802174
,p_label=>'Publish Draft Labels'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:10400:&SESSION.:PUBLISH:&DEBUG.:::'
,p_button_display_type=>'TEXT'
,p_is_hot=>true
,p_show_as_disabled=>false
);
wwv_flow_imp.component_end;
end;
/
