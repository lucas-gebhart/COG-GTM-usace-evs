prompt --application/pages/page_10065
begin
--   Manifest
--     PAGE: 10065
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
 p_id=>10065
,p_name=>'Task Type'
,p_alias=>'TASK-TYPE'
,p_page_mode=>'MODAL'
,p_step_title=>'Task Type'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55451870180457187693)
,p_name=>'Used as Default for'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlightOff:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.area ||'' / ''|| i.initiative d',
'  from sp_areas f,',
'       sp_initiatives i,',
'       sp_initiative_default_tasks t',
' where i.id = t.initiative_id',
'   and t.type_id = :P10065_ID',
'   and i.area_id = f.id',
'  order by 1'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_default_tasks',
' where type_id = :P10065_ID',
'   and :P10065_ID is not null'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P10065_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
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
 p_id=>wwv_flow_imp.id(55451870341538187694)
,p_query_column_id=>1
,p_column_alias=>'D'
,p_column_display_sequence=>10
,p_column_heading=>'D'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56847200857337705430)
,p_plug_name=>'Task Type'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_TASK_TYPES'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56847207500749705462)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144730408328711555)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56847207500749705462)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144729979387711555)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56847207500749705462)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P10065_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144729209030711554)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56847207500749705462)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P10065_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55144729585573711555)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(56847207500749705462)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Task Type'
,p_button_position=>'NEXT'
,p_button_condition=>'P10065_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46901091485651793909)
,p_name=>'P10065_TASK_NAME_REQ_YN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_prompt=>'Task Name Required'
,p_source=>'TASK_NAME_REQ_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Indicates if tasks of this type will be required to have names in order to be created.  Should be required for more general task types (e.g. Development).'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015244311694801)
,p_name=>'P10065_TASK_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_prompt=>'Task Type'
,p_source=>'TASK_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015346870694802)
,p_name=>'P10065_PARENT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_prompt=>'Parent Type'
,p_source=>'PARENT_TYPE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_type d, id r',
'  from sp_task_types',
' where parent_type_id is null',
'  order by display_seq'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015367292694803)
,p_name=>'P10065_CREATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015498839694804)
,p_name=>'P10065_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015588149694805)
,p_name=>'P10065_UPDATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55059015754416694806)
,p_name=>'P10065_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56847201795851705437)
,p_name=>'P10065_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56847202604002705458)
,p_name=>'P10065_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56847202996495705459)
,p_name=>'P10065_DISPLAY_SEQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_default=>'select max(display_seq) + 10 from SP_TASK_TYPES'
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Display Sequence'
,p_source=>'DISPLAY_SEQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>22
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56847204955467705464)
,p_name=>'P10065_STATIC_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_prompt=>'Static ID'
,p_source=>'STATIC_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_restricted_characters=>'WEB_SAFE'
,p_help_text=>'The static ID is provided for reporting purposes. MILESTONE and REVIEW prefixes are coded to be used within this application for custom reporting and should remain.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(58642746459867946790)
,p_name=>'P10065_INCLUDE_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_source_plug_id=>wwv_flow_imp.id(56847200857337705430)
,p_item_default=>'Y'
,p_prompt=>'Include'
,p_source=>'INCLUDE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Included types are current and new tasks can be created with this type.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(55451872510946187716)
,p_validation_name=>'Cannot change parent if refs'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_tasks',
' where task_sub_type_id = :P10065_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Cannot change parent if the task type is referenced.'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_task_types',
' where nvl(:P10065_PARENT_TYPE_ID,-1) != nvl(parent_type_id,-1)',
'   and id = :P10065_ID'))
,p_validation_condition_type=>'EXISTS'
,p_when_button_pressed=>wwv_flow_imp.id(55144729209030711554)
,p_associated_item=>wwv_flow_imp.id(55059015346870694802)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(37605961833960061941)
,p_validation_name=>'static id no spaces'
,p_validation_sequence=>20
,p_validation=>'instr(:P10065_STATIC_ID,'' '') = 0'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Static ID cannot contain spaces'
,p_associated_item=>wwv_flow_imp.id(56847204955467705464)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55144731439658711556)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(55144730408328711555)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55144731913474711557)
,p_event_id=>wwv_flow_imp.id(55144731439658711556)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55144728504485711554)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(56847200857337705430)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form '
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed'
,p_internal_uid=>18245370639083743785
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55144731001653711556)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>18245373136251743787
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55144728143655711553)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(56847200857337705430)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form'
,p_internal_uid=>18245370278253743784
);
wwv_flow_imp.component_end;
end;
/
