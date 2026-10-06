prompt --application/pages/page_00035
begin
--   Manifest
--     PAGE: 00035
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
 p_id=>35
,p_name=>'Edit Initiative Focus Area Comment'
,p_alias=>'IFA-COMMENT'
,p_page_mode=>'MODAL'
,p_step_title=>'Edit Comment'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(54731659924435211600)
,p_plug_name=>'Edit Comment'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_INIT_FOCUS_AREA_COMMENTS_V'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(54731679391221211637)
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
 p_id=>wwv_flow_imp.id(53933039400045382857)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(54731679391221211637)
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
 p_id=>wwv_flow_imp.id(53933038643405382856)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(54731679391221211637)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P35_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53933038971008382856)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(54731679391221211637)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P35_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722867246413623570)
,p_name=>'P35_NEW_IMAGE_REF_ID'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54731661181124211607)
,p_name=>'P35_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_item_source_plug_id=>wwv_flow_imp.id(54731659924435211600)
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
 p_id=>wwv_flow_imp.id(54731671355618211629)
,p_name=>'P35_BODY'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_item_source_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_prompt=>'Comment'
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
'                imageRefId: apex.item(''P35_NEW_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(57431058013185618099)
,p_name=>'P35_PRIVATE_YN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_item_source_plug_id=>wwv_flow_imp.id(54731659924435211600)
,p_item_default=>'N'
,p_prompt=>'Private'
,p_source=>'PRIVATE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53933041340943382858)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(53933039400045382857)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933041836392382859)
,p_event_id=>wwv_flow_imp.id(53933041340943382858)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21722867292421623571)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.update_init_focus_area_comment (',
'    p_comment_id   => :P35_ID,',
'    p_comment      => :P35_BODY,',
'    p_private_yn   => :P35_PRIVATE_YN,',
'    p_image_ref_id => :P35_NEW_IMAGE_REF_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53933038971008382856)
,p_process_success_message=>'Comment saved.'
,p_internal_uid=>21721327710553565443
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21722867466384623572)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.delete_init_focus_area_comment (',
'    p_comment_id   => :P35_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53933038643405382856)
,p_process_success_message=>'Comment deleted.'
,p_internal_uid=>21721327884516565444
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53933040110691382858)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17033682245289415089
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53933037549249382855)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(54731659924435211600)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Edit Comment'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>17033679683847415086
);
wwv_flow_imp.component_end;
end;
/
