prompt --application/pages/page_12140
begin
--   Manifest
--     PAGE: 12140
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
 p_id=>12140
,p_name=>'Configure External Person Link'
,p_alias=>'CONFIGURE-EXTERNAL-PERSON-LINK'
,p_page_mode=>'MODAL'
,p_step_title=>'Configure External Person Link'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(176222232227855897789)
,p_protection_level=>'U'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Select the appropriate choice for any authenticated users.<br> ',
'Selecting <strong>No</strong> makes the application more secure as only specified users can access the application. ',
'However, if your application has a large user community then maintaining users may be onerous, and you may prefer to choose <strong>Yes</strong> and only enter application Administrators, and possibly Contributors.<br>',
'If you select <strong>Yes</strong> then you must also select how users not included in the users list are treated.</p>',
'<p>Select between requiring email addresses and any alphanumeric value for Usernames.<br>',
'Generally, you should set this setting to <strong>E-mail Address</strong> if your application uses (or will be configured to use) a centralized authentication scheme such as Oracle Access Manager, or SSO.</p>',
'<p><em><strong>Note:</strong> This application supports the following 3 access levels: Reader, Contributor, and Administrator.',
'<ul>',
'  <li><strong>Readers</strong> have read-only access to all information and can also view reports.</li>',
'  <li><strong>Contributors</strong> can create, edit and delete information and view reports.</li>',
'  <li><strong>Administrators</strong>, in addition to Contributors capability, can also perform configuration of the application by accessing the Administration section of the application.</li>',
'</ul>',
'</em></p>'))
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(180680678084175877652)
,p_plug_name=>'Configure External Person Link'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>'If both a link and domain are provided, a link of "External Directory" will display on the detailed person pages whenever a person''s email address is within the specified domain.  The Link must contain #EMAIL#, which will then be substituted with the'
||' person''s email.'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(180680678230577877652)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41357796317836947557)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(180680678230577877652)
,p_button_name=>'APPLY_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41357796710548947558)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(180680678230577877652)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'PREVIOUS'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38280684654242691715)
,p_name=>'P12140_EXT_PERSON_LINK_DOMAIN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(180680678084175877652)
,p_prompt=>'Domain used for'
,p_source=>'return apex_app_setting.get_value(''EXTERNAL_PERSON_LINK_DOMAIN'');'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>2318601014859922299
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(180680682045185877664)
,p_name=>'P12140_EXTERNAL_PERSON_LINK'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(180680678084175877652)
,p_prompt=>'External Person Link'
,p_source=>'return apex_app_setting.get_value(''EXTERNAL_PERSON_LINK'');'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_field_template=>2318601014859922299
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38280684857335691717)
,p_validation_name=>'link must have #EMAIL#'
,p_validation_sequence=>10
,p_validation=>'instr(:P12140_EXTERNAL_PERSON_LINK,''#EMAIL#'') > 0'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Link must contain #EMAIL#'
,p_validation_condition=>'P12140_EXTERNAL_PERSON_LINK'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_imp.id(180680682045185877664)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38280684877672691718)
,p_validation_name=>'domain not contains @'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(:P12140_EXT_PERSON_LINK_DOMAIN is not null and ',
' :P12140_EXTERNAL_PERSON_LINK is not null) ',
'or',
'(:P12140_EXT_PERSON_LINK_DOMAIN is null and ',
' :P12140_EXTERNAL_PERSON_LINK is null)'))
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Domain should not contain the @ sign'
,p_validation_condition=>'P12140_EXT_PERSON_LINK_DOMAIN'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_imp.id(38280684654242691715)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38280684998731691719)
,p_validation_name=>'Must have both (or neither)'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(:P12140_EXT_PERSON_LINK_DOMAIN is not null and ',
' :P12140_EXTERNAL_PERSON_LINK is not null) ',
'or',
'(:P12140_EXT_PERSON_LINK_DOMAIN is null and ',
' :P12140_EXTERNAL_PERSON_LINK is null)'))
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Must provide both a link and domain'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41357797668639947559)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41357796710548947558)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41357798211338947560)
,p_event_id=>wwv_flow_imp.id(41357797668639947559)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41357797317474947559)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Settings'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_link   varchar2(4000) := apex_app_setting.get_value(''EXTERNAL_PERSON_LINK'');',
'    l_domain varchar2(4000) := apex_app_setting.get_value(''EXTERNAL_PERSON_LINK_DOMAIN'');',
'begin',
'',
'apex_app_setting.set_value (',
'    p_name  => ''EXTERNAL_PERSON_LINK'',',
'    p_value => :P12140_EXTERNAL_PERSON_LINK );',
'',
'apex_app_setting.set_value (',
'    p_name  => ''EXTERNAL_PERSON_LINK_DOMAIN'',',
'    p_value => :P12140_EXT_PERSON_LINK_DOMAIN );',
'',
'if not sp_value_compare.is_equal(l_link,:P12140_EXTERNAL_PERSON_LINK) then',
'    sp_util.add_app_log(',
'        p_activity => ''Updated External Person Link'', ',
'        p_details  => substr(''changed from "''|| l_link ||''"" to "''||:P12140_EXTERNAL_PERSON_LINK||''"'',1,4000) );',
'end if;',
'',
'if not sp_value_compare.is_equal(l_domain,:P12140_EXT_PERSON_LINK_DOMAIN) then',
'    sp_util.add_app_log(',
'        p_activity => ''Updated External Person Link Domain'', ',
'        p_details  => substr(''changed from "''|| l_domain ||''"" to "''||:P12140_EXT_PERSON_LINK_DOMAIN||''"'',1,4000) );',
'end if;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41357796317836947557)
,p_process_success_message=>'Settings saved.'
,p_internal_uid=>4458439452072979790
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38280684695182691716)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CLOSE'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>1381326829780723947
);
wwv_flow_imp.component_end;
end;
/
