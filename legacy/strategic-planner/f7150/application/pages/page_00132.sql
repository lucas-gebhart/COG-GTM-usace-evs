prompt --application/pages/page_00132
begin
--   Manifest
--     PAGE: 00132
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
 p_id=>132
,p_name=>'My Approval Requests'
,p_alias=>'MY-APPROVAL-REQUESTS'
,p_page_mode=>'MODAL'
,p_step_title=>'My Approval Requests'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(50799538773915804187)
,p_name=>'Pending Requests'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id, ',
'       p.project,',
'       t.approval_type,',
'       m.first_name||'' ''||m.last_name submitted_by',
'  from sp_project_approval_chain c,',
'       sp_project_approvals a,',
'       sp_projects p,',
'       sp_team_members m,',
'       sp_approval_types t',
' where a.id = c.project_approval_id',
'   and c.team_member_id = :APP_USER_ID',
'   and c.status = ''PENDING''',
'   and c.final_yn = ''Y''',
'   and a.project_id = p.id',
'   and a.approval_type_id = t.id    ',
'   and a.submitted_by_team_member_id = m.id',
' order by c.last_status_on'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.approval_pending_cnt (',
'    p_team_member_id => :APP_USER_ID ) > 0'))
,p_display_when_cond2=>'PLSQL'
,p_display_condition_type=>'EXPRESSION'
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
 p_id=>wwv_flow_imp.id(50799538929662804188)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539039994804189)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>20
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:#ID#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539145248804190)
,p_query_column_id=>3
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>30
,p_column_heading=>'Approval Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539258266804191)
,p_query_column_id=>4
,p_column_alias=>'SUBMITTED_BY'
,p_column_display_sequence=>40
,p_column_heading=>'Submitted By'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(50799539357592804192)
,p_name=>'More Info Pending'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id, ',
'       p.project,',
'       t.approval_type,',
'       m.first_name||'' ''||m.last_name requested_by,',
'       c.comments',
'  from sp_project_approval_chain c,',
'       sp_project_approvals a,',
'       sp_projects p,',
'       sp_team_members m,',
'       sp_approval_types t',
' where a.id = c.project_approval_id',
'   and c.status = ''CLARIFICATION-REQUESTED''',
'   and a.status = ''CLARIFICATION-REQUESTED''',
'   and c.final_yn = ''Y''',
'   and a.submitted_by_team_member_id = :APP_USER_ID',
'   and a.project_id = p.id',
'   and a.approval_type_id = t.id    ',
'   and c.team_member_id = m.id',
' order by c.last_status_on'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_approvals.more_info_pending_cnt (',
'    p_team_member_id => :APP_USER_ID ) > 0'))
,p_display_when_cond2=>'PLSQL'
,p_display_condition_type=>'EXPRESSION'
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
 p_id=>wwv_flow_imp.id(50799539383012804193)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539536395804194)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>20
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:#ID#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539619339804195)
,p_query_column_id=>3
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>30
,p_column_heading=>'Approval Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539810246804197)
,p_query_column_id=>4
,p_column_alias=>'REQUESTED_BY'
,p_column_display_sequence=>40
,p_column_heading=>'Requested By'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50799539889253804198)
,p_query_column_id=>5
,p_column_alias=>'COMMENTS'
,p_column_display_sequence=>50
,p_column_heading=>'Comments'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp.component_end;
end;
/
