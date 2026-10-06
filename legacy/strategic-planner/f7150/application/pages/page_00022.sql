prompt --application/pages/page_00022
begin
--   Manifest
--     PAGE: 00022
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
 p_id=>22
,p_name=>'Initiative'
,p_alias=>'INITIATIVE-EDIT'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_INITIATIVE.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176257870655540813250)
,p_plug_name=>'&NOMENCLATURE_INITIATIVE.'
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
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176257877566936813269)
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
 p_id=>wwv_flow_imp.id(176257877929792813269)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176257877566936813269)
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
 p_id=>wwv_flow_imp.id(176257879342397813273)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(176257877566936813269)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P22_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176257879706648813274)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(176257877566936813269)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P22_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176257880105896813274)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(176257877566936813269)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P22_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(53797036524639814992)
,p_branch_name=>'to main initiative page after delete'
,p_branch_action=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:22,94::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(176257879342397813273)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41702541030163774083)
,p_name=>'P22_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'REGION_SOURCE_COLUMN'
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
,p_is_persistent=>'N'
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
 p_id=>wwv_flow_imp.id(41702541487163774088)
,p_name=>'P22_HIDDEN_BY_DEFAULT_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_default=>'N'
,p_prompt=>'Hidden By Default'
,p_source=>'HIDDEN_BY_DEFAULT_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Use this flag to reduce clutter of abandoned &NOMENCLATURE_INITIATIVES..  If an &NOMENCLATURE_INITIATIVE. is no longer in use enable this hidden by default.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44624522037616736020)
,p_name=>'P22_IMAGE'
,p_source_data_type=>'BLOB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'Drag and Drop Icon Image here'
,p_source=>'IMAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_IMAGE_UPLOAD'
,p_cSize=>60
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
 p_id=>wwv_flow_imp.id(176257870959811813251)
,p_name=>'P22_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(176257871282259813256)
,p_name=>'P22_FOCUS_AREA_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'&NOMENCLATURE_AREA.'
,p_source=>'AREA_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SP_AREAS.AREA'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Choose &NOMENCLATURE_AREA. -'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(176257871992261813262)
,p_name=>'P22_INITIATIVE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'&NOMENCLATURE_INITIATIVE.'
,p_source=>'INITIATIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
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
 p_id=>wwv_flow_imp.id(176257872405569813263)
,p_name=>'P22_OBJECTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'Objective'
,p_source=>'OBJECTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(176257872780543813263)
,p_name=>'P22_SPONSOR_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_item_source_plug_id=>wwv_flow_imp.id(176257870655540813250)
,p_prompt=>'Owner'
,p_source=>'SPONSOR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'  from SP_TEAM_MEMBERS',
' where is_current_yn = ''Y''',
'    or id = :P22_SPONSOR_ID',
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
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(53797036353809814990)
,p_validation_name=>'Can''t delete if projects'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_projects',
' where initiative_id = :P22_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'You cannot delete an initiative that has projects.'
,p_when_button_pressed=>wwv_flow_imp.id(176257879342397813273)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(176257878043345813269)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(176257877929792813269)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(176257878775159813272)
,p_event_id=>wwv_flow_imp.id(176257878043345813269)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40046801449761400400)
,p_name=>'refresh status scale report'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_STATUS_SCALE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40046801550124400401)
,p_event_id=>wwv_flow_imp.id(40046801449761400400)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P22_STATUS_SCALE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50133919899275657071)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete - to avoid mutating triggers'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from sp_initiative_approvals',
' where initiative_id = :P22_ID;',
'',
'for c1 in (',
'    select image_ref_id',
'      from sp_initiative_comments',
'     where initiative_id = :P22_ID',
'       and image_ref_id is not null',
') loop',
'    delete from sp_comment_images',
'     where image_ref_id = c1.image_ref_id;',
'end loop;',
'',
'delete from sp_initiative_comments',
' where initiative_id = :P22_ID;',
'',
'delete from sp_initiative_default_tasks',
' where initiative_id = :P22_ID;',
'',
'delete from sp_initiative_documents',
' where initiative_id = :P22_ID;',
'',
'delete from sp_initiative_focus_areas',
' where initiative_id = :P22_ID;',
'',
'delete from sp_initiative_links',
' where initiative_id = :P22_ID;',
'',
'delete from sp_initiatives',
' where id = :P22_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(176257879342397813273)
,p_process_success_message=>'&NOMENCLATURE_INITIATIVE. deleted.'
,p_internal_uid=>13234562033873689302
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176257880918644813276)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(176257870655540813250)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Initiative'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Action Processed'
,p_internal_uid=>139358523053242845507
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176257881291576813277)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>139358523426174845508
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(176257880523395813275)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(176257870655540813250)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Initiative'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>139358522657993845506
);
wwv_flow_imp.component_end;
end;
/
