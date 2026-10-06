prompt --application/pages/page_00033
begin
--   Manifest
--     PAGE: 00033
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
 p_id=>33
,p_name=>'Initiative Focus Area Details'
,p_alias=>'IFA-DETAILS'
,p_step_title=>'&NOMENCLATURE_INITIATIVE. Focus Area Details'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
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
'}',
'',
'.sp-control-break {',
'    background-color: rgba(219, 204, 175, .2);',
'    font-size: 0.875rem;',
'    font-weight: 700;',
'    line-height: var(--ut-report-header-cell-line-height, var(--ut-report-cell-line-height, 1rem));',
'    padding-block-end: var(--ut-report-header-cell-padding-y, .75rem);',
'    padding-block-start: var(--ut-report-header-cell-padding-y, .75rem);',
'    padding-inline-end: var(--ut-report-header-cell-padding-x, .75rem);',
'    padding-inline-start: var(--ut-report-header-cell-padding-x, .75rem);',
'}',
'/* Hide repeating col headers for schedule report */',
'.sp-schedule-report tbody:not(:first-child) + thead tr:first-child {',
'    display: none;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39226228670154940686)
,p_plug_name=>'&NOMENCLATURE_PROJECT. Schedule'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from sp_tasks t, sp_projects p',
' where nvl(p.ARCHIVED_YN,''N'') != ''Y'' ',
'   and p.DUPLICATE_OF_PROJECT_ID is null',
'   and p.focus_area_id = :P33_INIT_FOCUS_AREA_ID',
'   and t.project_id = p.id',
'   and t.task_type_id = (select id from sp_task_types where static_id = ''MILESTONE'')'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55083683028706389416)
,p_name=>'report'
,p_parent_plug_id=>wwv_flow_imp.id(39226228670154940686)
,p_template=>4072358936313175081
,p_display_sequence=>50
,p_region_css_classes=>'sp-schedule-report'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_id, project, pct_complete, status, the_owner, ',
'       task_type, target_date, milestone_status, overdue,',
'       friendly_identifier, project_url_name,',
'       case when i.PCT_COMPLETE >= 90 ',
'            then ''Recently Completed''',
'            when TARGET_DATE is null',
'            then ''No Target''',
'            else to_char(TARGET_DATE,''Month ''''RR'')',
'            end to_group',
'  from (',
'select p.ID project_id,',
'       p.PROJECT,',
'       p.pct_complete,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       tt.task_type, tt.display_seq task_display_seq,',
'       t.target_complete target_date,',
'       ts.status milestone_status,',
'       case when p.pct_complete < 90 and t.target_complete < sysdate then ''Y'' end overdue,',
'       p.friendly_identifier,',
'       p.project_url_name',
'from  SP_PROJECTS p,',
'      sp_initiatives i,',
'      sp_project_scales s,',
'      sp_tasks t,',
'      sp_task_statuses ts,',
'      sp_task_types tt',
'where nvl(p.ARCHIVED_YN,''N'') != ''Y'' ',
'  and p.DUPLICATE_OF_PROJECT_ID is null',
'  and p.focus_area_id = :P33_INIT_FOCUS_AREA_ID',
'  and p.pct_complete >= :P33_MIN_PERCENT',
'  and p.id = t.project_id',
'  and p.initiative_id = i.id',
'  and i.status_scale = s.scale_letter',
'  and (t.task_sub_type_id = :P33_MILESTONE_TYPE_ID or :P33_MILESTONE_TYPE_ID = 0)',
'  and t.status_id = ts.id',
'  and t.task_sub_type_id = tt.id',
'  and (p.pct_complete < 100 or t.target_complete > sysdate-90)',
'  and (:P33_EXCLUDE_COMPLETE_YN = ''N'' or p.pct_complete < 90)',
'union all',
'select p.ID project_id,',
'       p.PROJECT,',
'       p.pct_complete,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       ''Target Complete'' task_type, ',
'       1000000 task_display_seq,',
'       p.target_complete target_date,',
'       null milestone_status,',
'       case when p.pct_complete < 90 and p.target_complete < sysdate then ''Y'' end overdue,',
'       p.friendly_identifier,',
'       p.project_url_name',
'  from sp_projects p,',
'       sp_initiatives i,',
'       SP_TEAM_MEMBERS tm,',
'       sp_project_scales s',
'  where p.OWNER_ID = tm.id (+) ',
'    and p.focus_area_id = :P33_INIT_FOCUS_AREA_ID',
'    and p.pct_complete >= :P33_MIN_PERCENT',
'    and p.ARCHIVED_YN = ''N''  ',
'    and p.duplicate_of_project_id is null',
'    and p.initiative_id = i.id',
'    and i.status_scale = s.scale_letter',
'    and (:P33_MILESTONE_TYPE_ID = -1 or :P33_MILESTONE_TYPE_ID = 0)',
'    and (p.pct_complete < 100 or p.target_complete > sysdate-90)',
'    and (:P33_EXCLUDE_COMPLETE_YN = ''N'' or p.pct_complete < 90)',
') i',
'order by case when PCT_COMPLETE >= 90 then 1',
'              when TARGET_DATE is not null',
'              then 2',
'              else 3',
'              end, target_date, project, task_display_seq, pct_complete'))
,p_footer=>'<div class="padding-sm">Recently Completed will only show &NOMENCLATURE_PROJECTS. that completed selected milestone in the last 90 days.</div>'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P33_MILESTONE_TYPE_ID,P33_MIN_PERCENT,P33_EXCLUDE_COMPLETE_YN'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>5000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_break_cols=>'1'
,p_break_type_flag=>'REPEAT_HEADINGS_ON_BREAK_1'
,p_break_repeat_heading_format=>'<div class="sp-control-break">#COLUMN_VALUE#</div>'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226228392176940683)
,p_query_column_id=>1
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083683203846389418)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>40
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_use_as_row_header=>'Y'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226228034127940679)
,p_query_column_id=>3
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>60
,p_column_heading=>'Percent Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(52590899178037963418)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>70
,p_column_heading=>'Project Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226227529680940674)
,p_query_column_id=>5
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>50
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226229618985940695)
,p_query_column_id=>6
,p_column_alias=>'TASK_TYPE'
,p_column_display_sequence=>80
,p_column_heading=>'Milestone Type'
,p_heading_alignment=>'LEFT'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P33_MILESTONE_TYPE_ID'
,p_display_when_condition2=>'0'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226228511271940684)
,p_query_column_id=>7
,p_column_alias=>'TARGET_DATE'
,p_column_display_sequence=>100
,p_column_heading=>'Target Date'
,p_column_format=>'DD-Mon-YYYY'
,p_column_html_expression=>'{if OVERDUE/}<span style="color:red;">#TARGET_DATE#</span>{else/}#TARGET_DATE#{endif/}'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226229363330940692)
,p_query_column_id=>8
,p_column_alias=>'MILESTONE_STATUS'
,p_column_display_sequence=>90
,p_column_heading=>'Milestone Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226229402122940693)
,p_query_column_id=>9
,p_column_alias=>'OVERDUE'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226227751236940676)
,p_query_column_id=>10
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226227817556940677)
,p_query_column_id=>11
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39226228355025940682)
,p_query_column_id=>12
,p_column_alias=>'TO_GROUP'
,p_column_display_sequence=>10
,p_column_heading=>'Complete'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(43926633770451298648)
,p_name=>'&NOMENCLATURE_PROJECTS.'
,p_template=>4501440665235496320
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.PROJECT,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then ''Y''',
'            end status_ind,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       p.UPDATED,',
'       null attributes,',
'       p.owner_id,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       p.ARCHIVED_YN,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(p.updated_by)),lower(p.updated_by)) updated_by',
'from  SP_PROJECTS p,',
'       sp_initiatives i,',
'       sp_project_scales s',
'where p.initiative_id = i.id and',
'      i.status_scale = s.scale_letter and',
'      nvl(p.ARCHIVED_YN,''N'') != ''Y'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.focus_area_id = :P33_INIT_FOCUS_AREA_ID',
'order by p.updated desc nulls last'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>500
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319215133813979440)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319215478045979441)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>30
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_use_as_row_header=>'Y'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319215942933979441)
,p_query_column_id=>3
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319216301937979441)
,p_query_column_id=>4
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319216751383979442)
,p_query_column_id=>5
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(52590899127988963417)
,p_query_column_id=>6
,p_column_alias=>'STATUS_IND'
,p_column_display_sequence=>230
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(52590899008324963416)
,p_query_column_id=>7
,p_column_alias=>'STATUS'
,p_column_display_sequence=>220
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319217537997979442)
,p_query_column_id=>8
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319217811172979443)
,p_query_column_id=>9
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319218246561979443)
,p_query_column_id=>10
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_column_html_expression=>'#UPDATED# - #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319218603494979444)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>110
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#%</span>',
'{if STATUS_IND/}    <span class="sp-tag">#STATUS#</span>{endif/}',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319218978115979444)
,p_query_column_id=>12
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319213526923979439)
,p_query_column_id=>13
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319213962790979439)
,p_query_column_id=>14
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319214281848979440)
,p_query_column_id=>15
,p_column_alias=>'ARCHIVED_YN'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40319214760651979440)
,p_query_column_id=>16
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(58563378628182979081)
,p_plug_name=>'RDS'
,p_region_css_classes=>'u-padding-inline-dynamic project-rds-region'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>60
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_region_icons', 'N',
  'include_show_all', 'N',
  'rds_mode', 'STANDARD',
  'remember_selection', 'USER')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61249993517802845017)
,p_plug_name=>'Details'
,p_region_css_classes=>'u-flex'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>50
,p_plug_display_point=>'REGION_POSITION_01'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(90040788400486182177)
,p_name=>'details'
,p_parent_plug_id=>wwv_flow_imp.id(61249993517802845017)
,p_template=>4501440665235496320
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.area, ',
'       i.initiative,',
'       fa.focus_area,',
'       fa.development_owner_id,',
'       (select first_name||'' ''||last_name ',
'          from sp_team_members tm ',
'         where tm.id = fa.development_owner_id) dev_owner,',
'       --',
'       -- projects',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.focus_area_id = fa.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       -- projects',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.focus_area_id = fa.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.pct_complete = 100 and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects_resolved,',
'       --',
'       fa.updated',
'  from SP_INITIATIVES i,',
'       SP_AREAS f,',
'       sp_initiative_focus_areas fa',
' where i.area_id = f.id',
'   and i.id = fa.initiative_id  ',
'   and fa.id = :P33_INIT_FOCUS_AREA_ID',
'     '))
,p_translate_title=>'N'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P33_INITIATIVE_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53811144502562576682)
,p_query_column_id=>1
,p_column_alias=>'AREA'
,p_column_display_sequence=>10
,p_column_heading=>'&NOMENCLATURE_AREA.'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FOCUS_AREA:#AREA#'
,p_column_linktext=>'#AREA#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455254916911056471)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>30
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38455255057962056472)
,p_query_column_id=>3
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>40
,p_column_heading=>'Focus Area'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059131117387104)
,p_query_column_id=>4
,p_column_alias=>'DEVELOPMENT_OWNER_ID'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53811144637531576683)
,p_query_column_id=>5
,p_column_alias=>'DEV_OWNER'
,p_column_display_sequence=>20
,p_column_heading=>'Development Owner'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:73:P73_TEAM_MEMBER_ID:#DEVELOPMENT_OWNER_ID#'
,p_column_linktext=>'#DEV_OWNER#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53897099283999651306)
,p_query_column_id=>6
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECT. Count'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53897099711140651307)
,p_query_column_id=>7
,p_column_alias=>'PROJECTS_RESOLVED'
,p_column_display_sequence=>60
,p_column_heading=>'Projects Resolved'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53897101685776651309)
,p_query_column_id=>8
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>70
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(63345222381534692222)
,p_plug_name=>'Links'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       LINK_NAME,',
'       case when lower(link_url) not like ''http%''',
'            then ''http://''||link_url',
'            else link_url',
'            end for_link,',
'       LINK_URL,',
'       decode(IMPORTANT_YN,''Y'',''Yes'',''N'',''No'',IMPORTANT_YN) IMPORTANT,',
'       CREATED,',
'       lower(CREATED_BY) created_by,',
'       UPDATED,',
'       UPDATED_BY',
'from SP_INIT_FOCUS_AREA_LINKS',
'where  init_focus_area_id = :P33_INIT_FOCUS_AREA_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P33_INIT_FOCUS_AREA_ID'
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(63345222457385692223)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:RP,40:P40_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>26445864591983724454
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63345222571435692224)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63345222836490692226)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_html_expression=>'<a href="#FOR_LINK#" target="_blank">#LINK_NAME#</a>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63345222864081692227)
,p_db_column_name=>'LINK_URL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'URL'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63345223094947692229)
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
 p_id=>wwv_flow_imp.id(63345223187105692230)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(63345223323764692231)
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
 p_id=>wwv_flow_imp.id(63345223442530692232)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(68592539124329357324)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933056554968387078)
,p_db_column_name=>'FOR_LINK'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'For Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(63347606743608738731)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'47246263'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK_NAME:LINK_URL:IMPORTANT:UPDATED:CREATED_BY'
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
 p_id=>wwv_flow_imp.id(65831865274248661846)
,p_plug_name=>'Description'
,p_region_name=>'DESCRIPTION'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(85041865137304079971)
,p_plug_name=>'description'
,p_parent_plug_id=>wwv_flow_imp.id(65831865274248661846)
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
'for c1 in (',
'    select description ',
'      from SP_INITIATIVE_FOCUS_AREAS d',
'     where d.id = :P33_INIT_FOCUS_AREA_ID',
'       and description is not null',
') loop',
'    x := apex_markdown.to_html(c1.description);',
'end loop;',
'return x;',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(65980528401448794196)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66844871756481809014)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(65980528401448794196)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ai_enabled=>false
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
 p_id=>wwv_flow_imp.id(66844872989987809026)
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
 p_id=>wwv_flow_imp.id(172644463904682558133)
,p_plug_name=>'Comments'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53811147375086576711)
,p_plug_name=>'Comment Form'
,p_parent_plug_id=>wwv_flow_imp.id(172644463904682558133)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(159887310845130223944)
,p_name=>'Comments Report'
,p_region_name=>'COMMENTS'
,p_parent_plug_id=>wwv_flow_imp.id(172644463904682558133)
,p_template=>4501440665235496320
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:margin-top-md'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ic.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       to_char(ic.created,''fmDay, fmDD fmMonth, YYYY'') date_full,',
'       null comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       ic.body_html comment_text,',
'       case when lower(ic.created_by) = lower(:app_user)',
'            then ''<a href="''||apex_util.prepare_URL(',
'                 p_url => ''f?p=''||:APP_ID||'':35:''||:APP_SESSION||''::NO:35:P35_ID:''||ic.id,',
'                 p_checksum_type => ''3''',
'                 )||''">edit</a>'' ',
'            end actions,',
'       '' '' attribute_1,',
'       '' '' attribute_2,',
'       '' '' attribute_3,',
'       '' '' attribute_4,',
'       ''u-color-''||ora_hash(ic.created_by,45) icon_modifier,',
'       --',
'       --',
'       --',
'       decode(ic.private_yn,null,null,''N'',null,''Y'','' Private Comment'') private_comment_label,',
'       --',
'       -- Data Columns',
'       --',
'       ic.BODY,',
'       ic.BODY_HTML,',
'       ic.AUTHOR_ID,',
'       --',
'       ic.CREATED,',
'       ic.CREATED_BY,',
'       ic.UPDATED,',
'       ic.UPDATED_BY,',
'       tm.id team_member_id',
'  from sp_init_focus_area_comments_v ic, ',
'       sp_team_members tm',
'where ic.author_id = tm.id and',
'      ic.init_focus_area_id = :P33_INIT_FOCUS_AREA_ID and  ',
'      (nvl(ic.private_yn,''N'') = ''N'' or lower(ic.created_by) = lower(:app_user) )',
'order by ic.created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P33_PROJECT_ID'
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
 p_id=>wwv_flow_imp.id(53926564674672949352)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926565139169949352)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178319245862483259)
,p_query_column_id=>3
,p_column_alias=>'DATE_FULL'
,p_column_display_sequence=>280
,p_column_heading=>'Date Full'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926565514043949353)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_column_html_expression=>'<span title="added #DATE_FULL#">#CREATED#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926565929963949353)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926566325968949353)
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
 p_id=>wwv_flow_imp.id(53926566666612949353)
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
 p_id=>wwv_flow_imp.id(53926567133078949354)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926567522570949354)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926567958759949354)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926568347208949355)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926568723852949355)
,p_query_column_id=>12
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926574283076949361)
,p_query_column_id=>13
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>270
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926569909856949356)
,p_query_column_id=>14
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926570355058949356)
,p_query_column_id=>15
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926571489592949358)
,p_query_column_id=>16
,p_column_alias=>'AUTHOR_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Author Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926572280955949359)
,p_query_column_id=>17
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926572687590949359)
,p_query_column_id=>18
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926573133161949359)
,p_query_column_id=>19
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926573554713949360)
,p_query_column_id=>20
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53926573936518949360)
,p_query_column_id=>21
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(184431665270146012797)
,p_plug_name=>'Documents'
,p_region_name=>'DOCUMENTS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>100
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
'  from SP_INIT_FOCUS_AREA_DOCUMENTS d',
' where init_focus_area_id = :P33_INIT_FOCUS_AREA_ID',
'order by created desc',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P33_INITIATIVE_ID'
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(70740279081811308121)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:56:&SESSION.::&DEBUG.:56:P56_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>33840921216409340352
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(70740279182975308122)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(70740279315366308123)
,p_db_column_name=>'DOCUMENT_FILENAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Filename'
,p_column_link=>'f?p=&APP_ID.:59:&SESSION.::&DEBUG.:59:P59_ID,P59_PREV_PAGE:#ID#,33'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(70740279740167308127)
,p_db_column_name=>'DOC_DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(70740279945696308129)
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
 p_id=>wwv_flow_imp.id(70740279492330308125)
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
 p_id=>wwv_flow_imp.id(70740279568173308126)
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
 p_id=>wwv_flow_imp.id(70740279962734308130)
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
 p_id=>wwv_flow_imp.id(71177134153480156909)
,p_db_column_name=>'FILE_EXTENSION'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'File Extension'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(81836817857420705712)
,p_db_column_name=>'TAGS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(68823313869680038156)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69932861709090235616)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014891306321880776)
,p_db_column_name=>'DOCUMENT'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Document'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DOWNLOAD:SP_INIT_FOCUS_AREA_DOCUMENTS:DOCUMENT_BLOB:ID::DOCUMENT_MIMETYPE:DOCUMENT_FILENAME:DOCUMENT_LASTUPD:DOCUMENT_CHARSET:attachment:Download:'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(70742015316614900892)
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
 p_id=>wwv_flow_imp.id(53897121290002653873)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(53811147375086576711)
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
 p_id=>wwv_flow_imp.id(53897358939989947517)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(63345222381534692222)
,p_button_name=>'add_link'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Link'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53926107618107914230)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(85041865137304079971)
,p_button_name=>'edit_description'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Edit'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:RP,10151:P10151_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53897142932188656623)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(184431665270146012797)
,p_button_name=>'view_images'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Image Gallery'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:68:&SESSION.::&DEBUG.:68:P68_INIT_FOCUS_AREA_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from SP_INIT_FOCUS_AREA_DOCUMENTS d',
' where init_focus_area_id = :P33_INIT_FOCUS_AREA_ID and ',
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
 p_id=>wwv_flow_imp.id(53897143323134656624)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(184431665270146012797)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Document'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:56:&SESSION.::&DEBUG.:RR,56:P56_INIT_FOCUS_AREA_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53897279023790940331)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(65980528401448794196)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:&P33_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722866850543623566)
,p_name=>'P33_IMAGE_REF_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(53811147375086576711)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39226228573826940685)
,p_name=>'P33_MILESTONE_TYPE_ID'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39226228670154940686)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id task_id ',
'  from sp_task_types ',
' where static_id = ''MILESTONE-MERGED'''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Milestone Type'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r ',
'  from',
'(',
'select task_type d, id r, display_seq',
'  from sp_task_types',
' where parent_type_id = (select id from sp_task_types where static_id = ''MILESTONE'')',
' union all',
'select ''Target Complete'' d, -1 r, 1000000 display_seq',
'  from dual',
')',
' order by display_seq'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All Milestone Types'
,p_lov_null_value=>'0'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39226229047819940689)
,p_name=>'P33_MIN_PERCENT'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(39226228670154940686)
,p_item_default=>'20'
,p_prompt=>'Minimum Percent Complete'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:0%;0,10%;10,20%;20,30%;30'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39226230140750940700)
,p_name=>'P33_EXCLUDE_COMPLETE_YN'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(39226228670154940686)
,p_item_default=>'N'
,p_prompt=>'Exclude Complete'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40293449287576691790)
,p_name=>'P33_INIT_FOCUS_AREA_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(61249993517802845017)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53811143825047576675)
,p_name=>'P33_INITIATIVE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(61249993517802845017)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53811143899588576676)
,p_name=>'P33_FOCUS_AREA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(61249993517802845017)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53811144404815576681)
,p_name=>'P33_INITIATIVE_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(61249993517802845017)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(58700306656287460206)
,p_name=>'P33_PRIVATE_YN'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(53811147375086576711)
,p_item_default=>'N'
,p_prompt=>'This is a private comment'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63345232070122692287)
,p_name=>'P33_LINK'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(63345222381534692222)
,p_prompt=>'Link URL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'URL',
  'trim_spaces', 'BOTH')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63345232471253692291)
,p_name=>'P33_LINK_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(63345222381534692222)
,p_prompt=>'Link Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(181215591012425815374)
,p_name=>'P33_COMMENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(53811147375086576711)
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
'                imageRefId: apex.item(''P33_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53928395404978999541)
,p_name=>'Post Comment'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(53897121290002653873)
,p_condition_element=>'P33_COMMENT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722866963234623567)
,p_event_id=>wwv_flow_imp.id(53928395404978999541)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(53897121290002653873)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53928395766573999544)
,p_event_id=>wwv_flow_imp.id(53928395404978999541)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_init_focus_area_comment (',
'    p_app_user_id        => :APP_USER_ID,',
'    p_comment            => :P33_COMMENT,',
'    p_init_focus_area_id => :P33_INIT_FOCUS_AREA_ID,',
'    p_private_yn         => nvl(:P33_PRIVATE_YN,''N''),',
'    p_image_ref_id       => :P33_IMAGE_REF_ID );',
'',
':P33_COMMENT      := null;',
':P33_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P33_COMMENT,P33_PRIVATE_YN,P33_INIT_FOCUS_AREA_ID,P33_IMAGE_REF_ID'
,p_attribute_03=>'P33_COMMENT,P33_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53928396351195999545)
,p_event_id=>wwv_flow_imp.id(53928395404978999541)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(159887310845130223944)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722867094201623569)
,p_event_id=>wwv_flow_imp.id(53928395404978999541)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722867020200623568)
,p_event_id=>wwv_flow_imp.id(53928395404978999541)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(53897121290002653873)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53928712841524033224)
,p_name=>'comments refresh on dialog close'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(159887310845130223944)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53928713191199033226)
,p_event_id=>wwv_flow_imp.id(53928712841524033224)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(159887310845130223944)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53933056704230387080)
,p_name=>'doc refresh on dialog close'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(184431665270146012797)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933056814429387081)
,p_event_id=>wwv_flow_imp.id(53933056704230387080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(184431665270146012797)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53933056332256387076)
,p_name=>'link refresh on dialog close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(63345222381534692222)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933056413639387077)
,p_event_id=>wwv_flow_imp.id(53933056332256387076)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(63345222381534692222)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53928589043935744094)
,p_name=>'on edit description dialog close'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(85041865137304079971)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53928589472903744096)
,p_event_id=>wwv_flow_imp.id(53928589043935744094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(85041865137304079971)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53811147522022576712)
,p_name=>'after edit'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(66844871756481809014)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53811147728199576714)
,p_event_id=>wwv_flow_imp.id(53811147522022576712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(90040788400486182177)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53811147631213576713)
,p_event_id=>wwv_flow_imp.id(53811147522022576712)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(85041865137304079971)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53933498737816449766)
,p_name=>'add link'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(53897358939989947517)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933500101479449770)
,p_event_id=>wwv_flow_imp.id(53933498737816449766)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please supply a Link URL and a Link Name.'
,p_attribute_02=>'Missing Link Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P33_LINK'') === '''' || $v(''P33_LINK_NAME'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933499069502449768)
,p_event_id=>wwv_flow_imp.id(53933498737816449766)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P33_LINK_NAME is not null and :P33_LINK is not null',
'then insert into sp_init_focus_area_links',
'         (init_focus_area_id, link_name, link_url )',
'     values',
'         (:P33_INIT_FOCUS_AREA_ID, :P33_LINK_NAME, :P33_LINK);',
'    :P33_LINK_NAME := null;',
'    :P33_LINK := null;',
'end if;'))
,p_attribute_02=>'P33_LINK_NAME,P33_LINK,P33_INIT_FOCUS_AREA_ID'
,p_attribute_03=>'P33_LINK,P33_LINK_NAME'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933499582954449769)
,p_event_id=>wwv_flow_imp.id(53933498737816449766)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(63345222381534692222)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39226228808795940687)
,p_name=>'when change milestone type'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P33_MILESTONE_TYPE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39226228866008940688)
,p_event_id=>wwv_flow_imp.id(39226228808795940687)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55083683028706389416)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39226230405115940703)
,p_name=>'when change exclude complete'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P33_EXCLUDE_COMPLETE_YN'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39226230512753940704)
,p_event_id=>wwv_flow_imp.id(39226230405115940703)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55083683028706389416)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39226229128117940690)
,p_name=>'when change min percent'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P33_MIN_PERCENT'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39226229246669940691)
,p_event_id=>wwv_flow_imp.id(39226229128117940690)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55083683028706389416)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27117240049401764633)
,p_name=>'links in comments in new tab'
,p_event_sequence=>110
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27117240146993764634)
,p_event_id=>wwv_flow_imp.id(27117240049401764633)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53811144201553576679)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'load display'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select i.id, i.initiative, fa.focus_area',
'      from sp_initiatives i,',
'           sp_initiative_focus_areas fa',
'     where i.id = fa.initiative_id',
'       and fa.id = :P33_INIT_FOCUS_AREA_ID',
') loop',
'    :P33_INITIATIVE_ID := c1.id;',
'    :P33_INITIATIVE    := c1.initiative;',
'    :P33_FOCUS_AREA    := c1.focus_area;',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>16911786336151608910
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(60183873389630602658)
,p_region_id=>wwv_flow_imp.id(66844871756481809014)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:RP,10151:P10151_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(66844872057060809017)
,p_region_id=>wwv_flow_imp.id(66844871756481809014)
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
 p_id=>wwv_flow_imp.id(62702767076272849082)
,p_component_action_id=>wwv_flow_imp.id(66844872057060809017)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_INIT_FOCUS_AREA_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(66844872762967809024)
,p_component_action_id=>wwv_flow_imp.id(66844872057060809017)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,:P33_INIT_FOCUS_AREA_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(70809064082233549228)
,p_component_action_id=>wwv_flow_imp.id(66844872057060809017)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>60
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(70809064218676549229)
,p_component_action_id=>wwv_flow_imp.id(66844872057060809017)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:57:&SESSION.::&DEBUG.:57:P57_INIT_FOCUS_AREA_ID:&P33_INIT_FOCUS_AREA_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp.component_end;
end;
/
