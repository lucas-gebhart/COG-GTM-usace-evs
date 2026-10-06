prompt --application/pages/page_04012
begin
--   Manifest
--     PAGE: 04012
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
 p_id=>4012
,p_name=>'Initiative Approval Types'
,p_alias=>'INITIATIVE-APPROVAL-TYPES'
,p_step_title=>'&NOMENCLATURE_INITIATIVE. Approval Types'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60406637142913002242)
,p_plug_name=>'&NOMENCLATURE_INITIATIVE. Approval Types'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.ID,',
'       a.approval_type_id,',
'       i.INITIATIVE,',
'       t.approval_type,',
'       case when a.active_yn = ''Y'' then ''Active'' else ''Inactive'' end status,',
'       a.CREATED,',
'       a.CREATED_BY,',
'       a.UPDATED,',
'       a.UPDATED_BY,',
'       (select count(*) from sp_project_approvals',
'         where initiative_approval_id = a.id) projects,',
'       nvl((select listagg(case when c.alternate_team_member_id is not null and   ',
'                                    (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                                    (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'                                then ''Alternate - ''||',
'                                     (select first_name||'' ''||last_name',
'                                        from sp_team_members',
'                                       where id = c.alternate_team_member_id)',
'                                else tm.first_name||'' ''||tm.last_name',
'                                end ,'', '')',
'                   within group (order by approval_seq)',
'              from sp_initiative_approval_chain c,',
'                   sp_team_members tm',
'             where c.initiative_approval_id = a.id',
'               and c.team_member_id = tm.id',
'               and c.active_yn = ''Y''',
'              group by c.initiative_approval_id),''None Yet'') approvers',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Initiative Approval Types'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(60406637252815002242)
,p_name=>'Initiative Approval Types'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:4013:&SESSION.::&DEBUG.:RP,4013:P4013_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>23507279387413034473
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60406637897979002244)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48139346569435521318)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>10
,p_column_identifier=>'I'
,p_column_label=>'&NOMENCLATURE_INITIATIVE.'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48139346707458521319)
,p_db_column_name=>'APPROVAL_TYPE'
,p_display_order=>20
,p_column_identifier=>'J'
,p_column_label=>'Approval Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48653980512047826598)
,p_db_column_name=>'PROJECTS'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'&NOMENCLATURE_PROJECTS.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50489754609247794574)
,p_db_column_name=>'APPROVERS'
,p_display_order=>50
,p_column_identifier=>'P'
,p_column_label=>'Approvers'
,p_column_link=>'f?p=&APP_ID.:4014:&SESSION.::&DEBUG.:4014,CIR,RIR:IR_INITIATIVE_APPROVAL_ID:#ID#'
,p_column_linktext=>'#APPROVERS#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60406638694424002245)
,p_db_column_name=>'CREATED'
,p_display_order=>60
,p_column_identifier=>'C'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60406639159335002246)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>70
,p_column_identifier=>'D'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60406639538303002246)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'E'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60406639919858002246)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>90
,p_column_identifier=>'F'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48653978420565826577)
,p_db_column_name=>'APPROVAL_TYPE_ID'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Selected Approval Type'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954356134232454118)
,p_db_column_name=>'STATUS'
,p_display_order=>110
,p_column_identifier=>'O'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(60406656548875008114)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'117529421'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INITIATIVE:APPROVAL_TYPE:STATUS:APPROVERS:PROJECTS:UPDATED'
,p_sort_column_1=>'INITIATIVE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'APPROVAL_TYPE'
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60406642492715002249)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48653718833891575514)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(60406642492715002249)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Type'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:4013:&SESSION.::&DEBUG.:4013::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48653718372838575513)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(60406642492715002249)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48653719753959575515)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(60406637142913002242)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48653720216432575516)
,p_event_id=>wwv_flow_imp.id(48653719753959575515)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(60406637142913002242)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48653981275756826606)
,p_name=>'add entry'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(60406642492715002249)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48653981389411826607)
,p_event_id=>wwv_flow_imp.id(48653981275756826606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(60406637142913002242)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
