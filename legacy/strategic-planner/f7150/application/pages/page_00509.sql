prompt --application/pages/page_00509
begin
--   Manifest
--     PAGE: 00509
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
 p_id=>509
,p_name=>'Review'
,p_alias=>'REVIEW'
,p_page_mode=>'MODAL'
,p_step_title=>'Review'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(172455012607363236919)
,p_plug_name=>'Task'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>40
,p_query_type=>'TABLE'
,p_query_table=>'SP_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(172455021971079236925)
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
 p_id=>wwv_flow_imp.id(38100760204721355520)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(172455021971079236925)
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
 p_id=>wwv_flow_imp.id(38100759860075355520)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(172455021971079236925)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P509_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38100759433781355519)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(172455021971079236925)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P509_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38100758976173355519)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(172455021971079236925)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add'
,p_button_position=>'NEXT'
,p_button_condition=>'P509_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24178316926491483236)
,p_name=>'P509_OLD_OWNER_ID'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select owner_id from sp_tasks',
' where id = :P509_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38252339604970094199)
,p_name=>'P509_IMPACT'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Impact'
,p_source=>'IMPACT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Low;Low,Medium;Medium,High;High'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '6',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199038744642251005)
,p_name=>'P509_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>2
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
 p_id=>wwv_flow_imp.id(56199038900236251006)
,p_name=>'P509_TASK_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'TASK_TYPE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039003934251007)
,p_name=>'P509_TASK_SUB_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Review Type'
,p_source=>'TASK_SUB_TYPE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_type d, id r',
'  from sp_task_types',
' where parent_type_id = :P509_TASK_TYPE_ID',
'   and (include_yn = ''Y'' or id = :P509_TASK_SUB_TYPE_ID)',
' order by display_seq'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P509_TASK_TYPE_ID'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039062057251008)
,p_name=>'P509_OWNER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Assigned To'
,p_source=>'OWNER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'  from SP_TEAM_MEMBERS',
' where is_current_yn = ''Y''',
'    or id = :P509_OWNER_ID',
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039209062251009)
,p_name=>'P509_START_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Start Date'
,p_format_mask=>'DD-MON-YYYY'
,p_source=>'START_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039334558251010)
,p_name=>'P509_TARGET_COMPLETE'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Target Complete'
,p_format_mask=>'DD-MON-YYYY'
,p_source=>'TARGET_COMPLETE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'ITEM',
  'min_item', 'P509_START_DATE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039384073251011)
,p_name=>'P509_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Status'
,p_source=>'STATUS_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select status || case when include_yn = ''N'' ',
'                      then '' (no longer used)'' ',
'                      end d, ',
'       id r',
'  from SP_TASK_STATUSES',
' where (include_yn = ''Y'' or :P509_STATUS_ID = id)',
'   and task_type_id = :P509_TASK_TYPE_ID',
'  order by is_default_yn desc, display_seq'))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039479306251012)
,p_name=>'P509_STATUS_LAST_CHANGED_ON'
,p_source_data_type=>'DATE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'STATUS_LAST_CHANGED_ON'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039717883251014)
,p_name=>'P509_CREATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039769213251015)
,p_name=>'P509_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56199039844757251016)
,p_name=>'P509_UPDATED'
,p_source_data_type=>'DATE'
,p_is_query_only=>true
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(57412684901295215667)
,p_name=>'P509_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(69318597628704246852)
,p_name=>'P509_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>4000
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(172455015673238236949)
,p_name=>'P509_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
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
 p_id=>wwv_flow_imp.id(172455016463282236951)
,p_name=>'P509_PROJECT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_item_source_plug_id=>wwv_flow_imp.id(172455012607363236919)
,p_prompt=>'&NOMENCLATURE_PROJECT.'
,p_source=>'PROJECT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_PROJECTS.PROJECT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38100760942378355521)
,p_computation_sequence=>10
,p_computation_item=>'P509_TASK_TYPE_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select min(id)',
'  from sp_task_types',
' where parent_type_id is null',
'   and include_yn = ''Y''',
'   and static_id = ''REVIEW'''))
,p_compute_when=>'P509_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38100761277355355522)
,p_validation_name=>'when review complete, must provide date'
,p_validation_sequence=>10
,p_validation=>'P509_TARGET_COMPLETE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'When review is completed, must provide date.'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_task_statuses',
' where id = :P509_STATUS_ID',
'   and static_id = ''COMPLETED'''))
,p_validation_condition_type=>'EXISTS'
,p_associated_item=>wwv_flow_imp.id(56199039334558251010)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51905691972451848897)
,p_validation_name=>'when review complete, must provide owner'
,p_validation_sequence=>20
,p_validation=>'P509_OWNER_ID'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'When review is completed, must provide owner.'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_task_statuses',
' where id = :P509_STATUS_ID',
'   and static_id = ''COMPLETED'''))
,p_validation_condition_type=>'EXISTS'
,p_associated_item=>wwv_flow_imp.id(56199039062057251008)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38100762428621355523)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38100760204721355520)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38100762929294355523)
,p_event_id=>wwv_flow_imp.id(38100762428621355523)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38100761656500355522)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete (to avoid project_history table trigger mutation)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select image_ref_id',
'      from sp_task_comments',
'     where task_id = :P509_ID',
'       and image_ref_id is not null',
') loop',
'    delete from sp_comment_images',
'     where image_ref_id = c1.image_ref_id;',
'end loop;',
'',
'delete from sp_task_comments',
' where task_id = :P509_ID;',
'',
'delete from sp_task_documents',
' where task_id = :P509_ID;',
'',
'delete from sp_task_links',
' where task_id = :P509_ID;',
'',
'delete from sp_tasks',
' where id = :P509_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(38100759860075355520)
,p_process_success_message=>'Review deleted.'
,p_internal_uid=>1201403791098387753
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38100758336098355518)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(172455012607363236919)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE, SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Action processed.'
,p_internal_uid=>1201400470696387749
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40293452064415691817)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'send notification (if task owner is not project owner and user is not task owner)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_task_link   varchar2(4000);',
'begin',
'',
'for c1 in (',
'    select apex_escape.html(p.project) project, p.friendly_identifier fi,',
'           apex_escape.html(tt.task_type) task_type, t.target_complete, ',
'           apex_escape.html(t.impact) impact, ',
'           apex_escape.html(t.description) description,',
'           lower(substr(tt.task_type,1,1)) first_letter,',
'           apex_escape.html((select first_name',
'                               from sp_team_members',
'                              where id = :P509_OWNER_ID)) first_name',
'      from sp_projects p,',
'           sp_tasks t,',
'           sp_task_types tt',
'     where t.id = :P509_ID',
'       and t.project_id = p.id',
'       and t.task_sub_type_id = tt.id',
') loop',
'    l_task_link := sp_util.get_setting(p_static_id => ''APP_PREFIX_URL'')||',
'                      apex_page.get_url (',
'                          p_application    => :APP_ID,',
'                          p_page           => ''task-details'',',
'                          p_session        => null,',
'                          p_items          => ''P502_PTID'',',
'                          p_values         => :P509_ID,',
'                          p_plain_url      => TRUE );',
'',
'    sp_util.assignment_notification (',
'        p_team_member_id => :P509_OWNER_ID,',
'        p_app_name       => :NOMENCLATURE_STRATEGIC_PLANNER,',
'        p_app_id         => :APP_ID,',
'        p_title          => ''You have been assigned ''||case when c1.first_letter in (''a'',''o'',''i'')',
'                                                            then ''an ''',
'                                                            else ''a ''',
'                                                            end ||',
'                             c1.task_type||'' Review for ''||c1.project,',
'        p_project_id     => :P509_PROJECT_ID,',
'        p_task_id        => :P509_ID,',
'        p_link           => l_task_link,',
'        p_view_what      => ''Review'',',
'        p_email_contents => ''Hi ''||c1.first_name||''<br/><br/>''||',
'                            ''You have been assigned a Review for the following ''||:NOMENCLATURE_PROJECT||'':<br/><br/>''||',
'                            :NOMENCLATURE_PROJECT||'': <a  style="font-weight:bold" href="''||l_task_link||''">''||c1.project||''</a><br/>''||',
'                            case when c1.task_type is not null ',
'                                 then ''Review Type: <strong>''||c1.task_type||''</strong><br/>''',
'                                 end ||',
'                            case when c1.description is not null ',
'                                 then ''Description: ''||c1.description||''<br/>''',
'                                 end ||',
'                            case when c1.target_complete is not null ',
'                                 then ''Target Complete: ''||to_char(c1.target_complete,''DD-MON-YYYY'')||''<br/>''',
'                                 end ||',
'                            case when c1.impact is not null ',
'                                 then ''Impact: ''||c1.impact||''<br/>''',
'                                 end ||',
'                            ''Assigned by: ''||apex_escape.html(lower(:APP_USER))||''<br/>''||',
'                            ''Assigned on: ''||to_char(sysdate,''DD-MON-YYYY''),',
'        p_notification_type => ''ASSIGNMENT'' );',
'end loop;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from dual',
' where (:P509_ID is null and :P509_OWNER_ID is not null and :P509_OWNER_ID != :APP_USER_ID) ',
'    or (:P509_OWNER_ID is not null and :P509_OWNER_ID != :APP_USER_ID and :P509_OWNER_ID != nvl(:P509_OLD_OWNER_ID,''1'') )'))
,p_process_when_type=>'EXISTS'
,p_internal_uid=>3394094199013724048
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38100761992837355522)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>1201404127435387753
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38100557874764355517)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(172455012607363236919)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form'
,p_internal_uid=>1201200009362387748
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38252337651457094179)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P509_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1352979786055126410
);
wwv_flow_imp.component_end;
end;
/
