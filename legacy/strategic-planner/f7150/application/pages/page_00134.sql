prompt --application/pages/page_00134
begin
--   Manifest
--     PAGE: 00134
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
 p_id=>134
,p_name=>'All Project Approvals'
,p_alias=>'ALL-NOMENCLATURE-PROJECT-APPROVALS'
,p_step_title=>'All &NOMENCLATURE_PROJECT. Approvals'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45067720961302709863)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'All Approvals, regardless of status.  Includes &NOMENCLATURE_PROJECT., approval type, status, justification, list of approvers, and submitter.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50489716740263786806)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50489717426430786807)
,p_plug_name=>'All Project Approvals'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id project_id,',
'       i.initiative,',
'       p.project,',
'       t.approval_type,',
'       m.first_name||'' ''||m.last_name submitted_by,',
'       a.submitted,',
'       initcap(replace(a.status,''-'','' '')) status,',
'       case when a.status in (''PENDING'',''CLARIFICATION-REQUESTED'') then ''Active'' else ''Complete'' end state,',
'       a.justification,',
'       case when a.status in (''CLARIFICATION-REQUESTED'',''REJECTED'')',
'            then (select comments from ',
'                         (select comments, created, max(created) over (partition by project_approval_id) last_created',
'                            from sp_project_approval_chain',
'                           where a.id = project_approval_id)',
'                    where last_created = created)',
'            end last_comment,',
'       (select max(updated) from sp_project_approval_chain',
'         where project_approval_id = a.id) last_action,',
'       i.id initiative_id,',
'       (select listagg(t.first_name||'' ''||t.last_name,'', '')',
'               within group (order by c.last_status_on)',
'         from sp_project_approval_chain c,',
'              sp_team_members t',
'        where c.project_approval_id = a.id',
'          and c.team_member_id = t.id',
'          and c.final_yn = ''Y'') approvers',
'  from sp_project_approvals a,',
'       sp_approval_types t,',
'       sp_team_members m,',
'       sp_projects p,',
'       sp_initiatives i',
' where a.project_id = p.id',
'   and a.approval_type_id = t.id    ',
'   and a.submitted_by_team_member_id = m.id',
'   and p.initiative_id = i.id'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'All &NOMENCLATURE_PROJECT. Approvals'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(50489717559348786807)
,p_name=>'All &NOMENCLATURE_PROJECT. Approvals'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>13590359693946819038
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489756881271794597)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>11
,p_column_identifier=>'P'
,p_column_label=>'Initiative'
,p_column_link=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:94:P94_INITIATIVE_ID:#INITIATIVE_ID##ID#'
,p_column_linktext=>'#INITIATIVE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50133924757059657119)
,p_db_column_name=>'PROJECT'
,p_display_order=>21
,p_column_identifier=>'L'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:#PROJECT_ID#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489754234438794570)
,p_db_column_name=>'APPROVAL_TYPE'
,p_display_order=>31
,p_column_identifier=>'M'
,p_column_label=>'Approval Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489719806491786812)
,p_db_column_name=>'JUSTIFICATION'
,p_display_order=>41
,p_column_identifier=>'E'
,p_column_label=>'Justification'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489721045338786814)
,p_db_column_name=>'STATUS'
,p_display_order=>51
,p_column_identifier=>'H'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489720222172786813)
,p_db_column_name=>'SUBMITTED'
,p_display_order=>61
,p_column_identifier=>'F'
,p_column_label=>'Submitted'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489754282346794571)
,p_db_column_name=>'SUBMITTED_BY'
,p_display_order=>71
,p_column_identifier=>'N'
,p_column_label=>'Submitted By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489754433128794572)
,p_db_column_name=>'LAST_ACTION'
,p_display_order=>81
,p_column_identifier=>'O'
,p_column_label=>'Last Action'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489757196337794600)
,p_db_column_name=>'INITIATIVE_ID'
,p_display_order=>121
,p_column_identifier=>'S'
,p_column_label=>'Initiative Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489757358976794601)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>131
,p_column_identifier=>'T'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51905689887453848876)
,p_db_column_name=>'APPROVERS'
,p_display_order=>141
,p_column_identifier=>'U'
,p_column_label=>'Approvers'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53088318353830007014)
,p_db_column_name=>'STATE'
,p_display_order=>151
,p_column_identifier=>'V'
,p_column_label=>'State'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53717787254161053879)
,p_db_column_name=>'LAST_COMMENT'
,p_display_order=>161
,p_column_identifier=>'W'
,p_column_label=>'Last Comment'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(50489856866149829507)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'135904991'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INITIATIVE:PROJECT:APPROVAL_TYPE:STATUS:JUSTIFICATION:APPROVERS:LAST_COMMENT:SUBMITTED_BY:SUBMITTED:LAST_ACTION:'
,p_sort_column_1=>'LAST_ACTION'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(53949289464874384360)
,p_report_id=>wwv_flow_imp.id(50489856866149829507)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'STATE'
,p_operator=>'='
,p_expr=>'Active'
,p_condition_sql=>'"STATE" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''Active''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50489892233954837550)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(50489716740263786806)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:134:&SESSION.::&DEBUG.:RR,134,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50489888917482836575)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(50489716740263786806)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
