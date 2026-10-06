prompt --application/pages/page_00003
begin
--   Manifest
--     PAGE: 00003
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
 p_id=>3
,p_name=>'Project Details'
,p_alias=>'PROJECT-DETAILS'
,p_step_title=>'&P3_PROJECT_NAME.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.project-rds-region {',
'  background-color: rgba(219, 204, 175, .2);',
'}',
'',
'.t-Body-title {',
'  --ut-palette-warning-shade: rgba(var(--oj-palette-neutral-rgb-160));',
'  --ut-component-background-color: rgba(var(--oj-palette-neutral-rgb-170));',
'  --ut-alert-horizontal-border-radius: 0px;',
'}',
'',
'.t-ContextualInfo .t-Button--link {',
'  --a-button-line-height: 1rem;',
'  --a-button-border-radius: 0;',
'  --a-button-font-weight: normal;',
'}',
'',
'.t-ContextualInfo .t-Button--link:hover {',
'  text-decoration: none;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_deep_linking=>'Y'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37614963835027937371)
,p_plug_name=>'Reviews'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--removeHeader js-removeLandmark'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(40074095762229259811)
,p_landmark_type=>'exclude_landmark'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37614963900058937372)
,p_plug_name=>'review content'
,p_title=>'Reviews'
,p_parent_plug_id=>wwv_flow_imp.id(37614963835027937371)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>80
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       r.project_id,',
'       --',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       --',
'       t.task_type type,',
'       --',
'       case when length(r.description) > 200',
'            then substr(r.description,1,200)||''...''',
'            else r.description',
'            end description,',
'       --',
'       (select status from sp_task_statuses where id = r.status_id) status,',
'       r.impact,',
'       r.start_date,',
'       r.target_complete,',
'       --',
'       r.updated,',
'       --',
'       (select count(*) from sp_task_comments ',
'         where task_id = r.id',
'          and (nvl(private_yn,''N'') = ''N''  or lower(created_by) = lower(:app_user) )) nbr_comments,',
'       --',
'       (select count(*) from sp_task_documents where task_id = r.id) nbr_docs,',
'       (select count(*) from sp_task_links where task_id = r.id) nbr_links,',
'       t.display_seq ob,',
'       (select max(dbms_lob.substr(c.body_no_images,255,1)||',
'               decode(greatest(dbms_lob.getlength(c.body_no_images),255),255,null,''...'')) last_comment ',
'          from SP_TASK_COMMENTS c ',
'         where c.task_id = r.id and ',
'               c.private_yn = ''N'' and ',
'               c.created = (select max(c2.created) from sp_task_comments c2 where c2.task_id = r.id and c2.private_yn = ''N'')) last_comment',
'  from sp_tasks r,',
'       sp_task_types t',
' where project_id = :P3_PROJECT_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and t.static_id like ''REVIEW%'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'tasks content'
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
,p_landmark_label=>'Reviews'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37614964029509937373)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:509:&SESSION.::&DEBUG.:RP,509:P509_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'SBKENNED'
,p_internal_uid=>715606164107969604
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964130123937374)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964200140937375)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Review'
,p_column_link=>'f?p=&APP_ID.:98:&SESSION.::&DEBUG.:98:P98_TASK_ID,P98_PROJECT_ID:#ID#,#PROJECT_ID#'
,p_column_linktext=>'#TYPE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'Y'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964316758937376)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Details'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964419689937377)
,p_db_column_name=>'OWNER'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'Y'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964526725937378)
,p_db_column_name=>'STATUS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964648230937379)
,p_db_column_name=>'START_DATE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Start'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964759365937380)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964819560937381)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964883858937382)
,p_db_column_name=>'NBR_COMMENTS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Comments'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614964995903937383)
,p_db_column_name=>'NBR_DOCS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Documents'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965096693937384)
,p_db_column_name=>'NBR_LINKS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Links'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965199969937385)
,p_db_column_name=>'OB'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Order'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339758391094200)
,p_db_column_name=>'IMPACT'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Impact'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(27117241937690764652)
,p_db_column_name=>'LAST_COMMENT'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Last Comment'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844052592970784947)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37988492138080127191)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10891343'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:DESCRIPTION:OWNER:STATUS:IMPACT:START_DATE:TARGET_COMPLETE:LAST_COMMENT:UPDATED:'
,p_sort_column_1=>'OB'
,p_sort_direction_1=>'ASC'
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
 p_id=>wwv_flow_imp.id(27212119581633737578)
,p_report_id=>wwv_flow_imp.id(37988492138080127191)
,p_name=>'Completed'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'in'
,p_expr=>'Completed, Not Needed'
,p_condition_sql=>' (case when ("STATUS" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# ''Completed, Not Needed''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#d0f1cc'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46511823288554831604)
,p_plug_name=>'review button container'
,p_parent_plug_id=>wwv_flow_imp.id(37614963900058937372)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_task_history h,',
'       sp_tasks t,',
'       sp_task_types tt',
' where h.task_id = t.id',
'   and t.task_type_id = tt.id',
'   and tt.task_type = ''Review''',
'   and t.project_id = :P3_PROJECT_ID'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37614965283866937386)
,p_plug_name=>'Milestones'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--removeHeader js-removeLandmark'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_landmark_type=>'exclude_landmark'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37614965388362937387)
,p_plug_name=>'milestone content'
,p_title=>'Milestones'
,p_parent_plug_id=>wwv_flow_imp.id(37614965283866937386)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>90
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       r.project_id,',
'       --',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       --',
'       t.task_type type,',
'       --',
'       case when length(r.description) > 200',
'            then substr(r.description,1,200)||''...''',
'            else r.description',
'            end description,',
'       --',
'       (select status from sp_task_statuses where id = r.status_id) status,',
'       r.start_date,',
'       r.target_complete,',
'       --',
'       r.updated,',
'       --',
'       (select count(*) from sp_task_comments ',
'         where task_id = r.id',
'          and (nvl(private_yn,''N'') = ''N''  or lower(created_by) = lower(:app_user) )) nbr_comments,',
'       --',
'       (select count(*) from sp_task_documents where task_id = r.id) nbr_docs,',
'       (select count(*) from sp_task_links where task_id = r.id) nbr_links,',
'       t.display_seq ob,',
'(select max(dbms_lob.substr(c.body_no_images,255,1)||',
'               decode(greatest(dbms_lob.getlength(c.body_no_images),255),255,null,''...'')) last_comment ',
'          from SP_TASK_COMMENTS c ',
'         where c.task_id = r.id and ',
'               c.private_yn = ''N'' and ',
'               c.created = (select max(c2.created) from sp_task_comments c2 where c2.task_id = r.id and c2.private_yn = ''N'')) last_comment',
'  from sp_tasks r,',
'       sp_task_types t',
' where project_id = :P3_PROJECT_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and t.static_id like ''MILESTONE%'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'tasks content'
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
,p_landmark_label=>'Milestones'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37614965529855937388)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:508:&SESSION.::&DEBUG.:RP,508:P508_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'SBKENNED'
,p_internal_uid=>715607664453969619
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965652213937389)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965711581937390)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Milestone'
,p_column_link=>'f?p=&APP_ID.:98:&SESSION.::&DEBUG.:98:P98_TASK_ID,P98_PROJECT_ID:#ID#,#PROJECT_ID#'
,p_column_linktext=>'#TYPE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965781128937391)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Details'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965880824937392)
,p_db_column_name=>'OWNER'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614965988841937393)
,p_db_column_name=>'STATUS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966165021937394)
,p_db_column_name=>'START_DATE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Start'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966255707937395)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966293970937396)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966399003937397)
,p_db_column_name=>'NBR_COMMENTS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Comments'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966483636937398)
,p_db_column_name=>'NBR_DOCS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Documents'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966582068937399)
,p_db_column_name=>'NBR_LINKS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Links'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614966704186937400)
,p_db_column_name=>'OB'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Order'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(27117242067420764653)
,p_db_column_name=>'LAST_COMMENT'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Last Comment'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844052546850784946)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37988491547119127181)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10891337'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:DESCRIPTION:OWNER:STATUS:START_DATE:TARGET_COMPLETE:UPDATED:'
,p_sort_column_1=>'OB'
,p_sort_direction_1=>'ASC'
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
 p_id=>wwv_flow_imp.id(50894952248237630450)
,p_report_id=>wwv_flow_imp.id(37988491547119127181)
,p_name=>'Completed'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'='
,p_expr=>'Completed'
,p_condition_sql=>' (case when ("STATUS" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''Completed''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#d0f1cc'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46511822481136831596)
,p_plug_name=>'milestone button container'
,p_parent_plug_id=>wwv_flow_imp.id(37614965388362937387)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_task_history h,',
'       sp_tasks t,',
'       sp_task_types tt',
' where h.task_id = t.id',
'   and t.task_type_id = tt.id',
'   and tt.task_type = ''Milestone''',
'   and t.project_id = :P3_PROJECT_ID'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37713824072877667488)
,p_plug_name=>'Related'
,p_region_name=>'RELATED'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID relation_id,',
'       p.project related_project,',
'       p.pct_complete,',
'       r.project_relation,',
'       r.CREATED,',
'       p.FRIENDLY_IDENTIFIER,',
'       p.PROJECT_URL_NAME,',
'       lower(r.created_by) created_by,',
'       r.updated,',
'       lower(r.updated_by) updated_by',
'  from SP_PROJECT_RELATED r,',
'       sp_projects p',
'where  r.PROJECT_ID = :P3_PROJECT_ID and ',
'       r.RELATED_PROJECT_ID = p.id and ',
'       p.DUPLICATE_OF_PROJECT_ID is null and',
'       p.ARCHIVED_YN = ''N''',
'union',
'select r.ID relation_id,',
'       rp.project related_project,',
'       rp.pct_complete,',
'       r.project_relation,',
'       r.CREATED,',
'       rp.FRIENDLY_IDENTIFIER,',
'       rp.PROJECT_URL_NAME,',
'       lower(r.created_by) created_by,',
'       r.updated,',
'       lower(r.updated_by) updated_by',
'  from SP_PROJECT_RELATED r,',
'       sp_projects rp',
'where  r.RELATED_PROJECT_ID = :P3_PROJECT_ID and',
'       r.project_id = rp.id and',
'       rp.DUPLICATE_OF_PROJECT_ID is null and',
'       rp.ARCHIVED_YN = ''N'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Related'
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
 p_id=>wwv_flow_imp.id(37713824301375667490)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_ID:#RELATION_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>814466435973699721
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49762295512075785572)
,p_db_column_name=>'RELATION_ID'
,p_display_order=>10
,p_column_identifier=>'Y'
,p_column_label=>'Relation Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37713825269859667500)
,p_db_column_name=>'RELATED_PROJECT'
,p_display_order=>20
,p_column_identifier=>'J'
,p_column_label=>'Related &NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#RELATED_PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41725546487797004289)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>30
,p_column_identifier=>'X'
,p_column_label=>'Pct Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41501764936560119098)
,p_db_column_name=>'PROJECT_RELATION'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Relationship'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37713824880248667496)
,p_db_column_name=>'CREATED'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Relatation Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43687281748927577019)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>70
,p_column_identifier=>'T'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44003531710617536270)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>80
,p_column_identifier=>'U'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844051500043784936)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>90
,p_column_identifier=>'Z'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844051628555784937)
,p_db_column_name=>'UPDATED'
,p_display_order=>100
,p_column_identifier=>'AA'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844051768856784938)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>110
,p_column_identifier=>'AB'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37941682397771043690)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10423246'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RELATED_PROJECT:PROJECT_RELATION:CREATED'
,p_sort_column_1=>'CREATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38090003491716244790)
,p_plug_name=>'Contributors'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--removeHeader js-removeLandmark'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_landmark_type=>'exclude_landmark'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38090003604210244791)
,p_plug_name=>'contributors content'
,p_title=>'Contributors'
,p_parent_plug_id=>wwv_flow_imp.id(38090003491716244790)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>80
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.ID,',
'       t.first_name||'' ''||t.last_name name,',
'       c.TEAM_MEMBER_ID,',
'       (select RESOURCE_TYPE from SP_RESOURCE_TYPES r where r.id = c.RESPONSIBILITY_ID) responsibility,',
'       c.tags,',
'       c.CREATED,',
'       c.updated,',
'       c.responsibility comments,',
'       --',
'       nvl((select count(*) from SP_PROJECT_COMMENTS pc where pc.PROJECT_ID = c.project_id and pc.AUTHOR_ID = c.team_member_id),0) +',
'       nvl((select count(*) from SP_PROJECT_DOCUMENTS pd where pd.PROJECT_ID = c.project_id and pd.created_by = upper(t.email)),0) +',
'       nvl((select count(*) from SP_PROJECT_LINKS l where l.PROJECT_ID = c.project_id and l.created_by = upper(t.email)),0) ',
'       contributions',
'  from SP_PROJECT_CONTRIBUTORS c,',
'       SP_TEAM_MEMBERS t',
'where c.project_id = :P3_PROJECT_ID and',
'      t.id = c.TEAM_MEMBER_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'tasks content'
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
,p_landmark_label=>'Contributors'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(38090003759500244792)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:RP,9:P9_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'SBKENNED'
,p_internal_uid=>1190645894098277023
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090003806737244793)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005004910244805)
,p_db_column_name=>'NAME'
,p_display_order=>90
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:73:P73_TEAM_MEMBER_ID:#TEAM_MEMBER_ID#'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005365516244809)
,p_db_column_name=>'RESPONSIBILITY'
,p_display_order=>130
,p_column_identifier=>'G'
,p_column_label=>'Responsibility'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005525753244810)
,p_db_column_name=>'TAGS'
,p_display_order=>140
,p_column_identifier=>'H'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005570543244811)
,p_db_column_name=>'CREATED'
,p_display_order=>150
,p_column_identifier=>'I'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090004520216244800)
,p_db_column_name=>'UPDATED'
,p_display_order=>160
,p_column_identifier=>'B'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005763723244812)
,p_db_column_name=>'COMMENTS'
,p_display_order=>170
,p_column_identifier=>'J'
,p_column_label=>'Comments'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38090005817941244813)
,p_db_column_name=>'CONTRIBUTIONS'
,p_display_order=>180
,p_column_identifier=>'K'
,p_column_label=>'Contributions'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38104381424861281171)
,p_db_column_name=>'TEAM_MEMBER_ID'
,p_display_order=>190
,p_column_identifier=>'L'
,p_column_label=>'Team Member Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38102585341618136431)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12032275'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:RESPONSIBILITY:COMMENTS:CONTRIBUTIONS:CREATED:UPDATED'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'NAME'
,p_sort_direction_2=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46511822434929831595)
,p_plug_name=>'contributor button container'
,p_parent_plug_id=>wwv_flow_imp.id(38090003604210244791)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_PROJECT_HISTORY',
' where project_id = :P3_PROJECT_ID',
'   and attribute_column = ''CONTRIBUTOR'''))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41271237723189114202)
,p_plug_name=>'Comments'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41271237794675114203)
,p_plug_name=>'Comment Form'
,p_parent_plug_id=>wwv_flow_imp.id(41271237723189114202)
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(142860104311613242364)
,p_name=>'Comments Report'
,p_region_name=>'COMMENTS'
,p_parent_plug_id=>wwv_flow_imp.id(41271237723189114202)
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:margin-top-md'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pc.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       to_char(pc.created,''fmDay, fmDD fmMonth, YYYY'') date_full,',
'       null comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       pc.body_html comment_text,',
'       case when pc.author_id = :APP_USER_ID',
'            then ''<a href="''||apex_util.prepare_URL(',
'                 p_url => ''f?p=''||:APP_ID||'':28:''||:APP_SESSION||''::NO:28:P28_ID:''||pc.id,',
'                 p_checksum_type => ''3''',
'                 )||''">edit</a>'' ',
'            end actions,',
'       decode(pc.private_yn,null,null,''N'',null,''Y'','' Private Comment'') private_comment_label,',
'       '' '' attribute_1,',
'       '' '' attribute_2,',
'       '' '' attribute_3,',
'       '' '' attribute_4,',
'       ''u-color-''||ora_hash(pc.created_by,45) icon_modifier,',
'',
'       -- Data Columns',
'       pc.PROJECT_ID,',
'       pc.BODY,',
'       pc.BODY_HTML,',
'       --',
'       pc.CREATED,',
'       pc.CREATED_BY,',
'       pc.UPDATED,',
'       pc.UPDATED_BY,',
'       tm.id team_member_id',
'  from SP_PROJECT_COMMENTS_V pc, ',
'       sp_team_members tm',
'where pc.author_id = tm.id (+)',
'  and pc.project_id = :P3_PROJECT_ID',
'  and (nvl(pc.private_yn,''N'') = ''N'' or lower(pc.created_by) = lower(:app_user) )',
'order by pc.created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No Comments'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860104385207242365)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105760720242379)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178318786378483255)
,p_query_column_id=>3
,p_column_alias=>'DATE_FULL'
,p_column_display_sequence=>290
,p_column_heading=>'Date Full'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105927510242380)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_column_html_expression=>'<span title="added #DATE_FULL#">#CREATED#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860106030704242381)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860106103768242382)
,p_query_column_id=>6
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>180
,p_column_heading=>'Comment Text'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if PRIVATE_COMMENT_LABEL/}<strong class="u-danger-text">#PRIVATE_COMMENT_LABEL#</strong><br />{endif/}',
'#COMMENT_TEXT#'))
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860106167561242383)
,p_query_column_id=>7
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>190
,p_column_heading=>'Actions'
,p_report_column_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41271238131783114206)
,p_query_column_id=>8
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>270
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860106338327242384)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860106373591242385)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(151431003725346499536)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(151431003761688499537)
,p_query_column_id=>12
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(151431003864413499538)
,p_query_column_id=>13
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860104619140242367)
,p_query_column_id=>14
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>30
,p_column_heading=>'Project Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860104682752242368)
,p_query_column_id=>15
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860104851649242369)
,p_query_column_id=>16
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105400927242375)
,p_query_column_id=>17
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105486749242376)
,p_query_column_id=>18
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105577898242377)
,p_query_column_id=>19
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(142860105702879242378)
,p_query_column_id=>20
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(151399960988719022449)
,p_query_column_id=>21
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42765984306883148784)
,p_plug_name=>'Review Needed'
,p_icon_css_classes=>'fa-workflow'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--customIcons:t-Alert--warning:t-Alert--removeHeading js-removeLandmark:margin-bottom-none'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_plug_source=>'You have a pending &P3_APPROVAL_TYPE. approval request of this &NOMENCLATURE_PROJECT..'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P3_PROJECT_APPROVAL_CHAIN_ID'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(43922886083314717052)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>0
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44787229438347731870)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(43922886083314717052)
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
 p_id=>wwv_flow_imp.id(44787230671853731882)
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
 p_id=>wwv_flow_imp.id(46404489457287694998)
,p_plug_name=>'Approvals'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>165
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id,',
'       t.approval_type,',
'       m.first_name||'' ''||m.last_name submitted_by,',
'       a.submitted,',
'       initcap(replace(case when a.status = ''CLARIFICATION-REQUESTED'' then ''Needs Clarification'' else a.status end,''-'','' '')) status,',
'       a.status status_value,',
'       case a.status when ''PENDING'' then ''fa-clock-o fa-lg''',
'                     when ''CLARIFICATION-REQUESTED'' then ''fa-lg fa-info-circle-o''',
'                     when ''APPROVED'' then ''fa-lg fa-check-circle u-success-text''',
'                     when ''REJECTED'' then ''fa-remove fa-lg''',
'                     when ''WITHDRAWN'' then ''fa-lg fa-minus-circle-o''',
'                     end icon_class,',
'       case a.status when ''PENDING'' then ''warning''',
'                     when ''CLARIFICATION-REQUESTED'' then ''warning''',
'                     when ''APPROVED'' then ''success''',
'                     when ''REJECTED'' then ''danger''',
'                     when ''WITHDRAWN'' then null',
'                     else ''info''',
'                     end badge_class,',
'       case when a.status = ''PENDING'' then ''Justification: ''||a.justification',
'            when a.status in (''CLARIFICATION-REQUESTED'',''REJECTED'')',
'            then (select comments from ',
'                         (select comments, created, max(created) over (partition by project_approval_id) last_created',
'                            from sp_project_approval_chain',
'                           where a.id = project_approval_id)',
'                    where last_created = created)',
'            end justification,',
'       nvl((select max(last_status_on) from sp_project_approval_chain',
'         where project_approval_id = a.id),a.submitted) last_action,',
'       (select 1 from sp_project_approval_chain',
'        where a.id = project_approval_id',
'          and team_member_id = :APP_USER_ID',
'          and status = ''PENDING''',
'          and final_yn = ''Y'') user_has_pending_review,',
'       (select id from sp_project_approval_chain',
'         where a.id = project_approval_id',
'           and a.submitted_by_team_member_id = :APP_USER_ID',
'           and a.status = ''CLARIFICATION-REQUESTED'') clarification_id',
'  from sp_project_approvals a,',
'       sp_approval_types t,',
'       sp_team_members m',
' where a.project_id = :P3_PROJECT_ID',
'   and a.approval_type_id = t.id    ',
'   and a.submitted_by_team_member_id = m.id'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'last_action desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'No history found'
,p_show_total_row_count=>false
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_approvals',
' where project_id = :P3_PROJECT_ID',
'union',
'select 1',
'  from sp_initiative_approvals a,',
'       sp_projects p',
' where p.id = :P3_PROJECT_ID',
'   and p.initiative_id = a.initiative_id'))
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'BADGE_ALIGNMENT', 't-ContentRow-badge--alignCenter',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--lg',
  'BADGE_LABEL', 'Status',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_SHAPE', 't-Badge--square',
  'BADGE_SIZE', 't-Badge--md',
  'BADGE_STATE', 'BADGE_CLASS',
  'BADGE_VALUE', 'STATUS',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&JUSTIFICATION.',
    '<div><small>&STATUS. &LAST_ACTION. &middot; Submitted &SUBMITTED. by &SUBMITTED_BY.</small></div>')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N',
  'TITLE', '&APPROVAL_TYPE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36096048953352000059)
,p_name=>'CLARIFICATION_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CLARIFICATION_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511820574635831577)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511820763394831578)
,p_name=>'APPROVAL_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APPROVAL_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511820791536831579)
,p_name=>'SUBMITTED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SUBMITTED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511820874107831580)
,p_name=>'SUBMITTED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SUBMITTED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511820975239831581)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46511821116287831582)
,p_name=>'JUSTIFICATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'JUSTIFICATION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(49762297581798785593)
,p_name=>'LAST_ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_ACTION'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51905689785065848875)
,p_name=>'ICON_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53717465701022256272)
,p_name=>'BADGE_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53717466001812256275)
,p_name=>'STATUS_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53717466134821256276)
,p_name=>'USER_HAS_PENDING_REVIEW'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_HAS_PENDING_REVIEW'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47728216507071890003)
,p_plug_name=>'Duplicate of:'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning:margin-bottom-none'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'&P3_DUP_PROJECT.'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select 1 from sp_projects where id = :P3_PROJECT_ID and DUPLICATE_OF_PROJECT_ID is not null'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47728216572345890004)
,p_plug_name=>'Archived &NOMENCLATURE_PROJECT.'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning:margin-bottom-none'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select ARCHIVED_YN from sp_projects where id = :P3_PROJECT_ID and ARCHIVED_YN = ''Y'''
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48805116164342715389)
,p_plug_name=>'Description'
,p_region_name=>'DESCRIPTION'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50493824755486761115)
,p_plug_name=>'description button container'
,p_parent_plug_id=>wwv_flow_imp.id(48805116164342715389)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>1102
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(68015116027398133514)
,p_plug_name=>'description content'
,p_title=>'Description'
,p_parent_plug_id=>wwv_flow_imp.id(48805116164342715389)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>120
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    x clob;',
'begin',
'x := ''No description provided.'';',
'for c1 in (select description from sp_projects d ',
'            where d.id = :P3_PROJECT_ID',
'              and description is not null) loop',
'    x := apex_markdown.to_html(c1.description);',
'end loop;',
'return x;',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48877183674628636376)
,p_plug_name=>'footer'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>140
,p_plug_display_point=>'REGION_POSITION_05'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38455255769257056480)
,p_name=>'Additional Attriubtes'
,p_parent_plug_id=>wwv_flow_imp.id(48877183674628636376)
,p_template=>4501440665235496320
,p_display_sequence=>500
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id,',
'       p.created,',
'       --',
'       --',
'       --',
'       (select a.area from sp_areas a, sp_initiatives i    ',
'         where a.id = i.area_id',
'           and i.id = p.initiative_id) area,',
'       (select a.id from sp_areas a, sp_initiatives i    ',
'         where a.id = i.area_id',
'           and i.id = p.initiative_id) area_id,',
'       p.project_group_id,',
'       (select group_name from sp_project_groups pg where pg.id = p.project_group_id) project_group,',
'       --',
'       nvl((select first_name||'' ''||last_name from sp_team_members tm ',
'        where tm.email = lower(p.created_by)),lower(p.created_by)) created_by,',
'       (select id from sp_team_members tm ',
'         where tm.email = lower(p.created_by)) created_by_id,',
'       lower(p.created_by) created_by_email,',
'       --',
'       p.updated,',
'       --',
'       nvl((select first_name||'' ''||last_name from sp_team_members tm ',
'        where tm.email = lower(p.updated_by)),lower(p.updated_by)) updated_by,',
'       (select id from sp_team_members tm ',
'         where tm.email = lower(p.updated_by)) updated_by_id,',
'       lower(p.updated_by) updated_by_email,',
'       --',
'       (select count(*) cnt from SP_FAVORITES f where f.project_id = p.id) favorited,',
'       --',
'       (select count(*) c from sp_proj_interactions_log l where l.project_id = p.id)||'' by ''||',
'       (select count(distinct(app_user)) u ',
'        from sp_proj_interactions_log l ',
'        where l.project_id = p.id) ||'' users'' interactoions,',
'       --',
'       (select count(*)',
'        from SP_PROJECT_HISTORY',
'        where  project_id = p.id) +',
'       (select count(*)',
'        from sp_task_history h,',
'             sp_tasks t,',
'             sp_task_types tt',
'        where h.task_id = t.id',
'        and t.task_type_id = tt.id',
'        and t.project_id = p.id) changes',
'from SP_PROJECTS p',
'where p.id = :P3_PROJECT_ID'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455259273269056515)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455257609660056498)
,p_query_column_id=>2
,p_column_alias=>'CREATED'
,p_column_display_sequence=>30
,p_column_heading=>'Created'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53088314578603006977)
,p_query_column_id=>3
,p_column_alias=>'AREA'
,p_column_display_sequence=>10
,p_column_heading=>'Area'
,p_column_link=>'f?p=&APP_ID.:66:&SESSION.::&DEBUG.:66:P66_AREA_ID:#AREA_ID#'
,p_column_linktext=>'#AREA#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53088314722435006978)
,p_query_column_id=>4
,p_column_alias=>'AREA_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550797448010063999)
,p_query_column_id=>5
,p_column_alias=>'PROJECT_GROUP_ID'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550797504070064000)
,p_query_column_id=>6
,p_column_alias=>'PROJECT_GROUP'
,p_column_display_sequence=>20
,p_column_heading=>'Group'
,p_column_link=>'f?p=&APP_ID.:119:&SESSION.::&DEBUG.:RP,119:P119_PROJECT_GROUP_ID:#PROJECT_GROUP_ID#'
,p_column_linktext=>'#PROJECT_GROUP#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455259024153056512)
,p_query_column_id=>7
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>40
,p_column_heading=>'Created By'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#CREATED_BY_ID#'
,p_column_linktext=>'#CREATED_BY#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42765985249866148793)
,p_query_column_id=>8
,p_column_alias=>'CREATED_BY_ID'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550794605943063971)
,p_query_column_id=>9
,p_column_alias=>'CREATED_BY_EMAIL'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455257851345056500)
,p_query_column_id=>10
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>50
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455259540647056517)
,p_query_column_id=>11
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>60
,p_column_heading=>'Updated By'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#UPDATED_BY_ID#'
,p_column_linktext=>'#UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42765985360156148794)
,p_query_column_id=>12
,p_column_alias=>'UPDATED_BY_ID'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550794666045063972)
,p_query_column_id=>13
,p_column_alias=>'UPDATED_BY_EMAIL'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455258905263056511)
,p_query_column_id=>14
,p_column_alias=>'FAVORITED'
,p_column_display_sequence=>120
,p_column_heading=>'Favorited'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550794524522063970)
,p_query_column_id=>15
,p_column_alias=>'INTERACTOIONS'
,p_column_display_sequence=>90
,p_column_heading=>'Interactions'
,p_column_link=>'f?p=&APP_ID.:600:&SESSION.::&DEBUG.:RP,600:P600_PROJECT_ID:#ID#'
,p_column_linktext=>'#INTERACTOIONS#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455259623217056518)
,p_query_column_id=>16
,p_column_alias=>'CHANGES'
,p_column_display_sequence=>80
,p_column_heading=>'Changes'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_link=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:64:p64_project_id:#ID#'
,p_column_linktext=>'#CHANGES#'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48999803752597585389)
,p_plug_name=>'Clarification Requested for Review'
,p_icon_css_classes=>'fa-exclamation-circle'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--customIcons:t-Alert--warning:t-Alert--removeHeading js-removeLandmark:margin-bottom-none'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_plug_source=>'Clarification requested for the &P3_MORE_INFO_APPROVAL_TYPE. approval of this &NOMENCLATURE_PROJECT..'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51243452881739848190)
,p_plug_name=>'Activity'
,p_region_name=>'ACTIVITY'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51193797278043397052)
,p_plug_name=>'activity content'
,p_title=>'Activity'
,p_parent_plug_id=>wwv_flow_imp.id(51243452881739848190)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>121
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
'       tm.first_name||'' ''||tm.last_name name,',
'       --',
'       p.project,',
'       p.friendly_identifier,',
'       p.PROJECT_URL_NAME,',
'       apex_util.get_since(ap.updated) last_updated,',
'       --',
'       tm.first_name||'' ''||tm.last_name owner,',
'       --',
'       -- optional initiative',
'       --',
'       decode(ap.initiative_id,null,null,(',
'           select initiative from sp_initiatives where id = ap.initiative_id',
'       )) initiative,',
'       ap.initiative_id,',
'       --',
'       -- timeframe',
'       --',
'        decode(',
'           greatest(trunc(sysdate),trunc(ap.end_date)),',
'           trunc(sysdate),',
'           ''Past'',',
'           decode(',
'               greatest(trunc(sysdate),trunc(ap.start_date)),',
'               trunc(sysdate),',
'               ''Current'',',
'               ''Future'')',
'           ) timeframe,',
'       --',
'       -- pie chart icon in 10% chunks that show time percent complete',
'       --',
'       ''fa-pie-chart-''||sp_date_range_pct_comp(ap.start_date, ap.end_date) icon',
'from sp_activities ap,',
'     sp_projects p,',
'     sp_activity_types at,',
'     sp_team_members tm',
'where ap.project_id = p.id and',
'      p.id = :P3_PROJECT_ID and',
'      ap.activity_type_id = at.id and',
'      ap.team_member_id = tm.id and',
'      --',
'      --',
'      --',
'      (  ',
'         trunc(sysdate) between ap.start_date and ap.end_date or ',
'         (nvl(:P3_INCLUDE_FUTURE,''N'') = ''Y'' and ap.start_date >= trunc(sysdate)) or',
'         (nvl(:P3_INCLUDE_PAST,''N'') = ''Y'' and ap.end_date < trunc(sysdate))',
'      )',
'order by ap.updated desc',
''))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P3_PROJECT_ID,P3_INCLUDE_FUTURE,P3_INCLUDE_PAST'
,p_plug_query_num_rows=>30
,p_plug_query_num_rows_type=>'SET'
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
  'BADGE_VALUE', 'TIMEFRAME',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>Owner</strong>: &OWNER.<br>',
    '<strong>&ACTIVITY_TYPE.</strong>: &TIMELINE.<br>',
    '{if PROJECT/}<strong>&NOMENCLATURE_PROJECT.</strong>: &PROJECT.<br>{endif/}',
    '{if INITIATIVE/}<strong>&NOMENCLATURE_INITIATIVE.</strong>: &INITIATIVE.<br>{endif/}')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', 'Updated &LAST_UPDATED.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&COMMENTS.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38579315438848777681)
,p_name=>'TIMEFRAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMEFRAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>340
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(42368152746641953908)
,p_name=>'INITIATIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>350
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(42368152796422953909)
,p_name=>'INITIATIVE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATIVE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>360
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51193797453349397053)
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
 p_id=>wwv_flow_imp.id(51193798845968397067)
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
 p_id=>wwv_flow_imp.id(51193798997707397069)
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
 p_id=>wwv_flow_imp.id(51193800942067397088)
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
 p_id=>wwv_flow_imp.id(51193801057344397089)
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
 p_id=>wwv_flow_imp.id(51193801158155397090)
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
 p_id=>wwv_flow_imp.id(51193801249895397091)
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
 p_id=>wwv_flow_imp.id(51215033941926948542)
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
 p_id=>wwv_flow_imp.id(51215033979162948543)
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
 p_id=>wwv_flow_imp.id(51215034132981948544)
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
 p_id=>wwv_flow_imp.id(51215034255511948545)
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
 p_id=>wwv_flow_imp.id(51215034304236948546)
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
 p_id=>wwv_flow_imp.id(51215034366049948547)
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
 p_id=>wwv_flow_imp.id(51215034513410948548)
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
 p_id=>wwv_flow_imp.id(51215034643315948549)
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
 p_id=>wwv_flow_imp.id(51215035416310948557)
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
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51243455092034848212)
,p_name=>'OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>330
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51243453029844848191)
,p_plug_name=>'Activity Filters'
,p_parent_plug_id=>wwv_flow_imp.id(51243452881739848190)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>1111
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53797036597381814993)
,p_plug_name=>'Tasks'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--removeHeader js-removeLandmark'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_landmark_type=>'exclude_landmark'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53797036845315814995)
,p_plug_name=>'task content'
,p_title=>'Tasks'
,p_parent_plug_id=>wwv_flow_imp.id(53797036597381814993)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with today as (select trunc(sysdate) day from dual)',
'select r.ID,',
'       r.project_id,',
'       --',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       --',
'       (select task_type from sp_task_types rt where rt.id = r.task_type_id)||',
'           case when r.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = r.task_sub_type_id) ||',
'           case when r.task is not null then '' - ''||r.task end type,',
'       --',
'       case when length(r.description) > 200',
'            then substr(r.description,1,200)||''...''',
'            else r.description',
'            end description,',
'       --',
'       s.status,',
'       s.display_seq,',
'       r.start_date,',
'       r.target_complete,',
'       case when s.indicates_complete_yn = ''N'' and',
'                 r.target_complete is not null',
'            then least(5, trunc(r.target_complete) - trunc(r.target_complete, ''iw'') + 1)',
'                 - least(5, today.day - trunc(today.day, ''iw'') + 1)',
'                 + (trunc(r.target_complete, ''iw'') - trunc(today.day, ''iw'')) * 5 / 7',
'       end weekdays_left,',
'       --',
'       r.updated,',
'       --',
'       (select count(*) from sp_task_comments ',
'         where task_id = r.id',
'          and (nvl(private_yn,''N'') = ''N''  or lower(created_by) = lower(:app_user) )) nbr_comments,',
'       --',
'       (select count(*) from sp_task_documents where task_id = r.id) nbr_docs,',
'       (select count(*) from sp_task_links where task_id = r.id) nbr_links,',
'       t.display_seq ob,',
'       (select max(dbms_lob.substr(c.body_no_images,255,1)||',
'               decode(greatest(dbms_lob.getlength(c.body_no_images),255),255,null,''...'')) last_comment ',
'          from SP_TASK_COMMENTS c ',
'         where c.task_id = r.id and ',
'               c.private_yn = ''N'' and ',
'               c.created = (select max(c2.created) from sp_task_comments c2 where c2.task_id = r.id and c2.private_yn = ''N'')) last_comment',
'  from sp_tasks r,',
'       sp_task_types t,',
'       sp_task_statuses s,',
'       today',
' where project_id = :P3_PROJECT_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and r.status_id = s.id (+)',
'   and t.static_id not like ''MILESTONE%''',
'   and t.static_id not like ''REVIEW%'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'tasks content'
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
,p_landmark_label=>'Tasks'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(53797036886589814996)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:RP,501:P501_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'SBKENNED'
,p_internal_uid=>16897679021187847227
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037041275814997)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037428880815001)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'E'
,p_column_label=>'Task'
,p_column_link=>'f?p=&APP_ID.:98:&SESSION.::&DEBUG.:98:P98_TASK_ID,P98_PROJECT_ID:#ID#,#PROJECT_ID#'
,p_column_linktext=>'#TYPE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55010684306852779671)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'I'
,p_column_label=>'Details'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037204477814999)
,p_db_column_name=>'OWNER'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037282253815000)
,p_db_column_name=>'STATUS'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037924581815006)
,p_db_column_name=>'START_DATE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Start'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037982442815007)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53797037151504814998)
,p_db_column_name=>'UPDATED'
,p_display_order=>90
,p_column_identifier=>'B'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55010688565167779713)
,p_db_column_name=>'NBR_COMMENTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Comments'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55010688657157779714)
,p_db_column_name=>'NBR_DOCS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Documents'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55010688669992779715)
,p_db_column_name=>'NBR_LINKS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Links'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55177378976996247808)
,p_db_column_name=>'OB'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Task OB'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40690390056947052919)
,p_db_column_name=>'DISPLAY_SEQ'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Status OB'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46901092321473793917)
,p_db_column_name=>'WEEKDAYS_LEFT'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Weekdays Left'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(27117242124646764654)
,p_db_column_name=>'LAST_COMMENT'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Last Comment'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(31844052750334784948)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(55010329291305747891)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181109715'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:OWNER:STATUS:START_DATE:TARGET_COMPLETE:WEEKDAYS_LEFT:DESCRIPTION:UPDATED'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'DISPLAY_SEQ'
,p_sort_direction_2=>'ASC NULLS LAST'
,p_sort_column_3=>'OB'
,p_sort_direction_3=>'ASC NULLS FIRST'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(50894959697790631906)
,p_report_id=>wwv_flow_imp.id(55010329291305747891)
,p_name=>'Completed'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'='
,p_expr=>'Completed'
,p_condition_sql=>' (case when ("STATUS" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''Completed''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#d0f1cc'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(50894959359027631905)
,p_report_id=>wwv_flow_imp.id(55010329291305747891)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'!='
,p_expr=>'Completed'
,p_condition_sql=>'"STATUS" != #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# != ''Completed''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(68377260482145885715)
,p_name=>'Project Details'
,p_template=>4501440665235496320
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'REGION_POSITION_01'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.INITIATIVE_ID,',
'       i.initiative,',
'       p.PROJECT,',
'       --',
'       -- initiative focus area',
'       --',
'       (select focus_area from SP_INITIATIVE_FOCUS_AREAS ifa where ifa.id = p.FOCUS_AREA_ID) initiative_focus_area,',
'       (select id from SP_INITIATIVE_FOCUS_AREAS ifa where ifa.id = p.FOCUS_AREA_ID) init_focus_area_id,',
'       --',
'       -- owner',
'       --',
'       (select t.first_name||'' ''||t.last_name',
'       from SP_TEAM_MEMBERS t ',
'       where t.id = p.OWNER_ID) project_owner,',
'       --',
'       p.owner_id,',
'       --',
'       case when p.target_complete is null',
'            then ''No Target''',
'            else to_char(p.target_complete,''DD-Mon-RR'')',
'            end ||',
'            case when p.release_id is not null ',
'                 then '' (''||(select release_train||'': ''||release from SP_RELEASE_TRAINS t where t.id = p.release_id)||'')''',
'                 end target_complete,',
'       --',
'       -- status',
'       --',
'       case p.pct_complete when 0 then s.pc0_label   ||'' - ''|| p.pct_complete ||''%''',
'                           when 10 then s.pc10_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 20 then s.pc20_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 30 then s.pc30_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 40 then s.pc40_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 50 then s.pc50_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 60 then s.pc60_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 70 then s.pc70_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 80 then s.pc80_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 90 then s.pc90_label ||'' - ''|| p.pct_complete ||''%''',
'                           when 100 then s.pc100_label ||'' - ''|| p.pct_complete ||''%''',
'                           end as pct_complete,',
'       nvl((select status from sp_project_statuses',
'             where id = p.status_id),''Not Set'') status,',
'       --',
'       -- priority',
'       --',
'       p.PRIORITY_ID,',
'       nvl((select ''P''||PRIORITY from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'') priority,',
'       --',
'       p.TAGS,',
'       p.CREATED,',
'       p.CREATED_BY,',
'       p.UPDATED,',
'       p.UPDATED_BY,',
'       p.project_size,',
'       p.friendly_identifier,',
'       decode(p.ACTIVE_YN,''Y'',''Yes'',''N'',''No'',''Unknown'') active_yn,',
'       --',
'       -- external link',
'       --',
'       p.external_system_link,',
'       p.friendly_identifier ||'' <button type="button" title="Copy Permalink" aria-label="Copy Permalink" data-clipboard-source="''||:P3_PERMALINK_PREFIX||apex_escape.html(p.friendly_identifier)||''&pn=''||apex_escape.html(p.project_url_name)||''" class='
||'"t-Button t-Button--noLabel t-Button--icon t-Button--link padding-none">''||''<span class="fa fa-copy" aria-hidden="true"></span>''||''</button>'' perma_link,',
'       p.external_ticket_identifier,',
'       --',
'       -- favorite_icon',
'       --',
'       nvl((select ''<span class="fa fa-heart u-danger-text" aria-hidden="true"></span>'' ',
'            from sp_favorites fav ',
'            where fav.project_id = p.id and ',
'                  fav.team_member_id = :APP_USER_ID),',
'                  ''<span class="fa fa-heart-o" aria-hidden="true"></span>'') favorite_icon',
'       --',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f,',
'       SP_PROJECT_SCALES s',
'where ',
'      p.initiative_id = i.id and',
'      i.area_id = f.id and',
'      p.id = :P3_PROJECT_ID and  ',
'      p.status_scale = s.scale_letter'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'APP_USER_ID,P3_PROJECT_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377260510209885716)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377260610531885717)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377260821234885719)
,p_query_column_id=>3
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>40
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_column_link=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,:P94_INITIATIVE_ID:#INITIATIVE_ID#'
,p_column_linktext=>'#INITIATIVE#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377260974234885720)
,p_query_column_id=>4
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53205375899748421192)
,p_query_column_id=>5
,p_column_alias=>'INITIATIVE_FOCUS_AREA'
,p_column_display_sequence=>50
,p_column_heading=>'Focus Area'
,p_column_link=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:33:P33_INIT_FOCUS_AREA_ID:#INIT_FOCUS_AREA_ID#'
,p_column_linktext=>'#INITIATIVE_FOCUS_AREA#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933058401963387097)
,p_query_column_id=>6
,p_column_alias=>'INIT_FOCUS_AREA_ID'
,p_column_display_sequence=>310
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68528240181961240795)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_OWNER'
,p_column_display_sequence=>70
,p_column_heading=>'Owner'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RR,73:P73_TEAM_MEMBER_ID:#OWNER_ID#'
,p_column_linktext=>'#PROJECT_OWNER#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68528240149352240794)
,p_query_column_id=>8
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261182840885722)
,p_query_column_id=>9
,p_column_alias=>'TARGET_COMPLETE'
,p_column_display_sequence=>180
,p_column_heading=>'Target'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(52590898007413963406)
,p_query_column_id=>10
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>100
,p_column_heading=>'Completeness'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261394020885724)
,p_query_column_id=>11
,p_column_alias=>'STATUS'
,p_column_display_sequence=>110
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_projects p,',
'       sp_initiatives i,',
'       sp_project_scales s',
' where p.id = :P3_PROJECT_ID',
'   and p.initiative_id = i.id',
'   and i.status_scale = s.scale_letter',
'   and p.pct_complete >= s.min_pc_for_status ',
'   and p.pct_complete != 100'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261471816885725)
,p_query_column_id=>12
,p_column_alias=>'PRIORITY_ID'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261595030885726)
,p_query_column_id=>13
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>130
,p_column_heading=>'Priority'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261801189885729)
,p_query_column_id=>14
,p_column_alias=>'TAGS'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377261971871885730)
,p_query_column_id=>15
,p_column_alias=>'CREATED'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377262084979885731)
,p_query_column_id=>16
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377262186238885732)
,p_query_column_id=>17
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>220
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(68377262296734885733)
,p_query_column_id=>18
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>230
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(36965646737110198706)
,p_query_column_id=>19
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>150
,p_column_heading=>'Size'
,p_column_link=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:34:P34_ID:#ID#'
,p_column_linktext=>'#PROJECT_SIZE#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48805114307097715371)
,p_query_column_id=>20
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>250
,p_hidden_column=>'Y'
,p_derived_column=>'N'
,p_required_patch=>wwv_flow_imp.id(42654456934873218939)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51377187947468961494)
,p_query_column_id=>21
,p_column_alias=>'ACTIVE_YN'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
,p_required_patch=>wwv_flow_imp.id(54991132434390587116)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43162214260880749773)
,p_query_column_id=>22
,p_column_alias=>'EXTERNAL_SYSTEM_LINK'
,p_column_display_sequence=>270
,p_column_heading=>'External Link'
,p_column_html_expression=>'<a href="#EXTERNAL_SYSTEM_LINK#" target="_blank">#EXTERNAL_TICKET_IDENTIFIER#</a>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'from   SP_PROJECTS p',
'where  ID = :P3_PROJECT_ID and ',
'       p.external_ticket_identifier is not null and ',
'       p.external_ticket_system is not null and ',
'       p.display_external_link_yn = ''Y'''))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46901088244992793876)
,p_query_column_id=>23
,p_column_alias=>'PERMA_LINK'
,p_column_display_sequence=>260
,p_column_heading=>'Permalink'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43162214464211749775)
,p_query_column_id=>24
,p_column_alias=>'EXTERNAL_TICKET_IDENTIFIER'
,p_column_display_sequence=>300
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39007332418393180975)
,p_query_column_id=>25
,p_column_alias=>'FAVORITE_ICON'
,p_column_display_sequence=>290
,p_column_heading=>'My Favorite'
,p_column_link=>'f?p=&APP_ID.:128:&SESSION.::&DEBUG.:RP,128:P128_PROJECT_ID:#ID#'
,p_column_linktext=>'#FAVORITE_ICON#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(68377262439243885735)
,p_plug_name=>'RDS'
,p_region_css_classes=>'u-padding-inline-dynamic project-rds-region'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_08'
,p_location=>null
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_region_icons', 'N',
  'include_show_all', 'N',
  'rds_mode', 'STANDARD',
  'remember_selection', 'SESSION')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(151399961100667022450)
,p_plug_name=>'Links'
,p_region_name=>'LINKS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select :NOMENCLATURE_PROJECT type,',
'       ''6'' edit_page,',
'       l.id, ',
'       l.LINK_name, ',
'       decode(greatest(length(l.link_url),80),80,',
'           l.link_url,',
'           substr(l.link_url,1,39)||''...''||substr(l.link_url,length(l.link_url)-39)',
'           ) link_url,',
'       l.link_url full_url,',
'       l.created, ',
'       l.updated, ',
'       lower(created_by) added_by,',
'       decode(important_yn,''Y'',''Yes'',''N'',''No'',null,''No'') important',
'from SP_PROJECT_LINKS l ',
'where project_id = :P3_PROJECT_ID',
'union all',
'select case when t.task_sub_type_id is not null',
'            then (select task_type from sp_task_types',
'                   where id = t.task_type_id)||'': ''',
'            end ||',
'       tt.task_type || case when t.task is not null then '' - ''||t.task end type,',
'       ''506'' edit_page,',
'       l.id, ',
'       l.LINK_name, ',
'       decode(greatest(length(l.link_url),80),80,',
'           l.link_url,',
'           substr(l.link_url,1,39)||''...''||substr(l.link_url,length(l.link_url)-39)',
'           ) link_url,',
'       l.link_url full_url,',
'       l.created, ',
'       l.updated, ',
'       lower(l.created_by) added_by,',
'       decode(l.important_yn,''Y'',''Yes'',''N'',''No'',null,''No'') important',
'  from SP_TASK_LINKS l,',
'       SP_TASKS t,',
'       sp_task_types tt',
' where t.project_id = :P3_PROJECT_ID',
'   and t.id = l.task_id',
'   and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'order by created desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Links'
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
 p_id=>wwv_flow_imp.id(37713823371968667481)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:#EDIT_PAGE#:P#EDIT_PAGE#_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>814465506566699712
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37713823541321667482)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339458783094197)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'P'
,p_column_label=>'Belongs to'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'EXISTS'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_TASK_LINKS l,',
'       SP_TASKS t',
' where t.project_id = :P3_PROJECT_ID',
'   and t.id = l.task_id'))
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594542317965377594)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Link'
,p_column_link=>'#FULL_URL#'
,p_column_linktext=>'#LINK_NAME#'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37713823669908667484)
,p_db_column_name=>'LINK_URL'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'URL'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37713823952814667486)
,p_db_column_name=>'CREATED'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45076799699442940906)
,p_db_column_name=>'UPDATED'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594541277912377584)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52935082614942546792)
,p_db_column_name=>'ADDED_BY'
,p_display_order=>80
,p_column_identifier=>'N'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37433448732562894399)
,p_db_column_name=>'FULL_URL'
,p_display_order=>90
,p_column_identifier=>'O'
,p_column_label=>'Full Url'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339520624094198)
,p_db_column_name=>'EDIT_PAGE'
,p_display_order=>110
,p_column_identifier=>'Q'
,p_column_label=>'Edit Page'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37732480516811822351)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8331227'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:LINK_NAME:LINK_URL:IMPORTANT:UPDATED:ADDED_BY:'
,p_sort_column_1=>'IMPORTANT'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
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
 p_id=>wwv_flow_imp.id(151399962886842022468)
,p_plug_name=>'Documents'
,p_region_name=>'DOCUMENTS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case doc_type when ''Project''',
'            then :NOMENCLATURE_PROJECT',
'            when ''Task''',
'            then name',
'            end type,',
'       case doc_type when ''Project''',
'            then ''12'' ',
'            when ''Task''',
'            then ''504''',
'            end edit_page,',
'       case doc_type when ''Project''',
'            then ''30'' ',
'            when ''Task''',
'            then ''505''',
'            end display_page,',
'       document_id,',
'       DOCUMENT_FILENAME,',
'       UPDATED,',
'       created,',
'       doc_description,',
'       tags,',
'       added_by created_by,',
'       filesize doc_size,',
'       created date_created,',
'       file_extension,',
'       important,',
'       filesize document',
'  from SP_DOCUMENTS_V',
' where project_id = :P3_PROJECT_ID',
'   and doc_type in (''Project'',''Task'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3_PROJECT_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Documents'
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
 p_id=>wwv_flow_imp.id(37708576698507317792)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_control_break=>'N'
,p_show_computation=>'N'
,p_show_aggregate=>'N'
,p_show_chart=>'N'
,p_show_group_by=>'N'
,p_show_pivot=>'N'
,p_show_flashback=>'N'
,p_show_download=>'N'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:#EDIT_PAGE#:P#EDIT_PAGE#_ID:#DOCUMENT_ID###DOCUMENT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>809218833105350023
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339154112094194)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'N'
,p_column_label=>'Belongs to'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'EXISTS'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_TASK_DOCUMENTS d,',
'       SP_TASKS t',
' where t.project_id = :P3_PROJECT_ID',
'   and t.id = d.task_id'))
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708576932062317794)
,p_db_column_name=>'DOCUMENT_FILENAME'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Filename'
,p_column_link=>'f?p=&APP_ID.:#DISPLAY_PAGE#:&SESSION.::&DEBUG.:#DISPLAY_PAGE#:P#DISPLAY_PAGE#_ID,P#DISPLAY_PAGE#_PREV_PAGE:#DOCUMENT_ID#,3'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708577356863317798)
,p_db_column_name=>'DOC_DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708577562392317800)
,p_db_column_name=>'DOC_SIZE'
,p_display_order=>50
,p_column_identifier=>'H'
,p_column_label=>'Size'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FILESIZE'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708577109026317796)
,p_db_column_name=>'UPDATED'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708577184869317797)
,p_db_column_name=>'CREATED'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37708577579430317801)
,p_db_column_name=>'DATE_CREATED'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Created On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38145431770176166580)
,p_db_column_name=>'FILE_EXTENSION'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'File Extension'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48805115474116715383)
,p_db_column_name=>'TAGS'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51825532656633349310)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52935080913185546775)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339200943094195)
,p_db_column_name=>'EDIT_PAGE'
,p_display_order=>130
,p_column_identifier=>'O'
,p_column_label=>'Edit Page'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339308559094196)
,p_db_column_name=>'DISPLAY_PAGE'
,p_display_order=>140
,p_column_identifier=>'P'
,p_column_label=>'Display Page'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014890990761880773)
,p_db_column_name=>'DOCUMENT_ID'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Document Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014891092942880774)
,p_db_column_name=>'DOCUMENT'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Document'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'DOWNLOAD:SP_DOCUMENTS_V:DOCUMENT_BLOB:DOCUMENT_ID::DOCUMENT_MIMETYPE:DOCUMENT_FILENAME:DOCUMENT_LASTUPD:DOCUMENT_CHARSET:attachment:Download:'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37710312933310910563)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8109551'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:DOCUMENT_FILENAME:DOC_DESCRIPTION:CREATED_BY:IMPORTANT:DOCUMENT:DOC_SIZE:UPDATED:'
,p_sort_column_1=>'IMPORTANT'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_sum_columns_on_break=>'DOC_SIZE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46511822312995831594)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46511822434929831595)
,p_button_name=>'view_contributor_change_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View Contributor Change History'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP,64:P64_PROJECT_ID,P64_ATTRIBUTE_COLUMN:&P3_PROJECT_ID.,Contributor'
,p_icon_css_classes=>'fa-glasses'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46511822648734831597)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46511822481136831596)
,p_button_name=>'view_milesteone_change_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View Milestone Change History'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP,64:P64_PROJECT_ID,P64_PARENT_TYPE:&P3_PROJECT_ID.,Milestone'
,p_icon_css_classes=>'fa-glasses'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46511823395406831605)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46511823288554831604)
,p_button_name=>'view_review_change_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View Review Change History'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP,64:P64_PROJECT_ID,P64_PARENT_TYPE:&P3_PROJECT_ID.,Review'
,p_icon_css_classes=>'fa-glasses'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37713825506482667502)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37713824072877667488)
,p_button_name=>'add_related_project'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Related &NOMENCLATURE_PROJECT.'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38090006070089244816)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(38090003491716244790)
,p_button_name=>'add_contributor'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Contributor'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50493824604314761114)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(50493824755486761115)
,p_button_name=>'view_description_change_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View Description Change History'
,p_button_redirect_url=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP,64:P64_PROJECT_ID,P64_ATTRIBUTE_COLUMN:&P3_PROJECT_ID.,Description'
,p_icon_css_classes=>'fa-glasses'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(151431004109472499540)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(41271237794675114203)
,p_button_name=>'POST_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Post Comment'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'u-flex u-align-items-center'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38104381298080281170)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(38090003491716244790)
,p_button_name=>'about_contributor_roles'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'About Contributor Roles'
,p_button_redirect_url=>'f?p=&APP_ID.:67:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-info'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(69544560328935096276)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(151399961100667022450)
,p_button_name=>'add_link'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Link'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47728217714283890015)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(47728216572345890004)
,p_button_name=>'unmark_as_archived'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Restore'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:RP,52:P52_PROJECT_ID:&P3_PROJECT_ID.'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48714899471720337693)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(47728216507071890003)
,p_button_name=>'view_Duplicate'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'View Primary'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_PROJECT_ID:&P3_DUP_PROJECT_ID.'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47728217535539890013)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(47728216507071890003)
,p_button_name=>'unmark_as_duplidate'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--simple'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Not a Duplicate'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.:50:P50_PROJECT_ID:&P3_PROJECT_ID.'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46511820479582831576)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46404489457287694998)
,p_button_name=>'REQUEST_APPROVAL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Request Approval'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:121:&SESSION.::&DEBUG.:121:P121_PROJECT_ID:&P3_PROJECT_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- must have APP_USER_ID to submit',
'if :APP_USER_ID is null then  ',
'   return FALSE;',
'end if;',
'',
'-- if any approvals pending, cannot request another',
'for c1 in (',
'    select 1 from sp_project_approvals',
'     where project_id = :P3_PROJECT_ID',
'       and status in (''PENDING'',''CLARIFICATION-REQUESTED'')',
') loop',
'    return FALSE;',
'end loop;',
'',
'-- if project at 100%, nothing to approve',
'for c1 in (',
'    select 1 from sp_projects',
'     where id = :P3_PROJECT_ID',
'       and pct_complete = 100',
') loop',
'    return FALSE;',
'end loop;',
'',
'-- if all approvals already gotten, nothing to request',
'for c1 in (  ',
'   select 1',
'     from sp_initiative_approvals i',
'    where initiative_id = (select initiative_id from sp_projects where id = :P3_PROJECT_ID)',
'      and (initiative_id, approval_type_id) not in ',
'          (select initiative_id, approval_type_id',
'             from sp_project_approvals a,',
'                  sp_projects p',
'            where i.initiative_id = p.initiative_id',
'              and p.id = a.project_id ',
'              and a.project_id = :P3_PROJECT_ID',
'              and a.status = ''APPROVED'')',
') loop',
'   return TRUE;',
'end loop;',
'',
'return FALSE;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48805116007408715388)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(68015116027398133514)
,p_button_name=>'edit_description'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Edit'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP,32:P32_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51243453298683848194)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(51193797278043397052)
,p_button_name=>'add_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--padLeft:t-Button--gapTop'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Activity'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48999804251478585394)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(48999803752597585389)
,p_button_name=>'MORE-INFO-NOW'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Review'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:126:&SESSION.::&DEBUG.:126:P126_PROJECT_APPROVAL_CHAIN_ID,P126_APPROVAL_TYPE:&P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID.,&P3_MORE_INFO_APPROVAL_TYPE.'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47428147646146206175)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(42765984306883148784)
,p_button_name=>'REVIEW-NOW'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Review Now'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:125:P125_PROJECT_APPROVAL_CHAIN_ID,P125_APPROVAL_TYPE:&P3_PROJECT_APPROVAL_CHAIN_ID.,&P3_APPROVAL_TYPE.'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37614966854194937401)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37614963900058937372)
,p_button_name=>'add_review'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Review'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:509:&SESSION.::&DEBUG.:509:P509_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37614966934515937402)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37614965388362937387)
,p_button_name=>'add_milestone'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Milestone'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:508:&SESSION.::&DEBUG.:508:P508_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38145431178181166574)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(151399962886842022468)
,p_button_name=>'view_images'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Image Gallery'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:29:P29_PROJECT_ID:&P3_PROJECT_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from SP_PROJECT_DOCUMENTS d',
' where project_id = :P3_PROJECT_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )',
'union all',
'select 1 ',
'  from SP_task_DOCUMENTS d,',
'       sp_tasks t',
' where d.task_id = t.id',
'   and t.project_id = :P3_PROJECT_ID and ',
'       (',
'           lower(d.DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.ai'' ',
'       )'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53797036762540814994)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(53797036845315814995)
,p_button_name=>'add_task'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Task'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:501:P501_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(151399964428799022483)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(151399962886842022468)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Document'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RR,12:P12_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(69528577146771038733)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:&LAST_PROJECT_VIEW.:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722864329358623541)
,p_name=>'P3_IMAGE_REF_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(41271237794675114203)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(36932188108705386846)
,p_name=>'P3_INCLUDE_FUTURE'
,p_item_sequence=>23
,p_item_plug_id=>wwv_flow_imp.id(51243453029844848191)
,p_item_default=>'Y'
,p_prompt=>'Include Future'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-left-sm'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37713825402676667501)
,p_name=>'P3_RELATED_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(37713824072877667488)
,p_prompt=>'Related &NOMENCLATURE_PROJECT.'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select (select area from sp_areas f where f.id = i.area_id)||',
'       '' / ''||i.initiative ||',
'       '' / ''||p.project project, ',
'       p.id',
'from   sp_projects p,',
'       sp_initiatives i ',
'where  p.id != :P3_PROJECT_ID and',
'       p.id not in (',
'       select r.related_project_id ',
'       from   sp_project_related r ',
'       where  r.project_id = :P3_PROJECT_ID and r.related_project_id is not null) and',
'       p.initiative_id = i.id and  ',
'       p.ARCHIVED_YN = ''N''',
'order by 1'))
,p_cSize=>30
,p_grid_row_css_classes=>'u-align-items-center'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38090005904759244814)
,p_name=>'P3_CONTRIBUTOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38090003491716244790)
,p_item_default=>'APP_USER_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Add Contributor'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SP_TEAM_MEMBERS - CURRENT ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'where is_current_yn = ''Y''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- select &NOMENCLATURE_USER. -'
,p_cSize=>30
,p_grid_row_css_classes=>'u-align-items-center'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'Y',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '2')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38090006001172244815)
,p_name=>'P3_CONTRIBUTOR_ROLE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38090003491716244790)
,p_item_default=>'select max(id) from SP_RESOURCE_TYPES where IS_DEFAULT_YN = ''Y'''
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Role'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select RESOURCE_TYPE, id',
'from SP_RESOURCE_TYPES',
'order by 1'))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38623444363688817692)
,p_name=>'P3_INCLUDE_PAST'
,p_item_sequence=>33
,p_item_plug_id=>wwv_flow_imp.id(51243453029844848191)
,p_item_default=>'Y'
,p_prompt=>'Include Past'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-left-sm'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40397381375860203016)
,p_name=>'P3_PRIVATE_YN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(41271237794675114203)
,p_item_default=>'N'
,p_prompt=>'This is a private comment'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45694915678127981393)
,p_name=>'P3_PROJECT_APPROVAL_CHAIN_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(42765984306883148784)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46404488247015694986)
,p_name=>'P3_APPROVAL_TYPE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(42765984306883148784)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'S'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46901087933986793873)
,p_name=>'P3_PERMALINK_PREFIX'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48714899190453337690)
,p_name=>'P3_DUP_PROJECT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48714899580335337694)
,p_name=>'P3_DUP_PROJECT_ID'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48805114454023715372)
,p_name=>'FI'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_item_comment=>'friendly identifier'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48805114799725715376)
,p_name=>'PN'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48999803819456585390)
,p_name=>'P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(48999803752597585389)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48999804043430585392)
,p_name=>'P3_MORE_INFO_APPROVAL_TYPE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(48999803752597585389)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'S'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51594542208188377593)
,p_name=>'P3_LINK_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(151399961100667022450)
,p_prompt=>'Link Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68212663561189500504)
,p_name=>'P3_PROJECT_NAME'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68377262674985885737)
,p_name=>'P3_HAS_VOTED_CLASS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(69544560236991096275)
,p_name=>'P3_LINK'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(151399961100667022450)
,p_prompt=>'Link URL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'URL',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(148854287724640606385)
,p_name=>'P3_PROJECT_ID'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(43922886083314717052)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(151431003982219499539)
,p_name=>'P3_COMMENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(41271237794675114203)
,p_prompt=>' Comment'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(options) {',
'    return spCommentImageSupport.markdown.configEditor(options, {',
'        apexUpload: {',
'            // Application process name that that will handle the POST request when an image is dropped into',
'            // text box',
'            uploadApplicationProcess: ''POST_COMMENT_IMAGE'',',
'            // Pass in any data that you want in the POST process ',
'            // Will be passed in as a JSON object and available in apex_application.g_x01',
'            data: {',
'                imageRefId: apex.item(''P3_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function( options ) { return options; }',
'///* JS Init Function for Comments Rich Text Editor */',
'//function( options ) {',
'//    options.editorOptions.paste_data_images = false;',
'//    return options;',
'//}'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48805114494492715373)
,p_computation_sequence=>20
,p_computation_item=>'P3_PROJECT_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_util.get_project_id (',
'    p_friendly_identifier => :FI,',
'    p_project_url_name => :PN);'))
,p_compute_when=>'P3_PROJECT_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(68212663592878500505)
,p_computation_sequence=>40
,p_computation_item=>'P3_PROJECT_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select project from sp_projects where id = :P3_PROJECT_ID'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48714899312171337691)
,p_computation_sequence=>50
,p_computation_item=>'P3_DUP_PROJECT'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select (select b.project from sp_projects b where b.id = a.DUPLICATE_OF_PROJECT_ID) project',
'from sp_projects a',
'where a.id = :P3_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48714899763053337695)
,p_computation_sequence=>60
,p_computation_item=>'P3_DUP_PROJECT_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DUPLICATE_OF_PROJECT_ID',
'from sp_projects',
'where id = :P3_PROJECT_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(36966111867833502592)
,p_computation_sequence=>70
,p_computation_item=>'P3_INCLUDE_FUTURE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'Y'
,p_compute_when=>'P3_INCLUDE_FUTURE'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46901088078765793875)
,p_computation_sequence=>90
,p_computation_item=>'P3_PERMALINK_PREFIX'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>'return APEX_UTIL.HOST_URL(''SCRIPT'') || ''project-details?fi='';'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(45694915834758981394)
,p_computation_sequence=>100
,p_computation_item=>'P3_PROJECT_APPROVAL_CHAIN_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_approvals.approval_pending(',
'           p_project_id     => :P3_PROJECT_ID,',
'           p_team_member_id => :APP_USER_ID );'))
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48999803890310585391)
,p_computation_sequence=>110
,p_computation_item=>'P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_approvals.more_info_pending (',
'           p_project_id     => :P3_PROJECT_ID,',
'           p_team_member_id => :APP_USER_ID );'))
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46404488304868694987)
,p_computation_sequence=>120
,p_computation_item=>'P3_APPROVAL_TYPE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select approval_type   ',
'  from sp_approval_types',
' where id = (select approval_type_id',
'               from sp_project_approvals p,',
'                    sp_project_approval_chain c    ',
'              where p.id = c.project_approval_id   ',
'                and c.id = :P3_PROJECT_APPROVAL_CHAIN_ID)'))
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_compute_when=>'P3_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48999804118935585393)
,p_computation_sequence=>130
,p_computation_item=>'P3_MORE_INFO_APPROVAL_TYPE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select approval_type   ',
'  from sp_approval_types',
' where id = (select approval_type_id',
'               from sp_project_approvals p,',
'                    sp_project_approval_chain c    ',
'              where p.id = c.project_approval_id   ',
'                and c.id = :P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID)'))
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_compute_when=>'P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(151431004249972499541)
,p_name=>'Add Comment'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(151431004109472499540)
,p_condition_element=>'P3_COMMENT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(17885007967842678863)
,p_event_id=>wwv_flow_imp.id(151431004249972499541)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(151431004109472499540)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(151431004259120499542)
,p_event_id=>wwv_flow_imp.id(151431004249972499541)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'add comment and do alerts'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_project_comment (',
'    p_app_user_id   => :APP_USER_ID,',
'    p_app_user      => :APP_USER,',
'    p_comment       => :P3_COMMENT,',
'    p_project_id    => :P3_PROJECT_ID,',
'    p_private_yn    => nvl(:P3_PRIVATE_YN,''N''),',
'    p_app_id        => :APP_ID,',
'    p_permalink_pre => :P3_PERMALINK_PREFIX,',
'    p_nomen_sp      => :NOMENCLATURE_STRATEGIC_PLANNER,',
'    p_nomen_project => :NOMENCLATURE_PROJECT,',
'    p_image_ref_id  => :P3_IMAGE_REF_ID );',
'',
':P3_COMMENT      := null;',
':P3_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P3_COMMENT,P3_PRIVATE_YN,P3_PROJECT_ID,P3_PERMALINK_PREFIX,P3_IMAGE_REF_ID'
,p_attribute_03=>'P3_COMMENT,P3_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(151431004442033499543)
,p_event_id=>wwv_flow_imp.id(151431004249972499541)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(142860104311613242364)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44925161946205099314)
,p_event_id=>wwv_flow_imp.id(151431004249972499541)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_name=>'confirmation message'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(17885008063387678864)
,p_event_id=>wwv_flow_imp.id(151431004249972499541)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(151431004109472499540)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(151399962729195022466)
,p_name=>'rpt dialog close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(151399961100667022450)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(151399962792174022467)
,p_event_id=>wwv_flow_imp.id(151399962729195022466)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(151399961100667022450)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(151399964568585022485)
,p_name=>'doc refresh dialog close'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(151399962886842022468)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(151946405268341607736)
,p_event_id=>wwv_flow_imp.id(151399964568585022485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(151399962886842022468)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38252337919595094182)
,p_name=>'milestone refresh dialog close'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37614965388362937387)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38252338063509094183)
,p_event_id=>wwv_flow_imp.id(38252337919595094182)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37614965388362937387)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38252338106971094184)
,p_name=>'milestone reviews dialog close'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37614963900058937372)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38252338198400094185)
,p_event_id=>wwv_flow_imp.id(38252338106971094184)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37614963900058937372)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(69544560390015096277)
,p_name=>'add link'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(69544560328935096276)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51825529332453349277)
,p_event_id=>wwv_flow_imp.id(69544560390015096277)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please supply a Link URL and a Link Name.'
,p_attribute_02=>'Missing Link Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P3_LINK'') === '''' || $v(''P3_LINK_NAME'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(69544560479545096278)
,p_event_id=>wwv_flow_imp.id(69544560390015096277)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P3_LINK_NAME is not null and :P3_LINK is not null',
'then sp_util.add_project_link (',
'         p_project_id    => :P3_PROJECT_ID,',
'         p_link_name     => :P3_LINK_NAME,',
'         p_link_url      => :P3_LINK );',
'    :P3_LINK_NAME := null;',
'    :P3_LINK := null;',
'end if;'))
,p_attribute_02=>'P3_LINK_NAME,P3_LINK,P3_PROJECT_ID'
,p_attribute_03=>'P3_LINK,P3_LINK_NAME'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(69544560659103096279)
,p_event_id=>wwv_flow_imp.id(69544560390015096277)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(151399961100667022450)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44925162066993099316)
,p_event_id=>wwv_flow_imp.id(69544560390015096277)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Link Added Successfully");'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(69573635759361759598)
,p_name=>'doc refresh on dialog close'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(151399962886842022468)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(69573635856628759599)
,p_event_id=>wwv_flow_imp.id(69573635759361759598)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(151399962886842022468)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(36965646924809198708)
,p_name=>'comments refresh on dialog close'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(142860104311613242364)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(36965647043160198709)
,p_event_id=>wwv_flow_imp.id(36965646924809198708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(142860104311613242364)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41501764230442119091)
,p_name=>'add related'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37713825506482667502)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(42765985127952148792)
,p_event_id=>wwv_flow_imp.id(41501764230442119091)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please select a related &NOMENCLATURE_PROJECT..'
,p_attribute_02=>'Missing Related &NOMENCLATURE_PROJECT. Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P3_RELATED_PROJECT_ID'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501764290956119092)
,p_event_id=>wwv_flow_imp.id(41501764230442119091)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P3_RELATED_PROJECT_ID is not null then',
'    sp_util.add_related_project (',
'        p_related_project_id => :P3_RELATED_PROJECT_ID,',
'        p_project_id => :P3_PROJECT_ID );',
'end if;'))
,p_attribute_02=>'P3_RELATED_PROJECT_ID,P3_PROJECT_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_NULL'
,p_client_condition_element=>'P3_RELATED_PROJECT_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501765945936119108)
,p_event_id=>wwv_flow_imp.id(41501764230442119091)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_RELATED_PROJECT_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501764449350119093)
,p_event_id=>wwv_flow_imp.id(41501764230442119091)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37713824072877667488)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41501764685031119096)
,p_name=>'refresh related'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37713824072877667488)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501764793174119097)
,p_event_id=>wwv_flow_imp.id(41501764685031119096)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37713824072877667488)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(67214720961943729798)
,p_name=>'Remove Tag'
,p_event_sequence=>140
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.js-remove-tag'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(67214721062744729799)
,p_event_id=>wwv_flow_imp.id(67214720961943729798)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_TAG_TO_REMOVE'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'$(this.triggeringElement).data(''tag'');'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(67214721225825729801)
,p_event_id=>wwv_flow_imp.id(67214720961943729798)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.remove_project_tag (',
'    p_project_id => :P3_PROJECT_ID, ',
'    p_tag => :P3_TAG_TO_REMOVE);',
':P3_TAG_TO_REMOVE := null;'))
,p_attribute_02=>'P3_PROJECT_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51243453066932848192)
,p_name=>'show future activity da'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_INCLUDE_FUTURE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51243453567257848197)
,p_event_id=>wwv_flow_imp.id(51243453066932848192)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P3_INCLUDE_FUTURE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51243453208502848193)
,p_event_id=>wwv_flow_imp.id(51243453066932848192)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51243454752498848208)
,p_name=>'show activity on dc on add'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(51243453298683848194)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51243454765656848209)
,p_event_id=>wwv_flow_imp.id(51243454752498848208)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51243454945551848210)
,p_name=>'refresh description'
,p_event_sequence=>170
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48805116007408715388)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51243455020382848211)
,p_event_id=>wwv_flow_imp.id(51243454945551848210)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(50493824755486761115)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51243455244442848213)
,p_name=>'refresh activity rpt on dc'
,p_event_sequence=>180
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51243455287881848214)
,p_event_id=>wwv_flow_imp.id(51243455244442848213)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55010684793062779676)
,p_name=>'refresh tasks'
,p_event_sequence=>200
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(53797036845315814995)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55010684867367779677)
,p_event_id=>wwv_flow_imp.id(55010684793062779676)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(53797036845315814995)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38991624813125857780)
,p_name=>'show past activity'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_INCLUDE_PAST'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38991624929991857781)
,p_event_id=>wwv_flow_imp.id(38991624813125857780)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P3_INCLUDE_PAST,P3_INCLUDE_FUTURE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38991625056559857782)
,p_event_id=>wwv_flow_imp.id(38991624813125857780)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39007332690124180978)
,p_name=>'refresh on change project'
,p_event_sequence=>220
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(44787229438347731870)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39007332852288180979)
,p_event_id=>wwv_flow_imp.id(39007332690124180978)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(68377260482145885715)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48139342540755521277)
,p_name=>'refresh on review project'
,p_event_sequence=>230
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139342630351521278)
,p_event_id=>wwv_flow_imp.id(48139342540755521277)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39199491344407864102)
,p_name=>'on edit description dialog close'
,p_event_sequence=>240
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(68015116027398133514)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39199491438029864103)
,p_event_id=>wwv_flow_imp.id(39199491344407864102)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(68015116027398133514)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39281585699407394280)
,p_name=>'refresh on dialog closed bc'
,p_event_sequence=>250
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(43922886083314717052)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39281585852911394281)
,p_event_id=>wwv_flow_imp.id(39281585699407394280)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(43922886083314717052)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39768021089741113494)
,p_event_id=>wwv_flow_imp.id(39281585699407394280)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(68377260482145885715)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38090006223670244817)
,p_name=>'add contributor'
,p_event_sequence=>260
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38090006070089244816)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38090006329329244818)
,p_event_id=>wwv_flow_imp.id(38090006223670244817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'   c int := 0;',
'begin',
'   select count(*) into c from SP_PROJECT_CONTRIBUTORS where project_id = :P3_PROJECT_ID and TEAM_MEMBER_ID = :P3_CONTRIBUTOR;',
'   if c = 0 then ',
'      insert into SP_PROJECT_CONTRIBUTORS',
'      (PROJECT_ID, TEAM_MEMBER_ID, RESPONSIBILITY_ID)',
'      values',
'      (:P3_PROJECT_ID, :P3_CONTRIBUTOR, :P3_CONTRIBUTOR_ROLE);',
'   end if;',
'',
'   :P3_CONTRIBUTOR := null;',
'   for c1 in (select max(id) id from SP_RESOURCE_TYPES where IS_DEFAULT_YN = ''Y'') loop',
'       :P3_CONTRIBUTOR_ROLE := c1.id;',
'   end loop;',
'end;'))
,p_attribute_02=>'P3_PROJECT_ID,P3_CONTRIBUTOR,P3_CONTRIBUTOR_ROLE'
,p_attribute_03=>'P3_CONTRIBUTOR,P3_CONTRIBUTOR_ROLE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38090006443309244819)
,p_event_id=>wwv_flow_imp.id(38090006223670244817)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38090003604210244791)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(44925162251211099317)
,p_event_id=>wwv_flow_imp.id(38090006223670244817)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Contributor Added Successfully");'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37433448836847894400)
,p_name=>'refresh cont on dc'
,p_event_sequence=>270
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(38090003491716244790)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37433448902439894401)
,p_event_id=>wwv_flow_imp.id(37433448836847894400)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38090003604210244791)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48139342959321521281)
,p_name=>'refresh after review'
,p_event_sequence=>280
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(47428147646146206175)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139346073472521313)
,p_event_id=>wwv_flow_imp.id(48139342959321521281)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PROJECT_APPROVAL_CHAIN_ID'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_approvals.approval_pending(',
'           p_project_id     => :P3_PROJECT_ID,',
'           p_team_member_id => :APP_USER_ID );'))
,p_attribute_07=>'P3_PROJECT_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139343008879521282)
,p_event_id=>wwv_flow_imp.id(48139342959321521281)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(42765984306883148784)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139343070545521283)
,p_event_id=>wwv_flow_imp.id(48139342959321521281)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762296970297785587)
,p_event_id=>wwv_flow_imp.id(48139342959321521281)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(42765984306883148784)
,p_client_condition_type=>'NULL'
,p_client_condition_element=>'P3_PROJECT_APPROVAL_CHAIN_ID'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49762297145024785588)
,p_name=>'refresh after more info'
,p_event_sequence=>290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48999804251478585394)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762297220501785589)
,p_event_id=>wwv_flow_imp.id(49762297145024785588)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PROJECT_APPROVAL_CHAIN_ID,P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_approvals.more_info_pending (',
'           p_project_id     => :P3_PROJECT_ID,',
'           p_team_member_id => :APP_USER_ID );'))
,p_attribute_07=>'P3_PROJECT_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762297364629785590)
,p_event_id=>wwv_flow_imp.id(49762297145024785588)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48999803752597585389)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762297412298785591)
,p_event_id=>wwv_flow_imp.id(49762297145024785588)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762297504637785592)
,p_event_id=>wwv_flow_imp.id(49762297145024785588)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48999803752597585389)
,p_client_condition_type=>'NULL'
,p_client_condition_element=>'P3_MORE_INFO_PROJECT_APPROVAL_CHAIN_ID'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25423961185585543467)
,p_name=>'comment links in new tab'
,p_event_sequence=>300
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25423961379466543468)
,p_event_id=>wwv_flow_imp.id(25423961185585543467)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38335665084137853040)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P3_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1436307218735885271
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(36096049053692000060)
,p_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_position_id=>362316004162771045
,p_display_sequence=>30
,p_template_id=>362316605839802174
,p_label=>'Review'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:126:&SESSION.::&DEBUG.:126:P126_PROJECT_APPROVAL_CHAIN_ID,P126_APPROVAL_TYPE:&CLARIFICATION_ID.,&APPROVAL_TYPE.'
,p_button_display_type=>'TEXT'
,p_action_css_classes=>'w140'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>':STATUS_VALUE = ''CLARIFICATION-REQUESTED'' and :CLARIFICATION_ID is not null'
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40929883585908408866)
,p_region_id=>wwv_flow_imp.id(44787229438347731870)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:&P3_PROJECT_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(42368152957833953910)
,p_region_id=>wwv_flow_imp.id(51193797278043397052)
,p_position_id=>348722977165395441
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:RP,140:P140_ID:&ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(44787229738926731873)
,p_region_id=>wwv_flow_imp.id(44787229438347731870)
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
 p_id=>wwv_flow_imp.id(46511823965741831611)
,p_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362317865359806322
,p_label=>'Menu'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
,p_condition_type=>'NEVER'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(51193799436485397073)
,p_region_id=>wwv_flow_imp.id(51193797278043397052)
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
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(53717465813062256273)
,p_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362316605839802174
,p_label=>'Review'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:125:P125_PROJECT_APPROVAL_CHAIN_ID,P125_APPROVAL_TYPE:&P3_PROJECT_APPROVAL_CHAIN_ID.,&P3_APPROVAL_TYPE.'
,p_button_display_type=>'TEXT'
,p_action_css_classes=>'w140'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>':STATUS_VALUE in (''CLARIFICATION-REQUESTED'',''PENDING'') and :USER_HAS_PENDING_REVIEW is not null'
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(53717465954713256274)
,p_region_id=>wwv_flow_imp.id(46404489457287694998)
,p_position_id=>362316004162771045
,p_display_sequence=>40
,p_template_id=>362316605839802174
,p_label=>'View Details'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:125:P125_PROJECT_APPROVAL_ID:&ID.'
,p_button_display_type=>'TEXT'
,p_action_css_classes=>'w140'
,p_is_hot=>false
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>':STATUS_VALUE in (''APPROVED'',''REJECTED'',''WITHDRAWN'') or (:USER_HAS_PENDING_REVIEW is null and :CLARIFICATION_ID is null)'
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(28131762937067695129)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'AI Summaries'
,p_display_sequence=>140
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:26:&SESSION.::&DEBUG.:RP,26,RP:P26_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-ai-sparkle-generate-text'
,p_build_option_id=>wwv_flow_imp.id(27803842998100767814)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38028687408911872685)
,p_component_action_id=>wwv_flow_imp.id(51193799436485397073)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Activity Quick Look'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:RP,140:P140_ID:&ID.'
,p_icon_css_classes=>'fa-badge-check'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39281585975672394283)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Archive'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:47:&SESSION.::&DEBUG.:RP,47:P47_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-remove'
,p_condition_type=>'EXISTS'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ARCHIVED_YN ',
'  from sp_projects ',
' where id = :P3_PROJECT_ID',
'   and ARCHIVED_YN = ''N'''))
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39281586076120394284)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Mark as Duplicate'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:49:&SESSION.::&DEBUG.:RP,49:P49_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-file-text'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40645124758138771938)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>190
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RR,3:PN,FI:&PN.,&FI.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40714134854187388450)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>120
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:64:&SESSION.::&DEBUG.:RP,64:P64_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41400420647156484660)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>90
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42765984214869148783)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Exceptions'
,p_display_sequence=>130
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:93:&SESSION.::&DEBUG.:RP,93:P93_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-clipboard-x'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(44787230444833731880)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>180
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(44925162409852099319)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Copy'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:116:&SESSION.::&DEBUG.:RP,116:P116_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-copy'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(46709712011247593072)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Find Screen Names'
,p_display_sequence=>160
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:123:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-at'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(46709712086215593073)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>170
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(46709713824899593090)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Show Involved People'
,p_display_sequence=>110
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:96:&SESSION.::&DEBUG.:RP,96:P96_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-users-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(46709713926555593091)
,p_component_action_id=>wwv_flow_imp.id(44787229738926731873)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>150
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51193799498970397074)
,p_component_action_id=>wwv_flow_imp.id(51193799436485397073)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Activity'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52590896048783963386)
,p_component_action_id=>wwv_flow_imp.id(46511823965741831611)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Details'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:125:P125_PROJECT_APPROVAL_ID:&ID.'
,p_icon_css_classes=>'fa-clipboard-list'
);
wwv_flow_imp.component_end;
end;
/
