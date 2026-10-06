prompt --application/pages/page_00050
begin
--   Manifest
--     PAGE: 00050
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
 p_id=>50
,p_name=>'Unmark as Duplicate'
,p_alias=>'UNMARK-AS-DUPLICATE'
,p_page_mode=>'MODAL'
,p_step_title=>'Not a Duplicate'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(71027035670012821920)
,p_plug_name=>'Archive'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(71027036050477821924)
,p_plug_name=>'Button Container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48571459490737401792)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(71027036050477821924)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48571459926508401793)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(71027036050477821924)
,p_button_name=>'mark_as_duplicate'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Not a Duplicate'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(47728218044879890018)
,p_branch_name=>'back to project'
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_PROJECT_ID:&P50_PROJECT_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48571458020893401786)
,p_name=>'P50_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(71027035670012821920)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48571458446309401789)
,p_name=>'P50_PROJECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(71027035670012821920)
,p_prompt=>'&NOMENCLATURE_PROJECT.'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48571458835742401790)
,p_name=>'P50_DUPLICATE_OF'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(71027035670012821920)
,p_prompt=>'Marked as duplicate of'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_PROJECTS.PROJECT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48571460380418401794)
,p_computation_sequence=>10
,p_computation_item=>'P50_PROJECT'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project',
'from sp_projects p',
'where id = :P50_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(47728217604673890014)
,p_computation_sequence=>20
,p_computation_item=>'P50_DUPLICATE_OF'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project',
'from sp_projects p',
'where id = (',
'    select DUPLICATE_OF_PROJECT_ID',
'    from sp_projects p2 ',
'    where id = :P50_PROJECT_ID)'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48571461499815401799)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48571459490737401792)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48571462031556401801)
,p_event_id=>wwv_flow_imp.id(48571461499815401799)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48571461078965401799)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'unmark as dupicate'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.unmark_proj_as_duplicate (',
'    p_project_id       => :P50_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48571459926508401793)
,p_process_success_message=>'Not a duplicate'
,p_internal_uid=>11672103213563434030
);
wwv_flow_imp.component_end;
end;
/
