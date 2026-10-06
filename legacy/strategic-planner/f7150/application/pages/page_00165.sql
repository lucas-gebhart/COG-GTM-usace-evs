prompt --application/pages/page_00165
begin
--   Manifest
--     PAGE: 00165
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
 p_id=>165
,p_name=>'AI Release Summaries'
,p_alias=>'AI-RELEASE-SUMMARIES'
,p_page_mode=>'MODAL'
,p_step_title=>'AI Release Summaries'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_patch=>wwv_flow_imp.id(30769244999117825609)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(58752958076255379280)
,p_name=>'AI Summaries'
,p_template=>3371237801798025892
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null user_name,',
'       apex_escape.html(SUMMARY) comment_text,',
'       ''<br/>''||HIGHLIGHTS attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       CREATED comment_date,',
'       ''*'' user_icon,',
'       id ai_summary_id,',
'       ''Details'' actions',
'  from SP_RELEASE_AI_SUMMARIES',
' where RELEASE_ID = :P165_RELEASE_ID',
'   and summary is not null  -- excludes those ending in error',
' order by created desc'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No Summaries found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625151785964755245)
,p_query_column_id=>1
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>110
,p_column_heading=>'User Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625150519194755244)
,p_query_column_id=>2
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>80
,p_column_heading=>'Comment Text'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625151054872755245)
,p_query_column_id=>3
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>90
,p_column_heading=>'Attribute 1'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625153475637755247)
,p_query_column_id=>4
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>140
,p_column_heading=>'Attribute 2'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625153788058755248)
,p_query_column_id=>5
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>150
,p_column_heading=>'Attribute 3'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625154191724755248)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>160
,p_column_heading=>'Attribute 4'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625151462954755245)
,p_query_column_id=>7
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>100
,p_column_heading=>'Comment Date'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625154626038755248)
,p_query_column_id=>8
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>130
,p_column_heading=>'User Icon'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625152982976755247)
,p_query_column_id=>9
,p_column_alias=>'AI_SUMMARY_ID'
,p_column_display_sequence=>180
,p_column_heading=>'Ai Summary Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30625155050480755249)
,p_query_column_id=>10
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>120
,p_column_heading=>'Actions'
,p_column_link=>'f?p=&APP_ID.:166:&SESSION.::&DEBUG.:166:P166_ID:#AI_SUMMARY_ID#'
,p_column_linktext=>'#ACTIONS#'
,p_column_link_attr=>'title="View Details Sent"'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(58755374486648392252)
,p_plug_name=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(30625156960498755252)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(58755374486648392252)
,p_button_name=>'GENERATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Generate Summary'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(30625156101770755251)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(58755374486648392252)
,p_button_name=>'Information'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Info'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:78:&SESSION.::&DEBUG.:78:P78_TYPE:RELEASE'
,p_icon_css_classes=>'fa-info-circle-o'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(57740860422150461799)
,p_name=>'P165_RELEASE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(58752958076255379280)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(30625157972525755253)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_error_yn  varchar2(1);',
'begin',
'',
'sp_summary_util.generate_release_summary (',
'    p_release_id => :P165_RELEASE_ID,',
'    p_error_yn   => l_error_yn );',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(30625156960498755252)
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_internal_uid=>30623618390657697125
);
wwv_flow_imp.component_end;
end;
/
