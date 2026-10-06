prompt --application/pages/page_00005
begin
--   Manifest
--     PAGE: 00005
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
 p_id=>5
,p_name=>'UserDetail'
,p_alias=>'USERDETAIL'
,p_step_title=>'&P5_FIRST_NAME. &P5_LAST_NAME.'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066659146316698292)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.sp-tag {',
'  padding: .125rem .25rem;',
'  display: inline-block;',
'  vertical-align: text-bottom;',
'  border-radius: .1875rem;',
'  background-color: rgba(0, 0, 0, .1);',
'  text-overflow: ellipsis;',
'  white-space: nowrap;',
'}',
'',
'.sp-tags-container {',
'  display: flex;',
'  align-items: center;',
'  flex-wrap: wrap;',
'  gap: .25rem;',
'  justify-content: flex-start;',
'}',
'',
'h3:first-of-type {',
'  margin-block-start: 0;',
'}'))
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20511113226381173157)
,p_plug_name=>'Approvals'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.project, p.friendly_identifier, p.project_url_name,',
'       a.id approval_id, t.approval_type,',
'       case when a.submitted_by_team_member_id = :P5_ID',
'            then ''Submitter''',
'            when p.owner_id = :P5_ID',
'            then ''Owner''',
'            else  (select case when status = ''PENDING'' then ''Pending Review''',
'                               else initcap(replace(status,''-'','' ''))',
'                               end',
'                     from (select status,',
'                                  updated,',
'                                  max(updated) over (partition by team_member_id) last_updated',
'                             from sp_project_approval_chain',
'                            where project_approval_id = a.id',
'                              and team_member_id = :P5_ID)',
'                    where last_updated = updated)',
'            end role,',
'            initcap(replace(a.status,''-'','' '')) current_status,',
'            nvl((select max(updated) from sp_project_approval_chain',
'                  where project_approval_id = a.id), a.updated) updated',
'  from sp_projects p, ',
'       sp_project_approvals a,',
'       sp_approval_types t',
' where p.id = a.project_id',
'   and p.ARCHIVED_YN = ''N''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and a.approval_type_id = t.id',
'   and ( p.owner_id = :P5_ID',
'         or',
'         a.submitted_by_team_member_id = :P5_ID',
'         or',
'         exists (select 1 from sp_project_approval_chain',
'                  where project_approval_id = a.id',
'                    and team_member_id = :P5_ID) )',
'order by a.updated desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_ID'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_projects p, ',
'       sp_project_approvals a',
' where p.id = a.project_id',
'   and p.ARCHIVED_YN = ''N''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and ( p.owner_id = :P5_ID',
'         or',
'         a.submitted_by_team_member_id = :P5_ID',
'         or',
'         exists (select 1 from sp_project_approval_chain',
'                  where project_approval_id = a.id',
'                    and team_member_id = :P5_ID) )'))
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
,p_plug_footer=>'Approvals for &NOMENCLATURE_PROJECTS. you own, submitted for approval or have been involved in the approval process.'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(20511115250623173177)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_flashback=>'N'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>20509575668755115049
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20511115298040173178)
,p_db_column_name=>'PROJECT'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634795955913428129)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796062964428130)
,p_db_column_name=>'APPROVAL_TYPE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Approval Type'
,p_column_link=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:125:P125_PROJECT_APPROVAL_ID:#APPROVAL_ID#'
,p_column_linktext=>'#APPROVAL_TYPE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796125285428131)
,p_db_column_name=>'ROLE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Role'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796280210428132)
,p_db_column_name=>'CURRENT_STATUS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Current Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796360916428133)
,p_db_column_name=>'UPDATED'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796451484428134)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(20634796494503428135)
,p_db_column_name=>'APPROVAL_ID'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Approval Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(20634825341984431076)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'206332858'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:FRIENDLY_IDENTIFIER:APPROVAL_TYPE:ROLE:CURRENT_STATUS:UPDATED'
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37816329361387140402)
,p_plug_name=>'RDS'
,p_region_css_classes=>'project-rds-region'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_location=>null
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_region_icons', 'N',
  'include_show_all', 'N',
  'rds_mode', 'STANDARD',
  'remember_selection', 'USER')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38104381957453281176)
,p_name=>'Reviews'
,p_template=>4072358936313175081
,p_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--showIcon:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id project_id,',
'       p.friendly_identifier,',
'       t.id task_id,',
'       tt.task_type review_type,',
'       p.PROJECT,',
'       p.project_url_name,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       t.UPDATED,',
'       t.target_complete review_date,',
'       s.status,',
'       t.impact,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(t.updated_by)),lower(t.updated_by)) updated_by,',
'       null attributes',
'  from SP_PROJECTS p,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_statuses s',
' where nvl(p.ARCHIVED_YN,''N'') != ''Y''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and p.id = t.project_id',
'   and t.owner_id = :P5_ID',
'   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'   and tt.static_id like ''REVIEW%''',
'   and s.indicates_complete_yn = ''N''',
'   and t.status_id = s.id',
' order by t.target_complete asc nulls first'))
,p_header=>'&nbsp;Open Reviews'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P5_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No open reviews found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
,p_required_patch=>wwv_flow_imp.id(40074095762229259811)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104383393962281191)
,p_query_column_id=>1
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382994672281187)
,p_query_column_id=>2
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104383474834281192)
,p_query_column_id=>3
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382023278281177)
,p_query_column_id=>4
,p_column_alias=>'REVIEW_TYPE'
,p_column_display_sequence=>10
,p_column_heading=>'Type'
,p_column_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID,P502_PREV_PAGE:#TASK_ID#,5'
,p_column_linktext=>'#REVIEW_TYPE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382308306281180)
,p_query_column_id=>5
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104383116597281188)
,p_query_column_id=>6
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382938625281186)
,p_query_column_id=>7
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382506821281182)
,p_query_column_id=>8
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104383185076281189)
,p_query_column_id=>9
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104383323856281190)
,p_query_column_id=>10
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382391646281181)
,p_query_column_id=>11
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382711738281184)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>90
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_column_html_expression=>'#UPDATED# - #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382156862281178)
,p_query_column_id=>13
,p_column_alias=>'REVIEW_DATE'
,p_column_display_sequence=>20
,p_column_heading=>'Date'
,p_column_format=>'DD-MON'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382234237281179)
,p_query_column_id=>14
,p_column_alias=>'STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38252339819975094201)
,p_query_column_id=>15
,p_column_alias=>'IMPACT'
,p_column_display_sequence=>40
,p_column_heading=>'Impact'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382769065281185)
,p_query_column_id=>16
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38104382620956281183)
,p_query_column_id=>17
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>80
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#%</span>',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40996716200948284011)
,p_plug_name=>'button container'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-left-none'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>2000
,p_plug_display_point=>'REGION_POSITION_02'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45706975834150222702)
,p_plug_name=>'Profile'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>500
,p_plug_display_point=>'REGION_POSITION_02'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(45342885338470087134)
,p_name=>'Profile Details'
,p_parent_plug_id=>wwv_flow_imp.id(45706975834150222702)
,p_template=>3371237801798025892
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:margin-top-md'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-item--stacked:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tm.ID,',
'       tm.first_name||'' ''||tm.last_Name name,',
'       tm.INITIALS,',
'       tm.EMAIL,',
'       tm.screen_name,',
'       case when nvl(notification_pref,''APP:EMAIL'') = ''APP:EMAIL'' then ''Within Application and Email''',
'            when notification_pref = ''APP'' then ''Within Application''',
'            when notification_pref = ''EMAIL'' then ''Email''',
'            when notification_pref = ''NONE'' then ''None''',
'            end assignment_pref,',
'       case when nvl(comment_notif_pref,''APP:EMAIL'') = ''APP:EMAIL'' then ''Within Application and Email''',
'            when comment_notif_pref = ''APP'' then ''Within Application''',
'            when comment_notif_pref = ''EMAIL'' then ''Email''',
'            when comment_notif_pref = ''NONE'' then ''None''',
'            end comment_pref,',
'       lower(tm.TAGS) tags,',
'       competencies,',
'       CREATED,',
'       UPDATED,',
'       APP_ROLE,',
'       location,',
'       nvl((select country_Name from sp_countries c where c.id = tm.country_id),''Not Provided'') Country,',
'       --',
'       -- active projects',
'       --',
'       (select count(*) ',
'       from SP_PROJECTS p',
'       where (',
'         p.owner_id = :P5_ID or ',
'         :P5_ID in (select c.owner_id ',
'                    from SP_TASKS c ',
'                    where c.project_id = p.id) or',
'         :P5_ID in (select a.TEAM_MEMBER_ID from SP_ACTIVITIES a where a.PROJECT_ID = p.id)',
'         )',
'         and',
'         p.ARCHIVED_YN = ''N'' and ',
'         p.DUPLICATE_OF_PROJECT_ID is null and',
'         p.PCT_COMPLETE not in (0,100)',
'         ) as active_projects,',
'       --',
'       -- completed projects',
'       --',
'       (select count(*) ',
'       from SP_PROJECTS p',
'       where (',
'         p.owner_id = :P5_ID or ',
'         :P5_ID in (select c.owner_id ',
'                    from SP_TASKS c ',
'                    where c.project_id = p.id) or',
'         :P5_ID in (select a.TEAM_MEMBER_ID from SP_ACTIVITIES a where a.PROJECT_ID = p.id)',
'         )',
'         and',
'         p.ARCHIVED_YN = ''N'' and ',
'         p.DUPLICATE_OF_PROJECT_ID is null and',
'         p.PCT_COMPLETE = 100',
'         ) as completed_projects,',
'         --',
'         -- group associations',
'         --',
'        (select count(*)',
'         from   SP_GROUP_MEMBERS gm,',
'                SP_GROUPS g',
'         where  TEAM_MEMBER_ID = :P5_ID and',
'                g.id = gm.GROUP_ID) ',
'        as group_associations',
'  from SP_TEAM_MEMBERS tm',
' where id = :P5_ID'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P5_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335103186785076313)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335101176685076310)
,p_query_column_id=>2
,p_column_alias=>'NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335101986175076312)
,p_query_column_id=>3
,p_column_alias=>'INITIALS'
,p_column_display_sequence=>30
,p_column_heading=>'Initials'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335102373982076312)
,p_query_column_id=>4
,p_column_alias=>'EMAIL'
,p_column_display_sequence=>40
,p_column_heading=>'Email'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511823532863831606)
,p_query_column_id=>5
,p_column_alias=>'SCREEN_NAME'
,p_column_display_sequence=>50
,p_column_heading=>'Screen Name'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53088315414764006985)
,p_query_column_id=>6
,p_column_alias=>'ASSIGNMENT_PREF'
,p_column_display_sequence=>60
,p_column_heading=>'Assignment Alerts'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46511823566069831607)
,p_query_column_id=>7
,p_column_alias=>'COMMENT_PREF'
,p_column_display_sequence=>70
,p_column_heading=>'Comment Alerts'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335102799854076313)
,p_query_column_id=>8
,p_column_alias=>'TAGS'
,p_column_display_sequence=>140
,p_column_heading=>'Tags'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49015131040396361181)
,p_query_column_id=>9
,p_column_alias=>'COMPETENCIES'
,p_column_display_sequence=>150
,p_column_heading=>'Competencies'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335100780803076310)
,p_query_column_id=>10
,p_column_alias=>'CREATED'
,p_column_display_sequence=>160
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335100398120076308)
,p_query_column_id=>11
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>170
,p_column_heading=>'Last Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335101568330076311)
,p_query_column_id=>12
,p_column_alias=>'APP_ROLE'
,p_column_display_sequence=>80
,p_column_heading=>'Application Role'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38280683906833691708)
,p_query_column_id=>13
,p_column_alias=>'LOCATION'
,p_column_display_sequence=>90
,p_column_heading=>'Location'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_TEAM_MEMBERS tm',
' where id = :P5_ID',
'   and location is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41335103655942076313)
,p_query_column_id=>14
,p_column_alias=>'COUNTRY'
,p_column_display_sequence=>100
,p_column_heading=>'Country'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46943270338010730094)
,p_query_column_id=>15
,p_column_alias=>'ACTIVE_PROJECTS'
,p_column_display_sequence=>110
,p_column_heading=>'Active &NOMENCLATURE_PROJECTS.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46943270397411730095)
,p_query_column_id=>16
,p_column_alias=>'COMPLETED_PROJECTS'
,p_column_display_sequence=>120
,p_column_heading=>'Completed &NOMENCLATURE_PROJECTS.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46943270561496730096)
,p_query_column_id=>17
,p_column_alias=>'GROUP_ASSOCIATIONS'
,p_column_display_sequence=>130
,p_column_heading=>'Group Associations'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45799515719249157721)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>7
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46663859074282172539)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(45799515719249157721)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', 'fa-user',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL_DISPLAY', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46663860307788172551)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46943267974742730071)
,p_plug_name=>'Groups'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select gm.id, g.GROUP_NAME, gm.CREATED added_to_group, g.id group_id, ',
'       (select count(*) from SP_GROUP_MEMBERS x where x.group_id = gm.group_id) members,',
'       decode(nvl(full_time_yn,''N''),''Y'',''Yes'',''N'',''No'') full_time,',
'       decode(nvl(group_leader_yn,''N''),''Y'',''Yes'',''N'',''No'') leader',
'from   SP_GROUP_MEMBERS gm,',
'       SP_GROUPS g',
'where  TEAM_MEMBER_ID = :P5_ID and',
'       g.id = gm.GROUP_ID',
'order by upper(g.group_name)'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Groups'
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
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(46943268078299730072)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_condition_type=>'EXISTS'
,p_detail_link_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from sp_team_members',
' where email = lower(:APP_USER)',
'   and id = :P5_ID',
'union all',
'select 1',
'  from dual',
' where :IS_ADMIN = ''Y'''))
,p_owner=>'MIKE'
,p_internal_uid=>10043910212897762303
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943269911335730090)
,p_db_column_name=>'GROUP_NAME'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Group Name'
,p_column_link=>'f?p=&APP_ID.:151:&SESSION.::&DEBUG.:RP,151:P151_GROUP_ID:#GROUP_ID#'
,p_column_linktext=>'#GROUP_NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943270035735730091)
,p_db_column_name=>'ADDED_TO_GROUP'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Added To Group'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943270102055730092)
,p_db_column_name=>'GROUP_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Group Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943270219786730093)
,p_db_column_name=>'MEMBERS'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Members'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943270850115730099)
,p_db_column_name=>'FULL_TIME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Full Time'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46943270937245730100)
,p_db_column_name=>'LEADER'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Leader'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55083678706376389373)
,p_db_column_name=>'ID'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(46943470756324304356)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'100441129'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'GROUP_NAME:FULL_TIME:LEADER:MEMBERS:ADDED_TO_GROUP:'
,p_sort_column_1=>'ADDED_TO_GROUP'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49248167642094784007)
,p_plug_name=>'My &NOMENCLATURE_PROJECT. Changes'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_location=>null
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P5_ID'
,p_plug_display_when_cond2=>'&APP_USER_ID.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49248167681791784008)
,p_plug_name=>'Project Change content'
,p_title=>'Project Changes'
,p_parent_plug_id=>wwv_flow_imp.id(49248167642094784007)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_changes_yn      varchar2(1);',
'    l_change_summary  clob;',
'begin',
'',
'    sp_contributor_summary.project_changes (',
'        p_team_member_id => :P5_ID,',
'        p_frequency      => ''WEEKLY'',',
'        p_links          => ''APP'',',
'        p_apex_session   => :APP_SESSION,',
'        p_exclude_user_yn => nvl(:P5_PROJ_CHANGE_EXCLUDE_USER_YN,''N''),',
'        p_changes_yn     => l_changes_yn,',
'        p_change_summary => l_change_summary );',
'',
'    if l_changes_yn = ''Y'' then',
'        return l_change_summary;',
'    else',
'        return ''No changes found for projects you own or have favorited.'';',
'    end if;',
'',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P5_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61925773697916598291)
,p_plug_name=>'buttons'
,p_region_name=>'proj-changes'
,p_parent_plug_id=>wwv_flow_imp.id(49248167642094784007)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>2010
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(53728659243476523541)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(52117709369965011891)
,p_plug_name=>'Activity'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ap.id, ',
'       at.activity_type,',
'       ap.comments,',
'       ap.start_date,',
'       ap.end_date,',
'       to_char(ap.end_date,''Day DD-MON-YYYY'') end_date_formatted,',
'       to_char(ap.start_date,''Day DD-MON-YYYY'')||'' to ''||to_char(ap.end_date,''Day DD-MON-YYYY'') TIMELINE,',
'       ap.end_date - ap.start_date days,',
'       round(ap.end_date - sysdate) days_remaining,',
'       ap.url,',
'       apex_util.get_since(ap.updated) last_updated,',
'       --',
'       -- team member info',
'       --',
'       tm.first_name||'' ''||tm.last_name name,',
'       --',
'       -- project info',
'       --',
'       p.project,',
'       p.friendly_identifier,',
'       p.PROJECT_URL_NAME,',
'       --',
'       -- badge status is red if past due and green if within begin and and dates',
'       --',
'       decode(trunc(ap.start_date),trunc(sysdate),''success'',',
'       decode(trunc(ap.end_date),trunc(sysdate),''success'',',
'       decode(',
'           greatest(to_char(ap.end_date,''YYYY.MM.DD''),to_char(sysdate,''YYYY.MM.DD'')),',
'           to_char(sysdate,''YYYY.MM.DD''),',
'           ''danger'',',
'           ''success''))) as badge_class,',
'       --',
'       -- pie chart icon in 10% chunks that show time percent complete',
'       --',
'       ''fa-pie-chart-''||sp_date_range_pct_comp(ap.start_date, ap.end_date) icon',
'from sp_activities ap,',
'     sp_projects p,',
'     sp_activity_types at,',
'     sp_team_members tm',
'where ap.project_id = p.id(+) and',
'      ap.activity_type_id = at.id and',
'      tm.email = lower(:P5_EMAIL) and',
'      ap.team_member_id = tm.id and',
'      (p.id is null or p.DUPLICATE_OF_PROJECT_ID is null) and',
'      (p.id is null or p.ARCHIVED_YN = ''N'') and',
'      --',
'      (',
'         (nvl(:P5_INCLUDE_FUTURE,''N'') = ''Y'' and ap.start_date > trunc(sysdate)) or ',
'         (nvl(:P5_INCLUDE_PAST,''N'') = ''Y'' and ap.end_date < sysdate) or ',
'         trunc(sysdate) between trunc(ap.start_date) and ap.end_date ',
'      )'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'start_date desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P5_EMAIL,P5_INCLUDE_FUTURE,P5_INCLUDE_PAST'
,p_plug_query_num_rows=>30
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'No activity found.'
,p_show_total_row_count=>false
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--noShape',
  'AVATAR_SIZE', 't-Avatar--md',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--lg',
  'BADGE_LABEL', '&NOMENCLATURE_PROJECTS.',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_VALUE', 'ACTIVITY_TYPE',
  'DESCRIPTION', '&COMMENTS.',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', '&LAST_UPDATED.',
  'OVERLINE', '&TIMELINE.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&PROJECT.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38453595930972538912)
,p_name=>'BADGE_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>330
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117709545271011892)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117710937890011906)
,p_name=>'DAYS_REMAINING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS_REMAINING'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117711089629011908)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117713033989011927)
,p_name=>'ACTIVITY_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVITY_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117713149266011928)
,p_name=>'COMMENTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENTS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117713250077011929)
,p_name=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52117713341817011930)
,p_name=>'END_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946033848563381)
,p_name=>'DAYS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>230
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946071084563382)
,p_name=>'URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'URL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>240
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946224903563383)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>250
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946347433563384)
,p_name=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946396158563385)
,p_name=>'FRIENDLY_IDENTIFIER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FRIENDLY_IDENTIFIER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>270
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946457971563386)
,p_name=>'TIMELINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMELINE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946605332563387)
,p_name=>'PROJECT_URL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_URL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>290
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138946735237563388)
,p_name=>'LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>300
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52138947508232563396)
,p_name=>'END_DATE_FORMATTED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_DATE_FORMATTED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>310
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(54164594605811607162)
,p_name=>'Milestones'
,p_template=>4072358936313175081
,p_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--showIcon:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id project_id,',
'       p.friendly_identifier,',
'       t.id task_id,',
'       tt.task_type review_type,',
'       p.PROJECT,',
'       p.project_url_name,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       t.UPDATED,',
'       t.target_complete review_date,',
'       s.status,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(t.updated_by)),lower(t.updated_by)) updated_by,',
'       null attributes',
'  from SP_PROJECTS p,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_statuses s',
' where nvl(p.ARCHIVED_YN,''N'') != ''Y''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and p.id = t.project_id',
'   and t.owner_id = :P5_ID',
'   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'   and tt.static_id like ''MILESTONE%''',
'   and s.indicates_complete_yn = ''N''',
'   and t.status_id = s.id',
' order by t.target_complete asc nulls first'))
,p_header=>'&nbsp;Open Milestones'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P5_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No open milestones found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330184383375852575)
,p_query_column_id=>1
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557174294204287962)
,p_query_column_id=>2
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451870492615187696)
,p_query_column_id=>3
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330184175941852573)
,p_query_column_id=>4
,p_column_alias=>'REVIEW_TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Type'
,p_column_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID,P502_PREV_PAGE:#TASK_ID#,5'
,p_column_linktext=>'#REVIEW_TYPE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557176333908287964)
,p_query_column_id=>5
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557174692673287962)
,p_query_column_id=>6
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557176707207287964)
,p_query_column_id=>7
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557177078102287965)
,p_query_column_id=>8
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557177498296287965)
,p_query_column_id=>9
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557178294907287966)
,p_query_column_id=>10
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557178741208287966)
,p_query_column_id=>11
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557179080461287966)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>90
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_column_html_expression=>'#UPDATED# - #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330184359071852574)
,p_query_column_id=>13
,p_column_alias=>'REVIEW_DATE'
,p_column_display_sequence=>30
,p_column_heading=>'Date'
,p_column_format=>'DD-MON'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50330187631823852607)
,p_query_column_id=>14
,p_column_alias=>'STATUS'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557175538234287963)
,p_query_column_id=>15
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50557179466572287967)
,p_query_column_id=>16
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>80
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#%</span>',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55451870786372187699)
,p_name=>'Tasks'
,p_template=>4072358936313175081
,p_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--showIcon:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id project_id,',
'       p.friendly_identifier,',
'       t.id task_id,',
'       tt.task_type review_type,',
'       p.PROJECT,',
'       p.project_url_name,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       t.UPDATED,',
'       case when t.start_date is not null then to_char(t.start_date,''DD-MON-YYYY'') ||'' - '' end || ',
'           to_char(t.target_complete,''DD-MON-YYYY'') review_date,',
'       s.status,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(t.updated_by)),lower(t.updated_by)) updated_by,',
'       null attributes',
'  from SP_PROJECTS p,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_statuses s',
' where nvl(p.ARCHIVED_YN,''N'') != ''Y''',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and p.id = t.project_id',
'   and t.owner_id = :P5_ID',
'   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'   and tt.static_id not like ''REVIEW%''',
'   and tt.static_id not like ''MILESTONE%''',
'   and s.indicates_complete_yn = ''N''',
'   and t.status_id = s.id',
' order by t.target_complete asc nulls first'))
,p_header=>'&nbsp;Open Tasks'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P5_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No open tasks found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451872291645187714)
,p_query_column_id=>1
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871945279187710)
,p_query_column_id=>2
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451872452357187715)
,p_query_column_id=>3
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451870887975187700)
,p_query_column_id=>4
,p_column_alias=>'REVIEW_TYPE'
,p_column_display_sequence=>10
,p_column_heading=>'Type'
,p_column_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID,P502_PREV_PAGE:#TASK_ID#,5'
,p_column_linktext=>'#REVIEW_TYPE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871199577187703)
,p_query_column_id=>5
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>40
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871977454187711)
,p_query_column_id=>6
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871801320187709)
,p_query_column_id=>7
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871372872187705)
,p_query_column_id=>8
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451872081611187712)
,p_query_column_id=>9
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451872201773187713)
,p_query_column_id=>10
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871346761187704)
,p_query_column_id=>11
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871640519187707)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>80
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_column_html_expression=>'#UPDATED# - #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451870998639187701)
,p_query_column_id=>13
,p_column_alias=>'REVIEW_DATE'
,p_column_display_sequence=>20
,p_column_heading=>'Date'
,p_column_format=>'DD-MON'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871067111187702)
,p_query_column_id=>14
,p_column_alias=>'STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871751970187708)
,p_query_column_id=>15
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451871491544187706)
,p_query_column_id=>16
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>70
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#%</span>',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(151946407440773607757)
,p_plug_name=>'&NOMENCLATURE_PROJECTS.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.*,',
'       ltrim(case when x.is_owner = ''Yes'' then ''Owner'' end || ',
'             case when x.other_assoc > 0 then '', Contributor'' end ||',
'             case when x.milestone_owner > 0 then '', Milestone Owner'' end ||',
'             case when x.reviewer > 0 then '', Reviewer'' end ||',
'             case when x.task_owner > 0 then '', Task Owner'' end,'', '') Association',
'from (',
'select p.id, ',
'       p.PROJECT, ',
'       i.INITIATIVE, ',
'       f.area focus_area, ',
'       --',
'       -- other association',
'       --',
'       nvl((select min(1) from SP_PROJECT_CONTRIBUTORS c ',
'                    where c.project_id = p.id',
'                      and c.team_member_id = :P5_ID),0) other_assoc,',
'       --',
'       -- task owner',
'       --',
'       nvl((select min(1) from sp_tasks t, sp_task_types tt ',
'                 where t.project_id = p.id',
'                   and t.owner_id = :P5_ID',
'                   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'                   and tt.static_id not like ''REVIEW%''',
'                   and tt.static_id not like ''MILESTONE%''),0) task_owner,',
'       --',
'       -- milestone owner',
'       --',
'       nvl((select min(1) from sp_tasks t, sp_task_types tt ',
'                 where t.project_id = p.id',
'                   and t.owner_id = :P5_ID',
'                   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'                   and tt.static_id like ''MILESTONE%''),0) milestone_owner,',
'       --',
'       -- reviewer',
'       --',
'       nvl((select min(1) from sp_tasks t, sp_task_types tt ',
'                 where t.project_id = p.id',
'                   and t.owner_id = :P5_ID',
'                   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'                   and tt.static_id like ''REVIEW%''),0) reviewer,',
'       --',
'       -- project owner',
'       --',
'       case when p.OWNER_ID = :P5_ID',
'            then ''Yes''',
'            else ''No'' end is_owner,',
'       --',
'       -- project activity',
'       --',
'       (select ''Current '' from dual where exists (',
'           select 1 ',
'           from SP_ACTIVITIES a ',
'           where a.TEAM_MEMBER_ID = :P5_ID and ',
'                 a.project_id = p.id and ',
'                 trunc(sysdate) between trunc(a.start_date) and trunc(a.end_date)',
'           )',
'           )||',
'        (select ''Future '' from dual where exists (',
'           select 1 ',
'           from SP_ACTIVITIES a ',
'           where a.TEAM_MEMBER_ID = :P5_ID and ',
'                 a.project_id = p.id and ',
'                 trunc(sysdate) < trunc(a.start_date)',
'           )',
'           )||          ',
'        (select ''Past '' from dual where exists (',
'           select 1 ',
'           from SP_ACTIVITIES a ',
'           where a.TEAM_MEMBER_ID = :P5_ID and ',
'                 a.project_id = p.id and ',
'                 trunc(sysdate) > trunc(a.end_date)',
'           )',
'           )           ',
'            Activity,',
'       --',
'       -- project attributes',
'       --',
'       p.PCT_COMPLETE PCT_COMPLETE,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       (select max(''P''||PRIORITY) from sp_project_priorities pp where pp.id = p.priority_id) priority,',
'       (select max(release_train||'' ''||release) from SP_RELEASE_TRAINS r where r.id = p.release_id) release,',
'       p.tags,',
'       p.project_size,',
'       p.updated,',
'       p.created,',
'       --',
'       -- columns needed to link to project',
'       --',
'       p.FRIENDLY_IDENTIFIER,',
'       p.PROJECT_URL_NAME',
'from SP_PROJECTS p,',
'     sp_initiatives i,',
'     sp_areas f,',
'     sp_project_scales s',
'where (p.owner_id = :P5_ID or ',
'        :P5_ID in (select c.team_member_id ',
'                     from SP_PROJECT_CONTRIBUTORS c ',
'                    where c.project_id = p.id) or',
'        :P5_ID in (select t.owner_id from SP_TASKS t where t.project_id = p.id) or',
'        :P5_ID in (select a.TEAM_MEMBER_ID from SP_ACTIVITIES a where a.project_id = p.id) )',
'  and p.INITIATIVE_ID = i.id',
'  and i.status_scale = s.scale_letter',
'  and i.area_id = f.id',
'  and p.ARCHIVED_YN = ''N''',
'  and p.DUPLICATE_OF_PROJECT_ID is null',
') x'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'&NOMENCLATURE_PROJECTS.'
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
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37816327478957140384)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>916969613555172615
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816327584049140385)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816327704336140386)
,p_db_column_name=>'PROJECT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816327790373140387)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'&NOMENCLATURE_INITIATIVE.'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816327958938140388)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'&NOMENCLATURE_AREA.'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328131918140390)
,p_db_column_name=>'PRIORITY'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328205396140391)
,p_db_column_name=>'UPDATED'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328268518140392)
,p_db_column_name=>'CREATED'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816329652758140405)
,p_db_column_name=>'IS_OWNER'
,p_display_order=>90
,p_column_identifier=>'P'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39768020534581113488)
,p_db_column_name=>'ACTIVITY'
,p_display_order=>100
,p_column_identifier=>'R'
,p_column_label=>'Activity'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328634540140395)
,p_db_column_name=>'RELEASE'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328709723140396)
,p_db_column_name=>'TAGS'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328817122140397)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>'Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816328873188140398)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816329053168140399)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37816329677151140406)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248168440006784015)
,p_db_column_name=>'ASSOCIATION'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Association'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38104381501899281172)
,p_db_column_name=>'OTHER_ASSOC'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Other Assoc'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38104381641526281173)
,p_db_column_name=>'TASK_OWNER'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Task Owner'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38104381672442281174)
,p_db_column_name=>'MILESTONE_OWNER'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Milestone Owner'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38104381804572281175)
,p_db_column_name=>'REVIEWER'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Reviewer'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53088314428451006975)
,p_db_column_name=>'STATUS'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37854287369125130440)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9549296'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:INITIATIVE:ASSOCIATION:RELEASE:PCT_COMPLETE:PRIORITY:UPDATED:'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(26119420959312805448)
,p_report_id=>wwv_flow_imp.id(37854287369125130440)
,p_name=>'Active Projects'
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'Q not in (0,100)'
,p_condition_sql=>'"PCT_COMPLETE" NOT IN ( 0 , 100 )'
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41363077796648330383)
,p_plug_name=>'Note on Report'
,p_parent_plug_id=>wwv_flow_imp.id(151946407440773607757)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_count_0    number;',
'    l_count_100  number;',
'    l_owner      varchar2(4000);',
'    l_link       varchar2(4000);',
'    l_return     clob;',
'begin',
'    select count(*)',
'      into l_count_0',
'      from sp_projects p',
'     where pct_complete = 0',
'       and owner_id = :P5_ID',
'       and archived_yn = ''N'';',
'',
'    select count(*)',
'      into l_count_100',
'      from sp_projects p',
'     where pct_complete = 100',
'       and owner_id = :P5_ID',
'       and archived_yn = ''N'';',
'',
'    if l_count_0 > 0 or l_count_100 > 0 then',
'       select first_name||'' ''||last_name',
'         into l_owner',
'         from sp_team_members ',
'        where id = :P5_ID;',
'    end if;',
'',
'    if l_count_0 > 0 or l_count_100 > 0 then',
'       l_link := ''<a href="''||apex_page.get_url(',
'                                   p_application => :APP_ID,',
'                                   p_page        => 23,',
'                                   p_session     => :APP_SESSION,',
'                                   p_items       => ''P23_THE_OWNER'',',
'                                   p_values      => l_owner,',
'                                   p_plain_url   => TRUE )||''">view all</a>'';',
'    end if;',
'',
'    if l_count_0 > 0 and l_count_100 > 0 then',
'       l_return := ''Report excludes ''|| l_count_0 ||'' and ''||',
'                    l_count_100 || '' '' ||',
'                    :NOMENCLATURE_PROJECTS ||'' owned by this user (''||l_link||'').'';',
'    elsif l_count_0 > 0 then',
'       l_return := ''Report excludes ''||l_count_0 || '' ''||',
'                    case when l_count_0 = 1 then :NOMENCLATURE_PROJECT else :NOMENCLATURE_PROJECTS end ||''  owned by this user (''||l_link||'').'';',
'    elsif l_count_100 > 0 then',
'       l_return := ''Report excludes ''||l_count_100 || '' ''||',
'                    case when l_count_100 = 1 then :NOMENCLATURE_PROJECT else :NOMENCLATURE_PROJECTS end ||''  owned by this user (''||l_link||'').'';',
'    end if;',
'',
'    return ''<br/>''||l_return;',
' end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P5_ID'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select 1',
'      from sp_projects p',
'     where pct_complete in (0,100)',
'       and owner_id = :P5_ID',
'       and archived_yn = ''N'''))
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41363076536703330370)
,p_button_sequence=>1000
,p_button_plug_id=>wwv_flow_imp.id(40996716200948284011)
,p_button_name=>'external_link'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft:t-Button--padLeft:t-Button--gapTop'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'External Directory'
,p_button_redirect_url=>'javascript:window.open(''&P5_EXT_LINK.'',''_blank'');'
,p_button_condition=>'P5_EXT_LINK'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-external-link'
,p_button_cattributes=>'title="External Directory"'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49810001605191204887)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(61925773697916598291)
,p_button_name=>'SUBSCRIBE_ME_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Subscribe me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''PROJECT_CHANGES''',
'   and is_active_yn = ''Y''',
'   and not exists (select 1 from sp_notification_subscriptions',
'                    where notification_id = n.id',
'                      and team_member_id = :APP_USER_ID',
'                      and opted_in_yn = ''Y'')',
'   and :APP_USER_ID is not null',
'   and :P5_ID = :APP_USER_ID'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49810002055740204887)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(61925773697916598291)
,p_button_name=>'UNSUBSCRIBE_ME_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Unsubscribe'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''PROJECT_CHANGES''',
'   and is_active_yn = ''Y''',
'   and exists (select 1 from sp_notification_subscriptions',
'                where notification_id = n.id',
'                  and team_member_id = :APP_USER_ID',
'                  and opted_in_yn = ''Y'')',
'   and :P5_ID = :APP_USER_ID'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49810001254476204886)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(61925773697916598291)
,p_button_name=>'EMAIL_ME_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Email to me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53933060506811387118)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46943267974742730071)
,p_button_name=>'Add'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_TEAM_MEMBER_ID:&P5_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from sp_team_members',
' where email = lower(:APP_USER)',
'   and id = :P5_ID',
'union all',
'select 1',
'  from dual',
' where :IS_ADMIN = ''Y'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39771378869359024898)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(45799515719249157721)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39768019760556113480)
,p_name=>'P5_INCLUDE_FUTURE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(52117709369965011891)
,p_item_default=>'N'
,p_prompt=>'Include Future'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39768020617060113489)
,p_name=>'P5_INCLUDE_PAST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(52117709369965011891)
,p_item_default=>'N'
,p_prompt=>'Include Past'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41271237568521114201)
,p_name=>'P5_PHOTO_DEFAULT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(45706975834150222702)
,p_item_default=>'#APP_FILES#default-user-avatar.png'
,p_prompt=>'Photo'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'mxw160'
,p_display_when=>'select 1 from sp_team_members where id = :P5_ID and photo is not null'
,p_display_when_type=>'NOT_EXISTS'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'alternative_text', 'Placeholder Photo',
  'based_on', 'URL')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41363076626201330371)
,p_name=>'P5_EXT_LINK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(45706975834150222702)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select replace(apex_app_setting.get_value(''EXTERNAL_PERSON_LINK''),''#EMAIL#'',lower(email)) ',
'  from sp_team_members',
' where id = :P5_ID',
'   and email is not null',
'   and apex_app_setting.get_value(''EXTERNAL_PERSON_LINK_DOMAIN'') is not null',
'   and lower(email) like ''%@''||lower(apex_app_setting.get_value(''EXTERNAL_PERSON_LINK_DOMAIN''))'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43687280997694577012)
,p_name=>'P5_EMAIL'
,p_item_sequence=>91
,p_item_plug_id=>wwv_flow_imp.id(151946407440773607757)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43687281186924577014)
,p_name=>'P5_FIRST_NAME'
,p_item_sequence=>101
,p_item_plug_id=>wwv_flow_imp.id(151946407440773607757)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43687281312751577015)
,p_name=>'P5_LAST_NAME'
,p_item_sequence=>111
,p_item_plug_id=>wwv_flow_imp.id(151946407440773607757)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44073260571249604774)
,p_name=>'P5_PROJ_CHANGE_EXCLUDE_USER_YN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(61925773697916598291)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return nvl(apex_util.get_preference (',
'              p_preference => ''P5_PROJ_CHANGE_EXCLUDE_USER_YN'',',
'              p_user       => :APP_USER ),''N'');'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Exclude Your Changes?'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_value', 'N',
  'on_value', 'Y',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45423912391526075047)
,p_name=>'P5_PHOTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(45706975834150222702)
,p_prompt=>'Photo'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'mxw160'
,p_display_when=>'select 1 from sp_team_members where id = :P5_ID and photo is not null'
,p_display_when_type=>'EXISTS'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'SQL',
  'sql_statement', 'select PHOTO from sp_team_members where id = :P5_ID')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(151946405706498607740)
,p_name=>'P5_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(151946407440773607757)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(43687279557231576997)
,p_computation_sequence=>50
,p_computation_item=>'LAST_PROJECT_VIEW'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'5'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(37816329476238140404)
,p_computation_sequence=>60
,p_computation_item=>'P5_EMAIL'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select email from sp_team_members t where id = :P5_ID'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39768019778640113481)
,p_name=>'on include future change'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_INCLUDE_FUTURE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39768019871284113482)
,p_event_id=>wwv_flow_imp.id(39768019778640113481)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P5_INCLUDE_FUTURE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39768020046857113483)
,p_event_id=>wwv_flow_imp.id(39768019778640113481)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(52117709369965011891)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39768020749453113490)
,p_name=>'on change of include past'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_INCLUDE_PAST'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39768020780634113491)
,p_event_id=>wwv_flow_imp.id(39768020749453113490)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P5_INCLUDE_PAST'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39768020943185113492)
,p_event_id=>wwv_flow_imp.id(39768020749453113490)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(52117709369965011891)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38280682038220691689)
,p_name=>'refresh on modal close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(46663859074282172539)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38280683400533691703)
,p_event_id=>wwv_flow_imp.id(38280682038220691689)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(45342885338470087134)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50330184614653852577)
,p_name=>'refresh reviews'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(54164594605811607162)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50330184686673852578)
,p_event_id=>wwv_flow_imp.id(50330184614653852577)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(54164594605811607162)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(44073260684867604775)
,p_name=>'when Project Change Exclude User'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_PROJ_CHANGE_EXCLUDE_USER_YN'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44073260937696604777)
,p_event_id=>wwv_flow_imp.id(44073260684867604775)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P5_PROJ_CHANGE_EXCLUDE_USER_YN'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44073260975024604778)
,p_event_id=>wwv_flow_imp.id(44073260684867604775)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_util.set_preference (',
'    p_preference => ''P5_PROJ_CHANGE_EXCLUDE_USER_YN'',',
'    p_value      => :P5_PROJ_CHANGE_EXCLUDE_USER_YN,',
'    p_user       => :APP_USER );'))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44073260851950604776)
,p_event_id=>wwv_flow_imp.id(44073260684867604775)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(49248167681791784008)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55083678531020389371)
,p_name=>'after group change'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(46943267974742730071)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55083678585001389372)
,p_event_id=>wwv_flow_imp.id(55083678531020389371)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46943267974742730071)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48094800544097664391)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary      clob;',
'begin',
'',
'    l_summary := sp_contributor_summary.generate (',
'                     p_team_member_id    => :P5_ID,',
'                     p_show_activities   => ''Y'',',
'                     p_show_projects     => ''Y'',',
'                     p_links             => ''EMAIL''',
'                     );',
'',
'    apex_mail.send ( ',
'            p_to                 => :APP_USER,   ',
'            p_from               => :APP_USER,  ',
'            p_application_id     => :APP_ID,  ',
'            p_template_static_id => ''EMAIL_ME'',  ',
'            p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                           ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                           ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ||'' Weekly Summary'') ||'', ''||',
'                                           ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                     ''}'' ); ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Weekly Summary email sent.'
,p_internal_uid=>11195442678695696622
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49015130327595361174)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email exceptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary      clob;',
'begin',
'',
'    l_summary := sp_contributor_summary.project_exceptions (',
'                     p_team_member_id  => :P5_ID,',
'                     p_links           => ''EMAIL''',
'                     );',
'',
'    apex_mail.send ( ',
'            p_to                 => :APP_USER,   ',
'            p_from               => :APP_USER,  ',
'            p_application_id     => :APP_ID,  ',
'            p_template_static_id => ''EMAIL_ME'',  ',
'            p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                           ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                           ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ||'' ''||:NOMENCLATURE_PROJECT ||'' Exceptions'') ||'', ''||',
'                                           ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                     ''}'' ); ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Project Exceptions email sent.'
,p_internal_uid=>12115772462193393405
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49248167768997784009)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email changes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_changes_yn  varchar2(1);',
'    l_summary     clob;',
'begin',
'',
'    sp_contributor_summary.project_changes (',
'        p_team_member_id  => :APP_USER_ID,',
'        p_frequency       => ''WEEKLY'',',
'        p_links           => ''EMAIL'',',
'        p_exclude_user_yn => :P5_PROJ_CHANGE_EXCLUDE_USER_YN,',
'        p_changes_yn      => l_changes_yn,',
'        p_change_summary  => l_summary );',
'',
'    if l_changes_yn = ''Y'' then',
'',
'        apex_mail.send ( ',
'                p_to                 => :APP_USER,   ',
'                p_from               => :APP_USER,  ',
'                p_application_id     => :APP_ID,  ',
'                p_template_static_id => ''EMAIL_ME'',  ',
'                p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                               ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                               ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ||'' ''||:NOMENCLATURE_PROJECT ||'' Changes'') ||'', ''||',
'                                               ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                         ''}'' ); ',
'',
'    end if;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49810001254476204886)
,p_process_success_message=>'Project changes email sent.'
,p_internal_uid=>12348809903595816240
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48401069061279018677)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Subscribe summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''WEEKLY_SUMMARY'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Subscribed to Weekly Summary.'
,p_internal_uid=>11501711195877050908
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49015132435588361195)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unsubscribe summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_out (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''WEEKLY_SUMMARY'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Unsubscribed from Weekly Summary.'
,p_internal_uid=>12115774570186393426
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49015130446082361175)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Subscribe exceptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''PROJECT_EXCEPTIONS'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Subscribed to Project Exceptions.'
,p_internal_uid=>12115772580680393406
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49015132513873361196)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unsubscribe exceptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_out (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''PROJECT_EXCEPTIONS'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Unsubscribed from Project Exceptions.'
,p_internal_uid=>12115774648471393427
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49248168057315784011)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Subscribe changes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''PROJECT_CHANGES'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49810001605191204887)
,p_process_success_message=>'Subscribed to Project Changes.'
,p_internal_uid=>12348810191913816242
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49248168133389784012)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unsubscribe changes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_out (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''PROJECT_CHANGES'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49810002055740204887)
,p_process_success_message=>'Unsubscribed from Project Changes.'
,p_internal_uid=>12348810267987816243
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47228927470328250486)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'sync roles'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.sync_team_member_app_role (',
'    p_app_id => :APP_ID,',
'    p_email  => :P5_EMAIL);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>10329569604926282717
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(43687281127448577013)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set first and last name session state'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (select first_name, last_name',
'from sp_team_members tm',
'where tm.id = :P5_ID) loop',
'    :P5_FIRST_NAME := c1.first_name;',
'    :P5_LAST_NAME  := c1.last_Name;',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>6787923262046609244
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(41376454961341866290)
,p_region_id=>wwv_flow_imp.id(46663859074282172539)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit My Profile'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:144:&SESSION.::&DEBUG.:RP,144:P144_ID:&P5_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXISTS'
,p_condition_expr1=>'select 1 from sp_team_members where email = lower(:APP_USER) and id = :P5_ID'
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234009685897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(46663859374861172542)
,p_region_id=>wwv_flow_imp.id(46663859074282172539)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(52117711364712011911)
,p_region_id=>wwv_flow_imp.id(52117709369965011891)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&FRIENDLY_IDENTIFIER.,&PROJECT_URL_NAME.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(52117711528407011912)
,p_region_id=>wwv_flow_imp.id(52117709369965011891)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(20511113004190173155)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Weekly Summary'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:148:&SESSION.::&DEBUG.:RP,148:P148_ID:&P5_ID.'
,p_icon_css_classes=>'fa-media-list'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(20511113095413173156)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Exceptions'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:153:&SESSION.::&DEBUG.:RP,153:P153_ID:&P5_ID.'
,p_icon_css_classes=>'fa-warning'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39768020065723113484)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Manage User Access'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:10012:&SESSION.:FROMPERSON:&DEBUG.:RP,10012:P10012_USER_NAME:&P5_EMAIL.'
,p_icon_css_classes=>'fa-lock'
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39768020223850113485)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit (Admin)'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:RP,20:P20_ID:&P5_ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41879352923728238095)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>60
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51594540255185377573)
,p_component_action_id=>wwv_flow_imp.id(46663859374861172542)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Quick Look'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:&P5_ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52117711590892011913)
,p_component_action_id=>wwv_flow_imp.id(52117711528407011912)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Activity'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52199824089746508982)
,p_component_action_id=>wwv_flow_imp.id(52117711528407011912)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View &NOMENCLATURE_PROJECT.'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,:FI,PN:&FRIENDLY_IDENTIFIER.,&PROJECT_URL_NAME.'
,p_icon_css_classes=>'fa-glasses'
,p_authorization_scheme=>wwv_flow_imp.id(176222234009685897793)
);
wwv_flow_imp.component_end;
end;
/
