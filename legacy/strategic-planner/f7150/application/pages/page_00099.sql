prompt --application/pages/page_00099
begin
--   Manifest
--     PAGE: 00099
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
 p_id=>99
,p_name=>'Past Due Milestones, Reviews and Tasks'
,p_alias=>'PAST-DUE-IR'
,p_step_title=>'Past Due Milestones, Reviews and Tasks'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45067720961302709863)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'All &NOMENCLATURE_PROJECT. Milestones, Reviews and tasks that are overdue.  Including who each is assigned to, current status, and target completion. '
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(82290168200892120961)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(82290232254532843007)
,p_plug_name=>'Search Results'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative,',
'       apex_page.get_url (',
'           p_page   => 502,',
'           p_items  => ''P502_TASK_ID,P502_PROJECT_ID,P502_PREV_PAGE'',',
'           p_values => t.ID||'',''||p.id||'',65'') link,',
'       case when rt.static_id like ''REVIEW%''',
'            then apex_page.get_url (',
'                     p_page   => 509,',
'                     p_clear_cache => 509,',
'                     p_items  => ''P509_ID'',',
'                     p_values => t.ID) ',
'            when rt.static_id like ''MILESTONE%''',
'            then apex_page.get_url (',
'                     p_page   => 508,',
'                     p_clear_cache => 508,',
'                     p_items  => ''P508_ID'',',
'                     p_values => t.ID) ',
'            else apex_page.get_url (',
'                     p_page   => 501,',
'                     p_clear_cache => 501,',
'                     p_items  => ''P501_ID'',',
'                     p_values => t.ID)',
'            end edit_link,',
'       --',
'       -- project attributes',
'       --',
'       p.project project,',
'       p.id project_id,',
'       p.tags project_tags,',
'       p.PROJECT_URL_NAME,',
'       p.FRIENDLY_IDENTIFIER,',
'       --',
'       -- task info',
'       --',
'       t.id task_id,',
'       t.UPDATED,',
'       lower(t.updated_by) updated_by,',
'       t.created,',
'       lower(t.created_by) added_by,',
'       t.tags,',
'       t.start_date,',
'       t.target_complete,',
'       t.task task_name,',
'       substr(t.description,1,200)||case when length(t.description) > 200 then ''...'' end details,',
'       to_char(t.target_complete,''YYYY.MM'') complete_month_ob,',
'       nvl(to_char(t.target_complete,''YYYY.MM''),''Not Targeted'') complete_month_display,',
'       --',
'       -- status',
'       --',
'       s.status,',
'       --',
'       --',
'       --',
'       rt.task_type parent_task_type,',
'       --',
'       -- task name prefixed with task type',
'       --',
'       rt.task_type ||',
'           case when t.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = t.task_sub_type_id) name,',
'       --',
'       --',
'       case when p.release_id is not null',
'            then (select release_train||'' ''||release from sp_release_trains where id = p.release_id)',
'            else ''Not Targeted''',
'            end release,',
'       --',
'       -- owner',
'       --',
'       (select first_name ||'' ''||last_name from sp_team_members tm',
'         where tm.id = t.owner_id) assigned_to,',
'       --',
'       --',
'       --',
'       (select tags from sp_team_members tm where tm.id = t.owner_id) assignee_tags,',
'       --',
'       --',
'       --',
'       case when s.INDICATES_COMPLETE_YN = ''Y''',
'            then ''Complete''',
'            when t.target_complete < sysdate',
'            then ''Overdue''',
'            when t.target_complete is null',
'            then ''No Target Complete''',
'            else ''On Target''',
'            end completion_status',
'  from sp_tasks t,',
'       sp_projects p,',
'       sp_task_types rt,',
'       sp_initiatives i,',
'       sp_task_statuses s',
' where t.project_id = p.id',
'   and t.task_type_id = rt.id',
'   and p.initiative_id = i.id',
'   and t.status_id = s.id',
'   and p.ARCHIVED_YN = ''N''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   --',
'   and t.target_complete is not null ',
'   and s.status != ''Completed''',
'   and s.status != ''Not Needed''',
'   and t.target_complete < sysdate ',
'   and to_char(t.target_complete,''DD-MON-YYYY'') != to_char(sysdate,''DD-MON-YYYY'')',
'order by t.created desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(63247044849295460802)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'#EDIT_LINK#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>26347686983893493033
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63247045277243460806)
,p_db_column_name=>'PROJECT'
,p_display_order=>10
,p_column_identifier=>'D'
,p_column_label=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63247045356897460807)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'E'
,p_column_label=>'Milestone / Review / Task'
,p_column_link=>'f?p=&APP_ID.:98:&SESSION.::&DEBUG.:98:P98_TASK_ID:#TASK_ID#'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63247045474187460808)
,p_db_column_name=>'TASK_NAME'
,p_display_order=>30
,p_column_identifier=>'F'
,p_column_label=>'Task Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63247045073590460804)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>50
,p_column_identifier=>'B'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63247045158633460805)
,p_db_column_name=>'LINK'
,p_display_order=>60
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406278300487259)
,p_db_column_name=>'DETAILS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Details'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406350482487260)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406498381487261)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406566573487262)
,p_db_column_name=>'CREATED'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406815686487264)
,p_db_column_name=>'ADDED_BY'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406865151487265)
,p_db_column_name=>'TAGS'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450406986886487266)
,p_db_column_name=>'RELEASE'
,p_display_order=>130
,p_column_identifier=>'N'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407172454487268)
,p_db_column_name=>'ASSIGNED_TO'
,p_display_order=>140
,p_column_identifier=>'P'
,p_column_label=>'Assigned To'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407250334487269)
,p_db_column_name=>'STATUS'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407352723487270)
,p_db_column_name=>'PARENT_TASK_TYPE'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Parent Task Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407447406487271)
,p_db_column_name=>'START_DATE'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407549791487272)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>180
,p_column_identifier=>'T'
,p_column_label=>'Target Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-Mon-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407683742487273)
,p_db_column_name=>'PROJECT_TAGS'
,p_display_order=>190
,p_column_identifier=>'U'
,p_column_label=>'Project Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450407862291487275)
,p_db_column_name=>'COMPLETE_MONTH_OB'
,p_display_order=>200
,p_column_identifier=>'W'
,p_column_label=>'Completion Month Order By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450408009002487276)
,p_db_column_name=>'COMPLETE_MONTH_DISPLAY'
,p_display_order=>210
,p_column_identifier=>'X'
,p_column_label=>'Completion Month'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63450410738894487304)
,p_db_column_name=>'TASK_ID'
,p_display_order=>220
,p_column_identifier=>'Y'
,p_column_label=>'Task Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63592866403749219576)
,p_db_column_name=>'COMPLETION_STATUS'
,p_display_order=>230
,p_column_identifier=>'Z'
,p_column_label=>'Completion Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51065624554954282186)
,p_db_column_name=>'ASSIGNEE_TAGS'
,p_display_order=>240
,p_column_identifier=>'AA'
,p_column_label=>'Assignee Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51065624618183282187)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>250
,p_column_identifier=>'AB'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51065624692869282188)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>260
,p_column_identifier=>'AC'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51065624860690282189)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>270
,p_column_identifier=>'AD'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014888922860880752)
,p_db_column_name=>'EDIT_LINK'
,p_display_order=>280
,p_column_identifier=>'AE'
,p_column_label=>'Edit Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(63450600232124724215)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'119581795'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:NAME:TASK_NAME:ASSIGNED_TO:STATUS:RELEASE:TARGET_COMPLETE:UPDATED:'
,p_sort_column_1=>'UPDATED'
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
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(63452972084618751741)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Bar Chart by Status'
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'119605514'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RELEASE:PROJECT:NAME:TASK_NAME:ASSIGNED_TO:STATUS:UPDATED'
,p_sort_column_1=>'RELEASE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'PROJECT'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'NAME'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_chart_type=>'bar'
,p_chart_label_column=>'STATUS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'horizontal'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(63452994868828758861)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Bar Chart by Assignee'
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'119605742'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RELEASE:PROJECT:NAME:TASK_NAME:ASSIGNED_TO:STATUS:UPDATED'
,p_sort_column_1=>'RELEASE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'PROJECT'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'NAME'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_chart_type=>'bar'
,p_chart_label_column=>'ASSIGNED_TO'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'horizontal'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(63454871739511965709)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Grouped by Completion Month'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'119624511'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RELEASE:PROJECT:PARENT_TASK_TYPE:NAME:TASK_NAME:ASSIGNED_TO:STATUS:TARGET_COMPLETE:UPDATED:COMPLETE_MONTH_DISPLAY:'
,p_sort_column_1=>'COMPLETE_MONTH_OB'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'PROJECT'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'NAME'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'COMPLETE_MONTH_DISPLAY'
,p_break_enabled_on=>'COMPLETE_MONTH_DISPLAY'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51492358185946879919)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(82290168200892120961)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:99:&SESSION.::&DEBUG.:RR,99,RIR,CIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51492358646814879920)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(82290168200892120961)
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
