prompt --application/pages/page_00127
begin
--   Manifest
--     PAGE: 00127
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
 p_id=>127
,p_name=>'Default Completeness Scale'
,p_alias=>'DEFAULT-COMPLETENESS-SCALE'
,p_page_mode=>'MODAL'
,p_step_title=>'Default Completeness Scale'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(53095319942587384871)
,p_name=>'Status Scale'
,p_template=>4072358936313175081
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''0%'' pct_complete, pc0_label project_status, pc0_desc description, :P127_STATUS_SCALE selected_scale,',
'       0 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''10%'' pct_complete, pc10_label, pc10_desc, :P127_STATUS_SCALE selected_scale,',
'       10 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''20%'' pct_complete, pc20_label, pc20_desc, :P127_STATUS_SCALE selected_scale,',
'       20 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''30%'' pct_complete, pc30_label, pc30_desc, :P127_STATUS_SCALE selected_scale,',
'       30 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''40%'' pct_complete, pc40_label, pc40_desc, :P127_STATUS_SCALE selected_scale,',
'       40 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''50%'' pct_complete, pc50_label, pc50_desc, :P127_STATUS_SCALE selected_scale,',
'       50 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''60%'' pct_complete, pc60_label, pc60_desc, :P127_STATUS_SCALE selected_scale,',
'       60 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''70%'' pct_complete, pc70_label, pc70_desc, :P127_STATUS_SCALE selected_scale,',
'       70 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''80%'' pct_complete, pc80_label, pc80_desc, :P127_STATUS_SCALE selected_scale,',
'       80 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''90%'' pct_complete, pc90_label, pc90_desc, :P127_STATUS_SCALE selected_scale,',
'       90 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'union all',
'select ''100%'' pct_complete, pc100_label, pc100_desc, :P127_STATUS_SCALE selected_scale,',
'       100 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P127_STATUS_SCALE,''A'')',
'order by r'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P127_STATUS_SCALE'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49947880550253952272)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Completeness'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49947880912040952273)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49947881365041952274)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>60
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49947881766051952275)
,p_query_column_id=>4
,p_column_alias=>'SELECTED_SCALE'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49947882249421952275)
,p_query_column_id=>5
,p_column_alias=>'R'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(189306390875706797738)
,p_plug_name=>'Initiative'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_INITIATIVES'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(189306397787102797757)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49947883586470952277)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(189306397787102797757)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49947884456637952277)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(189306397787102797757)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P127_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53095322508875384895)
,p_name=>'P127_STATUS_SCALE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_item_source_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_item_default=>'A'
,p_prompt=>'Default Completeness Scale'
,p_source=>'STATUS_SCALE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select scale_name, scale_letter',
'  from sp_project_scales',
' where is_active_yn = ''Y''',
' order by scale_letter'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '7',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189306399272842797761)
,p_name=>'P127_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_item_source_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189306400305292797772)
,p_name=>'P127_INITIATIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_item_source_plug_id=>wwv_flow_imp.id(189306390875706797738)
,p_prompt=>'&NOMENCLATURE_INITIATIVE.'
,p_source=>'INITIATIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49947894064045952290)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(49947883586470952277)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49947894515611952293)
,p_event_id=>wwv_flow_imp.id(49947894064045952290)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49947894927118952293)
,p_name=>'refresh status scale report'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P127_STATUS_SCALE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49947895867822952294)
,p_event_id=>wwv_flow_imp.id(49947894927118952293)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P127_STATUS_SCALE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49947895428963952294)
,p_event_id=>wwv_flow_imp.id(49947894927118952293)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(53095319942587384871)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49947892698091952288)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(189306390875706797738)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Initiative'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed'
,p_internal_uid=>13048534832689984519
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49947893578051952290)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>13048535712649984521
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49947892283997952288)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(189306390875706797738)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Initiative'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>13048534418595984519
);
wwv_flow_imp.component_end;
end;
/
