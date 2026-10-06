prompt --application/pages/page_00503
begin
--   Manifest
--     PAGE: 00503
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
 p_id=>503
,p_name=>'Task Comment'
,p_alias=>'TASK-COMMENT'
,p_page_mode=>'MODAL'
,p_step_title=>'Comment'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45074294665875875763)
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67846499840415899311)
,p_plug_name=>'Task Comment'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_TASK_COMMENTS_V'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67846507155736899346)
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
 p_id=>wwv_flow_imp.id(55058880095947979207)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(67846507155736899346)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55058879730433979206)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(67846507155736899346)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P503_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55058880510872979207)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(67846507155736899346)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P503_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722865221422623550)
,p_name=>'P503_NEW_IMAGE_REF_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55010688960576779717)
,p_name=>'P503_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_source_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_prompt=>'Comment For'
,p_source=>'TASK_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'TASK NAMES FOR DISPLAY LOVS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.id r,',
'       (select task_type from sp_task_types rt where rt.id = r.task_type_id)||',
'           case when r.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = r.task_sub_type_id) ||',
'           case when r.task is not null then '' - ''||r.task end d',
'  from sp_tasks r'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59862060493428785536)
,p_name=>'P503_PRIVATE_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_source_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_default=>'N'
,p_prompt=>'Private'
,p_source=>'PRIVATE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(67846501377049899320)
,p_name=>'P503_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_source_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(67846502602055899344)
,p_name=>'P503_BODY'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_item_source_plug_id=>wwv_flow_imp.id(67846499840415899311)
,p_prompt=>'Body'
,p_source=>'BODY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(options) {',
'    return spCommentImageSupport.markdown.configEditor(options, {',
'        apexUpload: {',
'            // Application process name that that will handle the POST request when an image is dropped into',
'            // text box',
'            uploadApplicationProcess: ''POST_COMMENT_IMAGE'',',
'            // Pass in any data that you want in the POST process ',
'            // Will be passed in as a JSON object and available in apex_application.g_x01',
'            data: {',
'                imageRefId: apex.item(''P503_NEW_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '280')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55058881949852979208)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(55058880095947979207)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55058882428387979209)
,p_event_id=>wwv_flow_imp.id(55058881949852979208)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22347508258685623617)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.update_task_comment (',
'    p_comment_id   => :P503_ID,',
'    p_comment      => :P503_BODY,',
'    p_private_yn   => :P503_PRIVATE_YN,',
'    p_image_ref_id => :P503_NEW_IMAGE_REF_ID );'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Comment failed to be saved.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55058880510872979207)
,p_process_success_message=>'Comment saved.'
,p_internal_uid=>22345968676817565489
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22347665721226382695)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.delete_task_comment (',
'    p_comment_id => :P503_ID );'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Comment failed to be deleted.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55058879730433979206)
,p_process_success_message=>'Comment deleted.'
,p_internal_uid=>22346126139358324567
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55058881552218979208)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>18159523686817011439
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55058878516693979205)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(67846499840415899311)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form'
,p_internal_uid=>18159520651292011436
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38335823459304878683)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select project_id',
'      from sp_tasks',
'     where id = :P503_TASK_ID',
') loop',
'    sp_log.log_interaction(',
'        p_project_id => c1.project_id);',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'P503_TASK_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>1436465593902910914
);
wwv_flow_imp.component_end;
end;
/
