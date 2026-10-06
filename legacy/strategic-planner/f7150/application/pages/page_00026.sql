prompt --application/pages/page_00026
begin
--   Manifest
--     PAGE: 00026
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
 p_id=>26
,p_name=>'AI Summaries'
,p_alias=>'AI-SUMMARIES'
,p_page_mode=>'MODAL'
,p_step_title=>'AI &NOMENCLATURE_PROJECT. Summaries'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_patch=>wwv_flow_imp.id(27803842998100767814)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(28129347697042682169)
,p_name=>'AI Summaries'
,p_template=>3371237801798025892
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sys.dbms_lob.substr(DETAILS_SENT,3000)||',
'           case when length(details_sent) > 3000',
'            then '' ...''',
'            end details_sent,',
'       case when summary_type = ''full''',
'            then ''Full Summary''',
'            else ''Summary Update''',
'            end user_name,',
'       ''<b>''||decode(risk,''None'',''No'',apex_escape.html(risk))||'' risk</b><br/>''||apex_escape.html(SUMMARY) comment_text,',
'       ''<br/>''||HIGHLIGHTS attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       CREATED comment_date,',
'       substr(risk,1,1) user_icon,',
'       case risk when ''None''',
'                 then ''u-color-29''',
'                 when ''High''',
'                 then ''u-color-39''',
'                 when ''Medium''',
'                 then ''u-color-23''',
'                 else ''u-color-5'' ',
'                 end icon_modifier,',
'       id ai_summary_id,',
'       ''Details'' actions',
'  from SP_PROJECT_AI_SUMMARIES',
' where PROJECT_ID = :P26_PROJECT_ID',
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
 p_id=>wwv_flow_imp.id(28129349377307682173)
,p_query_column_id=>1
,p_column_alias=>'DETAILS_SENT'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763286441695133)
,p_query_column_id=>2
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>110
,p_column_heading=>'User Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763075336695130)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>80
,p_column_heading=>'Comment Text'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763088045695131)
,p_query_column_id=>4
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>90
,p_column_heading=>'Attribute 1'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763598040695136)
,p_query_column_id=>5
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>140
,p_column_heading=>'Attribute 2'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763694692695137)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>150
,p_column_heading=>'Attribute 3'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763838376695138)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>160
,p_column_heading=>'Attribute 4'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763240178695132)
,p_query_column_id=>8
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>100
,p_column_heading=>'Comment Date'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763566968695135)
,p_query_column_id=>9
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>130
,p_column_heading=>'User Icon'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763894603695139)
,p_query_column_id=>10
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>170
,p_column_heading=>'Icon Modifier'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(29014888750923880750)
,p_query_column_id=>11
,p_column_alias=>'AI_SUMMARY_ID'
,p_column_display_sequence=>180
,p_column_heading=>'Ai Summary Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(28131763476400695134)
,p_query_column_id=>12
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>120
,p_column_heading=>'Actions'
,p_column_link=>'f?p=&APP_ID.:84:&SESSION.::&DEBUG.::P84_ID:#AI_SUMMARY_ID#'
,p_column_linktext=>'#ACTIONS#'
,p_column_link_attr=>'title="View Details Sent"'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(28131764107435695141)
,p_plug_name=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28131764037227695140)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(28131764107435695141)
,p_button_name=>'GENERATE_FULL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Generate Full Summary'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28131766143568695161)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(28131764107435695141)
,p_button_name=>'GENERATE_UPDATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Generate Update'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_ai_summaries',
' where project_id = :P26_PROJECT_ID'))
,p_button_condition_type=>'EXISTS'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(29014888577740880748)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(28131764107435695141)
,p_button_name=>'Information'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Info'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:78:&SESSION.::&DEBUG.:78:P78_TYPE:PROJECT'
,p_icon_css_classes=>'fa-info-circle-o'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(27117244558809764678)
,p_name=>'P26_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(28129347697042682169)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(28131766257460695162)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_error_yn  varchar2(1);',
'    l_ai_id     number;',
'begin',
'',
'sp_summary_util.generate_project_summary (',
'    p_project_id   => :P26_PROJECT_ID,',
'    p_summary_type => ''update'',',
'    p_ai_id        => l_ai_id,',
'    p_error_yn     => l_error_yn );',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(28131766143568695161)
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_internal_uid=>28130226675592637034
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(28145642684431526801)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'full summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_error_yn  varchar2(1);',
'    l_ai_id     number;',
'begin',
'',
'sp_summary_util.generate_project_summary (',
'    p_project_id   => :P26_PROJECT_ID,',
'    p_summary_type => ''full'',',
'    p_ai_id        => l_ai_id,',
'    p_error_yn     => l_error_yn );',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(28131764037227695140)
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_internal_uid=>28144103102563468673
);
wwv_flow_imp.component_end;
end;
/
