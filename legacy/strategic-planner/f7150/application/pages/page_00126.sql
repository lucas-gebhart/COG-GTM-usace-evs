prompt --application/pages/page_00126
begin
--   Manifest
--     PAGE: 00126
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
 p_id=>126
,p_name=>'Clarification Requested'
,p_alias=>'CLARIFICATION-REQUESTED'
,p_page_mode=>'MODAL'
,p_step_title=>'Clarification Requested'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(60003305559851181314)
,p_name=>'Approval History'
,p_template=>4072358936313175081
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.id,',
'       t.initials user_icon,',
'       apex_util.get_since(c.last_status_on) comment_date,',
'       t.first_name || '' '' || t.last_name user_name,',
'       ''<strong>''||initcap(replace(c.status,''-'','' ''))||''</strong>'' comment_text,',
'       case when c.comments is not null',
'            then ''<br/>''||c.comments ',
'            end attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       null actions,',
'       case c.status ',
'            when ''PENDING'' then ''u-normal-bg''',
'            when ''APPROVED'' then ''u-success-bg''',
'            when ''REJECTED'' then ''u-danger-bg''',
'            when ''CLARIFICATION-REQUESTED'' then ''u-warning-bg''',
'            end icon_modifier,',
'       c.updated,',
'       null ob',
'  from sp_project_approval_chain c,',
'       sp_team_members t',
' where c.project_approval_id = :P126_PROJECT_APPROVAL_ID',
'   and c.team_member_id = t.id',
' union all',
'select a.id,',
'       t.initials user_icon,',
'       apex_util.get_since(a.updated) comment_date,',
'       t.first_name || '' '' || t.last_name user_name,',
'       ''<strong>''||initcap(a.status)||''</strong>'' comment_text,',
'       null attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       null actions,',
'       ''u-warning-bg'' icon_modifier,',
'       a.updated,',
'       null ob',
'  from sp_project_approvals a,',
'       sp_team_members t  ',
' where a.id = :P126_PROJECT_APPROVAL_ID',
'   and a.withdrawn_by_team_member_id = t.id',
'   and a.status = ''WITHDRAWN'' ',
' union all',
'select a.id,',
'       t.initials user_icon,',
'       apex_util.get_since(a.submitted) comment_date,',
'       t.first_name || '' '' || t.last_name user_name,',
'       ''<strong>Submitted</strong>'' comment_text,',
'       ''<br/>''||a.justification attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       null actions,',
'       ''u-info-bg'' icon_modifier,',
'       a.submitted updated,',
'       null ob',
'  from sp_project_approvals a,',
'       sp_team_members t  ',
' where a.id = :P126_PROJECT_APPROVAL_ID',
'   and a.submitted_by_team_member_id = t.id'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'updated desc nulls first, ob'
,p_display_when_condition=>'P126_PROJECT_APPROVAL_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475666144245828925)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475664509700828923)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>70
,p_column_heading=>'User Icon'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475667292967828927)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>40
,p_column_heading=>'Comment Date'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475666915846828926)
,p_query_column_id=>4
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'User Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475666533270828926)
,p_query_column_id=>5
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>20
,p_column_heading=>'Comment Text'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475664871197828924)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>80
,p_column_heading=>'Attribute 1'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475668138645828928)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>100
,p_column_heading=>'Attribute 2'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475668544966828929)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>110
,p_column_heading=>'Attribute 3'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475668934969828929)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>120
,p_column_heading=>'Attribute 4'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475665339466828924)
,p_query_column_id=>10
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>130
,p_column_heading=>'Actions'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475669302487828930)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>140
,p_column_heading=>'Icon Modifier'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475667693501828928)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_column_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475665670205828925)
,p_query_column_id=>13
,p_column_alias=>'OB'
,p_column_display_sequence=>150
,p_column_heading=>'Ob'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(60715651443867382455)
,p_name=>'Project'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.project,',
'       t.approval_type,',
'       a.justification,',
'       c.comments info_requested,',
'       apex_util.get_since(c.last_status_on) request_on,',
'       m.first_name || '' '' || m.last_name request_by',
'  from sp_project_approvals a,',
'       sp_project_approval_chain c,',
'       sp_projects p,',
'       sp_approval_types t,',
'       sp_team_members m',
' where a.project_id = p.id',
'   and a.id = :P126_PROJECT_APPROVAL_ID',
'   and a.approval_type_id = t.id',
'   and c.id = :P126_PROJECT_APPROVAL_CHAIN_ID',
'   and c.project_approval_id = :P126_PROJECT_APPROVAL_ID',
'   and c.team_member_id = m.id'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475673572049828936)
,p_query_column_id=>1
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>10
,p_column_heading=>'Project'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475674414391828937)
,p_query_column_id=>2
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>30
,p_column_heading=>'Approval Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49475674021099828937)
,p_query_column_id=>3
,p_column_alias=>'JUSTIFICATION'
,p_column_display_sequence=>20
,p_column_heading=>'Justification'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48999804278103585395)
,p_query_column_id=>4
,p_column_alias=>'INFO_REQUESTED'
,p_column_display_sequence=>60
,p_column_heading=>'Request'
,p_column_html_expression=>'<strong>#INFO_REQUESTED#</strong>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48999804390692585396)
,p_query_column_id=>5
,p_column_alias=>'REQUEST_ON'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48999804557783585397)
,p_query_column_id=>6
,p_column_alias=>'REQUEST_BY'
,p_column_display_sequence=>40
,p_column_heading=>'Requested'
,p_column_html_expression=>'#REQUEST_ON# by #REQUEST_BY#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(65966723060839506433)
,p_plug_name=>'&P126_APPROVAL_TYPE. Review'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P126_PROJECT_APPROVAL_CHAIN_ID'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49475670959535828932)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'CREATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49475669690642828930)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(60003305559851181314)
,p_button_name=>'Withdraw'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Withdraw Review'
,p_button_position=>'EDIT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_project_approvals',
' where id = :P126_PROJECT_APPROVAL_ID',
'   and submitted_by_team_member_id = :APP_USER_ID',
'   and status in (''PENDING'',''CLARIFICATION-REQUESTED'')'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(65966733487056506461)
,p_name=>'P126_COMMENTS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_prompt=>'Response'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>3
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68895663950996339060)
,p_name=>'P126_WF_TASK_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68895664485507339066)
,p_name=>'P126_PROJECT_APPROVAL_CHAIN_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(69605237054395052659)
,p_name=>'P126_APPROVAL_TYPE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(70628896528979563849)
,p_name=>'P126_PROJECT_APPROVAL_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(65966723060839506433)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49475675095961828938)
,p_computation_sequence=>140
,p_computation_item=>'P126_PROJECT_APPROVAL_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_approval_id',
'  from sp_project_approval_chain',
' where id = :P126_PROJECT_APPROVAL_CHAIN_ID'))
,p_compute_when=>'P126_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49475675478152828939)
,p_computation_sequence=>160
,p_computation_item=>'P126_WF_TASK_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id',
'  from apex_tasks',
' where to_char(detail_pk) = :P126_PROJECT_APPROVAL_CHAIN_ID'))
,p_compute_when=>'P126_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(49475675906808828939)
,p_validation_name=>'must have comments'
,p_validation_sequence=>10
,p_validation=>'P126_COMMENTS'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'You must provide comments.'
,p_associated_item=>wwv_flow_imp.id(65966733487056506461)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48999804647952585398)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Clarify'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.clarify (',
'    p_project_approval_chain_id => :P126_PROJECT_APPROVAL_CHAIN_ID,',
'    p_team_member_id            => :APP_USER_ID,',
'    p_response                  => :P126_COMMENTS );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49475670959535828932)
,p_internal_uid=>12100446782550617629
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49475676979338828941)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Provide Info'
,p_attribute_01=>'SUBMIT_INFO'
,p_attribute_02=>'P126_WF_TASK_ID'
,p_attribute_03=>'&P126_COMMENTS.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49475670959535828932)
,p_process_success_message=>'Information submitted.'
,p_internal_uid=>12576319113936861172
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49475676664742828940)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Withdraw'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select workflow_id ',
'      from apex_workflows',
'     where detail_pk = :P126_PROJECT_APPROVAL_ID',
'       and application_id = :APP_ID  ',
'       and workflow_def_static_id = ''PROJECT-REVIEW''',
') loop',
'   apex_workflow.terminate(p_instance_id => c1.workflow_id);',
'end loop;',
'',
'sp_approvals.withdraw (',
'    p_project_approval_id => :P126_PROJECT_APPROVAL_ID,',
'    p_team_member_id      => :APP_USER_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49475669690642828930)
,p_process_success_message=>'Request withdrawn.'
,p_internal_uid=>12576318799340861171
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49475676174755828940)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close window'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>12576318309353861171
);
wwv_flow_imp.component_end;
end;
/
