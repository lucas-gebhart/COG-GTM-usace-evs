prompt --application/pages/page_00171
begin
--   Manifest
--     PAGE: 00171
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
 p_id=>171
,p_name=>'Add Initiative - Completeness Scale'
,p_alias=>'ADD-INITIATIVE-COMPLETENESS-SCALE'
,p_page_mode=>'MODAL'
,p_step_title=>'Add &NOMENCLATURE_INITIATIVE. - Completeness Scale'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>2121795032473542284
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50047300489128743717)
,p_plug_name=>'Completeness Scale'
,p_region_template_options=>'#DEFAULT#:t-Wizard--hideStepsXSmall'
,p_plug_template=>2119049015939707260
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_header=>'All &NOMENCLATURE_PROJECTS. have a Completeness Scale from 0 to 100% in 10% increments.  Select the Completeness Scale to be used by default for each &NOMENCLATURE_PROJECT. created within this &NOMENCLATURE_INITIATIVE..  '
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(66327549176163877544)
,p_name=>'Status Scale Report'
,p_parent_plug_id=>wwv_flow_imp.id(50047300489128743717)
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''0%'' pct_complete, pc0_label project_status, pc0_desc description, :P171_STATUS_SCALE selected_scale,',
'       0 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''10%'' pct_complete, pc10_label, pc10_desc, :P171_STATUS_SCALE selected_scale,',
'       10 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''20%'' pct_complete, pc20_label, pc20_desc, :P171_STATUS_SCALE selected_scale,',
'       20 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''30%'' pct_complete, pc30_label, pc30_desc, :P171_STATUS_SCALE selected_scale,',
'       30 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''40%'' pct_complete, pc40_label, pc40_desc, :P171_STATUS_SCALE selected_scale,',
'       40 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''50%'' pct_complete, pc50_label, pc50_desc, :P171_STATUS_SCALE selected_scale,',
'       50 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''60%'' pct_complete, pc60_label, pc60_desc, :P171_STATUS_SCALE selected_scale,',
'       60 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''70%'' pct_complete, pc70_label, pc70_desc, :P171_STATUS_SCALE selected_scale,',
'       70 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''80%'' pct_complete, pc80_label, pc80_desc, :P171_STATUS_SCALE selected_scale,',
'       80 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''90%'' pct_complete, pc90_label, pc90_desc, :P171_STATUS_SCALE selected_scale,',
'       90 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'union all',
'select ''100%'' pct_complete, pc100_label, pc100_desc, :P171_STATUS_SCALE selected_scale,',
'       100 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P171_STATUS_SCALE,''A'')',
'order by r'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50131587389188460446)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Completeness'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50131587827496460448)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50131588193749460448)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>60
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50131588620663460449)
,p_query_column_id=>4
,p_column_alias=>'SELECTED_SCALE'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50131588994629460450)
,p_query_column_id=>5
,p_column_alias=>'R'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(202713819443023049628)
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
 p_id=>wwv_flow_imp.id(50127365924364090774)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(202713819443023049628)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50127365504171090773)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(202713819443023049628)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50047298136956743693)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(202713819443023049628)
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
 p_id=>wwv_flow_imp.id(50047298183326743694)
,p_branch_name=>'previous'
,p_branch_action=>'f?p=&APP_ID.:170:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50047298136956743693)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50047298450967743696)
,p_branch_name=>'next'
,p_branch_action=>'f?p=&APP_ID.:172:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50127365504171090773)
,p_branch_sequence=>20
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50131789315322698880)
,p_name=>'P171_STATUS_SCALE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(50047300489128743717)
,p_item_default=>'A'
,p_prompt=>'Default Completeness Scale'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select scale_name, scale_letter',
'  from sp_project_scales',
' where is_active_yn = ''Y''',
' order by scale_letter'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '7',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50127371599146090781)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(50127365924364090774)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50127372161888090782)
,p_event_id=>wwv_flow_imp.id(50127371599146090781)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50127372476403090782)
,p_name=>'refresh status scale report'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P171_STATUS_SCALE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50127372999472090783)
,p_event_id=>wwv_flow_imp.id(50127372476403090782)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P171_STATUS_SCALE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047300665034743718)
,p_event_id=>wwv_flow_imp.id(50127372476403090782)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(66327549176163877544)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
