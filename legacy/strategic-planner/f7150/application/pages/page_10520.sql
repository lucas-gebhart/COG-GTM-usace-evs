prompt --application/pages/page_10520
begin
--   Manifest
--     PAGE: 10520
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
 p_id=>10520
,p_name=>'Team Member Default Tags'
,p_alias=>'TEAM-MEMBER-DEFAULT-TAGS'
,p_step_title=>'Team Member Default Tags'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(41210652394819931049)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into SP_DEFAULT_PEOPLE_TAGS (ID, DISPLAY_SEQUENCE, TAG, DESCRIPTION) values (''||',
'       id||'', ''||',
'       display_sequence||'', ''''''||',
'       TAG||'', ''''''||',
'       DESCRIPTION||'''''');'' SQL',
'  from SP_DEFAULT_PEOPLE_TAGS t',
'order by display_sequence, tag'))
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
 p_id=>wwv_flow_imp.id(40990541452734345799)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51018514457480152819)
,p_plug_name=>'Default Tags'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null edit,',
'       ID,',
'       display_sequence,',
'       TAG,',
'       lower(tag) tag_link,',
'       description,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       (select count(*) from sp_team_members where instr(tags, t.tag) > 0) references',
'  from SP_DEFAULT_PEOPLE_TAGS t'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Default Tags'
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
 p_id=>wwv_flow_imp.id(51018514520358152820)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>14119156654956185051
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018516649998152841)
,p_db_column_name=>'EDIT'
,p_display_order=>10
,p_column_identifier=>'I'
,p_column_label=>'Edit'
,p_column_link=>'f?p=&APP_ID.:15021:&SESSION.::&DEBUG.:RP,15021:P15021_ID:#ID#'
,p_column_linktext=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018514645763152821)
,p_db_column_name=>'ID'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Edit'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594544278956377614)
,p_db_column_name=>'DISPLAY_SEQUENCE'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018514779731152823)
,p_db_column_name=>'TAG'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Tag'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594543836432377609)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>50
,p_column_identifier=>'J'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594544215533377613)
,p_db_column_name=>'REFERENCES'
,p_display_order=>60
,p_column_identifier=>'K'
,p_column_label=>'References'
,p_column_link=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:74:P74_TAGS:#TAG_LINK#'
,p_column_linktext=>'#REFERENCES#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018514881662152824)
,p_db_column_name=>'CREATED'
,p_display_order=>70
,p_column_identifier=>'D'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018515020793152825)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>80
,p_column_identifier=>'E'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018515101235152826)
,p_db_column_name=>'UPDATED'
,p_display_order=>90
,p_column_identifier=>'F'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51018515195134152827)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594544582130377617)
,p_db_column_name=>'TAG_LINK'
,p_display_order=>110
,p_column_identifier=>'M'
,p_column_label=>'Tag Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(51036472522947703749)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'100459378'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EDIT:DISPLAY_SEQUENCE:TAG:DESCRIPTION:REFERENCES:UPDATED:'
,p_sort_column_1=>'DISPLAY_SEQUENCE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'TAG'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'PROJECTS'
,p_sort_direction_3=>'DESC'
,p_sum_columns_on_break=>'PROJECTS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51020477140300819721)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>50
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40990540238347345792)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(51020477140300819721)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40990538745928345768)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(51018514457480152819)
,p_button_name=>'add_tag'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapTop'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Add Tag'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40990540651051345794)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(51020477140300819721)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10520:&SESSION.::&DEBUG.:RP,10520::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51018519754406152887)
,p_name=>'P10520_ADD_TAG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(51018514457480152819)
,p_prompt=>'Add Tag'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40990544477940345838)
,p_name=>'add tag'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(40990538745928345768)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40990545039383345838)
,p_event_id=>wwv_flow_imp.id(40990544477940345838)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_DEFAULT_PEOPLE_TAGS (tag) values (:P10520_ADD_TAG);',
':P10520_ADD_TAG := null;'))
,p_attribute_02=>'P10520_ADD_TAG'
,p_attribute_03=>'P10520_ADD_TAG'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40990545496079345839)
,p_event_id=>wwv_flow_imp.id(40990544477940345838)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'refresh report'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51018514457480152819)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40990543611779345835)
,p_name=>'refresh on dialog close'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(51018514457480152819)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40990544139830345837)
,p_event_id=>wwv_flow_imp.id(40990543611779345835)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51018514457480152819)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
