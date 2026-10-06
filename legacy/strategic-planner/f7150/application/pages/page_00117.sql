prompt --application/pages/page_00117
begin
--   Manifest
--     PAGE: 00117
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
 p_id=>117
,p_name=>'Release'
,p_alias=>'RELEASE2'
,p_step_title=>'Release &P117_RELEASE.'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.sp-tag {',
'    padding: 2px 4px;',
'    display: inline-block;',
'    vertical-align: text-bottom;',
'    border-radius: 3px;',
'    background-color: rgba(0,0,0,.1);',
'    text-overflow: ellipsis;',
'    white-space: nowrap;',
'}',
'.sp-tags-container {',
'    display: flex;',
'    align-items: center;',
'    flex-wrap: wrap;',
'    gap: 4px;',
'    justify-content: flex-start;',
'}',
'',
'.resize-region {',
'  resize: vertical;',
'  overflow: auto;',
'}',
'',
'.a-CardView-iconWrap,',
'.a-CardView-badge { align-self: flex-start; }',
'',
'.project-rds-region {',
'    background-color: rgb(219 204 175 / 20%);',
'}',
'.t-Body-title {',
'    --ut-palette-warning-shade: rgba(var(--oj-palette-neutral-rgb-160));',
'    --ut-component-background-color: rgba(var(--oj-palette-neutral-rgb-170)); ',
'    --ut-alert-horizontal-border-radius: 0;',
'}',
'',
'/* Percent Chart Styles */',
':root {',
'  --a-percent-chart-border-radius: 0.125rem;',
'  --a-percent-chart-bar-border-radius: 0.125rem;',
'  --a-percent-chart-bar-background-color: var(--rw-palette-slate-100);',
'  --ut-report-cell-hover-background-color: rgba(0, 0, 0, 0.025);',
'}',
'',
'/* Report Overrides */',
'.a-IRR-header {',
'  box-shadow: inset 0 -1px 0 var(--a-gv-header-cell-border-color);',
'}',
'',
'.t-Report {',
'  background-color: var(--rw-palette-neutral-0);',
'}',
'',
'.t-Report th {',
'  font-size: .6875rem;',
'}',
'',
'.t-Report th,',
'.t-Report td {',
'  border-inline-width: 0;',
'  transition: none;',
'}',
'',
'/* Group borders */',
'th#PCT_10,',
'td[headers="PCT_10"],',
'th#EFFORT_DAYS,',
'td[headers="EFFORT_DAYS"],',
'th#MOST_RECENT_COMMENT,',
'td[headers="MOST_RECENT_COMMENT"],',
'th#SPECS_COMPLETED,',
'td[headers="SPECS_COMPLETED"],',
'th#P1,',
'td[headers="P1"] {',
'  border-inline-start-width: 0.25rem;',
'}',
'',
'th#P1,',
'th#P2,',
'th#P3,',
'th#P4,',
'th#P5,',
'[headers="P1"],',
'[headers="P2"],',
'[headers="P3"],',
'[headers="P4"],',
'[headers="P5"] {',
'  background-color: var(--rw-palette-red-10);',
'}',
'',
'tr:hover th#P1,',
'tr:hover th#P2,',
'tr:hover th#P3,',
'tr:hover th#P4,',
'tr:hover th#P5,',
'tr:hover [headers="P1"],',
'tr:hover [headers="P2"],',
'tr:hover [headers="P3"],',
'tr:hover [headers="P4"],',
'tr:hover [headers="P5"] {',
'  background-color: var(--rw-palette-red-20);',
'}',
'',
'th#PCT_0,',
'th#PCT_10,',
'th#PCT_20,',
'th#PCT_30,',
'th#PCT_40,',
'th#PCT_50,',
'th#PCT_60,',
'th#PCT_70,',
'th#PCT_80,',
'th#PCT_90,',
'th#PCT_100,',
'th#PCT_COMPLETE,',
'[headers="PCT_0"],',
'[headers="PCT_10"],',
'[headers="PCT_20"],',
'[headers="PCT_30"],',
'[headers="PCT_40"],',
'[headers="PCT_50"],',
'[headers="PCT_60"],',
'[headers="PCT_70"],',
'[headers="PCT_80"],',
'[headers="PCT_90"],',
'[headers="PCT_100"],',
'[headers="PCT_COMPLETE"] {',
'  background-color: var(--rw-palette-green-10);',
'}',
'',
'tr:hover th#PCT_0,',
'tr:hover th#PCT_10,',
'tr:hover th#PCT_20,',
'tr:hover th#PCT_30,',
'tr:hover th#PCT_40,',
'tr:hover th#PCT_50,',
'tr:hover th#PCT_60,',
'tr:hover th#PCT_70,',
'tr:hover th#PCT_80,',
'tr:hover th#PCT_90,',
'tr:hover th#PCT_100,',
'tr:hover th#PCT_COMPLETE,',
'tr:hover [headers="PCT_0"],',
'tr:hover [headers="PCT_10"],',
'tr:hover [headers="PCT_20"],',
'tr:hover [headers="PCT_30"],',
'tr:hover [headers="PCT_40"],',
'tr:hover [headers="PCT_50"],',
'tr:hover [headers="PCT_60"],',
'tr:hover [headers="PCT_70"],',
'tr:hover [headers="PCT_80"],',
'tr:hover [headers="PCT_90"],',
'tr:hover [headers="PCT_100"],',
'tr:hover [headers="PCT_COMPLETE"] {',
'  background-color: var(--rw-palette-green-20);',
'}',
'',
'th#EFFORT_DAYS,',
'th#DAYS_COMPLETED,',
'th#DAYS_OUTSTANDING,',
'[headers="EFFORT_DAYS"],',
'[headers="DAYS_COMPLETED"],',
'[headers="DAYS_OUTSTANDING"] {',
'  background-color: var(--rw-palette-blue-10);',
'}',
'',
'tr:hover th#EFFORT_DAYS,',
'tr:hover th#DAYS_COMPLETED,',
'tr:hover th#DAYS_OUTSTANDING,',
'tr:hover [headers="EFFORT_DAYS"],',
'tr:hover [headers="DAYS_COMPLETED"],',
'tr:hover [headers="DAYS_OUTSTANDING"] {',
'  background-color: var(--rw-palette-blue-20);',
'}',
'',
'th#MOST_RECENT_COMMENT,',
'th#CURRENTLY_ACTIVE_PROJECTS,',
'[headers="MOST_RECENT_COMMENT"],',
'[headers="CURRENTLY_ACTIVE_PROJECTS"] {',
'  background-color: var(--rw-palette-plum-10);',
'}',
'',
'tr:hover th#MOST_RECENT_COMMENT,',
'tr:hover th#CURRENTLY_ACTIVE_PROJECTS,',
'tr:hover [headers="MOST_RECENT_COMMENT"],',
'tr:hover [headers="CURRENTLY_ACTIVE_PROJECTS"] {',
'  background-color: var(--rw-palette-plum-20);',
'}',
'',
'h3:first-of-type { margin-top: 0; }'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41597147690488379788)
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
 p_id=>wwv_flow_imp.id(41621599801777453074)
,p_plug_name=>'Links'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       RELEASE_ID,',
'       LINK_NAME,',
'       --LINK_URL,',
'       decode(greatest(length(l.link_url),80),80,',
'           l.link_url,',
'           substr(l.link_url,1,39)||''...''||substr(l.link_url,length(l.link_url)-39,39)',
'           ) link_url,',
'       decode(IMPORTANT_YN,''Y'',''Yes'',''N'',''No'',IMPORTANT_YN) IMPORTANT,',
'       CREATED,',
'       lower(CREATED_BY) created_by,',
'       UPDATED,',
'       UPDATED_BY',
'  from SP_RELEASE_LINKS l',
'where release_id = :P117_RELEASE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(41621599877628453075)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:38:&SESSION.::&DEBUG.:RP,38:P38_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>4722242012226485306
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621599991678453076)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600152383453077)
,p_db_column_name=>'RELEASE_ID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Release Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600256733453078)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_html_expression=>'<a href="#LINK_URL#" target="_blank">#LINK_NAME#</a>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600284324453079)
,p_db_column_name=>'LINK_URL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'URL'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600515190453081)
,p_db_column_name=>'CREATED'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600607348453082)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621600744007453083)
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
 p_id=>wwv_flow_imp.id(41621600862773453084)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594540392380377575)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(41623984163851499583)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'47246263'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK_NAME:LINK_URL:IMPORTANT:UPDATED:CREATED_BY:'
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
 p_id=>wwv_flow_imp.id(46075840318215616801)
,p_plug_name=>'Timeline'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49015132006556361191)
,p_plug_name=>'timeline buttons'
,p_parent_plug_id=>wwv_flow_imp.id(46075840318215616801)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>30
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49015132144728361192)
,p_plug_name=>'Timeline contents'
,p_parent_plug_id=>wwv_flow_imp.id(46075840318215616801)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>40
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_release_timeline.show_week (',
'    p_release_id          => :P117_RELEASE_ID,',
'    p_show_past_yn        => nvl(:P117_INCLUDE_PAST_YN,''N''),',
'    p_exclude_complete_yn => :P117_EXCLUDE_COMPLETE_YN',
'    );'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_translate_title=>'N'
,p_ajax_items_to_submit=>'P117_RELEASE_ID,P117_INCLUDE_PAST_YN,P117_EXCLUDE_COMPLETE_YN'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46264679718184155049)
,p_plug_name=>'&NOMENCLATURE_PROJECTS.'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.PROJECT,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       p.target_complete,',
'       (select decode(greatest(length(initiative),15),15,initiative,substr(initiative,1,12)||''...'') initiative ',
'        from sp_initiatives i ',
'        where i.id = p.initiative_id) initiative,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       (select focus_area from sp_initiative_focus_areas',
'         where id = p.focus_area_id) focus_area,',
'       case when p.requires_reviews_yn = ''Y'' then ''Yes'' else ''No'' end requires_reviews,',
'       case when p.doc_impact_yn = ''Y'' then ''Yes'' else ''No'' end doc_impact,',
'       p.UPDATED,',
'       p.owner_id,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(p.updated_by)),lower(p.updated_by)) updated_by,',
'       replace(lower(p.tags),'','','', '') as tags,',
'       --',
'       -- activities',
'       --',
'       (select count(*) from SP_ACTIVITIES a where a.project_id = p.id and sysdate between a.START_DATE and a.end_date) Current_activities,',
'       (select count(*) from SP_ACTIVITIES a where a.project_id = p.id) activities,',
'       -- completed milestones',
'       (select listagg(tt.task_type ||',
'                        case when instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') > 0',
'                             then '' ''||s.status||'' ''',
'                             when t.target_complete is null',
'                             then '' no date''',
'                             else '' targeted for ''',
'                             end || to_char(t.target_complete,''DD-MON'') ,'', '')',
'                        within group (order by t.target_complete nulls first, tt.display_seq)',
'          from sp_tasks t,',
'               sp_task_types tt,',
'               sp_task_statuses s',
'         where t.project_id = p.id',
'           and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'           and tt.static_id like ''MILESTONE%''',
'           and instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') > 0',
'           and t.status_id = s.id) completed_milestones,',
'       -- open milestones',
'       (select listagg(tt.task_type ||',
'                        case when t.target_complete is null',
'                             then '' no date''',
'                             else '' targeted for ''',
'                             end || to_char(t.target_complete,''DD-MON'') ,'', '')',
'                        within group (order by t.target_complete nulls first, tt.display_seq)',
'          from sp_tasks t,',
'               sp_task_types tt',
'         where t.project_id = p.id',
'           and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'           and tt.static_id like ''MILESTONE%''',
'           and instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') = 0) open_milestones,',
'       -- completed reviews',
'       (select listagg(tt.task_type ||',
'                        case when instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') > 0',
'                             then '' completed ''',
'                             when t.target_complete is null',
'                             then '' no date''',
'                             else '' targeted for ''',
'                             end || to_char(t.target_complete,''DD-MON'') ,'', '')',
'                        within group (order by t.target_complete nulls first, tt.display_seq)',
'          from sp_tasks t,',
'               sp_task_types tt',
'         where t.project_id = p.id',
'           and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'           and tt.static_id like ''REVIEW%''',
'           and instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') > 0) completed_reviews,',
'       -- open reviews',
'       (select listagg(tt.task_type ||',
'                        case when instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') > 0',
'                             then '' completed ''',
'                             when t.target_complete is null',
'                             then '' no date''',
'                             else '' targeted for ''',
'                             end || to_char(t.target_complete,''DD-MON'') ,'', '')',
'                        within group (order by t.target_complete nulls first, tt.display_seq)',
'          from sp_tasks t,',
'               sp_task_types tt',
'         where t.project_id = p.id',
'           and nvl(t.task_sub_type_id,t.task_type_id) = tt.id',
'           and tt.static_id like ''REVIEW%''',
'           and instr(:COMPLETE_TASK_STATUS_IDS,'':''||t.status_id||'':'') = 0) open_reviews,',
'       --',
'       -- description',
'       --',
'       decode(nvl(dbms_lob.getlength(p.description),0),0,''Not Provided'',',
'           dbms_lob.substr(p.description,300,1)||',
'           decode(greatest(dbms_lob.getlength(p.description),300),300,null,''...'')) description,',
'       --',
'       -- task_contributors',
'       --',
'       (select listagg(distinct tm.first_name||'' ''||tm.last_name,'', '')',
'                   within group (order by tm.first_name||'' ''||tm.last_name) name',
'          from sp_tasks t,',
'               SP_TEAM_MEMBERS tm ',
'         where tm.id = t.owner_id',
'           and t.project_id = p.id) task_contributors,',
'       --',
'       -- contributors',
'       --',
'       (select listagg(distinct tm.first_name||'' ''||tm.last_name,'', '')',
'                   within group (order by tm.first_name||'' ''||tm.last_name) name',
'          from sp_tasks t,',
'               SP_TEAM_MEMBERS tm ',
'         where tm.id = t.owner_id',
'           and t.project_id = p.id) contributors,',
'       --',
'       -- last comment',
'       --',
'       (select max(dbms_lob.substr(c.body_no_images,255,1)||',
'               decode(greatest(dbms_lob.getlength(c.body_no_images),255),255,null,''...'')) last_comment ',
'        from   SP_PROJECT_COMMENTS c ',
'        where c.project_id = p.id and ',
'              c.private_yn = ''N'' and ',
'              c.created = (select max(c2.created) from sp_project_comments c2 where c2.project_id = p.id and c2.private_yn = ''N''))',
'        as last_comment,',
'       (select first_name||'' ''||last_name ',
'        from SP_TEAM_MEMBERS t ',
'        where t.id = (select max(c.author_id) from sp_project_comments c where c.project_id = p.id and c.created = (select max(c.created) from sp_project_comments c where c.project_id = p.id and c.private_yn = ''N''))) last_comment_by,',
'       --',
'       (select max(c.created) from sp_project_comments c where c.project_id = p.id and c.private_yn = ''N'') last_comment_on,',
'       --',
'       nvl((select ''Yes'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''No'') favorite,',
'       nvl((select ''fa-heart u-danger-text'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''fa-heart-o'') favorite_icon,',
'       null actions',
' from  SP_PROJECTS p,',
'       sp_initiatives i,',
'       sp_project_scales s',
'where p.initiative_id = i.id and',
'      i.status_scale = s.scale_letter and',
'      nvl(p.ARCHIVED_YN,''N'') = ''N'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.release_id = :P117_RELEASE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
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
,p_plug_footer=>'Click &NOMENCLATURE_PROJECT. name for detail view.'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(46264681362209155065)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'No &NOMENCLATURE_PROJECTS. Found'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>9365323496807187296
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46264681371616155066)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46264681541288155067)
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
 p_id=>wwv_flow_imp.id(46296416789806532718)
,p_db_column_name=>'THE_OWNER'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Owner'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#OWNER_ID#'
,p_column_linktext=>'#THE_OWNER#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296416909783532719)
,p_db_column_name=>'PRIORITY'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296416990326532720)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52590898589582963412)
,p_db_column_name=>'STATUS'
,p_display_order=>60
,p_column_identifier=>'BK'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417117425532721)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417223999532722)
,p_db_column_name=>'RELEASE'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417304554532723)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417445184532724)
,p_db_column_name=>'UPDATED'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417573829532726)
,p_db_column_name=>'OWNER_ID'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Owner Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417761044532727)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296417855046532728)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46296418022923532730)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597149369247379805)
,p_db_column_name=>'CURRENT_ACTIVITIES'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Current Activities'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597149610628379807)
,p_db_column_name=>'ACTIVITIES'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Activities'
,p_column_link=>'f?p=&APP_ID.:130:&SESSION.::&DEBUG.:RP,130:P130_PROJECT_ID:#ID#'
,p_column_linktext=>'#ACTIVITIES#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41628123400905336370)
,p_db_column_name=>'FAVORITE'
,p_display_order=>180
,p_column_identifier=>'AE'
,p_column_label=>'Favorite'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41628123522916336371)
,p_db_column_name=>'FAVORITE_ICON'
,p_display_order=>190
,p_column_identifier=>'AF'
,p_column_label=>'Favorite Icon'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41628126359972336399)
,p_db_column_name=>'ACTIONS'
,p_display_order=>200
,p_column_identifier=>'AG'
,p_column_label=>'Quick Look'
,p_column_link=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:#ID#'
,p_column_linktext=>'<span class="fa fa-align-justify" aria-hidden="true"></span>'
,p_column_link_attr=>'title="&NOMENCLATURE_PROJECT. Quick Look"'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42387622249299847218)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>210
,p_column_identifier=>'AT'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45300840291395285807)
,p_db_column_name=>'LAST_COMMENT'
,p_display_order=>220
,p_column_identifier=>'AV'
,p_column_label=>'Last Comment'
,p_column_html_expression=>'#LAST_COMMENT# - #LAST_COMMENT_BY# - #LAST_COMMENT_ON#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45300840428044285808)
,p_db_column_name=>'LAST_COMMENT_ON'
,p_display_order=>230
,p_column_identifier=>'AW'
,p_column_label=>'Last Comment On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45300840519334285809)
,p_db_column_name=>'LAST_COMMENT_BY'
,p_display_order=>240
,p_column_identifier=>'AX'
,p_column_label=>'Last Comment By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45300840673411285811)
,p_db_column_name=>'TAGS'
,p_display_order=>250
,p_column_identifier=>'AY'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165038357783981)
,p_db_column_name=>'REQUIRES_REVIEWS'
,p_display_order=>260
,p_column_identifier=>'AZ'
,p_column_label=>'Requires Reviews'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55451868244930187673)
,p_db_column_name=>'CONTRIBUTORS'
,p_display_order=>270
,p_column_identifier=>'BC'
,p_column_label=>'Contributors'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55451868297906187674)
,p_db_column_name=>'COMPLETED_MILESTONES'
,p_display_order=>280
,p_column_identifier=>'BD'
,p_column_label=>'Completed Milestones'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55451868446852187675)
,p_db_column_name=>'OPEN_MILESTONES'
,p_display_order=>290
,p_column_identifier=>'BE'
,p_column_label=>'Open Milestones'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614967669978937410)
,p_db_column_name=>'COMPLETED_REVIEWS'
,p_display_order=>300
,p_column_identifier=>'BF'
,p_column_label=>'Completed Reviews'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_required_patch=>wwv_flow_imp.id(40074095762229259811)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37614967828936937411)
,p_db_column_name=>'OPEN_REVIEWS'
,p_display_order=>310
,p_column_identifier=>'BG'
,p_column_label=>'Open Reviews'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_required_patch=>wwv_flow_imp.id(40074095762229259811)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252338546593094188)
,p_db_column_name=>'DOC_IMPACT'
,p_display_order=>320
,p_column_identifier=>'BH'
,p_column_label=>'Doc Impact'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40293448157215691778)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>330
,p_column_identifier=>'BI'
,p_column_label=>'Focus Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'EXISTS'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_initiative_focus_areas'))
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42933091462533680478)
,p_db_column_name=>'TASK_CONTRIBUTORS'
,p_display_order=>340
,p_column_identifier=>'BJ'
,p_column_label=>'Task Contributors'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(30944275725007136830)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>350
,p_column_identifier=>'BL'
,p_column_label=>'Target Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-Mon-RR'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(46296258829160177124)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'46976301'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:THE_OWNER:ACTIVITIES:PRIORITY:PROJECT_SIZE:TARGET_COMPLETE:PCT_COMPLETE:STATUS:OPEN_MILESTONES:OPEN_REVIEWS:CONTRIBUTORS:UPDATED:ACTIONS:'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'PCT_COMPLETE'
,p_sort_direction_2=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48020573912237669512)
,p_plug_name=>'Exceptions'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_release_trains',
' where id = :P117_RELEASE_ID',
'   and nvl(release_completed,''N'') = ''N'''))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49015131594930361187)
,p_plug_name=>'exception buttons'
,p_parent_plug_id=>wwv_flow_imp.id(48020573912237669512)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(53728659243476523541)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49015131709721361188)
,p_plug_name=>'Exceptions body'
,p_parent_plug_id=>wwv_flow_imp.id(48020573912237669512)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_release_timeline.release_exceptions (',
'    p_release_id              => :P117_RELEASE_ID,',
'    p_links                   => ''APP'',',
'    p_apex_session            => :APP_SESSION );'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53887118731445620272)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
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
 p_id=>wwv_flow_imp.id(57961272367074832206)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(53887118731445620272)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>30
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
 p_id=>wwv_flow_imp.id(57961273600580832218)
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
 p_id=>wwv_flow_imp.id(53888433030352211463)
,p_plug_name=>'Milestones'
,p_region_name=>'MILESTONES'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select m.ID,',
'       --',
'       -- milestone attributes',
'       --',
'       m.RELEASE_ID,',
'       (select milestone_type from sp_release_milestone_types where m.milestone_type_id = id) milestone_type,',
'       m.MILESTONE_NAME,',
'       m.UPPER_MILESTONE_NAME,',
'       m.milestone_start_date,',
'       m.MILESTONE_DATE,',
'       m.ORIGINAL_MILESTONE_DATE,',
'       decode(m.MILESTONE_COMPLETED_YN,''N'',''No'',''Y'',''Yes'') MILESTONE_COMPLETED_YN,',
'       m.MILESTONE_DESCRIPTION,',
'       m.tags,',
'       --',
'       -- milestones audit columns',
'       --',
'       m.CREATED,',
'       m.CREATED_BY,',
'       m.UPDATED,',
'       m.UPDATED_BY,',
'       --',
'       --',
'       --',
'       round(m.MILESTONE_DATE  - sysdate) days,',
'       --',
'       -- Milestone status based on milestone date',
'       --',
'       decode(',
'           greatest(round(m.MILESTONE_DATE  - sysdate),0),',
'           0,',
'           decode(m.MILESTONE_COMPLETED_YN,''Y'',''Completed'',''Past Due''),',
'           decode(m.MILESTONE_COMPLETED_YN,''Y'',''Completed'',''On Track'')',
'       ) status,',
'       --',
'       -- Days since release open',
'       --',
'       round(m.MILESTONE_DATE - (select r.RELEASE_OPEN_DATE from SP_RELEASE_TRAINS r where r.id = :P117_RELEASE_ID)) days_since_open,',
'       --',
'       -- Days remaining in the release',
'       --',
'       round( (select r.RELEASE_TARGET_DATE from SP_RELEASE_TRAINS r where r.id = :P117_RELEASE_ID)-  m.MILESTONE_DATE) days_until_release',
'  from SP_RELEASE_MILESTONES m',
'  where release_Id = :P117_RELEASE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Milestones'
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
 p_id=>wwv_flow_imp.id(53888433150434211463)
,p_name=>'Release Milestones'
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
,p_detail_link=>'f?p=&APP_ID.:92:&APP_SESSION.::&DEBUG.:RP:P92_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>16989075285032243694
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888433543907211465)
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
 p_id=>wwv_flow_imp.id(40972229437818736088)
,p_db_column_name=>'MILESTONE_TYPE'
,p_display_order=>10
,p_column_identifier=>'T'
,p_column_label=>'Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888434326896211467)
,p_db_column_name=>'MILESTONE_NAME'
,p_display_order=>20
,p_column_identifier=>'C'
,p_column_label=>'Milestone'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888434708332211468)
,p_db_column_name=>'UPPER_MILESTONE_NAME'
,p_display_order=>30
,p_column_identifier=>'D'
,p_column_label=>'Upper Milestone Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40972232496093736119)
,p_db_column_name=>'MILESTONE_START_DATE'
,p_display_order=>40
,p_column_identifier=>'U'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888435126520211468)
,p_db_column_name=>'MILESTONE_DATE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888435557440211469)
,p_db_column_name=>'ORIGINAL_MILESTONE_DATE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Original Milestone Date'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888435961502211469)
,p_db_column_name=>'MILESTONE_COMPLETED_YN'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Completed '
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888436306711211469)
,p_db_column_name=>'MILESTONE_DESCRIPTION'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888437121840211470)
,p_db_column_name=>'CREATED'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888437472701211470)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888437919881211471)
,p_db_column_name=>'UPDATED'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53888438356105211471)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53903269031135698083)
,p_db_column_name=>'RELEASE_ID'
,p_display_order=>130
,p_column_identifier=>'O'
,p_column_label=>'Release Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55193034036094854344)
,p_db_column_name=>'DAYS'
,p_display_order=>140
,p_column_identifier=>'P'
,p_column_label=>'Days'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55193034122349854345)
,p_db_column_name=>'STATUS'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55193035742970854361)
,p_db_column_name=>'DAYS_SINCE_OPEN'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Days Since Open'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55193035821516854362)
,p_db_column_name=>'DAYS_UNTIL_RELEASE'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Days Until Release'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(30944277526177136848)
,p_db_column_name=>'TAGS'
,p_display_order=>180
,p_column_identifier=>'V'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(53889068800652606280)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'122904977'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MILESTONE_TYPE:MILESTONE_NAME:MILESTONE_START_DATE:MILESTONE_DATE:DAYS:MILESTONE_COMPLETED_YN:STATUS:UPDATED:'
,p_sort_column_1=>'MILESTONE_DATE'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(43976830512332511341)
,p_report_id=>wwv_flow_imp.id(53889068800652606280)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'='
,p_expr=>'Past Due'
,p_condition_sql=>' (case when ("STATUS" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''Past Due''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#ffd6d2'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56482362084353629410)
,p_plug_name=>'Contributors'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select team_member_id,',
'       name,',
'       email,',
'       person_tags,',
'       is_contributor,',
'       has_tasks,',
'       has_milestones,',
'       has_reviews,',
'       project_activivity_contributor,',
'       project_owner_count,',
'       --',
'       -- photo',
'       --',
'       photo,',
'       photo_mimetype',
'from',
'(',
'select tm.id                             team_member_id,',
'       tm.first_name||'' ''||tm.last_name  name,',
'       tm.email                          email,',
'       tm.tags                           person_tags,',
'       --',
'       -- contributor',
'       --',
'       (select count(distinct p.id) ',
'        from  sp_project_contributors c,',
'              sp_projects p',
'        where c.PROJECT_ID = p.id and ',
'              c.team_member_id = tm.id and',
'              p.release_id = rt.ID and ',
'              p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and',
'              p.release_id = :P117_RELEASE_ID',
'       ) is_contributor,',
'       --',
'       -- has_tasks',
'       --',
'       (select count(distinct p.id) ',
'        from  SP_tasks pc, ',
'              sp_task_types tt,',
'              sp_projects p',
'        where pc.PROJECT_ID = p.id and ',
'              pc.owner_ID = tm.id and',
'              p.release_id = rt.ID and ',
'              p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and',
'              p.release_id = :P117_RELEASE_ID and',
'              nvl(pc.task_sub_type_id,pc.task_type_id) = tt.id and',
'              tt.static_id not like ''REVIEW%'' and',
'              tt.static_id not like ''MILESTONE%''',
'       ) has_tasks,',
'       --',
'       -- milestones',
'       --',
'       (select count(distinct p.id) ',
'        from  SP_tasks pc, ',
'              sp_task_types tt,',
'              sp_projects p',
'        where pc.PROJECT_ID = p.id and ',
'              pc.owner_ID = tm.id and',
'              p.release_id = rt.ID and ',
'              p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and',
'              p.release_id = :P117_RELEASE_ID and',
'              nvl(pc.task_sub_type_id,pc.task_type_id) = tt.id and',
'              tt.static_id like ''MILESTONE%''',
'       ) has_milestones,',
'       --',
'       -- reviewer',
'       --',
'       (select count(distinct p.id) ',
'        from  SP_tasks pc, ',
'              sp_task_types tt,',
'              sp_projects p',
'        where pc.PROJECT_ID = p.id and ',
'              pc.owner_ID = tm.id and',
'              p.release_id = rt.ID and ',
'              p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and',
'              p.release_id = :P117_RELEASE_ID and',
'              nvl(pc.task_sub_type_id,pc.task_type_id) = tt.id and',
'              tt.static_id like ''REVIEW%''',
'       ) has_reviews,',
'        --',
'        -- activity contributor',
'        --',
'        (select count(distinct p.id)',
'         from  SP_ACTIVITIES dap, ',
'               sp_projects p ',
'         where p.release_id = rt.id and',
'               p.ARCHIVED_YN = ''N'' and ',
'               p.DUPLICATE_OF_PROJECT_ID is null and ',
'               dap.project_id = p.id and',
'               dap.TEAM_MEMBER_ID = tm.id and',
'              p.release_id = :P117_RELEASE_ID ',
'               ) project_activivity_contributor,',
'        --',
'        -- project owner',
'        --',
'        (select count(*) ',
'         from sp_projects p ',
'         where p.release_id = rt.id and',
'               p.owner_id = tm.id and',
'               p.ARCHIVED_YN = ''N'' and ',
'               p.DUPLICATE_OF_PROJECT_ID is null and',
'               p.release_id = :P117_RELEASE_ID ',
'        ) project_owner_count,',
'        --',
'        -- team member photo',
'        --',
'        tm.photo,',
'        tm.photo_mimetype',
'  from SP_RELEASE_TRAINS rt,',
'       SP_TEAM_MEMBERS tm',
'where rt.id = :P117_RELEASE_ID and ',
'      --',
'      -- search',
'      --',
'      (:P117_CONTRIBUTOR_SEARCH is null or instr(upper(tm.first_name||'' ''||last_name||'' ''||email), upper(:P117_CONTRIBUTOR_SEARCH)) > 0)',
') x',
'where (',
'            has_tasks > 0 or ',
'            has_milestones > 0 or',
'            has_reviews > 0 or',
'            project_activivity_contributor > 0 or ',
'            project_owner_count > 0',
'       )'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_CONTENT_ROW'
,p_ajax_items_to_submit=>'P117_RELEASE_ID,P117_CONTRIBUTOR_SEARCH'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_plug_footer=>'<p>This list of contributors includes anyone who is identified as a &NOMENCLATURE_PROJECT. owner, contributor, reviewer, or who has activity logged against a &NOMENCLATURE_PROJECT. identified for this release.'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"PHOTO","filenameColumn":"PHOTO_MIMETYPE","mimeTypeColumn":"","lastUpdatedColumn":""}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'DESCRIPTION', '&NOMENCLATURE_PROJECT. Owner: <strong>&PROJECT_OWNER_COUNT.</strong>, Contributor: <strong>&IS_CONTRIBUTOR.</strong>, Milestones: <strong>&HAS_MILESTONES.</strong>, Reviews: <strong>&HAS_REVIEWS.</strong>, Tasks: <strong>&HAS_TASKS.</strong>, Activit'
||'y: <strong>&PROJECT_ACTIVIVITY_CONTRIBUTOR.</strong>',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'MISC', '&EMAIL.',
  'TITLE', '&NAME.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(37614967932559937412)
,p_name=>'HAS_REVIEWS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_REVIEWS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38104384719835281204)
,p_name=>'HAS_MILESTONES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_MILESTONES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38104384797032281205)
,p_name=>'IS_CONTRIBUTOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_CONTRIBUTOR'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606533430292739269)
,p_name=>'TEAM_MEMBER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEAM_MEMBER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606533590089739270)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606533640628739271)
,p_name=>'EMAIL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMAIL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606533767872739272)
,p_name=>'PERSON_TAGS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PERSON_TAGS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606534025124739275)
,p_name=>'PROJECT_ACTIVIVITY_CONTRIBUTOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_ACTIVIVITY_CONTRIBUTOR'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45606534195927739276)
,p_name=>'PROJECT_OWNER_COUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_OWNER_COUNT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45696105959582044681)
,p_name=>'PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45696106086227044682)
,p_name=>'PHOTO_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55451868687083187678)
,p_name=>'HAS_TASKS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_TASKS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61448501732573340600)
,p_plug_name=>'Reviewers'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id project_id,',
'       p.project,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       p.project_size,',
'       t.id team_member_id,',
'       t.first_name||'' ''||last_name reviewer,',
'       t.email reviewer_email,',
'       tt.task_type type,',
'       ts.status,',
'       r.impact,',
'       r.target_complete,',
'       r.tags review_tags,',
'       substr(r.description,1,255) comments,',
'       r.updated,',
'       p.FRIENDLY_IDENTIFIER,',
'       p.PROJECT_URL_NAME,',
'       null quick_view',
'  from SP_PROJECTS p,',
'       sp_tasks r,',
'       sp_task_types tt,',
'       sp_task_statuses ts,',
'       sp_team_members t',
'where p.id = r.project_id and',
'      t.id = r.owner_id and',
'      nvl(r.task_sub_type_id,r.task_type_id) = tt.id and',
'      tt.static_id like ''REVIEW%'' and',
'      r.status_id = ts.id and',
'      nvl(p.ARCHIVED_YN,''N'') = ''N'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.release_id = :P117_RELEASE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'reviews content'
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
,p_required_patch=>wwv_flow_imp.id(40074095762229259811)
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(61448501844674340601)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SBKENNED'
,p_internal_uid=>24549143979272372832
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165600271783987)
,p_db_column_name=>'REVIEWER'
,p_display_order=>10
,p_column_identifier=>'L'
,p_column_label=>'Reviewer'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:73:P73_TEAM_MEMBER_ID:#TEAM_MEMBER_ID#'
,p_column_linktext=>'#REVIEWER#'
,p_column_link_attr=>'title="Reviewer Details"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165702802783988)
,p_db_column_name=>'REVIEWER_EMAIL'
,p_display_order=>20
,p_column_identifier=>'M'
,p_column_label=>'Reviewer Email'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165197331783983)
,p_db_column_name=>'PROJECT'
,p_display_order=>30
,p_column_identifier=>'H'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_link_attr=>'title="&NOMENCLATURE_PROJECT. Details"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(61448502368161340606)
,p_db_column_name=>'TYPE'
,p_display_order=>40
,p_column_identifier=>'E'
,p_column_label=>'Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(61448502246036340605)
,p_db_column_name=>'STATUS'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(61448502502433340607)
,p_db_column_name=>'COMMENTS'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Comments'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165280255783984)
,p_db_column_name=>'PRIORITY'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165443623783985)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Pct Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165525955783986)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Project Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55451868588145187677)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>110
,p_column_identifier=>'T'
,p_column_label=>'Target Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(61448502005627340603)
,p_db_column_name=>'UPDATED'
,p_display_order=>120
,p_column_identifier=>'B'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165815736783989)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>130
,p_column_identifier=>'N'
,p_column_label=>'Project Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49248165900652783990)
,p_db_column_name=>'TEAM_MEMBER_ID'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Team Member'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49247648245802194492)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49247648328663194493)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49247648464236194494)
,p_db_column_name=>'QUICK_VIEW'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Quick View'
,p_column_link=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:#PROJECT_ID#'
,p_column_linktext=>'<span class="fa fa-bars" aria-hidden="true"></span>'
,p_column_link_attr=>'Quick View'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252339958309094202)
,p_db_column_name=>'IMPACT'
,p_display_order=>180
,p_column_identifier=>'U'
,p_column_label=>'Impact'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47782358375382251196)
,p_db_column_name=>'REVIEW_TAGS'
,p_display_order=>190
,p_column_identifier=>'W'
,p_column_label=>'Review Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(61681060179326191640)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'123483344'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REVIEWER:PROJECT:TYPE:STATUS:IMPACT:TARGET_COMPLETE:UPDATED:QUICK_VIEW'
,p_sort_column_1=>'REVIEWER'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'TYPE'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'STATUS'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(40106560276764947375)
,p_report_id=>wwv_flow_imp.id(61681060179326191640)
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
 p_id=>wwv_flow_imp.id(74136251618652525759)
,p_name=>'Release'
,p_template=>4072358936313175081
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody:t-Region-orderBy--end:margin-left-md'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked'
,p_display_point=>'REGION_POSITION_01'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       r.RELEASE_TRAIN||'' ''||r.RELEASE release,',
'       decode(r.RELEASE_TARGET_DATE,null,    ''No Date'',to_char(r.RELEASE_TARGET_DATE,   ''DD-MON-YY'')) RELEASE_TARGET_DATE,',
'       decode(r.RELEASE_OPEN_DATE,null,      ''No Date'',to_char(r.RELEASE_OPEN_DATE,     ''DD-MON-YY'')) RELEASE_OPEN_DATE,',
'       greatest(round(r.RELEASE_TARGET_DATE - sysdate),0) days_remaining,',
'       --',
'       -- projects',
'       --',
'       (select count(*) ',
'       from sp_projects p ',
'       where p.release_id = r.id and ',
'             p.ARCHIVED_YN = ''N'' and ',
'             p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       --',
'       --',
'       round(r.RELEASE_TARGET_DATE - r.RELEASE_OPEN_DATE) release_length,',
'       --',
'       -- owner',
'       --',
'       t.first_name||'' ''||t.last_name owner,',
'       --',
'       -- release open and close',
'       --',
'       decode(r.RELEASE_OPEN_COMPLETED,''Y'',''Yes'',''N'',''No'',''Unknown'') release_opened,',
'       decode(r.RELEASE_COMPLETED,''Y'',''Yes'',''N'',''No'',''Unknown'') release_completed',
'  from SP_RELEASE_TRAINS r,',
'       SP_TEAM_MEMBERS t',
' where r.id = :P117_RELEASE_ID and ',
'       r.RELEASE_OWNER_ID = t.id(+)'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(41597266532669471276)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597266917085471277)
,p_query_column_id=>2
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597264078838471272)
,p_query_column_id=>3
,p_column_alias=>'RELEASE_TARGET_DATE'
,p_column_display_sequence=>70
,p_column_heading=>'Target Complete'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597264921446471274)
,p_query_column_id=>4
,p_column_alias=>'RELEASE_OPEN_DATE'
,p_column_display_sequence=>60
,p_column_heading=>'Open'
,p_column_format=>'DD-MON-YY'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597267275748471278)
,p_query_column_id=>5
,p_column_alias=>'DAYS_REMAINING'
,p_column_display_sequence=>90
,p_column_heading=>'Remaining'
,p_column_format=>'99999'
,p_column_html_expression=>'#DAYS_REMAINING# days'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597265337628471274)
,p_query_column_id=>6
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>100
,p_column_heading=>'&NOMENCLATURE_PROJECTS.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597265750606471275)
,p_query_column_id=>7
,p_column_alias=>'RELEASE_LENGTH'
,p_column_display_sequence=>80
,p_column_heading=>'Length'
,p_column_html_expression=>'#RELEASE_LENGTH# days'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597267722673471278)
,p_query_column_id=>8
,p_column_alias=>'OWNER'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49247648154068194491)
,p_query_column_id=>9
,p_column_alias=>'RELEASE_OPENED'
,p_column_display_sequence=>160
,p_column_heading=>'Release Opened'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49247648010833194490)
,p_query_column_id=>10
,p_column_alias=>'RELEASE_COMPLETED'
,p_column_display_sequence=>150
,p_column_heading=>'Release Completed'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(155647751022702851590)
,p_name=>'Comments'
,p_region_name=>'COMMENTS'
,p_template=>4501440665235496320
,p_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rc.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       to_char(rc.created,''fmDay, fmDD fmMonth, YYYY'') date_full,',
'       null comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       rc.body_html comment_text,',
'       case when lower(rc.created_by) = lower(:app_user)',
'            then ''<a href="''||apex_util.prepare_URL(',
'                              p_url => ''f?p=''||:APP_ID||'':83:''||:APP_SESSION||''::NO::P83_ID:''||rc.id,',
'                              p_checksum_type => ''3'')||''">edit</a>''',
'            end actions,',
'       decode(rc.private_yn,null,null,''N'',null,''Y'','' Private Comment'') private_comment_label,',
'       '' '' attribute_1,',
'       '' '' attribute_2,',
'       '' '' attribute_3,',
'       '' '' attribute_4,',
'       ''u-color-''||ora_hash(rc.created_by,45) icon_modifier,',
'',
'       -- Data Columns',
'       rc.BODY,',
'       rc.BODY_HTML,',
'       rc.AUTHOR_ID,',
'       --',
'       rc.CREATED,',
'       rc.CREATED_BY,',
'       rc.UPDATED,',
'       rc.UPDATED_BY,',
'       tm.id team_member_id',
'  from sp_release_comments_v rc, ',
'       sp_team_members tm',
'where rc.author_id = tm.id and',
'      rc.release_id = :P117_RELEASE_ID and',
'      (nvl(rc.private_yn,''N'') = ''N'' or lower(rc.created_by) = lower(:app_user) )',
'order by rc.created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(41597539805082160788)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597532634538160780)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178319129985483258)
,p_query_column_id=>3
,p_column_alias=>'DATE_FULL'
,p_column_display_sequence=>270
,p_column_heading=>'Date Full'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597532982775160781)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_column_html_expression=>'<span title="added #DATE_FULL#">#CREATED#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597533396691160782)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597533775060160782)
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
 p_id=>wwv_flow_imp.id(41597534230003160783)
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
 p_id=>wwv_flow_imp.id(50330188565019852616)
,p_query_column_id=>8
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>260
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597534593578160783)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597535037107160783)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597535425854160784)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597535861430160784)
,p_query_column_id=>12
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597536230712160784)
,p_query_column_id=>13
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597536609416160785)
,p_query_column_id=>14
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597536991359160785)
,p_query_column_id=>15
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597537398036160785)
,p_query_column_id=>16
,p_column_alias=>'AUTHOR_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Author Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597537781735160786)
,p_query_column_id=>17
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597538217542160786)
,p_query_column_id=>18
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597538605031160786)
,p_query_column_id=>19
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597538982203160787)
,p_query_column_id=>20
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41597539463239160787)
,p_query_column_id=>21
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53205376165132421194)
,p_plug_name=>'Add Comment'
,p_parent_plug_id=>wwv_flow_imp.id(155647751022702851590)
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>40
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(183469377721151756702)
,p_plug_name=>'Documents'
,p_region_name=>'DOCUMENTS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.ID,',
'       d.DOCUMENT_FILENAME,',
'       d.UPDATED,',
'       d.created,',
'       case when length(d.doc_description) > 200',
'            then substr(d.doc_description,1,200)||''...''',
'            else d.doc_description',
'            end doc_description,',
'       d.tags,',
'       lower(created_by) created_by,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) doc_size,',
'       created date_created,',
'       substr(DOCUMENT_FILENAME,instr(DOCUMENT_FILENAME,''.'',-1)+1,length(DOCUMENT_FILENAME)-instr(DOCUMENT_FILENAME,''.'',-1)) file_extension,',
'       decode(important_yn,''Y'',''Yes'',''No'') important,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) document',
'  from SP_RELEASE_DOCUMENTS d',
' where release_id = :P117_RELEASE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P117_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(69777991532817052026)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:120:&SESSION.::&DEBUG.:120:P120_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>32878633667415084257
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69777991633981052027)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69777991766372052028)
,p_db_column_name=>'DOCUMENT_FILENAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Filename'
,p_column_link=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:42:P42_ID,P42_PREV_PAGE:#ID#,117'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69777992191173052032)
,p_db_column_name=>'DOC_DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69777992396702052034)
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
 p_id=>wwv_flow_imp.id(69777991943336052030)
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
 p_id=>wwv_flow_imp.id(69777992019179052031)
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
 p_id=>wwv_flow_imp.id(69777992413740052035)
,p_db_column_name=>'DATE_CREATED'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Created On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(70214846604485900814)
,p_db_column_name=>'FILE_EXTENSION'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'File Extension'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80874530308426449617)
,p_db_column_name=>'TAGS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(67861026320685782061)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52935081035724546776)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(30944275664806136829)
,p_db_column_name=>'DOCUMENT'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Document'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DOWNLOAD:SP_RELEASE_DOCUMENTS:DOCUMENT_BLOB:ID::DOCUMENT_MIMETYPE:DOCUMENT_FILENAME:DOCUMENT_LASTUPD:DOCUMENT_CHARSET:attachment:Download:'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(69779727767620644797)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8109551'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DOCUMENT_FILENAME:DOC_DESCRIPTION:CREATED_BY:IMPORTANT:DOCUMENT:DOC_SIZE:UPDATED:'
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
 p_id=>wwv_flow_imp.id(45628234073138527480)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56482362084353629410)
,p_button_name=>'contributor_search_button'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41621601150607453087)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(41621599801777453074)
,p_button_name=>'add_link'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Link'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41597540199189160788)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(53205376165132421194)
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
 p_id=>wwv_flow_imp.id(48401068364088018670)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(49015131594930361187)
,p_button_name=>'SUBSCRIBE_TO_EXCEPTIONS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Subscribe me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''RELEASE_EXCEPTIONS''',
'   and is_active_yn = ''Y''',
'   and not exists (select 1',
'                     from sp_notification_subscriptions',
'                    where team_member_id = :APP_USER_ID',
'                      and notification_id = n.id',
'                      and release_id = :P117_RELEASE_ID',
'                      and opted_in_yn = ''Y'')',
'   and :APP_USER_ID is not null'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50330188844090852619)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(49015132006556361191)
,p_button_name=>'INCLUDE_PAST'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Include Past'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.::P117_INCLUDE_PAST_YN:Y'
,p_button_condition=>'P117_INCLUDE_PAST_YN'
,p_button_condition2=>'N'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49015131812371361189)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(49015131594930361187)
,p_button_name=>'UNSUBSCRIBE_EXCEPTIONS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Unsubscribe'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''RELEASE_EXCEPTIONS''',
'   and is_active_yn = ''Y''',
'   and :APP_USER_ID is not null',
'   and exists (select 1',
'                 from sp_notification_subscriptions',
'                where team_member_id = :APP_USER_ID',
'                  and notification_id = n.id',
'                  and release_id = :P117_RELEASE_ID',
'                  and opted_in_yn = ''Y'')'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51594540037959377571)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(49015132006556361191)
,p_button_name=>'EXCLUDE_PAST'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Exclude Past'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.::P117_INCLUDE_PAST_YN:N'
,p_button_condition=>'P117_INCLUDE_PAST_YN'
,p_button_condition2=>'Y'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48020573989628669513)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(49015131594930361187)
,p_button_name=>'EMAIL_EXCEPTIONS_TO_ME'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Email to me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50330185352827852584)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(49015132006556361191)
,p_button_name=>'INCLUDE_COMPLETED'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Include Completed'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.::P117_EXCLUDE_COMPLETE_YN:N'
,p_button_condition=>'P117_EXCLUDE_COMPLETE_YN'
,p_button_condition2=>'Y'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50330185192882852583)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(49015132006556361191)
,p_button_name=>'EXCLUDE_COMPLETED'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Exclude Completed'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.::P117_EXCLUDE_COMPLETE_YN:Y'
,p_button_condition=>'nvl(:P117_EXCLUDE_COMPLETE_YN,''N'') = ''N'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48208268242234975268)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(49015132006556361191)
,p_button_name=>'EMAIL_TO_ME'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Email to me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_required_patch=>wwv_flow_imp.id(53728659243476523541)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40972228295952736077)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(53888433030352211463)
,p_button_name=>'Calendar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Calendar View'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:203:P203_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-calendar-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41597148809245379799)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46264679718184155049)
,p_button_name=>'add_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add &NOMENCLATURE_PROJECT.'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:104:&SESSION.::&DEBUG.:RP,104,24:P104_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46901091427356793908)
,p_button_sequence=>10
,p_button_name=>'view_all_bugs'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View All'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RR,4,CIR,RIR::'
,p_icon_css_classes=>'fa-bug'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52934855427407400526)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(183469377721151756702)
,p_button_name=>'view_images'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Image Gallery'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:69:&SESSION.::&DEBUG.:69:P69_RELEASE_ID:&P117_RELEASE_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from SP_RELEASE_DOCUMENTS d',
' where release_id = :P117_RELEASE_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41597148708212379798)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(53888433030352211463)
,p_button_name=>'add_milestone'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Milestone'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:85:&SESSION.::&DEBUG.:RP,85:P85_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52934855797249400526)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(183469377721151756702)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Document'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:120:&SESSION.::&DEBUG.:RR,120:P120_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41597249286506469838)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(53887118731445620272)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722866371734623561)
,p_name=>'P117_IMAGE_REF_ID'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(53205376165132421194)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41597147305427379784)
,p_name=>'P117_RELEASE'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41597147440243379785)
,p_name=>'P117_RELEASE_ID'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41621601036305453086)
,p_name=>'P117_LINK'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(41621599801777453074)
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
 p_id=>wwv_flow_imp.id(41621601437436453090)
,p_name=>'P117_LINK_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(41621599801777453074)
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
 p_id=>wwv_flow_imp.id(45628234064054527479)
,p_name=>'P117_CONTRIBUTOR_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56482362084353629410)
,p_prompt=>'Search'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50330184808304852579)
,p_name=>'P117_EXCLUDE_COMPLETE_YN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(46075840318215616801)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51246081221341254471)
,p_name=>'P117_PRIVATE_YN'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(53205376165132421194)
,p_item_default=>'N'
,p_prompt=>'This is a private comment'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51594539919447377570)
,p_name=>'P117_INCLUDE_PAST_YN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(46075840318215616801)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(164218669452283108808)
,p_name=>'P117_COMMENT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(53205376165132421194)
,p_prompt=>' '
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
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
'                imageRefId: apex.item(''P117_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41597147477173379786)
,p_computation_sequence=>10
,p_computation_item=>'P117_RELEASE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select release_train||'' ''||release d from sp_release_trains where id = :P117_RELEASE_ID'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(50330187469118852606)
,p_computation_sequence=>20
,p_computation_item=>'P117_EXCLUDE_COMPLETE_YN'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P117_EXCLUDE_COMPLETE_YN'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(51594540156503377572)
,p_computation_sequence=>30
,p_computation_item=>'P117_INCLUDE_PAST_YN'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P117_INCLUDE_PAST_YN'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41597148049302379791)
,p_name=>'post comment'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41597540199189160788)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722866409367623562)
,p_event_id=>wwv_flow_imp.id(41597148049302379791)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(41597540199189160788)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41597148090996379792)
,p_event_id=>wwv_flow_imp.id(41597148049302379791)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'post comment on server'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_release_comment (',
'    p_app_user_id     => :APP_USER_ID,',
'    p_comment         => :P117_COMMENT,',
'    p_release_id      => :P117_RELEASE_ID,',
'    p_private_yn      => :P117_PRIVATE_YN,',
'    p_image_ref_id    => :P117_IMAGE_REF_ID );',
'',
':P117_COMMENT      := null;',
':P117_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P117_COMMENT,P117_RELEASE_ID,P117_PRIVATE_YN,P117_IMAGE_REF_ID'
,p_attribute_03=>'P117_COMMENT,P117_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41597148263694379793)
,p_event_id=>wwv_flow_imp.id(41597148049302379791)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155647751022702851590)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722866665513623564)
,p_event_id=>wwv_flow_imp.id(41597148049302379791)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722866580374623563)
,p_event_id=>wwv_flow_imp.id(41597148049302379791)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(41597540199189160788)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41597148325145379794)
,p_name=>'reload comments on dialog close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(155647751022702851590)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41597148435265379795)
,p_event_id=>wwv_flow_imp.id(41597148325145379794)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155647751022702851590)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51594540481148377576)
,p_name=>'reload links on dialog close'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(41621599801777453074)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51594540651755377577)
,p_event_id=>wwv_flow_imp.id(51594540481148377576)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(41621599801777453074)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51825533085545349315)
,p_name=>'reload documents'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(183469377721151756702)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51825533186319349316)
,p_event_id=>wwv_flow_imp.id(51825533085545349315)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(183469377721151756702)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41597149060286379801)
,p_name=>'refresh milestones on dc'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(53888433030352211463)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41597149079678379802)
,p_event_id=>wwv_flow_imp.id(41597149060286379801)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(53888433030352211463)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41597149227604379803)
,p_name=>'refresh projects on dc'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(46264679718184155049)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41597149314315379804)
,p_event_id=>wwv_flow_imp.id(41597149227604379803)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46264679718184155049)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41621601257421453088)
,p_name=>'on add link click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41621601150607453087)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51825529395768349278)
,p_event_id=>wwv_flow_imp.id(41621601257421453088)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please supply a Link URL and a Link Name.'
,p_attribute_02=>'Missing Link Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P117_LINK'') === '''' || $v(''P117_LINK_NAME'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41621601323851453089)
,p_event_id=>wwv_flow_imp.id(41621601257421453088)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P117_LINK_NAME is not null and :P117_LINK is not null then',
'    insert into SP_RELEASE_LINKS (release_id, link_name, link_url) ',
'        values (:P117_RELEASE_ID, :P117_LINK_NAME, :P117_LINK);',
':P117_LINK_NAME := null;',
':P117_LINK := null;',
'end if;'))
,p_attribute_02=>'P117_LINK_NAME,P117_LINK,P117_RELEASE_ID'
,p_attribute_03=>'P117_LINK,P117_LINK_NAME'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41621601469296453091)
,p_event_id=>wwv_flow_imp.id(41621601257421453088)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(41621599801777453074)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(45628234193859527481)
,p_name=>'on cont button click'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(45628234073138527480)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(45628234347065527482)
,p_event_id=>wwv_flow_imp.id(45628234193859527481)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P117_CONTRIBUTOR_SEARCH'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(45628234427954527483)
,p_event_id=>wwv_flow_imp.id(45628234193859527481)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56482362084353629410)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48020574218814669515)
,p_name=>'after release edit'
,p_event_sequence=>110
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(53887118731445620272)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48020574265438669516)
,p_event_id=>wwv_flow_imp.id(48020574218814669515)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'refresh Release'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(74136251618652525759)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48020574504984669518)
,p_event_id=>wwv_flow_imp.id(48020574218814669515)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'refresh Exceptions'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48020573912237669512)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48401070928259018696)
,p_event_id=>wwv_flow_imp.id(48020574218814669515)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'refresh Timeline'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46075840318215616801)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27117239823158764631)
,p_name=>'links in comments in new tab'
,p_event_sequence=>120
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27117239894697764632)
,p_event_id=>wwv_flow_imp.id(27117239823158764631)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48208271514960977034)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email timeline to me'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary      clob;',
'begin',
'',
'    l_summary := sp_release_timeline.show_week (',
'                     p_release_id          => :P117_RELEASE_ID,',
'                     p_exclude_complete_yn => nvl(:P117_EXCLUDE_COMPLETE_YN,''N''));',
'',
'    apex_mail.send ( ',
'            p_to                 => :APP_USER,   ',
'            p_from               => :APP_USER,  ',
'            p_application_id     => :APP_ID,  ',
'            p_template_static_id => ''EMAIL_ME'',  ',
'            p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                           ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                           ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER || '' '' || :P117_RELEASE ||'' Release Timeline'' ) ||'', ''||',
'                                           ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                     ''}'' ); ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48208268242234975268)
,p_process_success_message=>'Timeline email sent.'
,p_internal_uid=>11308913649559009265
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48020574163504669514)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email exceptions to me'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary      clob;',
'begin',
'',
'    l_summary := sp_release_timeline.release_exceptions (',
'                     p_release_id              => :P117_RELEASE_ID,',
'                     p_links                   => ''EMAIL'' );',
'',
'    apex_mail.send ( ',
'            p_to                 => :APP_USER,   ',
'            p_from               => :APP_USER,  ',
'            p_application_id     => :APP_ID,  ',
'            p_template_static_id => ''EMAIL_ME'',  ',
'            p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                           ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                           ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER || '' '' || :P117_RELEASE ||'' Release Exceptions'' ) ||'', ''||',
'                                           ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                     ''}'' ); ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48020573989628669513)
,p_process_success_message=>'Release Exceptions email sent.'
,p_internal_uid=>11121216298102701745
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48401068436032018671)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Subscribe to Exceptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''RELEASE_EXCEPTIONS''),',
'    p_release_id      => :P117_RELEASE_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48401068364088018670)
,p_process_success_message=>'Subscribed to Release Exceptions.'
,p_internal_uid=>11501710570630050902
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(49015131918341361190)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unsubscribe Exceptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_out (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''RELEASE_EXCEPTIONS''),',
'    p_release_id      => :P117_RELEASE_ID );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(49015131812371361189)
,p_process_success_message=>'Unsubscribed from Release Exceptions.'
,p_internal_uid=>12115774052939393421
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(42375736253727215414)
,p_region_id=>wwv_flow_imp.id(57961272367074832206)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:27:P27_ID:&P117_RELEASE_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(45606534740066739282)
,p_region_id=>wwv_flow_imp.id(56482362084353629410)
,p_position_id=>wwv_flow_imp.id(45454619629473400040)
,p_display_sequence=>10
,p_template_id=>wwv_flow_imp.id(45454621490670435317)
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(57961272667653832209)
,p_region_id=>wwv_flow_imp.id(57961272367074832206)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(29014889694088880760)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'AI Summaries'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:165:&SESSION.::&DEBUG.:RP,165:P165_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-ai-sparkle-generate-text'
,p_build_option_id=>wwv_flow_imp.id(30769244999117825609)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41725546053837004284)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Delete Release'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:76:&SESSION.::&DEBUG.:RP,76:P76_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-trash-o'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45606534951416739284)
,p_component_action_id=>wwv_flow_imp.id(45606534740066739282)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_USER. Details'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_ID:&TEAM_MEMBER_ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45606535115771739285)
,p_component_action_id=>wwv_flow_imp.id(45606534740066739282)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_USER. Quick Look'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:&TEAM_MEMBER_ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(49762296834965785585)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Copy Release'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.:RP,63:P63_COPY_FROM_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-copy'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382009760883366499)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Calendar'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:RP,203:P203_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-calendar-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382009912355366501)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:RP,14:P14_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382010016083366502)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Dashboard'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:202:&SESSION.::&DEBUG.:RP,202:P202_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-area-chart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382010765750366510)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>70
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51825528894147349273)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Search'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:RP,300,CIR,RIR:P300_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(57961272747313832210)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>110
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(57961273373560832216)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>120
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RR,117:P117_RELEASE_ID:&P117_RELEASE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(63891382145431686298)
,p_component_action_id=>wwv_flow_imp.id(57961272667653832209)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>100
);
wwv_flow_imp.component_end;
end;
/
