prompt --application/pages/page_00112
begin
--   Manifest
--     PAGE: 00112
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
 p_id=>112
,p_name=>'Initiative Milestones'
,p_alias=>'INITIATIVE-MILESTONES'
,p_step_title=>'&NOMENCLATURE_INITIATIVE. Milestones'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066643681567697200)
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
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(54007418925934833325)
,p_plug_name=>'Filter'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(69864873284486282055)
,p_name=>'Report Results'
,p_template=>4072358936313175081
,p_display_sequence=>50
,p_region_css_classes=>'sp-schedule-report'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_id, ',
'       project, ',
'       pct_complete, ',
'       the_owner, ',
'       milestone_owner,',
'       task_type, ',
'       target_date, ',
'       milestone_status, ',
'       overdue,',
'       friendly_identifier, ',
'       project_url_name,',
'       project_group,',
'       focus_area,',
'       project_target,',
'       case when PCT_COMPLETE >= 90 ',
'            then ''Recently Completed''',
'            when TARGET_DATE is null',
'            then ''No Target''',
'            else to_char(TARGET_DATE,''Month ''''RR'')',
'            end to_group',
'  from (',
'--',
'--',
'--',
'select p.ID project_id,',
'       p.PROJECT,',
'       p.pct_complete,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = t.OWNER_ID) milestone_owner,',
'       (select focus_area from SP_INITIATIVE_FOCUS_AREAS ifa where ifa.id = p.focus_area_id) focus_area,',
'       tt.task_type, tt.display_seq task_display_seq,',
'       t.target_complete target_date,',
'       s.status milestone_status,',
'       case when p.pct_complete < 90 and t.target_complete < sysdate then ''Y'' end overdue,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       nvl((select group_name from SP_PROJECT_GROUPS pg where pg.id = p.project_group_id),''Not Grouped'') Project_group,',
'       case when p.target_complete is null',
'            then ''No Target''',
'            else to_char(p.target_complete,''DD-Mon-YYYY'')',
'            end ||',
'            case when p.release_id is not null ',
'                 then '' (''||(select release_train||'': ''||release from SP_RELEASE_TRAINS t where t.id = p.release_id)||'')''',
'                 end project_target',
'from  SP_PROJECTS p,',
'      sp_tasks t,',
'      sp_task_statuses s,',
'      sp_task_types tt',
'where nvl(p.ARCHIVED_YN,''N'') != ''Y'' ',
'  and p.DUPLICATE_OF_PROJECT_ID is null',
'  and (:P112_FOCUS_AREA_ID is null or p.focus_area_id = :P112_FOCUS_AREA_ID)',
'  and (:P112_PROJECT_GROUP_ID is null or p.PROJECT_GROUP_ID = :P112_PROJECT_GROUP_ID)',
'  and (trim(:P112_PROJECT) is null or instr(upper(p.project),trim(upper(:P112_PROJECT)))> 0 )',
'  and p.pct_complete >= nvl(:P112_MIN_PERCENT,0)',
'  and p.pct_complete <= nvl(:P112_MAX_PERCENT,100)',
'  and p.id = t.project_id',
'  and (t.task_sub_type_id = :P112_MILESTONE_TYPE_ID or :P112_MILESTONE_TYPE_ID = 0)',
'  and t.status_id = s.id',
'  and t.task_sub_type_id = tt.id',
'  --and (p.pct_complete < 100 or t.target_complete > sysdate-90)',
'  and (:P112_TAG is null or instr('',''||upper(p.tags)||'','','',''||upper(:P112_TAG)||'','') > 0 )',
'  and p.initiative_id = :P112_INITIATIVE_ID',
') i',
'where (:P112_TARGET is null or instr(upper(PROJECT_TARGET),upper(:P112_TARGET)) > 0 )',
'order by case when PCT_COMPLETE >= 90 ',
'              then 1',
'              when TARGET_DATE is not null',
'              then 2',
'              else 3',
'              end, target_date, project, task_display_seq, pct_complete'))
,p_footer=>'<br><div class="padding-sm">Recently Completed will only show &NOMENCLATURE_PROJECTS. that completed selected milestone in the last 90 days.</div>'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P112_MILESTONE_TYPE_ID,P112_MIN_PERCENT'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>5000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_break_cols=>'1'
,p_query_no_data_found=>'No &NOMENCLATURE_PROJECTS. found.'
,p_break_type_flag=>'REPEAT_HEADINGS_ON_BREAK_1'
,p_break_repeat_heading_format=>'<div class="sp-control-break">#COLUMN_VALUE#</div>'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680595249644860464)
,p_query_column_id=>1
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680591721199860462)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>40
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_use_as_row_header=>'Y'
,p_column_link=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:#PROJECT_ID#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680593574462860463)
,p_query_column_id=>3
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>70
,p_column_heading=>'&NOMENCLATURE_PROJECT. Completeness'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680592090565860462)
,p_query_column_id=>4
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECT. Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51065626486171282206)
,p_query_column_id=>5
,p_column_alias=>'MILESTONE_OWNER'
,p_column_display_sequence=>60
,p_column_heading=>'Milestone Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680594771651860464)
,p_query_column_id=>6
,p_column_alias=>'TASK_TYPE'
,p_column_display_sequence=>80
,p_column_heading=>'Milestone Type'
,p_heading_alignment=>'LEFT'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P112_MILESTONE_TYPE_ID'
,p_display_when_condition2=>'0'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680595649586860465)
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
 p_id=>wwv_flow_imp.id(51680596035525860465)
,p_query_column_id=>8
,p_column_alias=>'MILESTONE_STATUS'
,p_column_display_sequence=>90
,p_column_heading=>'Milestone Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680594381261860464)
,p_query_column_id=>9
,p_column_alias=>'OVERDUE'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680592850881860462)
,p_query_column_id=>10
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680593260949860463)
,p_query_column_id=>11
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51065625842854282199)
,p_query_column_id=>12
,p_column_alias=>'PROJECT_GROUP'
,p_column_display_sequence=>140
,p_column_heading=>'Group'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_required_patch=>wwv_flow_imp.id(51655467048481750655)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51065626723601282208)
,p_query_column_id=>13
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>160
,p_column_heading=>'Focus Area'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(30944276630086136839)
,p_query_column_id=>14
,p_column_alias=>'PROJECT_TARGET'
,p_column_display_sequence=>170
,p_column_heading=>'Project Target'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51680594050442860463)
,p_query_column_id=>15
,p_column_alias=>'TO_GROUP'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(76031183773582737656)
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
 p_id=>wwv_flow_imp.id(104821978656266074816)
,p_name=>'details'
,p_parent_plug_id=>wwv_flow_imp.id(76031183773582737656)
,p_template=>4501440665235496320
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.area, ',
'       i.initiative,',
'       --',
'       -- projects in initaitive',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.initiative_id = i.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       -- projects resolved',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.initiative_id = i.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.pct_complete = 100 and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects_resolved,',
'       --',
'       i.updated',
'  from SP_INITIATIVES i,',
'       SP_AREAS f',
' where i.area_id = f.id',
'   and i.id = :P112_INITIATIVE_ID',
'',
'     '))
,p_translate_title=>'N'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P112_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(51680577430712860443)
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
 p_id=>wwv_flow_imp.id(51680578585157860444)
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
 p_id=>wwv_flow_imp.id(51065625379296282195)
,p_query_column_id=>3
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>40
,p_column_heading=>'Projects'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51065625509714282196)
,p_query_column_id=>4
,p_column_alias=>'PROJECTS_RESOLVED'
,p_column_display_sequence=>50
,p_column_heading=>'Projects Resolved'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51065625574831282197)
,p_query_column_id=>5
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(80761832750567691499)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>13
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(81626062012261701653)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(80761832750567691499)
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
 p_id=>wwv_flow_imp.id(81626063245767701665)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51065625238595282193)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_button_name=>'run_report'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--gapTop:t-Button--padBottom'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Run Report'
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51680579689205860445)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(80761832750567691499)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:&P112_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51065625725077282198)
,p_name=>'P112_PROJECT_GROUP_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_prompt=>'&NOMENCLATURE_PROJECT. Group'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select group_name, id',
'from SP_PROJECT_GROUPS',
'order by 1'))
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(51655467048481750655)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51065626011554282201)
,p_name=>'P112_TAG'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_prompt=>'Tag'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51065626308314282204)
,p_name=>'P112_MAX_PERCENT'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_item_default=>'100'
,p_prompt=>'Maximum &NOMENCLATURE_PROJECT. Percent Complete'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>'STATIC2:0%;0,10%;10,20%;20,30%;30,40%;40,50%;50,60%;60,70%;70,80%;80,90%;90,100%;100'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51065626606338282207)
,p_name=>'P112_PROJECT'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_prompt=>'&NOMENCLATURE_PROJECT.'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51065627041408282211)
,p_name=>'P112_TARGET'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_prompt=>'Target'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54007461100439833375)
,p_name=>'P112_MILESTONE_TYPE_ID'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id task_id ',
'  from sp_task_types ',
' where static_id = ''MILESTONE-MERGED'''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Milestone Type'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_type d, id r',
'  from sp_task_types',
' where parent_type_id = (select id from sp_task_types where static_id = ''MILESTONE'')',
' order by display_seq'))
,p_cSize=>30
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54007461574432833379)
,p_name=>'P112_MIN_PERCENT'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_item_default=>'20'
,p_prompt=>'Minimum &NOMENCLATURE_PROJECT. Percent Complete'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>'STATIC2:0%;0,10%;10,20%;20,30%;30,40%;40,50%;50,60%;60,70%;70,80%;80'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55074665303564584460)
,p_name=>'P112_INIT_FOCUS_AREA_ID'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68592359841035469345)
,p_name=>'P112_INITIATIVE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68592359915576469346)
,p_name=>'P112_FOCUS_AREA_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_prompt=>'Focus Area'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select FOCUS_AREA, id',
'from SP_INITIATIVE_FOCUS_AREAS',
'where INITIATIVE_ID = :P112_INITIATIVE_ID'))
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68592360420803469351)
,p_name=>'P112_INITIATIVE_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(54007418925934833325)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(51065625284904282194)
,p_computation_sequence=>10
,p_computation_item=>'P112_INITIATIVE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative',
'from SP_INITIATIVES i',
'where i.id = :P112_INITIATIVE_ID'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51680607818874860477)
,p_name=>'after edit'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(81626062012261701653)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51680608306455860478)
,p_event_id=>wwv_flow_imp.id(51680607818874860477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(104821978656266074816)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(81626062312840701656)
,p_region_id=>wwv_flow_imp.id(81626062012261701653)
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
 p_id=>wwv_flow_imp.id(77483957332052741721)
,p_component_action_id=>wwv_flow_imp.id(81626062312840701656)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:112:&SESSION.::&DEBUG.:RP,112:P112_INITIATIVE_ID:&P112_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(81626063018747701663)
,p_component_action_id=>wwv_flow_imp.id(81626062312840701656)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:112:&SESSION.::&DEBUG.:RP,:P112_INITIATIVE_ID:&P112_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp.component_end;
end;
/
