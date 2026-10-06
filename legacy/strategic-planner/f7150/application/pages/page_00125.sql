prompt --application/pages/page_00125
begin
--   Manifest
--     PAGE: 00125
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
 p_id=>125
,p_name=>'Approval Request'
,p_alias=>'APPROVAL-REQUST'
,p_page_mode=>'MODAL'
,p_step_title=>'Approval Request'
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
 p_id=>wwv_flow_imp.id(47426999824562320168)
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
'       t.first_name ||'' ''|| t.last_name||'' (''||lower(t.email)||'')'' user_name,',
'       ''<strong>''||apex_escape.html(initcap(replace(c.status,''-'','' '')))||''</strong>'' comment_text,',
'       case when c.comments is not null',
'            then ''<br/>''||apex_escape.html(c.comments)',
'            end attribute_1,',
'       case when c.response is not null',
'            then ''<br/>Response: ''||apex_escape.html(c.response) ',
'            end attribute_2,',
'       case when c.response_by_team_member_id is not null',
'            then ''<br/>By: ''||(select apex_escape.html(first_name || '' '' || last_name) from sp_team_members',
'                            where id = c.response_by_team_member_id) ',
'            end ||'' ''||apex_util.get_since(c.responded_on) attribute_3,',
'       null attribute_4,',
'       null actions,',
'       case c.status ',
'            when ''PENDING'' then ''u-normal-bg''',
'            when ''APPROVED'' then ''u-success-bg''',
'            when ''REJECTED'' then ''u-danger-bg''',
'            when ''CLARIFICATION-REQUESTED'' then ''u-warning-bg''',
'            end icon_modifier,',
'       c.last_status_on updated,',
'       1 ob',
'  from sp_project_approval_chain c,',
'       sp_team_members t',
' where c.project_approval_id = :P125_PROJECT_APPROVAL_ID',
'   and c.team_member_id = t.id',
' union all',
'select a.id,',
'       t.initials user_icon,',
'       apex_util.get_since(a.updated) comment_date,',
'       t.first_name ||'' ''|| t.last_name||'' (''||lower(t.email)||'')'' user_name,',
'       ''<strong>''||initcap(a.status)||''</strong>'' comment_text,',
'       null attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       null actions,',
'       ''u-warning-bg'' icon_modifier,',
'       a.updated,',
'       1 ob',
'  from sp_project_approvals a,',
'       sp_team_members t  ',
' where a.id = :P125_PROJECT_APPROVAL_ID',
'   and a.withdrawn_by_team_member_id = t.id',
'   and a.status = ''WITHDRAWN'' ',
' union all',
'select a.id,',
'       t.initials user_icon,',
'       apex_util.get_since(a.submitted) comment_date,',
'       t.first_name ||'' ''|| t.last_name||'' (''||lower(t.email)||'')'' user_name,',
'       ''<strong>Submitted</strong>'' comment_text,',
'       ''<br/>''||a.justification attribute_1,',
'       null attribute_2,',
'       null attribute_3,',
'       null attribute_4,',
'       null actions,',
'       ''u-info-bg'' icon_modifier,',
'       a.submitted updated,',
'       2 ob',
'  from sp_project_approvals a,',
'       sp_team_members t  ',
' where a.id = :P125_PROJECT_APPROVAL_ID',
'   and a.submitted_by_team_member_id = t.id'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'ob, updated desc nulls first'
,p_display_when_condition=>'P125_PROJECT_APPROVAL_ID'
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
 p_id=>wwv_flow_imp.id(46511824132962831612)
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
 p_id=>wwv_flow_imp.id(46511824727170831618)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>70
,p_column_heading=>'User Icon'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511824389216831615)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>40
,p_column_heading=>'Comment Date'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511824332214831614)
,p_query_column_id=>4
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'User Name'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511824182436831613)
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
 p_id=>wwv_flow_imp.id(46511824770475831619)
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
 p_id=>wwv_flow_imp.id(47428147197087206171)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>100
,p_column_heading=>'Attribute 2'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(47428147352742206172)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>110
,p_column_heading=>'Attribute 3'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(47428147381072206173)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>120
,p_column_heading=>'Attribute 4'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(47428147079758206170)
,p_query_column_id=>10
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>130
,p_column_heading=>'Actions'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48139344568776521298)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>140
,p_column_heading=>'Icon Modifier'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511824599140831617)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_column_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48139346177572521314)
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
 p_id=>wwv_flow_imp.id(48139345708578521309)
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
'       a.justification',
'  from sp_project_approvals a,',
'       sp_projects p,',
'       sp_approval_types t',
' where a.project_id = p.id',
'   and a.id = :P125_PROJECT_APPROVAL_ID',
'   and a.approval_type_id = t.id'))
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
 p_id=>wwv_flow_imp.id(48139345766386521310)
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
 p_id=>wwv_flow_imp.id(48139345986830521312)
,p_query_column_id=>2
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Approval Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48139345937492521311)
,p_query_column_id=>3
,p_column_alias=>'JUSTIFICATION'
,p_column_display_sequence=>30
,p_column_heading=>'Justification'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(50489759041637794618)
,p_name=>'Subsequent Approvers'
,p_template=>2664334895415463485
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case when c.alternate_team_member_id is not null and   ',
'                 (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                 (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'            then ''Alternate - ''||',
'                 (select last_name||'', ''||first_name||'' (''||lower(email)||'')''',
'                    from sp_team_members',
'                   where id = c.alternate_team_member_id)',
'            else t.last_name||'', ''||t.first_name||'' (''||lower(t.email)||'')'' ',
'            end reviewer',
'  from sp_initiative_approval_chain c,',
'       sp_project_approvals a,',
'       sp_team_members t',
' where a.id = :P125_PROJECT_APPROVAL_ID',
'   and a.initiative_approval_id = c.initiative_approval_id',
'   and c.team_member_id = t.id',
'   and c.id not in (select initiative_approval_chain_id',
'                      from sp_project_approval_chain',
'                     where project_approval_id = :P125_PROJECT_APPROVAL_ID)',
' order by c.approval_seq'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_approvals pa,',
'       sp_initiative_approval_chain iac',
' where pa.id = :P125_PROJECT_APPROVAL_ID',
'   and pa.initiative_approval_id = iac.initiative_approval_id',
'    and iac.active_yn = ''Y''',
'    and iac.id not in (select initiative_approval_chain_id',
'                         from sp_project_approval_chain',
'                        where project_approval_id = pa.id',
'                          and status in (''PENDING'',''APPROVED'')',
'                          and final_yn = ''Y'')',
'    and iac.approval_seq > nvl((select max(iac2.approval_seq)',
'                                  from sp_project_approval_chain pac,',
'                                       sp_initiative_approval_chain iac2',
'                                 where pac.initiative_approval_chain_id = iac2.id',
'                                   and pac.project_approval_id = pa.id',
'                                   and pac.status = ''APPROVED''',
'                                   and pac.final_yn = ''Y''),-100)'))
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
 p_id=>wwv_flow_imp.id(50799538282351804182)
,p_query_column_id=>1
,p_column_alias=>'REVIEWER'
,p_column_display_sequence=>10
,p_column_heading=>'Reviewer'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53390417325550645287)
,p_plug_name=>'&P125_APPROVAL_TYPE. Review'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P125_PROJECT_APPROVAL_CHAIN_ID'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47523791585394464276)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_button_name=>'APPROVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_position=>'CREATE'
,p_confirm_message=>'Do you really want to approve this request?'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47523791190312464276)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_button_name=>'REQUEST_CLARIFICATION'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Request Clarification'
,p_button_position=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47523792372186464277)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_button_name=>'REJECT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reject'
,p_button_position=>'DELETE'
,p_confirm_message=>'Do you really want to reject this request?'
,p_icon_css_classes=>'fa-window-close-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47428148707643206186)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(47426999824562320168)
,p_button_name=>'Withdraw'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Withdraw Request'
,p_button_position=>'EDIT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_project_approvals',
' where id = :P125_PROJECT_APPROVAL_ID',
'   and submitted_by_team_member_id = :APP_USER_ID',
'   and status in (''PENDING'',''CLARIFICATION-REQUESTED'')'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53390419635944645297)
,p_name=>'P125_COMMENTS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_prompt=>'Comments'
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
 p_id=>wwv_flow_imp.id(56319350099884477896)
,p_name=>'P125_WF_TASK_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56319350634395477902)
,p_name=>'P125_PROJECT_APPROVAL_CHAIN_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(57028923203283191495)
,p_name=>'P125_APPROVAL_TYPE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(58052582677867702685)
,p_name=>'P125_PROJECT_APPROVAL_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(53390417325550645287)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(47524373332275256318)
,p_computation_sequence=>140
,p_computation_item=>'P125_PROJECT_APPROVAL_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_approval_id',
'  from sp_project_approval_chain',
' where id = :P125_PROJECT_APPROVAL_CHAIN_ID'))
,p_compute_when=>'P125_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(47524381274340258297)
,p_computation_sequence=>160
,p_computation_item=>'P125_WF_TASK_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id',
'  from apex_tasks',
' where to_char(detail_pk) = :P125_PROJECT_APPROVAL_CHAIN_ID'))
,p_compute_when=>'P125_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(47428147993667206179)
,p_validation_name=>'must have comments to reject or request more info'
,p_validation_sequence=>10
,p_validation=>'P125_COMMENTS'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'You must provide comments.'
,p_validation_condition=>'REJECT,REQUEST_CLARIFICATION'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(53390419635944645297)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47524692574144497037)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Approve'
,p_attribute_01=>'APPROVE_TASK'
,p_attribute_02=>'P125_WF_TASK_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(47523791585394464276)
,p_process_success_message=>'Approval submitted.'
,p_internal_uid=>10625334708742529268
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47524701497751498673)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Reject'
,p_attribute_01=>'REJECT_TASK'
,p_attribute_02=>'P125_WF_TASK_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(47523792372186464277)
,p_process_success_message=>'Rejection submitted.'
,p_internal_uid=>10625343632349530904
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47524708902279499854)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Request Info'
,p_attribute_01=>'REQUEST_INFO'
,p_attribute_02=>'P125_WF_TASK_ID'
,p_attribute_03=>'&P125_COMMENTS.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(47523791190312464276)
,p_process_success_message=>'More information requested.'
,p_internal_uid=>10625351036877532085
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47524874339077275710)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Pass Comments to Task'
,p_attribute_01=>'ADD_TASK_COMMENT'
,p_attribute_02=>'P125_WF_TASK_ID'
,p_attribute_03=>'&P125_COMMENTS.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P125_COMMENTS'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>10625516473675307941
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47428148821696206187)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Withdraw'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select workflow_id ',
'      from apex_workflows',
'     where detail_pk = :P125_PROJECT_APPROVAL_ID',
'       and application_id = :APP_ID  ',
'       and workflow_def_static_id = ''PROJECT-REVIEW''',
') loop',
'   apex_workflow.terminate(p_instance_id => c1.workflow_id);',
'end loop;',
'',
'sp_approvals.withdraw (',
'    p_project_approval_id => :P125_PROJECT_APPROVAL_ID,',
'    p_team_member_id      => :APP_USER_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(47428148707643206186)
,p_process_success_message=>'Request withdrawn.'
,p_internal_uid=>10528790956294238418
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47428148186069206181)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close window'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>10528790320667238412
);
wwv_flow_imp.component_end;
end;
/
