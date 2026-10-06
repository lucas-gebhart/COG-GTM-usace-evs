prompt --application/pages/page_00172
begin
--   Manifest
--     PAGE: 00172
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
 p_id=>172
,p_name=>'Add Initiative - Default Tasks'
,p_alias=>'ADD-INITIATIVE-DEFAULT-TASKS'
,p_page_mode=>'MODAL'
,p_step_title=>'Add &NOMENCLATURE_INITIATIVE. - Default Tasks'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
,p_step_template=>2121795032473542284
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(68405738538655406767)
,p_name=>'default tasks'
,p_template=>2119049015939707260
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Wizard--hideStepsXSmall'
,p_component_template_options=>'#DEFAULT#:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select APEX_ITEM.CHECKBOX2(p_idx => 1, p_value => t.id, p_checked_values => i.n001) checked,',
'       case when t.parent_type_id is not null',
'            then (select t2.task_type from sp_task_types t2',
'                   where t2.id = t.parent_type_id)||'': ''',
'            end ||',
'           t.task_type task,',
'       t.display_seq',
'  from sp_task_types t,',
'       apex_collections i',
' where t.include_yn = ''Y''',
'   and t.id = i.n001',
'   and i.collection_name = ''INITIATIVE_DEFAULT_TASKS''',
' union all',
'select APEX_ITEM.CHECKBOX2(p_idx => 1, p_value => t.id) checked,',
'       case when t.parent_type_id is not null',
'            then (select t2.task_type from sp_task_types t2',
'                   where t2.id = t.parent_type_id)||'': ''',
'            end ||',
'           t.task_type task,',
'       t.display_seq',
'  from sp_task_types t',
' where t.include_yn = ''Y''',
'   and id not in (select n001',
'                    from apex_collections',
'                   where collection_name = ''INITIATIVE_DEFAULT_TASKS'')',
' order by display_seq nulls first'))
,p_header=>'Identify the items that will be automatically created for all &NOMENCLATURE_PROJECTS. added to this &NOMENCLATURE_INITIATIVE..'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>1000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50127721330679126766)
,p_query_column_id=>1
,p_column_alias=>'CHECKED'
,p_column_display_sequence=>10
,p_column_heading=>'Checked'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50127721591355126766)
,p_query_column_id=>2
,p_column_alias=>'TASK'
,p_column_display_sequence=>20
,p_column_heading=>'Task'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50127720866273126765)
,p_query_column_id=>3
,p_column_alias=>'DISPLAY_SEQ'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(215942352049557428958)
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
 p_id=>wwv_flow_imp.id(50127891857757347107)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(215942352049557428958)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50047298602036743698)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(215942352049557428958)
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
 p_id=>wwv_flow_imp.id(50127892222166347107)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(215942352049557428958)
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
 p_id=>wwv_flow_imp.id(50127898212559347117)
,p_branch_name=>'previous'
,p_branch_action=>'f?p=&APP_ID.:171:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50127892222166347107)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50127898599418347117)
,p_branch_name=>'next'
,p_branch_action=>'f?p=&APP_ID.:174:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50127896266652347114)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(50127891857757347107)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50127896785437347115)
,p_event_id=>wwv_flow_imp.id(50127896266652347114)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50128024043275129291)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save tasks'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.create_or_truncate_collection (''INITIATIVE_DEFAULT_TASKS'');',
'',
'for i in 1..apex_application.g_f01.count loop',
'    apex_collection.add_member (',
'        p_collection_name => ''INITIATIVE_DEFAULT_TASKS'',',
'        p_n001            => apex_application.g_f01(i));',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>13228666177873161522
);
wwv_flow_imp.component_end;
end;
/
