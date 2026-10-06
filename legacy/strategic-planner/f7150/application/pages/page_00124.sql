prompt --application/pages/page_00124
begin
--   Manifest
--     PAGE: 00124
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
 p_id=>124
,p_name=>'Change History'
,p_alias=>'HISTORY'
,p_page_mode=>'MODAL'
,p_step_title=>'Change History'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38623442689355817676)
,p_name=>'History'
,p_template=>4501440665235496320
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       project,',
'       lower(p.CREATED_BY)||'' ''||apex_util.get_since(p.CREATED) created,',
'       lower(p.UPDATED_BY)||'' ''||apex_util.get_since(p.updated) updated',
'  from SP_PROJECTS p',
'where ',
'      p.archived_yn = ''N'' and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.id = :P124_ID'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623442812690817677)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623442963185817678)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>20
,p_column_heading=>'Project'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623443027979817679)
,p_query_column_id=>3
,p_column_alias=>'CREATED'
,p_column_display_sequence=>30
,p_column_heading=>'Created'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623443066598817680)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>40
,p_column_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39909939958755920747)
,p_name=>'Changes'
,p_template=>4072358936313175081
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null attributes,',
'       project_id,',
'       changed_on ATTRIBUTE_CHANGE_DATE,',
'       to_char(changed_on,''YYYY.MM'') ATTRIBUTE_CHANGE_Month,',
'       --',
'       initcap(replace(attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       case change_type when ''CREATE'' then ''Addition''',
'                        when ''UPDATE'' then ''Update''',
'                        when ''DELETE'' then ''Delete''',
'                        else change_type',
'            end change_type,',
'       substr(decode(old_value,''Y'',''Yes'',''N'',''No'',old_value),1,255)||(decode(greatest(nvl(length(old_value),255),0),255,null,''...'')) OLD_VALUE,',
'       substr(decode(new_value,''Y'',''Yes'',''N'',''No'',new_value),1,255)||(decode(greatest(length(new_value),255),255,null,''...'')) NEW_VALUE,',
'       changed_by',
'  from SP_PROJECT_HISTORY',
'where  project_id = :P124_ID and',
'       attribute_column != ''TAGS'' and',
'       nvl(trim(old_value),''.'') != nvl(trim(new_value),''-'')'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P124_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>100000
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623443778531817687)
,p_query_column_id=>1
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>57
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<strong>#ATTRIBUTE_COLUMN#</strong><br><br>',
'Change Type: #CHANGE_TYPE#<br><br>',
'Old: #OLD_VALUE#<br><br>',
'New: #NEW_VALUE#<br><br>',
'#CHANGED_BY# - #ATTRIBUTE_CHANGE_DATE#<br><br>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635434222227379724)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635434615282379726)
,p_query_column_id=>3
,p_column_alias=>'ATTRIBUTE_CHANGE_DATE'
,p_column_display_sequence=>27
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635436624467379729)
,p_query_column_id=>4
,p_column_alias=>'ATTRIBUTE_CHANGE_MONTH'
,p_column_display_sequence=>37
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635435024842379726)
,p_query_column_id=>5
,p_column_alias=>'ATTRIBUTE_COLUMN'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330188374840852615)
,p_query_column_id=>6
,p_column_alias=>'CHANGE_TYPE'
,p_column_display_sequence=>67
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635435423629379727)
,p_query_column_id=>7
,p_column_alias=>'OLD_VALUE'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635435795889379728)
,p_query_column_id=>8
,p_column_alias=>'NEW_VALUE'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38635436211021379729)
,p_query_column_id=>9
,p_column_alias=>'CHANGED_BY'
,p_column_display_sequence=>17
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40130220208272554582)
,p_plug_name=>'Buttons'
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
 p_id=>wwv_flow_imp.id(38635239609017004787)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40130220208272554582)
,p_button_name=>'Close'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38623443716183817686)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40130220208272554582)
,p_button_name=>'view_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'View &NOMENCLATURE_PROJECT.'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:&P124_ID.'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38623443389691817683)
,p_name=>'P124_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38623442689355817676)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38623443535060817684)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38635239609017004787)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38623443656304817685)
,p_event_id=>wwv_flow_imp.id(38623443535060817684)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp.component_end;
end;
/
