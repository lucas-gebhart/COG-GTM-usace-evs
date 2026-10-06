prompt --application/pages/page_00076
begin
--   Manifest
--     PAGE: 00076
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
 p_id=>76
,p_name=>'Delete Release'
,p_alias=>'DELETE-RELEASE'
,p_page_mode=>'MODAL'
,p_step_title=>'Delete Release'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45074294665875875763)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(41725545750441004281)
,p_name=>'Associated with this Release'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--staticRowColors:t-Report--rowHighlightOff:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ob, count(*) v, :NOMENCLATURE_PROJECTS||'' will have the associated Release removed'' d',
'  from sp_projects',
' where release_id = :P76_ID ',
'union all',
'select 2 ob, count(*) v, ''Release Milestones will be deleted'' d',
'  from SP_RELEASE_MILESTONES',
' where release_Id = :P76_ID',
'union all',
'select 3 ob, count(*) v, ''Release Comments will be deleted'' d',
'  from sp_release_comments rc',
' where rc.release_id = :P76_ID ',
'union all',
'select 4 ob, count(*) v, ''Release Links will be deleted'' d',
'  from sp_release_links',
' where release_id = :P76_ID',
' order by ob'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P76_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41725546074345004285)
,p_query_column_id=>1
,p_column_alias=>'OB'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41725545768888004282)
,p_query_column_id=>2
,p_column_alias=>'V'
,p_column_display_sequence=>10
,p_column_heading=>'V'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41725546236890004286)
,p_query_column_id=>3
,p_column_alias=>'D'
,p_column_display_sequence=>20
,p_column_heading=>'D'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(73698375585019699329)
,p_plug_name=>'Release'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_RELEASE_TRAINS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(73698382852666699362)
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
 p_id=>wwv_flow_imp.id(41782783734383754056)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(73698382852666699362)
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
 p_id=>wwv_flow_imp.id(41782783312518754055)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(73698382852666699362)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P76_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41782786517053754064)
,p_branch_action=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:76::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(41782783312518754055)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(73698376480462699338)
,p_name=>'P76_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(73698375585019699329)
,p_item_source_plug_id=>wwv_flow_imp.id(73698375585019699329)
,p_prompt=>'Release'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_RELEASE_TRAINS.RELEASE_TRAIN'
,p_lov=>'select release_train||'' ''||release release_train, id from SP_RELEASE_TRAINS'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(73698377243959699353)
,p_name=>'P76_RELEASE_OWNER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(73698375585019699329)
,p_item_source_plug_id=>wwv_flow_imp.id(73698375585019699329)
,p_prompt=>'Owner'
,p_source=>'RELEASE_OWNER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_TEAM_MEMBERS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'order by 1'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41782785555791754059)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41782783734383754056)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41782786002280754063)
,p_event_id=>wwv_flow_imp.id(41782785555791754059)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41725546360739004287)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set project associations to null'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update sp_projects',
'   set release_id = null',
' where release_id = :P76_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41782783312518754055)
,p_internal_uid=>4826188495337036518
,p_process_comment=>'done to avoid mutating table on sp_projects biu trigger (that references the sp_release_trains table)'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51825530798649349292)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete related to avoid mutation on history table'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select image_ref_id',
'      from sp_release_comments',
'     where release_id = :P76_ID',
'       and image_ref_id is not null',
') loop',
'    delete from sp_comment_images',
'     where image_ref_id = c1.image_ref_id;',
'end loop;',
'',
'delete from sp_release_comments',
' where release_id = :P76_ID;',
'',
'delete from sp_release_documents',
' where release_id = :P76_ID;',
'',
'delete from sp_release_links',
' where release_id = :P76_ID;',
'',
'delete from sp_release_milestones',
' where release_id = :P76_ID;',
'',
'delete from sp_release_history',
' where release_id = :P76_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41782783312518754055)
,p_internal_uid=>14926172933247381523
,p_process_comment=>'done to avoid mutating table on sp_projects biu trigger (that references the sp_release_trains table)'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41782782195815754053)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(73698375585019699329)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Release'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Release deleted'
,p_internal_uid=>4883424330413786284
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41782781796781754052)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(73698375585019699329)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Release'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>4883423931379786283
);
wwv_flow_imp.component_end;
end;
/
