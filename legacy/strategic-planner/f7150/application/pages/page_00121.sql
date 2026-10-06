prompt --application/pages/page_00121
begin
--   Manifest
--     PAGE: 00121
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
 p_id=>121
,p_name=>'Request Approval'
,p_alias=>'REQUEST-APPROVAL'
,p_page_mode=>'MODAL'
,p_step_title=>'Request Approval'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(48139344831136521300)
,p_name=>'Approval Chain'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rownum, reviewer',
'  from',
'  (',
'select case when c.alternate_team_member_id is not null and   ',
'                 (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                 (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'            then ''Alternate - ''||',
'                 (select last_name||'', ''||first_name||'' (''||lower(email)||'')''',
'                    from sp_team_members',
'                   where id = c.alternate_team_member_id)',
'            else tm.last_name||'', ''||tm.first_name||'' (''||lower(tm.email)||'')'' ',
'            end reviewer',
'  from sp_initiative_approvals ia,',
'       sp_initiative_approval_chain c,',
'       sp_team_members tm,',
'       sp_projects p',
' where ia.approval_type_id = :P121_APPROVAL_TYPE_ID',
'   and ia.initiative_id = p.initiative_id',
'   and p.id = :P121_PROJECT_ID',
'   and ia.id = c.initiative_approval_id',
'   and c.team_member_id = tm.id',
' order by c.approval_seq',
')'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P121_APPROVAL_TYPE_ID'
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
 p_id=>wwv_flow_imp.id(48139345586371521308)
,p_query_column_id=>1
,p_column_alias=>'ROWNUM'
,p_column_display_sequence=>10
,p_column_heading=>'Review Order'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48139344908678521301)
,p_query_column_id=>2
,p_column_alias=>'REVIEWER'
,p_column_display_sequence=>20
,p_column_heading=>'Reviewer'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(77299309669378483206)
,p_plug_name=>'Request Approval'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(77299310049843483210)
,p_plug_name=>'Button Container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46052080099291080966)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(77299310049843483210)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46052079739367080966)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(77299310049843483210)
,p_button_name=>'request-approval'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Request Approval'
,p_button_position=>'CREATE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(46052082898755080970)
,p_branch_name=>'Go To Page 3'
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:&P121_PROJECT_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45694913686231981373)
,p_name=>'P121_JUSTIFICATION'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_prompt=>'Justification'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46404487630350694980)
,p_name=>'P121_APP_NAME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46404488700260694991)
,p_name=>'P121_PROJECT_URL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46404489166870694996)
,p_name=>'P121_APPROVAL_TYPE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47428148378850206183)
,p_name=>'P121_PROJECT_APPROVAL_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(65672591689556985314)
,p_name=>'P121_APPROVAL_TYPE_ID'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select t.id r',
'      from sp_approval_types t,',
'           sp_initiative_approvals i,',
'           sp_projects p',
'     where t.id = i.approval_type_id',
'       and i.initiative_id = p.initiative_id',
'       and p.id = :P121_PROJECT_ID',
'       and t.id not in (select approval_type_id    ',
'                          from sp_project_approvals',
'                         where project_id = :P121_PROJECT_ID',
'                           and status in (''PENDING'',''APPROVED''))',
'     order by t.display_seq, t.approval_type',
') loop',
'    return c1.r;',
'end loop;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Approval Type'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.approval_type d, t.id r',
'  from sp_approval_types t,',
'       sp_initiative_approvals i,',
'       sp_projects p',
' where t.id = i.approval_type_id',
'   and i.initiative_id = p.initiative_id',
'   and p.id = :P121_PROJECT_ID',
'   and t.id not in (select approval_type_id    ',
'                      from sp_project_approvals',
'                     where project_id = :P121_PROJECT_ID',
'                       and status in (''PENDING'',''APPROVED''))',
' order by t.display_seq, t.approval_type'))
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(66470454854056561030)
,p_name=>'P121_PROJECT_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(66470455288089561032)
,p_name=>'P121_PROJECT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(77299309669378483206)
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
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46404489293280694997)
,p_computation_sequence=>20
,p_computation_item=>'P121_APPROVAL_TYPE'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select approval_type',
'  from sp_approval_types',
' where id = :P121_APPROVAL_TYPE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46052080818702080967)
,p_computation_sequence=>10
,p_computation_item=>'P121_PROJECT'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project',
'from sp_projects',
'where id = :P121_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46404487756772694981)
,p_computation_sequence=>30
,p_computation_item=>'P121_APP_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>'return sp_util.get_nomenclature(''STRATEGIC_PLANNER'');'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46404488811587694992)
,p_computation_sequence=>40
,p_computation_item=>'P121_PROJECT_URL'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select APEX_UTIL.HOST_URL(''SCRIPT'') || ''project-details?fi='' || friendly_identifier || ''&pn='' || project_url_name',
'  from sp_projects',
' where id = :P121_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46052081908042080969)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(46052080099291080966)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46052082366696080969)
,p_event_id=>wwv_flow_imp.id(46052081908042080969)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48139345005520521302)
,p_name=>'change approval type'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P121_APPROVAL_TYPE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139345370545521306)
,p_event_id=>wwv_flow_imp.id(48139345005520521302)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48139344831136521300)
,p_client_condition_type=>'NOT_NULL'
,p_client_condition_element=>'P121_APPROVAL_TYPE_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139345473762521307)
,p_event_id=>wwv_flow_imp.id(48139345005520521302)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48139344831136521300)
,p_client_condition_type=>'NULL'
,p_client_condition_element=>'P121_APPROVAL_TYPE_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139345097097521303)
,p_event_id=>wwv_flow_imp.id(48139345005520521302)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48139344831136521300)
,p_attribute_01=>'N'
,p_client_condition_type=>'NOT_NULL'
,p_client_condition_element=>'P121_APPROVAL_TYPE_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47428148337810206182)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Project Approval'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.submit_for_approval (',
'    p_project_id          => :P121_PROJECT_ID,',
'    p_approval_type_id    => :P121_APPROVAL_TYPE_ID,',
'    p_team_member_id      => :APP_USER_ID,',
'    p_justification       => :P121_JUSTIFICATION,',
'    p_project_approval_id => :P121_PROJECT_APPROVAL_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(46052079739367080966)
,p_internal_uid=>10528790472408238413
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(45694913783132981374)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Start Workflow'
,p_attribute_01=>'START'
,p_attribute_02=>wwv_flow_imp.id(42765986457466148805)
,p_attribute_03=>'P121_PROJECT_APPROVAL_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(46052079739367080966)
,p_process_success_message=>'Request Submitted.'
,p_internal_uid=>8795555917731013605
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(18397163051570845121)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(17885008776626678871)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'APP_USER_ID'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46167964647696522557)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(45694914706157981383)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_PROJECT_ID'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46278921197036124746)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(45694916507419981401)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'NOMENCLATURE_PROJECT'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46279656860851410527)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(45694916852188981404)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_PROJECT_URL'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46314818982839249604)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(45694917837996981414)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_PROJECT'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46407215744264946674)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(46404487517638694979)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_APP_NAME'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(46507842410532776552)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(46404489076453694995)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_APPROVAL_TYPE'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(47555985498755268211)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(47428148578787206185)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'P121_PROJECT_APPROVAL_ID'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(48269140023465981111)
,p_page_process_id=>wwv_flow_imp.id(45694913783132981374)
,p_workflow_variable_id=>wwv_flow_imp.id(48139342769096521280)
,p_page_id=>121
,p_value_type=>'ITEM'
,p_value=>'APP_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(46052081116723080968)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P121_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>9152723251321113199
);
wwv_flow_imp.component_end;
end;
/
