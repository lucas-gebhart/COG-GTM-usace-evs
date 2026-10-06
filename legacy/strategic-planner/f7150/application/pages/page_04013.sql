prompt --application/pages/page_04013
begin
--   Manifest
--     PAGE: 04013
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
 p_id=>4013
,p_name=>'Initiative Approval Type'
,p_alias=>'INITIATIVE-APPROVAL-TYPE'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_INITIATIVE. Approval Type'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_dialog_chained=>'N'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(50133922460630657096)
,p_name=>'Approvers'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.approval_seq, ',
'       case when c.alternate_team_member_id is not null and   ',
'                 (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                 (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'            then ''Alternate - ''||',
'                 (select last_name||'', ''||first_name||'' (''||lower(email)||'')''',
'                    from sp_team_members',
'                   where id = c.alternate_team_member_id)',
'            else tm.last_name||'', ''||tm.first_name||'' (''||lower(tm.email)||'')'' ',
'        end name, ',
'       decode(c.active_yn,''Y'',''Active'',''Inactive'') status',
'  from sp_initiative_approval_chain c,',
'       sp_team_members tm',
' where c.initiative_approval_id = :P4013_ID',
'   and c.team_member_id = tm.id',
' order by c.approval_seq'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4013_ID'))
,p_display_condition_type=>'EXISTS'
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
 p_id=>wwv_flow_imp.id(50133922560721657097)
,p_query_column_id=>1
,p_column_alias=>'APPROVAL_SEQ'
,p_column_display_sequence=>10
,p_column_heading=>'Approval Sequence'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133922610676657098)
,p_query_column_id=>2
,p_column_alias=>'NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53088318069140007012)
,p_query_column_id=>3
,p_column_alias=>'STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60406941637005026327)
,p_plug_name=>'&NOMENCLATURE_INITIATIVE. Approval Type'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_INITIATIVE_APPROVALS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60406947513122026335)
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
 p_id=>wwv_flow_imp.id(48654033557952599612)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(60406947513122026335)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48654033949869599613)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(60406947513122026335)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P4013_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48654034282992599613)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(60406947513122026335)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P4013_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48654034705500599614)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(60406947513122026335)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add'
,p_button_position=>'NEXT'
,p_button_condition=>'P4013_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48653977760228826570)
,p_name=>'P4013_INITIATIVE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_item_source_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_prompt=>'&NOMENCLATURE_INITIATIVE.'
,p_source=>'INITIATIVE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_named_lov=>'SP_INITIATIVES.INITIATIVE'
,p_cSize=>30
,p_read_only_when=>'P4013_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48653977784796826571)
,p_name=>'P4013_APPROVAL_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_item_source_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_prompt=>'Approval Type'
,p_source=>'APPROVAL_TYPE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select approval_type d, id r',
'  from sp_approval_types',
' where id not in (select approval_type_id',
'                    from sp_initiative_approvals',
'                   where initiative_id = :P4013_INITIATIVE_ID)',
'   or id = :P4013_APPROVAL_TYPE_ID',
' order by display_seq'))
,p_lov_cascade_parent_items=>'P4013_INITIATIVE_ID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50047298002062743692)
,p_name=>'P4013_ACTIVE_YN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_item_source_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_item_default=>'Y'
,p_prompt=>'Active'
,p_source=>'ACTIVE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(60406942411580026334)
,p_name=>'P4013_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_item_source_plug_id=>wwv_flow_imp.id(60406941637005026327)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(48653981520678826608)
,p_validation_name=>'no dups'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approvals',
' where initiative_id = :P4013_INITIATIVE_ID',
'   and approval_type_id = :P4013_APPROVAL_TYPE_ID',
'   and (:P4013_ID is null or :P4013_ID != id)'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Duplicate entry found.'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48654035696125599615)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48654033557952599612)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48654036166995599616)
,p_event_id=>wwv_flow_imp.id(48654035696125599615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48654032851395599611)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(60406941637005026327)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Initiative Approvals'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11754674985993631842
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48654035305503599615)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>11754677440101631846
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48654032394007599610)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(60406941637005026327)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Initiative Approvals'
,p_internal_uid=>11754674528605631841
);
wwv_flow_imp.component_end;
end;
/
