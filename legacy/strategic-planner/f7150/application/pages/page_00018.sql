prompt --application/pages/page_00018
begin
--   Manifest
--     PAGE: 00018
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
 p_id=>18
,p_name=>'Focus Area'
,p_alias=>'FOCUS-AREA'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_AREA.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066612982220696414)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176241876057327573707)
,p_plug_name=>'&NOMENCLATURE_AREA.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_AREAS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176241882541471573733)
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
 p_id=>wwv_flow_imp.id(176241882966590573733)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176241882541471573733)
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
 p_id=>wwv_flow_imp.id(176241884272108573737)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(176241882541471573733)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176241884736247573738)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(176241882541471573733)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176241885108067573738)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(176241882541471573733)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add &NOMENCLATURE_AREA.'
,p_button_position=>'NEXT'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340179658094205)
,p_name=>'P18_AREA'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_prompt=>'&NOMENCLATURE_AREA.'
,p_source=>'AREA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340390074094207)
,p_name=>'P18_STATUS_SCALE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'STATUS_SCALE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340486169094208)
,p_name=>'P18_IMAGE_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'IMAGE_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340639094094209)
,p_name=>'P18_IMAGE_MIMETYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'IMAGE_MIMETYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340675070094210)
,p_name=>'P18_IMAGE_LAST_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'IMAGE_LAST_UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340822691094211)
,p_name=>'P18_CREATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252340884990094212)
,p_name=>'P18_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252341025110094213)
,p_name=>'P18_UPDATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252341148673094214)
,p_name=>'P18_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41702541751931774090)
,p_name=>'P18_HIDDEN_BY_DEFAULT_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_default=>'N'
,p_prompt=>'Hidden By Default'
,p_source=>'HIDDEN_BY_DEFAULT_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Use this switch to reduce clutter of abandoned &NOMENCLATURE_AREAS..  If an &NOMENCLATURE_AREA. is no longer in use enable this hidden by default.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42281280826360438512)
,p_name=>'P18_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_COMBOBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''UNDER-CONSIDERATION'' d from dual union all',
'select ''MARKETING'' d from dual union all',
'select ''SALES'' d from dual union all',
'select ''SUPPORT'' d from dual',
'order by 1'))
,p_cSize=>30
,p_cMaxlength=>4000
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'max_values_in_list', '7',
  'min_chars', '0',
  'multi_selection', 'N')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42375733729109215389)
,p_name=>'P18_IMAGE'
,p_source_data_type=>'BLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_prompt=>'Drag and Drop Icon Image here'
,p_source=>'IMAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_IMAGE_UPLOAD'
,p_cSize=>30
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_cropping', 'Y',
  'aspect_ratio', '1:1',
  'blob_last_updated_column', 'IMAGE_LAST_UPDATED',
  'display_as', 'DROPZONE_ICON',
  'display_download_link', 'Y',
  'download_link_text', 'Download Icon',
  'filename_column', 'IMAGE_NAME',
  'max_height', '256',
  'max_width', '256',
  'mime_type_column', 'IMAGE_MIMETYPE',
  'preview_size', 'AUTO',
  'storage_type', 'DB_COLUMN')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(176241876329458573711)
,p_name=>'P18_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(176241877207765573717)
,p_name=>'P18_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
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
 p_id=>wwv_flow_imp.id(176241877730871573718)
,p_name=>'P18_OWNER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_item_source_plug_id=>wwv_flow_imp.id(176241876057327573707)
,p_prompt=>'Owner'
,p_source=>'OWNER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'  from SP_TEAM_MEMBERS',
' where is_current_yn = ''Y''',
'    or id = :P18_OWNER_ID',
' order by 1'))
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(176241883043157573733)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(176241882966590573733)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(176241883833632573736)
,p_event_id=>wwv_flow_imp.id(176241883043157573733)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176241885879050573742)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(176241876057327573707)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Focus Area'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed'
,p_internal_uid=>139342528013648605973
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176241886578566573744)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>139342528713164605975
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176241885543297573740)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(176241876057327573707)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Focus Area'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>139342527677895605971
);
wwv_flow_imp.component_end;
end;
/
