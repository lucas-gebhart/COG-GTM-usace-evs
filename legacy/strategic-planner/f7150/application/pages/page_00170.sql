prompt --application/pages/page_00170
begin
--   Manifest
--     PAGE: 00170
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
 p_id=>170
,p_name=>'Add Initiative'
,p_alias=>'ADD-INITIATIVE'
,p_page_mode=>'MODAL'
,p_step_title=>'Add &NOMENCLATURE_INITIATIVE.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>2121795032473542284
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'17'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(189485805779065926611)
,p_plug_name=>'&NOMENCLATURE_INITIATIVE.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(189485812690461926630)
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
 p_id=>wwv_flow_imp.id(50127293927043081139)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(189485812690461926630)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50127295239571081140)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(189485812690461926630)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50047298302072743695)
,p_branch_name=>'next'
,p_branch_action=>'f?p=&APP_ID.:171:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50127295239571081140)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50133921695270657089)
,p_name=>'P170_IMAGE_SELECTED_DISPLAY'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'Icon Selected'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'style="width:70px"  '
,p_begin_on_new_line=>'N'
,p_display_when=>'P170_IMAGE_SELECTED'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'SQL',
  'sql_statement', wwv_flow_string.join(wwv_flow_t_varchar2(
    'select blob_content from apex_application_temp_files',
    ' where application_id = :APP_ID',
    '   and name = :P170_IMAGE_SELECTED')))).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50133921835466657090)
,p_name=>'P170_IMAGE_SELECTED'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54930479178866887455)
,p_name=>'P170_TAGS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'Tags'
,p_display_as=>'NATIVE_COMBOBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''research'' tag from dual union all',
'select ''devops'' tag from dual union all',
'select ''review'' tag from dual',
'order by 1'))
,p_cSize=>30
,p_cMaxlength=>4000
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'max_values_in_list', '7',
  'min_chars', '0',
  'multi_selection', 'Y')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(57852460186319849392)
,p_name=>'P170_IMAGE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'Drag and Drop Icon Image here'
,p_display_as=>'NATIVE_IMAGE_UPLOAD'
,p_cSize=>60
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_cropping', 'N',
  'allow_multiple_files', 'N',
  'display_as', 'DROPZONE_ICON',
  'max_height', '256',
  'max_width', '256',
  'preview_size', 'AUTO',
  'purge_files_at', 'SESSION',
  'storage_type', 'APEX_APPLICATION_TEMP_FILES')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189485809430962926628)
,p_name=>'P170_FOCUS_AREA_ID'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'&NOMENCLATURE_AREA.'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SP_AREAS.AREA'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Choose &NOMENCLATURE_AREA. -'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189485810140964926634)
,p_name=>'P170_INITIATIVE'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'&NOMENCLATURE_INITIATIVE.'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189485810554272926635)
,p_name=>'P170_OBJECTIVE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'Objective'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '90')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(189485810929246926635)
,p_name=>'P170_SPONSOR_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(189485805779065926611)
,p_prompt=>'Owner'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_named_lov=>'SP_TEAM_MEMBERS - CURRENT ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'where is_current_yn = ''Y''',
'order by 1'))
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(50133921884322657091)
,p_computation_sequence=>10
,p_computation_item=>'P170_IMAGE_SELECTED'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P170_IMAGE'
,p_compute_when=>'P170_IMAGE'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(50133919970027657072)
,p_validation_name=>'unique'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiatives',
' where lower(initiative) = lower(:P170_INITIATIVE)',
'   and area_id = :P170_FOCUS_AREA_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'&NOMENCLATURE_INITIATIVE. already exists with same name.'
,p_when_button_pressed=>wwv_flow_imp.id(50127295239571081140)
,p_associated_item=>wwv_flow_imp.id(189485810140964926634)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50127303189490081151)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(50127293927043081139)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50127303737744081153)
,p_event_id=>wwv_flow_imp.id(50127303189490081151)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50133919839261657070)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'clear collections and temp file'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.create_or_truncate_collection (''INITIATIVE_DEFAULT_TASKS'');',
'',
'apex_collection.create_or_truncate_collection (''INITIATIVE_FOCUS_AREAS'');',
'',
'delete from apex_application_temp_files',
' where application_id = :APP_ID;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'P170_INITIATIVE'
,p_process_when_type=>'ITEM_IS_NULL'
,p_internal_uid=>13234561973859689301
);
wwv_flow_imp.component_end;
end;
/
