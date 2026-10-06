prompt --application/pages/page_00095
begin
--   Manifest
--     PAGE: 00095
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
 p_id=>95
,p_name=>'Initiative Default Tasks'
,p_alias=>'INITIATIVE-DEFAULT-TASKS'
,p_page_mode=>'MODAL'
,p_step_title=>'Initiative Default Tasks'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55177375751473247775)
,p_name=>'report'
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select APEX_ITEM.CHECKBOX2(p_idx => 1, p_value => t.id,p_checked_values => i.type_id) checked,',
'       case when t.parent_type_id is not null',
'            then (select t2.task_type from sp_task_types t2',
'                   where t2.id = t.parent_type_id)||'': ''',
'            end ||',
'           t.task_type task,',
'       t.display_seq',
'  from sp_task_types t,',
'       sp_initiative_default_tasks i',
' where t.include_yn = ''Y''',
'   and t.id = i.type_id',
'   and i.initiative_id = :P95_INITIATIVE_ID',
'union all',
'select case when t.parent_type_id is not null',
'            then APEX_ITEM.CHECKBOX2(p_idx => 1, p_value => t.id) ',
'            else null  -- you cannot default in parent task types',
'            end checked,',
'       case when t.parent_type_id is not null',
'            then (select t2.task_type from sp_task_types t2',
'                   where t2.id = t.parent_type_id)||'': ''',
'            end ||',
'           t.task_type task,',
'       t.display_seq',
'  from sp_task_types t',
' where t.include_yn = ''Y''',
'   and t.id not in (select type_id',
'                      from sp_initiative_default_tasks',
'                     where initiative_id = :P95_INITIATIVE_ID)',
'   and ( t.parent_type_id is not null or',
'         exists (select 1',
'                   from sp_task_types',
'                  where parent_type_id = t.id) )',
' order by display_seq nulls first'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P95_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(55177376524934247783)
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
 p_id=>wwv_flow_imp.id(55177376314087247781)
,p_query_column_id=>2
,p_column_alias=>'TASK'
,p_column_display_sequence=>20
,p_column_heading=>'Task'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177378585378247804)
,p_query_column_id=>3
,p_column_alias=>'DISPLAY_SEQ'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59902938735441276846)
,p_plug_name=>'Initiative Tasks'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59902945955600276860)
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
 p_id=>wwv_flow_imp.id(55177207006826958082)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(59902945955600276860)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55177207828507958083)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(59902945955600276860)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59902939953559276854)
,p_name=>'P95_INITIATIVE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(59902938735441276846)
,p_prompt=>'&NOMENCLATURE_INITIATIVE.'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'AREA INITIATIVE 2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative, ',
'       a.area,',
'       i.id initiative_id',
'from sp_initiatives i, sp_areas a',
'where i.area_id = a.id',
'order by 2, 1'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55177209188151958085)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(55177207006826958082)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55177209698505958088)
,p_event_id=>wwv_flow_imp.id(55177209188151958085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55177376644847247784)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save changes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    wwv_flow_collection.CREATE_OR_TRUNCATE_COLLECTION (''INITIATIVE_TASKS'');',
'',
'    for i in 1..apex_application.g_f01.count loop',
'        wwv_flow_collection.add_member (',
'            p_collection_name => ''INITIATIVE_TASKS'',',
'            p_n001            => apex_application.g_f01(i));',
'    end loop;',
'',
'    delete from sp_initiative_default_tasks',
'     where initiative_id = :P95_INITIATIVE_ID',
'       and type_id not in (select n001',
'                             from wwv_flow_collections',
'                            where collection_name = ''INITIATIVE_TASKS'');',
'',
'    insert into sp_initiative_default_tasks (initiative_id, type_id)',
'    select :P95_INITIATIVE_ID, n001',
'      from wwv_flow_collections',
'     where collection_name = ''INITIATIVE_TASKS''',
'       and n001 not in (select type_id',
'                          from sp_initiative_default_tasks',
'                         where initiative_id = :P95_INITIATIVE_ID);',
'',
'    commit;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55177207828507958083)
,p_process_success_message=>'Default tasks updated.'
,p_internal_uid=>18278018779445280015
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55177208863658958085)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>18277850998256990316
);
wwv_flow_imp.component_end;
end;
/
