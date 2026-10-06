prompt --application/pages/page_00082
begin
--   Manifest
--     PAGE: 00082
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
 p_id=>82
,p_name=>'Tag History'
,p_alias=>'TAG-HISTORY'
,p_page_mode=>'MODAL'
,p_step_title=>'Tag History'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39323069905960075959)
,p_name=>'Tag Changes'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sp_tag_diff(apex_escape.html(old_value),apex_escape.html(new_value)) tag_changes,',
'       apex_util.get_since(CHANGED_ON) || '' - ''|| CHANGED_BY  changed',
'  from SP_PROJECT_HISTORY',
' where project_id = :P82_ID and ',
'       attribute_column = ''TAGS'' and ',
'       (',
'           upper(replace(old_value,'' '',null)) != upper(replace(new_value,'' '',null)) or',
'           old_value is null',
'       )',
'order by CHANGED_ON desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P82_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38150044453083722435)
,p_query_column_id=>1
,p_column_alias=>'TAG_CHANGES'
,p_column_display_sequence=>40
,p_column_heading=>'Tag Changes'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38150044781866722436)
,p_query_column_id=>2
,p_column_alias=>'CHANGED'
,p_column_display_sequence=>30
,p_column_heading=>'Changed'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38136731545521233673)
,p_name=>'P82_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39323069905960075959)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38336267125088919507)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P82_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1436909259686951738
);
wwv_flow_imp.component_end;
end;
/
