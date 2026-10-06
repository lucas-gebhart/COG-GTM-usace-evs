prompt --application/pages/page_04016
begin
--   Manifest
--     PAGE: 04016
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
 p_id=>4016
,p_name=>'Initiative Approval Chain'
,p_alias=>'INITIATIVE-APPROVAL-CHAIN1'
,p_page_mode=>'MODAL'
,p_step_title=>'Initiative Approval Chain'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50133923929522657111)
,p_plug_name=>'Initiative'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50489754763320794575)
,p_plug_name=>'Add New Entry'
,p_region_css_classes=>'u-flex'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-bottom-sm'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>35
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(73988779081865974009)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(85744355980580952544)
,p_name=>'Initiative Approval Chain'
,p_template=>3371237801798025892
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.ID,',
'       c.initiative_approval_id,',
'       case when c.active_yn = ''N''',
'            then ''Inactive - ''',
'            end ||',
'       case when c.alternate_team_member_id is not null and   ',
'                 (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                 (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'            then ''Alternate - ''||',
'                 (select last_name||'', ''||first_name||'' (''||lower(email)||'')''',
'                    from sp_team_members',
'                   where id = c.alternate_team_member_id)',
'            else tm.last_name||'', ''||tm.first_name||'' (''||lower(tm.email)||'')'' ',
'            end reviewer,',
'       c.approval_seq,',
'       lower(c.CREATED_BY) created_by,',
'       c.UPDATED',
'  from sp_initiative_approval_chain c,',
'       sp_team_members tm,',
'       SP_INITIATIVE_APPROVALS a',
' where c.initiative_approval_id = a.id',
'   and c.team_member_id = tm.id',
'   and a.id = :P4016_INITIATIVE_APPROVAL_ID',
' order by c.approval_seq'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133922941668657101)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133923052019657102)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_APPROVAL_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133923362280657105)
,p_query_column_id=>3
,p_column_alias=>'REVIEWER'
,p_column_display_sequence=>40
,p_column_heading=>'Reviewer'
,p_column_link=>'f?p=&APP_ID.:4015:&SESSION.::&DEBUG.:4015:P4015_ID:#ID#'
,p_column_linktext=>'#REVIEWER#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133923424736657106)
,p_query_column_id=>4
,p_column_alias=>'APPROVAL_SEQ'
,p_column_display_sequence=>30
,p_column_heading=>'Sequence'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133923600586657108)
,p_query_column_id=>5
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>60
,p_column_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50133923729095657109)
,p_query_column_id=>6
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>70
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489755096844794579)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>80
,p_column_heading=>'Delete'
,p_column_link=>'javascript:void(null);'
,p_column_linktext=>'<span role="img" aria-label="Delete" class="fa fa-trash-o delete-entry" title="Delete"></span>'
,p_column_link_attr=>'data-id=#ID#'
,p_column_alignment=>'CENTER'
,p_derived_column=>'Y'
,p_include_in_export=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50480441554394837680)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(50489754763320794575)
,p_button_name=>'ADD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Approver'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50481189689631915447)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(73988779081865974009)
,p_button_name=>'CANCEL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(50489754990928794578)
,p_branch_action=>'f?p=&APP_ID.:4016:&SESSION.::&DEBUG.:4016:P4016_INITIATIVE_APPROVAL_ID:&P4016_INITIATIVE_APPROVAL_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(50480441554394837680)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555557247531440159)
,p_name=>'P4016_OTHER_APPROVERS_COUNT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(50133923929522657111)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555557447434440161)
,p_name=>'P4016_DELETE_PROCEED_YN'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(50133923929522657111)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50133924044120657112)
,p_name=>'P4016_INITIATIVE_APPROVAL_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(50133923929522657111)
,p_prompt=>'Initiative Approval'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative ||'' - ''|| t.approval_type d,',
'       a.id r',
'  from sp_initiatives i,',
'       sp_initiative_approvals a,',
'       sp_approval_types t',
' where i.id = a.initiative_id    ',
'   and a.id = :P4016_INITIATIVE_APPROVAL_ID',
'   and a.approval_type_id = t.id'))
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50489755606569794584)
,p_name=>'P4016_ID_TO_DELETE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(50133923929522657111)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50555525181535923577)
,p_name=>'P4016_APPROVAL_SEQ'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(50489754763320794575)
,p_prompt=>'Sequence'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'numeric')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50555534384188925095)
,p_name=>'P4016_TEAM_MEMBER_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(50489754763320794575)
,p_prompt=>'Team Member'
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
,p_cSize=>50
,p_field_template=>1609121967514267634
,p_item_css_classes=>'u-flex-grow-1'
,p_item_template_options=>'#DEFAULT#:margin-left-sm:margin-right-sm'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53088317756976007008)
,p_name=>'P4016_APPROVAL_COUNT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(50133923929522657111)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(50555322873389653980)
,p_validation_name=>'no dups'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4016_INITIATIVE_APPROVAL_ID',
'   and team_member_id = :P4016_TEAM_MEMBER_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Duplicate entry found.'
,p_when_button_pressed=>wwv_flow_imp.id(50480441554394837680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(50555328265278655529)
,p_validation_name=>'no dup approval seq'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4016_INITIATIVE_APPROVAL_ID',
'   and approval_seq = :P4016_APPROVAL_SEQ'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Must use unique approval sequence'
,p_when_button_pressed=>wwv_flow_imp.id(50480441554394837680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50489755177286794580)
,p_name=>'delete'
,p_event_sequence=>20
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.delete-entry'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489755446604794582)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'set ID to delete'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_ID_TO_DELETE'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'$(this.triggeringElement).parent().data(''id'')'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53088317822999007009)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'check if pending approvals'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_APPROVAL_COUNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_project_approval_chain',
' where initiative_approval_chain_id = :P4016_ID_TO_DELETE'))
,p_attribute_07=>'P4016_ID_TO_DELETE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555557543671440162)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'set do not proceed'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_DELETE_PROCEED_YN'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'GREATER_THAN'
,p_client_condition_element=>'P4016_APPROVAL_COUNT'
,p_client_condition_expression=>'0'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53088317609249007007)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_name=>'active approval alert'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'User has active Approval assignments, cannot delete.'
,p_client_condition_type=>'GREATER_THAN'
,p_client_condition_element=>'P4016_APPROVAL_COUNT'
,p_client_condition_expression=>'0'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555557133204440158)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_name=>'check if only active approver'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_OTHER_APPROVERS_COUNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_initiative_approvals a,',
'       sp_initiative_approval_chain c',
' where a.id = c.initiative_approval_id    ',
'   and a.active_yn = ''Y''',
'   and c.active_yn = ''Y''',
'   and c.id != :P4016_ID_TO_DELETE',
'   and c.initiative_approval_id = (select initiative_approval_id',
'                                     from sp_initiative_approval_chain',
'                                    where c.id = :P4016_ID_TO_DELETE)'))
,p_attribute_07=>'P4016_ID_TO_DELETE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P4016_DELETE_PROCEED_YN'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555557654174440163)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_name=>'set do not proceed'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_DELETE_PROCEED_YN'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P4016_OTHER_APPROVERS_COUNT'
,p_client_condition_expression=>'0'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555557314339440160)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_name=>'only approver alert'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Only active approver, cannot delete.'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P4016_OTHER_APPROVERS_COUNT'
,p_client_condition_expression=>'0'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489755363890794581)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>'Are you sure you want to delete this entry?'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P4016_DELETE_PROCEED_YN'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489755555431794583)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_name=>'delete'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from sp_initiative_approval_chain',
' where id = :P4016_ID_TO_DELETE;'))
,p_attribute_02=>'P4016_ID_TO_DELETE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P4016_DELETE_PROCEED_YN'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489755808840794586)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_name=>'clear id'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_ID_TO_DELETE'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489755723448794585)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(85744355980580952544)
,p_attribute_01=>'N'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P4016_DELETE_PROCEED_YN'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555557722798440164)
,p_event_id=>wwv_flow_imp.id(50489755177286794580)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_name=>'clear counts'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_APPROVAL_COUNT,P4016_OTHER_APPROVERS_COUNT,P4016_DELETE_PROCEED_YN'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50489755881176794587)
,p_name=>'Add'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(50480441554394837680)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756209612794590)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Must provide Sequence and Team Member'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P4016_TEAM_MEMBER_ID'') === '''' || $v(''P4016_APPROVAL_SEQ'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756584803794594)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P4016_INITIATIVE_APPROVAL_ID,P4016_TEAM_MEMBER_ID,P4016_APPROVAL_SEQ'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756366776794592)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Team Member already in Approval Chain.'
,p_server_condition_type=>'EXISTS'
,p_server_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4016_INITIATIVE_APPROVAL_ID',
'   and team_member_id = :P4016_TEAM_MEMBER_ID'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756477995794593)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Approval Sequence must be unique.'
,p_server_condition_type=>'EXISTS'
,p_server_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_approval_chain',
' where initiative_approval_id = :P4016_INITIATIVE_APPROVAL_ID',
'   and approval_seq = :P4016_APPROVAL_SEQ'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756011084794588)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P4016_TEAM_MEMBER_ID is not null and :P4016_APPROVAL_SEQ is not null then',
'    insert into sp_initiative_approval_chain',
'        (INITIATIVE_APPROVAL_ID, TEAM_MEMBER_ID, APPROVAL_SEQ)',
'    values',
'        (:P4016_INITIATIVE_APPROVAL_ID, :P4016_TEAM_MEMBER_ID, :P4016_APPROVAL_SEQ);',
'end if;'))
,p_attribute_02=>'P4016_INITIATIVE_APPROVAL_ID,P4016_TEAM_MEMBER_ID,P4016_APPROVAL_SEQ'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756149275794589)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4016_APPROVAL_SEQ,P4016_TEAM_MEMBER_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50489756324761794591)
,p_event_id=>wwv_flow_imp.id(50489755881176794587)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(85744355980580952544)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53088318488482007016)
,p_name=>'after edit'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(85744355980580952544)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53088318605056007017)
,p_event_id=>wwv_flow_imp.id(53088318488482007016)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(85744355980580952544)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50489754935263794577)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'add entry'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into sp_initiative_approval_chain',
'    (INITIATIVE_APPROVAL_ID, TEAM_MEMBER_ID, APPROVAL_SEQ, active_yn)',
'values',
'    (:P4016_INITIATIVE_APPROVAL_ID, :P4016_TEAM_MEMBER_ID, :P4016_APPROVAL_SEQ, ''Y'');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(50480441554394837680)
,p_process_success_message=>'Entry added.'
,p_internal_uid=>13590397069861826808
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(50489758619431794614)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Cancel'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(50481189689631915447)
,p_internal_uid=>13590400754029826845
);
wwv_flow_imp.component_end;
end;
/
