prompt --application/pages/page_00175
begin
--   Manifest
--     PAGE: 00175
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
 p_id=>175
,p_name=>'Add Initiative - Confirm'
,p_alias=>'ADD-INITIATIVE-CONFIRM'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Initiative - Confirm'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>2121795032473542284
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(94866437179672508104)
,p_plug_name=>'The following &NOMENCLATURE_INITIATIVE. will be created'
,p_region_template_options=>'#DEFAULT#:t-Wizard--showTitle:t-Wizard--hideStepsXSmall:margin-left-lg:margin-right-lg'
,p_plug_template=>2119049015939707260
,p_plug_display_sequence=>30
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_clob            clob;',
'   l_status_scale    varchar2(60);',
'   l_default_tasks   number;',
'   l_focus_areas     number;',
'begin',
'',
'    select scale_name',
'      into l_status_scale',
'      from sp_project_scales',
'     where scale_letter = :P171_STATUS_SCALE;',
'',
'    select count(*)',
'      into l_default_tasks',
'      from apex_collections',
'     where collection_name = ''INITIATIVE_DEFAULT_TASKS'';',
'',
'    select count(*)',
'      into l_focus_areas',
'      from apex_collections',
'     where collection_name = ''INITIATIVE_FOCUS_AREAS'';',
'',
'    l_clob := ''Name: <strong>''|| apex_escape.html(:P170_INITIATIVE) ||''</strong><br/>''||',
'              ''Default Completeness Scale: ''||l_status_scale||''<br/>''||',
'              ''Default Tasks: ''||l_default_tasks||''<br/>''||',
'              ''Focus Areas: ''||l_focus_areas;',
'',
'    return l_clob;',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(242403050690574530295)
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
 p_id=>wwv_flow_imp.id(50130652063619591578)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(242403050690574530295)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50130651617557591577)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(242403050690574530295)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50130652392619591578)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(242403050690574530295)
,p_button_name=>'PREVIOUS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Previous'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50130656908340591583)
,p_branch_name=>'previous'
,p_branch_action=>'f?p=&APP_ID.:174:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50130652392619591578)
,p_branch_sequence=>30
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50130657774837591584)
,p_branch_name=>'CREATE'
,p_branch_action=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:94:P94_INITIATIVE_ID:&P175_NEW_INITIATIVE_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50130651617557591577)
,p_branch_sequence=>40
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63278586090221367494)
,p_name=>'P175_NEW_INITIATIVE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(94866437179672508104)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50130655930108591582)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(50130652063619591578)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50130656370525591582)
,p_event_id=>wwv_flow_imp.id(50130655930108591582)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50130654965143591581)
,p_name=>'refresh status scale report'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P175_STATUS_SCALE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50130655397626591582)
,p_event_id=>wwv_flow_imp.id(50130654965143591581)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P175_STATUS_SCALE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50130654552583591580)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'create initiative'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_initiative_id  number;',
'begin',
'    insert into sp_initiatives',
'        (area_id, initiative, objective,',
'         sponsor_id, tags, hidden_by_default_yn,',
'         status_scale)',
'    values',
'        (:P170_FOCUS_AREA_ID, :P170_INITIATIVE, :P170_OBJECTIVE,',
'         :P170_SPONSOR_ID, :P170_TAGS, ''N'',',
'         :P171_STATUS_SCALE)',
'    returning id into l_initiative_id;',
'',
'    if :P170_IMAGE_SELECTED is not null then',
'        for c1 in (',
'            select * from apex_application_temp_files',
'             where application_id = :APP_ID',
'               and name = :P170_IMAGE_SELECTED',
'        ) loop',
'            update sp_initiatives',
'               set image = c1.blob_content,',
'                   image_name = c1.filename,',
'                   image_mimetype = c1.mime_type,',
'                   image_last_updated = c1.created_on',
'             where id = l_initiative_id;',
'        end loop;',
'    end if;',
'',
'    insert into sp_initiative_default_tasks ',
'        (initiative_id, type_id)',
'    select l_initiative_id, n001',
'      from apex_collections',
'     where collection_name = ''INITIATIVE_DEFAULT_TASKS'';',
'',
'    insert into sp_initiative_focus_areas',
'        (initiative_id, focus_area, development_owner_id, description, display_sequence)',
'    select l_initiative_id, c001, n001, c002, seq_id',
'      from apex_collections',
'     where collection_name = ''INITIATIVE_FOCUS_AREAS''',
'       and c001 is not null;',
'',
'    :P175_NEW_INITIATIVE_ID := l_initiative_id;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(50130651617557591577)
,p_process_success_message=>'Initiative created.'
,p_internal_uid=>13231296687181623811
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50047300672114743719)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'clean up'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.delete_collection (',
'    p_collection_name => ''INITIATIVE_DEFAULT_TASKS'');',
'',
'apex_collection.delete_collection (',
'    p_collection_name => ''INITIATIVE_FOCUS_AREAS'');',
'',
'if :P170_IMAGE_SELECTED is not null then',
'    delete from apex_application_temp_files',
'     where application_id = :APP_ID',
'       and name = :P170_IMAGE_SELECTED;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(50130651617557591577)
,p_internal_uid=>13147942806712775950
);
wwv_flow_imp.component_end;
end;
/
