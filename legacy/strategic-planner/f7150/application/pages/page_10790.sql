prompt --application/pages/page_10790
begin
--   Manifest
--     PAGE: 10790
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
 p_id=>10790
,p_name=>'Team Member Notifications'
,p_alias=>'TEAM-MEMBER-NOTIFICATIONS'
,p_step_title=>'Team Member Notifications'
,p_autocomplete_on_off=>'OFF'
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18063943007089890172)
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
 p_id=>wwv_flow_imp.id(18063943729445890174)
,p_plug_name=>'Team Member Notifications'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       TEAM_MEMBER_ID,',
'       (select first_name||'' ''||last_name',
'          from sp_team_members',
'         where id = n.team_member_id) team_member,',
'       length(EMAIL_CONTENTS) view_email,',
'       PROJECT_ID,',
'       (select project',
'          from sp_projects',
'         where id = n.project_id) project,',
'       DISMISSED_YN,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       NOTIFICATION_PREF,',
'       TITLE,',
'       RELEASE_ID,',
'       INITIATIVE_ID,',
'       TASK_ID,',
'       NOTIFICATION_TYPE',
'  from SP_TEAM_MEMBER_NOTIFICATIONS n'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Team Member Notifications'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(18063943844842890174)
,p_name=>'Team Member Notifications'
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
,p_internal_uid=>18062404262974832046
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063945584164890389)
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
 p_id=>wwv_flow_imp.id(18063947233072890391)
,p_db_column_name=>'DISMISSED_YN'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Dismissed '
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063947639325890392)
,p_db_column_name=>'CREATED'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063948006215890392)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063948403784890392)
,p_db_column_name=>'UPDATED'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063948806820890393)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063949191686890393)
,p_db_column_name=>'NOTIFICATION_PREF'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Notification Pref'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063949589599890393)
,p_db_column_name=>'TITLE'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Title'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(18063951265820890395)
,p_db_column_name=>'NOTIFICATION_TYPE'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Notification Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007037813678854)
,p_db_column_name=>'TEAM_MEMBER_ID'
,p_display_order=>25
,p_column_identifier=>'P'
,p_column_label=>'Team Member ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007177733678855)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>35
,p_column_identifier=>'Q'
,p_column_label=>'Project ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007234421678856)
,p_db_column_name=>'RELEASE_ID'
,p_display_order=>45
,p_column_identifier=>'R'
,p_column_label=>'Release ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007293865678857)
,p_db_column_name=>'INITIATIVE_ID'
,p_display_order=>55
,p_column_identifier=>'S'
,p_column_label=>'Initiative ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007421994678858)
,p_db_column_name=>'TASK_ID'
,p_display_order=>65
,p_column_identifier=>'T'
,p_column_label=>'Task Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007527892678859)
,p_db_column_name=>'TEAM_MEMBER'
,p_display_order=>75
,p_column_identifier=>'U'
,p_column_label=>'Team Member'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007650046678860)
,p_db_column_name=>'PROJECT'
,p_display_order=>85
,p_column_identifier=>'V'
,p_column_label=>'Project'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(17885007843710678862)
,p_db_column_name=>'VIEW_EMAIL'
,p_display_order=>95
,p_column_identifier=>'W'
,p_column_label=>'Email Length'
,p_column_link=>'f?p=&APP_ID.:10791:&SESSION.::&DEBUG.:10791:P10791_ID:#ID#'
,p_column_linktext=>'#VIEW_EMAIL#'
,p_column_link_attr=>'title="View Email"'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(18064100227460145370)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'180625607'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TEAM_MEMBER:NOTIFICATION_PREF:NOTIFICATION_TYPE:TITLE:PROJECT:VIEW_EMAIL:DISMISSED_YN:UPDATED:'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18064338867332916565)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(18063943007089890172)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
