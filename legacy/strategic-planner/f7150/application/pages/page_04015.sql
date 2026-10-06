prompt --application/pages/page_04015
begin
--   Manifest
--     PAGE: 04015
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
 p_id=>4015
,p_name=>'Initiative Approval Entry'
,p_alias=>'INITIATIVE-APPROVAL-ENTRY'
,p_page_mode=>'MODAL'
,p_step_title=>'Initiative Approval Entry'
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
 p_id=>wwv_flow_imp.id(48653979662739826589)
,p_name=>'Existing Initiative Approval Chain'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.approval_seq,',
'        case when c.active_yn = ''N'' ',
'            then ''Inactive - ''',
'            end ||',
'        case when c.alternate_team_member_id is not null and   ',
'                 (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                 (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'            then ''Alternate - ''||',
'                 (select last_name||'', ''||first_name||'' (''||lower(email)||'')''',
'                    from sp_team_members',
'                   where id = c.alternate_team_member_id)',
'            else tm.last_name||'', ''||tm.first_name||'' (''||lower(tm.email)||'')'' ',
'            end  reviewer',
'  from sp_initiative_approval_chain c,',
'       sp_team_members tm,',
'       SP_INITIATIVE_APPROVALS a',
' where a.id = :P4015_INITIATIVE_APPROVAL_ID',
'   and c.initiative_approval_id = a.id',
'   and c.team_member_id = tm.id',
'   order by c.approval_seq'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P4015_INITIATIVE_APPROVAL_ID'
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
 p_id=>wwv_flow_imp.id(48653979721660826590)
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
 p_id=>wwv_flow_imp.id(48653979829470826591)
,p_query_column_id=>2
,p_column_alias=>'REVIEWER'
,p_column_display_sequence=>20
,p_column_heading=>'Reviewer'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(72163671094143141231)
,p_plug_name=>'Initiative Approval Entry'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SP_INITIATIVE_APPROVAL_CHAIN'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(72163676970260141239)
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
 p_id=>wwv_flow_imp.id(48656087950922082678)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(72163676970260141239)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48656088276033082678)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(72163676970260141239)
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
,p_button_condition=>'P4015_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48656088681639082679)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(72163676970260141239)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P4015_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48656089131221082679)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(72163676970260141239)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P4015_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555554591104440133)
,p_name=>'P4015_ALTERNATE_TEAM_MEMBER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Alternate Assignee'
,p_source=>'ALTERNATE_TEAM_MEMBER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_named_lov=>'SP_TEAM_MEMBER - CONTRIBS AND ADMINS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'where upper(email) in (select user_name',
'                         from apex_appl_acl_user_roles',
'                        where application_id = :APP_ID',
'                          and role_static_id in (''ADMINISTRATOR'',''CONTRIBUTOR''))',
'order by 1'))
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'This user will be assigned to do Approvals (instead of the Assignee) during the timeframe identified (or indefinitely if there is no timeframe).  This does not affect any approvals already assigned.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555554777989440134)
,p_name=>'P4015_ALTERNATE_START_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Alternate Start Date'
,p_format_mask=>'DD-MON-YYYY'
,p_source=>'ALTERNATE_START_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'I'
,p_help_text=>'If left blank, the Alternate Assignee will be used immediately.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'STATIC',
  'min_static', '&P4015_INIT_ALTERNATE_START_DATE.',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555554795179440135)
,p_name=>'P4015_ALTERNATE_END_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Alternate End Date'
,p_format_mask=>'DD-MON-YYYY'
,p_source=>'ALTERNATE_END_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'I'
,p_help_text=>'If left blank, the Alternate Assignee will be used until the alternate is removed.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'STATIC',
  'min_static', '&P4015_INIT_ALTERNATE_END_DATE.',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555556660451440153)
,p_name=>'P4015_INIT_ALTERNATE_START_DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_help_text=>'If left blank, the Alternate Assignee will be used immediately.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555556698289440154)
,p_name=>'P4015_INIT_ALTERNATE_END_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_help_text=>'If left blank, the Alternate Assignee will be used until the alternate is removed.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48653978913608826582)
,p_name=>'P4015_INITIATIVE_APPROVAL_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Initiative Approval '
,p_source=>'INITIATIVE_APPROVAL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.INITIATIVE ||'' - ''|| t.approval_type d,',
'       a.id r',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id'))
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
 p_id=>wwv_flow_imp.id(48653979000275826583)
,p_name=>'P4015_TEAM_MEMBER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Assignee'
,p_source=>'TEAM_MEMBER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_named_lov=>'SP_TEAM_MEMBER - CONTRIBS AND ADMINS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'where upper(email) in (select user_name',
'                         from apex_appl_acl_user_roles',
'                        where application_id = :APP_ID',
'                          and role_static_id in (''ADMINISTRATOR'',''CONTRIBUTOR''))',
'order by 1'))
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(48653979105129826584)
,p_name=>'P4015_APPROVAL_SEQ'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_prompt=>'Approval Sequence'
,p_source=>'APPROVAL_SEQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53088316816543006999)
,p_name=>'P4015_ACTIVE_YN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_default=>'Y'
,p_prompt=>'Active'
,p_source=>'ACTIVE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Setting inactive prevents new assignments but does affect any already assigned.  To set back to active, the &NOMENCLATURE_INITIATIVE. Approval Types option under Admin must be used (because inactive assignees are hidden within Configuration).'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(72163674503098141245)
,p_name=>'P4015_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(72163671094143141231)
,p_item_source_plug_id=>wwv_flow_imp.id(72163671094143141231)
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
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(18555554946560440136)
,p_computation_sequence=>10
,p_computation_item=>'P4015_ALTERNATE_START_DATE'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_compute_when=>'P4015_ALTERNATE_TEAM_MEMBER_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(18555555056944440137)
,p_computation_sequence=>20
,p_computation_item=>'P4015_ALTERNATE_END_DATE'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_compute_when=>'P4015_ALTERNATE_TEAM_MEMBER_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(48653981862973826611)
,p_validation_name=>'no dups'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID',
'   and team_member_id = :P4015_TEAM_MEMBER_ID',
'   and (:P4015_ID is null or :P4015_ID != id)'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Duplicate entry found.'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(48653981959878826612)
,p_validation_name=>'no dup approval seq'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID',
'   and approval_seq = :P4015_APPROVAL_SEQ',
'   and (:P4015_ID is null or :P4015_ID != id)'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Must use unique approval sequence'
,p_associated_item=>wwv_flow_imp.id(48653979105129826584)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(53088318166188007013)
,p_validation_name=>'cannot delete with active approvals'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_approval_chain',
' where team_member_id = :P4015_TEAM_MEMBER_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Cannot delete reviewer with active approvals pending.'
,p_when_button_pressed=>wwv_flow_imp.id(48656088276033082678)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(18555556932629440156)
,p_validation_name=>'cannot delete only approver (if type is active)'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approvals a,',
'       sp_initiative_approval_chain c',
' where a.id = c.initiative_approval_id    ',
'   and a.active_yn = ''Y''',
'   and c.active_yn = ''Y''',
'   and c.id != :P4015_ID',
'   and c.initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID'))
,p_validation_type=>'EXISTS'
,p_error_message=>'Cannot delete only active reviewer of active approval type.'
,p_when_button_pressed=>wwv_flow_imp.id(48656088276033082678)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(18555557075135440157)
,p_validation_name=>'cannot inactivate only approver (if type is active)_1'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approvals a,',
'       sp_initiative_approval_chain c',
' where a.id = c.initiative_approval_id    ',
'   and a.active_yn = ''Y''',
'   and c.active_yn = ''Y''',
'   and c.id != :P4015_ID',
'   and c.initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID'))
,p_validation_type=>'EXISTS'
,p_error_message=>'Cannot inactivate only active reviewer of active approval type.'
,p_validation_condition=>'P4015_ACTIVE_YN'
,p_validation_condition2=>'Y'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_imp.id(48656088681639082679)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(18555555179398440138)
,p_validation_name=>'alt end >= alt start'
,p_validation_sequence=>60
,p_validation=>':P4015_ALTERNATE_END_DATE >= :P4015_ALTERNATE_START_DATE'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Alternate End Date must be the same or after the Alternate Start Date.'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P4015_ALTERNATE_START_DATE is not null and',
':P4015_ALTERNATE_END_DATE is not null'))
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(18555554795179440135)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(18555555270063440139)
,p_validation_name=>'Alternate cannot be in approval chain'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID',
'   and team_member_id = :P4015_ALTERNATE_TEAM_MEMBER_ID',
'   and active_yn = ''Y'''))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Alternate Assignee is already an active assignee within this approval chain.'
,p_validation_condition=>'P4015_ALTERNATE_TEAM_MEMBER_ID'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_imp.id(18555554591104440133)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(18555555352800440140)
,p_validation_name=>'Alternate cannot already be alternate'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4015_INITIATIVE_APPROVAL_ID',
'   and alternate_team_member_id = :P4015_ALTERNATE_TEAM_MEMBER_ID',
'   and active_yn = ''Y''',
'   and id != :P4015_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Alternate Assignee is already an alternate assignee within this approval chain.'
,p_validation_condition=>'P4015_ALTERNATE_TEAM_MEMBER_ID'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_imp.id(18555554591104440133)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48656093131592082686)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48656087950922082678)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48656093594179082687)
,p_event_id=>wwv_flow_imp.id(48656093131592082686)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48653979942219826592)
,p_name=>'when IA changes'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P4015_INITIATIVE_APPROVAL_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48653980067890826594)
,p_event_id=>wwv_flow_imp.id(48653979942219826592)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48653979662739826589)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48653979983463826593)
,p_event_id=>wwv_flow_imp.id(48653979942219826592)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48653979662739826589)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48653980229944826595)
,p_name=>'hide existing chain for new'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48653980346828826596)
,p_event_id=>wwv_flow_imp.id(48653980229944826595)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48653979662739826589)
,p_client_condition_type=>'NULL'
,p_client_condition_element=>'P4015_INITIATIVE_APPROVAL_ID'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53088317288505007004)
,p_name=>'active to N'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P4015_ACTIVE_YN'
,p_condition_element=>'P4015_ACTIVE_YN'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_approval_chain',
' where team_member_id = :P4015_TEAM_MEMBER_ID',
'   and status in (''PENDING'',''CLARIFICATION-REQUESTED'')'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53088317367108007005)
,p_event_id=>wwv_flow_imp.id(53088317288505007004)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'This person has pending approvals - inactivating them only affect future assignments.'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48656092228377082685)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(72163671094143141231)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Initiative Approval Entry'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11756734362975114916
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48656092711833082686)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>11756734846431114917
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48656091856331082684)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(72163671094143141231)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Initiative Approval Entry'
,p_internal_uid=>11756733990929114915
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18555556855562440155)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set init start and end dates (used for date pickers)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P4015_ID is not null then',
'    for c1 in (   ',
'        select to_char(alternate_start_date,''YYYYMMDDHH24MI'') alt_start_date, ',
'               to_char(alternate_end_date,''YYYYMMDDHH24MI'') alt_end_date',
'          from sp_initiative_approval_chain',
'         where id = :P4015_ID',
'    ) loop',
'        :P4015_INIT_ALTERNATE_START_DATE := nvl(c1.alt_start_date,''+0d'');',
'        :P4015_INIT_ALTERNATE_END_DATE := nvl(c1.alt_end_date,''+0d'');',
'    end loop;',
'else',
'    :P4015_INIT_ALTERNATE_START_DATE := ''+0d'';',
'    :P4015_INIT_ALTERNATE_END_DATE := ''+0d'';',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>18554017273694382027
);
wwv_flow_imp.component_end;
end;
/
