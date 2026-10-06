prompt --application/pages/page_00135
begin
--   Manifest
--     PAGE: 00135
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
 p_id=>135
,p_name=>'Planning Board'
,p_alias=>'PLANNING-BOARD'
,p_step_title=>'Planning Board'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Set background when kanban is there */',
':root:has(.kb-Layout) {',
'  --ut-body-main-background-color: #fff;',
'}',
'',
'/* Clip overflow */',
'.kb-Layout {',
'  --ut-focus-outline: var(--ut-link-text-color) solid 2px;',
'  --ut-focus-outline-offset: -1px;',
'',
'  overflow: clip;',
'}',
'',
'/* Row layout */',
'.kb-RowHeader,',
'.kb-Row {',
'  display: grid;',
'  grid-template-columns: repeat(5, 1fr);',
'  border-bottom-width: var(--ut-component-border-width);',
'  border-bottom-style: solid;',
'  border-bottom-color: var(--ut-component-border-color);',
'}',
'',
'/* Headers */',
'.kb-RowHeader {',
'  position: sticky;',
'  background-color: #eee;',
'  top: var(--js-page-title-height);',
'  z-index: 2;',
'  width: ;',
'}',
'',
'.kb-RowHeader .kb-Column {',
'  font-size: .675rem;',
'  line-height: 1rem;',
'  font-weight: 400;',
'  text-transform: uppercase;',
'  text-align: start;',
'  padding-inline: .5rem;',
'  padding-block: .5rem;',
'  position: relative;',
'}',
'',
'.kb-RowHeader .kb-Column:not(:first-child):before {',
'  content: '''';',
'  position: absolute;',
'  background-color: #ddd;',
'  inline-size: var(--ut-component-border-width);',
'  inset-block: 0;',
'  inset-inline-start: 0;',
'}',
'',
'/* Groups */',
'.kb-Group {',
'  position: sticky;',
'  top: calc(var(--js-page-title-height) + 2rem + 1px);',
'  z-index: 3;',
'  font-size: .875rem;',
'  line-height: 1rem;',
'  font-weight: 700;',
'  margin: 0;',
'}',
'',
'.kb-Group-label {',
'  display: inline-block;',
'  background-color: var(--ut-body-main-background-color);',
'  padding-inline: .5rem;',
'  padding-block: .5rem;',
'  margin-block-end: -.5rem;',
'  inline-size: 20%;',
'  text-overflow: ellipsis;',
'  overflow: hidden;',
'  white-space: nowrap;',
'}',
'',
'.kb-Cell {',
'  min-inline-size: 0;',
'  display: flex;',
'  flex-direction: column;',
'  gap: .25rem;',
'  padding: .5rem;',
'  min-block-size: 4rem;',
'}',
'',
'.kb-Cell:not(:first-child):before {',
'  content: '''';',
'  position: absolute;',
'  background-color: #ddd;',
'  inline-size: var(--ut-component-border-width);',
'  inset-block: 0;',
'  margin-inline-start: -.5rem;',
'}',
'',
'/* Card */',
'.kb-Card {',
'  border-width: var(--ut-component-border-width);',
'  border-style: solid;',
'  border-color: var(--ut-component-border-color);',
'  border-radius: .25rem;',
'  /* var(--ut-component-border-radius); */',
'  background-color: var(--kb-card-background, var(--ut-component-background-color));',
'  color: var(--ut-component-text-default-color);',
'  padding: 8px;',
'  display: flex;',
'  flex-direction: column;',
'  gap: .25rem;',
'  cursor: move;',
'}',
'',
'.kb-Card:hover {',
'  border-color: rgba(22, 21, 19, .4);',
'}',
'',
'.kb-Card:focus:not(:focus-visible) {',
'  outline: none !important;',
'}',
'',
'/* Hide Empty Cards */',
'.kb-Card:has(.kb-Card-title:empty) {',
'  display: none !important;',
'}',
'',
'.kb-Card-title {',
'  font-size: .75rem;',
'  font-weight: var(--a-base-font-weight-semibold, 500);',
'  line-height: 1rem;',
'  color: var(--ut-component-text-title-color);',
'  margin: 0;',
'',
'  display: -webkit-box;',
'  -webkit-box-orient: vertical;',
'  overflow: hidden;',
'  text-overflow: ellipsis;',
'  -webkit-line-clamp: 2;',
'}',
'',
'/* .kb-Card-title:before {',
'  background-color: var(--kb-emphasis-background-color, var(--ut-component-border-color));',
'  display: inline-block;',
'  inline-size: .5rem;',
'  block-size: .5rem;',
'  border-radius: .5rem;',
'  margin-inline-end: .25rem;',
'  content: '''';',
'  vertical-align: baseline;',
'} */',
'',
'.kb-Card-attributes {',
'  font-size: .6875rem;',
'  color: var(--ut-component-text-muted-color);',
'  display: flex;',
'  flex-wrap: wrap;',
'  gap: .5rem;',
'  align-items: center;',
'}',
'',
'.kb-Card-badges {',
'  --ut-badge-padding-x: .375rem;',
'  --ut-badge-height: 1rem;',
'  --ut-badge-line-height: .75rem;',
'  --ut-badge-font-size: .6875rem;',
'  --ut-badge-icon-size: .75rem;',
'  --ut-badge-border-radius: .25rem;',
'  --ut-badge-subtle-background-color: rgba(0, 0, 0, .075);',
'',
'  flex-grow: 1;',
'}',
'',
'.kb-Badge--priority {',
'  --ut-badge-background-color: var(--kb-emphasis-background-color);',
'  --ut-badge-text-color: var(--kb-emphasis-text-color);',
'  --ut-badge-font-weight: 700;',
'}',
'',
'.kb-Badge--priority .t-Badge-icon {',
'  display: none;',
'}',
'',
'.kb-Badge--release,',
'.kb-Badge--percent {',
'  --ut-badge-background-color: transparent;',
'  --ut-badge-text-color: currentColor;',
'}',
'',
'.kb-Badge--percent:has(.fa-pie-chart-100) {',
'  --ut-badge-font-weight: 700;',
'}',
'',
'.kb-Badge--percent:has(.fa-pie-chart-100) .t-Badge-icon:before {',
'  content: ''\f058'';',
'  color: var(--a-palette-success);',
'}',
'',
'.kb-Badge--percent:has(.fa-pie-chart-0) {',
'  --ut-badge-font-weight: 700;',
'}',
'',
'.kb-Badge--percent:has(.fa-pie-chart-0) .t-Badge-icon:before {',
'  content: ''\f071'';',
'  color: var(--a-palette-danger);',
'}',
'',
'.kb-Badge--percent {',
'  margin-inline-start: auto;',
'}',
'',
'/* Droppable */',
'.kb-Droppable {',
'  background-color: rgba(0, 0, 0, .08);',
'}',
'',
'.kb-Cell.kb-Droppable {',
'  border-radius: var(--ut-component-border-radius);',
'}',
'',
'/* States */',
'.kb-Card--p1 {',
'  --kb-card-background: #FFEAE8;',
'  --kb-emphasis-background-color: #D83F2A;',
'  --kb-emphasis-text-color: #fff;',
'}',
'',
'.kb-Card--p2 {',
'  --kb-card-background: #FCEDDA;',
'  --kb-emphasis-background-color: #AE650E;',
'  --kb-emphasis-text-color: #fff;',
'}',
'',
'.kb-Card--p3 {',
'  --kb-card-background: #E4F4D4;',
'  --kb-emphasis-background-color: #518324;',
'  --kb-emphasis-text-color: #fff;',
'}',
'',
'.kb-Card--p4 {',
'  --kb-card-background: #E5F1F5;',
'  --kb-emphasis-background-color: #457D95;',
'  --kb-emphasis-text-color: #fff;',
'}',
'',
'.kb-Card--p5 {',
'  --kb-card-background: #F3ECF8;',
'  --kb-emphasis-background-color: #876D94;',
'  --kb-emphasis-text-color: #fff;',
'}',
'',
'.kb-Blank {display:none;}'))
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#:t-PageBody--noContentPadding'
,p_required_patch=>wwv_flow_imp.id(48520462122696828334)
,p_protection_level=>'C'
,p_page_comment=>'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(141815726291224212782)
,p_plug_name=>'Faceted Search'
,p_region_template_options=>'#DEFAULT#:margin-top-none'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>90
,p_plug_display_point=>'REGION_POSITION_02'
,p_location=>null
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(155854421097495473435)
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(117190599600756010519)
,p_plug_name=>'Parameters'
,p_parent_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(147990917132455446913)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle:t-BreadcrumbRegion--headingFontAlt'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>110
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(154851375477332108559)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(147990917132455446913)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>100
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
 p_id=>wwv_flow_imp.id(154851376710838108571)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(155584106088334196737)
,p_name=>'Planning Board'
,p_template=>3371237801798025892
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  x.focus_area_name focus_area,',
'  y.id,',
'  y.project project,',
'  x.column_id,',
'  y.priority,',
'  case y.priority',
'  when 1 then ''kb-Card--p1''',
'  when 2 then ''kb-Card--p2''',
'  when 3 then ''kb-Card--p3''',
'  when 4 then ''kb-Card--p4''',
'  when 5 then ''kb-Card--p5''',
'  else null end p_style,',
'  y.project_size,',
'  y.effort_days,',
'  y.weight,',
'  decode(y.release,''TBD'',null,y.release_dependent_yn) release_dependent_yn,',
'  y.pct_complete,',
'  y.status_scale,',
'  x.focus_area_id,',
'  y.kb_stack_rank,',
'  y.release,',
'  nvl(y.name,''(No Owner)'') name,',
'  nvl2(y.id,null,''kb-Blank'') display,',
'  row_number() over(PARTITION BY x.focus_area_id ORDER BY x.focus_area,x.column_id,y.kb_stack_rank,y.id) row_split,',
'  row_number() over(PARTITION BY x.focus_area_id,x.column_id ORDER BY x.focus_area, x.release_target_date ,y.kb_stack_rank,y.id) column_split,',
'  ''apex.navigation.redirect(''''''||',
'  apex_util.prepare_url(p_url => ''f?p='' || :APP_ID || '':36:'' || :APP_SESSION || ''::NO::P36_ID:'' || y.id)||'''''')'' as link,',
'  -- Display Attributes',
'  null attrs,',
'  case',
'  (select count(*) from APEX_APPL_ACL_USER_ROLES where role_static_id in (''CONTRIBUTOR'', ''ADMINISTRATOR'') and application_id = :app_id and user_name = :app_user)',
'    when 0 then null',
'    else ''kb-Sortable'' end sortable',
'from ',
'--------------------------------------------------',
'-- Inline view that lays out the Planning Board --',
'--------------------------------------------------',
'(select * from',
'      -------------',
'      -- Columns --',
'      -------------',
'      (select 0 column_id, sysdate release_target_date from dual union all',
'        (select id column_id,',
'              release_target_date',
'            from sp_release_trains',
'            where release_train = :P135_RELEASE_TRAIN',
'            --and release_completed = ''N''',
'            and sysdate < release_target_date',
'            and release_type = ''FULL''',
'            order by release_target_date',
'            fetch first 4 rows only',
'            )) columns',
'       cross join',
'      ------------',
'      -- Groups --',
'      ------------',
'      (select ',
'        focus_area||(select '' (''||stm.first_name||'' ''||stm.last_name||'')'' from SP_TEAM_MEMBERS stm where stm.id = fa.development_owner_id) focus_area_name,',
'        focus_area,',
'        to_char(id) focus_area_id',
'      from',
'        sp_initiative_focus_areas fa',
'      where fa.initiative_id = :P135_INITIATIVE_ID',
'        and active_yn = ''Y''',
'      --------------------------------------------------',
'      -- Create a sudo group for unallocated projects --',
'      -------------------------------------------------- ',
'      union all select ''Unallocated'', ''Unallocated'', ''Unallocated'' from dual) groups) x',
'  --------------------------------------------------------',
'  -- An inline view of all the projects is outer joined --',
'  -- to the Planning Board                              --',
'  --------------------------------------------------------',
'  left join (',
'      select ',
'           re.id column_id,',
'           case when sp.release_id is null then ''TBD''',
'                else re.release_train||'' ''||re.release end release,',
'           to_char(sp.id) as id,',
'           sp.project,',
'           sp.tags,',
'           case when sp.release_id is not null then ''Y'' ',
'                else ''N'' end release_dependent_yn,',
'           pp.priority,',
'           ps.project_size,',
'           ps.effort_days,',
'           re.release_target_date,',
'           pp.priority * ps.effort_days weight,',
'           sp.kb_stack_rank,',
'           sp.pct_complete,',
'           sp.status_scale,',
'           nvl(to_char(sp.focus_area_id),''Unallocated'') focus_area_id,',
'           (select tm.first_name||'' ''||tm.last_name from sp_team_members tm where sp.owner_id = tm.id) name',
'      from sp_projects sp',
'      inner join sp_project_priorities pp on sp.priority_id = pp.id',
'      inner join sp_project_sizes ps on sp.project_size = ps.project_size ',
'      left outer join sp_release_trains re on sp.release_id = re.id',
'      ----------------------------------------',
'      -- Predicates to filter projects only --',
'      ----------------------------------------',
'      where sp.pct_complete > 0 ',
'        and sp.archived_yn = ''N'' ',
'        and sp.duplicate_of_project_id is null',
'        and sp.initiative_id = :P135_INITIATIVE_ID',
'        --and sp.status_scale = ''A''',
'        and (pp.priority in (select column_value from table(apex_string.split(:p135_kb_priority,'':''))) or :p135_kb_priority is null)',
'        and (sp.project_size in (select column_value from table(apex_string.split(:p135_kb_project_size,'':'')))  or :p135_kb_project_size is null)',
'        and ((select count(*) from table(apex_string.split(sp.tags,'','')) t1 inner join table(apex_string.split(:P135_KB_TAGS,'':'')) t2 on t1.column_value = t2.column_value) > 0  or :p135_kb_tags is null)',
'        and ((sp.release_id is null and sp.pct_complete < 100)',
'              or (sp.release_id is not null and (sysdate < release_target_date or re.id is null)))',
'        or sp.id is null',
'  ) y on x.focus_area_id = y.focus_area_id ',
'     and x.column_id = nvl(y.column_id,0)',
'     and (y.release in (select column_value from table(apex_string.split(:p135_kb_release,'':''))) or :p135_kb_release is null)',
'     and (y.pct_complete in (select column_value from table(apex_string.split(:p135_kb_pct_complete,'':''))) or :p135_kb_pct_complete is null)',
'     and (nvl(y.name,''$$NULL$$'') in (select column_value from table(apex_string.split(:p135_kb_name,'':''))) or :p135_kb_name is null)',
'     and (instr(upper(y.project||y.name||x.focus_area||y.tags||y.project_size), upper(:P135_KB_SEARCH), 1, 1) > 0 or :P135_KB_SEARCH is null)',
'----------------------------------------------------',
'-- Predicates that filter both board and projects --',
'----------------------------------------------------',
'where (x.focus_area in (select column_value from table(apex_string.split(:p135_kb_focus_area,'':''))) or :p135_kb_focus_area is null)',
'order by x.focus_area, x.release_target_date, y.kb_stack_rank, y.id',
'',
'',
''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P135_KB_SEARCH,P135_KB_RELEASE,P135_KB_TAGS,P135_KB_NAME,P135_KB_PRIORITY,P135_KB_PROJECT_SIZE,P135_KB_FOCUS_AREA,P135_KB_COLUMN_ID,P135_RELEASE_TRAIN,P135_KB_PCT_COMPLETE'
,p_lazy_loading=>true
,p_query_row_template=>wwv_flow_imp.id(46433465674625149314)
,p_query_headings=>'return ''Not Scheduled:''||:P135_COLUMN_NAMES;'
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>1000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536746500949236356)
,p_query_column_id=>1
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>10
,p_column_heading=>'Focus Area'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536746943062236357)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>220
,p_hidden_column=>'Y'
,p_display_when_cond_type=>'NEVER'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536747268251236358)
,p_query_column_id=>3
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>40
,p_column_heading=>'Project'
,p_heading_alignment=>'LEFT'
,p_display_when_cond_type=>'EXPRESSION'
,p_display_when_condition=>':p135_column_count >= 2'
,p_display_when_condition2=>'PLSQL'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536747704790236359)
,p_query_column_id=>4
,p_column_alias=>'COLUMN_ID'
,p_column_display_sequence=>50
,p_column_heading=>'Column Id'
,p_heading_alignment=>'LEFT'
,p_display_when_cond_type=>'EXPRESSION'
,p_display_when_condition=>':p135_column_count >= 3'
,p_display_when_condition2=>'PLSQL'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536748081099236360)
,p_query_column_id=>5
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536748497023236361)
,p_query_column_id=>6
,p_column_alias=>'P_STYLE'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536748926472236362)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536749257218236363)
,p_query_column_id=>8
,p_column_alias=>'EFFORT_DAYS'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536749676284236364)
,p_query_column_id=>9
,p_column_alias=>'WEIGHT'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536750104886236365)
,p_query_column_id=>10
,p_column_alias=>'RELEASE_DEPENDENT_YN'
,p_column_display_sequence=>230
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536750450399236366)
,p_query_column_id=>11
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536750913386236367)
,p_query_column_id=>12
,p_column_alias=>'STATUS_SCALE'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536751313862236368)
,p_query_column_id=>13
,p_column_alias=>'FOCUS_AREA_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536751668297236369)
,p_query_column_id=>14
,p_column_alias=>'KB_STACK_RANK'
,p_column_display_sequence=>60
,p_column_heading=>'Kb Stack Rank'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_display_when_cond_type=>'EXPRESSION'
,p_display_when_condition=>':p135_column_count >= 4'
,p_display_when_condition2=>'PLSQL'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536752125660236370)
,p_query_column_id=>15
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536752532164236370)
,p_query_column_id=>16
,p_column_alias=>'NAME'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536752920506236371)
,p_query_column_id=>17
,p_column_alias=>'DISPLAY'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536753319367236372)
,p_query_column_id=>18
,p_column_alias=>'ROW_SPLIT'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536753703320236373)
,p_query_column_id=>19
,p_column_alias=>'COLUMN_SPLIT'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536754082488236374)
,p_query_column_id=>20
,p_column_alias=>'LINK'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536754488008236374)
,p_query_column_id=>21
,p_column_alias=>'ATTRS'
,p_column_display_sequence=>20
,p_column_heading=>'ID'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span class="kb-Card-author" title="Assigned">#NAME#</span>',
'',
'<div class="t-Badges kb-Card-badges">',
'  <span class="t-Badge kb-Badge--priority" role="status" aria-label="Priority: P#PRIORITY#" title="Priority: P#PRIORITY#">',
'    <span class="t-Badge-icon fa fa-exclamation-diamond" aria-hidden="true"></span>',
'    <span class="t-Badge-value">P#PRIORITY#</span>',
'  </span>',
'  <span class="t-Badge t-Badge--subtle kb-Badge--size" role="status" aria-label="Project Size: #PROJECT_SIZE#" title="Project Size: #PROJECT_SIZE#">',
'    <span class="t-Badge-icon fa fa-expand" aria-hidden="true"></span>',
'    <span class="t-Badge-value">#PROJECT_SIZE#</span>',
'  </span>',
'  <span class="t-Badge kb-Badge--release" role="status" aria-label="Release: #RELEASE#" title="Release: #RELEASE#">',
'    <span class="t-Badge-icon fa fa-cube" aria-hidden="true"></span><span class="t-Badge-value" id="#ID#-release">#RELEASE#</span>',
'    {if ?RELEASE_DEPENDENT_YN/}',
'      {case RELEASE_DEPENDENT_YN/}',
'      {when N/}',
'      <span class="t-Badge-icon fa fa-asterisk" aria-hidden="true"></span>',
'      {when Y/}',
'      <span class="t-Badge-icon fa fa-check" aria-hidden="true"></span>',
'      {endcase/} ',
'    {else/}',
'    <span aria-hidden="true"></span>',
'    {endif/}',
'  </span>',
'  <span class="t-Badge kb-Badge--percent" id="#ID#-pct-complete" role="status" aria-label="Complete: #PCT_COMPLETE#%" title="Complete: #PCT_COMPLETE#%">',
'    <span class="t-Badge-icon fa fa-pie-chart-#PCT_COMPLETE#" aria-hidden="true"></span>',
'    <span class="t-Badge-value">#PCT_COMPLETE#%</span>',
'  </span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_display_when_cond_type=>'EXPRESSION'
,p_display_when_condition=>':p135_column_count >= 1'
,p_display_when_condition2=>'PLSQL'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536754908924236376)
,p_query_column_id=>22
,p_column_alias=>'SORTABLE'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(155854421097495473435)
,p_name=>'do not delete - Search Results'
,p_region_name=>'search-results'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'     select ',
'           sp.id,',
'           sp.project,',
'           case when sp.release_id is null then ''TBD''',
'                else re.release_train||'' ''||re.release end release,',
'           sp.release_id,',
'           sp.tags,',
'           pp.priority,',
'           ps.project_size,',
'           ps.effort_days,',
'           sp.pct_complete,',
'           nvl(fa.focus_area,''Unallocated'') focus_area,',
'           sp.status_scale,',
'           (select tm.first_name||'' ''||tm.last_name from sp_team_members tm where sp.owner_id = tm.id) name',
'      from sp_projects sp',
'      inner join sp_project_priorities pp on sp.priority_id = pp.id',
'      inner join sp_project_sizes ps on sp.project_size = ps.project_size ',
'      left outer join sp_initiative_focus_areas fa on sp.focus_area_id = fa.id',
'      left outer join sp_release_trains re on sp.release_id = re.id',
'      where sp.pct_complete > 0 ',
'        and sp.initiative_id = :P135_INITIATIVE_ID',
'        and sp.archived_yn = ''N'' ',
'        and sp.duplicate_of_project_id is null',
'        and ((sp.release_id is null and sp.pct_complete < 100)',
'            or (sp.release_id is not null and (sysdate < release_target_date or re.id is null)))',
'        and (sp.release_id in (select id column_id',
'            from sp_release_trains',
'            where release_train = :P135_RELEASE_TRAIN',
'            and sysdate < release_target_date',
'            and release_type = ''FULL'') or sp.release_id is null)'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P135_RELEASE_TRAIN'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536730927936236320)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>20
,p_column_heading=>'Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536731258107236321)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>30
,p_column_heading=>'Project'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536731707710236322)
,p_query_column_id=>3
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>100
,p_column_heading=>'Release'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536732097973236322)
,p_query_column_id=>4
,p_column_alias=>'RELEASE_ID'
,p_column_display_sequence=>130
,p_column_heading=>'Release Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536732487801236323)
,p_query_column_id=>5
,p_column_alias=>'TAGS'
,p_column_display_sequence=>120
,p_column_heading=>'Tags'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536732852585236323)
,p_query_column_id=>6
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>40
,p_column_heading=>'Priority'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536733268769236324)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>50
,p_column_heading=>'Project Size'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536733713373236324)
,p_query_column_id=>8
,p_column_alias=>'EFFORT_DAYS'
,p_column_display_sequence=>60
,p_column_heading=>'Effort Days'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536734119365236325)
,p_query_column_id=>9
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>70
,p_column_heading=>'Pct Complete'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536734545579236326)
,p_query_column_id=>10
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>140
,p_column_heading=>'Focus Area'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536734919766236326)
,p_query_column_id=>11
,p_column_alias=>'STATUS_SCALE'
,p_column_display_sequence=>80
,p_column_heading=>'Status Scale'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6536735259175236327)
,p_query_column_id=>12
,p_column_alias=>'NAME'
,p_column_display_sequence=>110
,p_column_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6536739635184236340)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(147990917132455446913)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:4:P4_INITIATIVE_ID:&P135_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(117190617289328010563)
,p_name=>'P135_RELEASE_TRAIN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(117190599600756010519)
,p_prompt=>'Release Train'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct release_train d, release_train r from sp_release_trains',
'order by 1'))
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-top-md:margin-bottom-none:margin-left-md:margin-right-md'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(117190652317906010658)
,p_name=>'P135_COLUMN_NAMES'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(117190652450298010659)
,p_name=>'P135_COLUMN_COUNT'
,p_item_sequence=>150
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(128943492873370640372)
,p_name=>'P135_DROP_RELEASE'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(132637082901000239446)
,p_name=>'P135_KB_PCT_COMPLETE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_item_default=>'20:30:40:50:60:70:80:90:100'
,p_prompt=>'% Complete'
,p_source=>'PCT_COMPLETE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC2:10,20,30,40,50,60,70,80,90,100'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(132637342077909239575)
,p_name=>'P135_SR_BELOW'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(132637342776557239582)
,p_name=>'P135_DROP_FOCUS_AREA_ID'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141438991245788262209)
,p_name=>'P135_AREA_ID'
,p_item_sequence=>110
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141464257132094169680)
,p_name=>'P135_SR_ABOVE'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141749386723267860635)
,p_name=>'P135_DRAG_ITEM_ID'
,p_item_sequence=>50
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141815751225926212848)
,p_name=>'P135_KB_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Kb Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141815751692917212853)
,p_name=>'P135_KB_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>false
,p_fc_filter_combination=>'OR'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141815751836204212854)
,p_name=>'P135_KB_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Priority'
,p_source=>'PRIORITY'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_display_as=>'FILTER_DIALOG'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141815751968697212856)
,p_name=>'P135_KB_PROJECT_SIZE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Project Size'
,p_source=>'PROJECT_SIZE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_size d, project_size r ',
'from sp_project_sizes',
'where include_yn = ''Y''',
'order by effort_days',
''))
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_display_as=>'FILTER_DIALOG'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141983398101023593829)
,p_name=>'P135_DROP_COLUMN_ID'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141983398944440593838)
,p_name=>'P135_DRAG_COLUMN_ID'
,p_item_sequence=>30
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141983399068506593839)
,p_name=>'P135_DRAG_FOCUS_AREA_ID'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(141983400534789593854)
,p_name=>'P135_INITIATIVE_ID'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(142571462358828464340)
,p_name=>'P135_KB_RELEASE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Release'
,p_source=>'RELEASE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(142571462833520464345)
,p_name=>'P135_KB_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Owner'
,p_source=>'NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_display_null=>'YES'
,p_lov_sort_direction=>'ASC'
,p_lov_null_text=>'(No Owner)'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(142571738533541464505)
,p_name=>'P135_INITIATIVE'
,p_item_sequence=>130
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(149257843681182327331)
,p_name=>'P135_KB_FOCUS_AREA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(141815726291224212782)
,p_prompt=>'Focus Area'
,p_source=>'FOCUS_AREA'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>6
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536760263471236388)
,p_name=>'Drop Item'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_SR_BELOW'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536760797481236392)
,p_event_id=>wwv_flow_imp.id(6536760263471236388)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  insufficient_data exception;',
'  lv_stack_rank number;',
'',
'begin',
'',
':P135_DROP_RELEASE := null;',
'',
'if :P135_DRAG_FOCUS_AREA_ID is null ',
'  or :P135_DROP_FOCUS_AREA_ID is null ',
'  or :P135_DRAG_ITEM_ID is null ',
'  or :P135_DRAG_COLUMN_ID is null ',
'  or :P135_DROP_COLUMN_ID is null ',
'  or :P135_INITIATIVE_ID is null',
'  or :P135_SR_ABOVE is null',
'  or :P135_SR_BELOW is null then',
'  raise insufficient_data;',
'end if;',
'',
'if :P135_SR_ABOVE != ''None'' and :P135_SR_BELOW != ''None'' then',
'',
'  select sum(kb_stack_rank) / 2 into lv_stack_rank from sp_projects',
'  where initiative_id = :P135_INITIATIVE_ID and id in (:P135_SR_ABOVE,:P135_SR_BELOW);',
'',
'  update sp_projects set kb_stack_rank = lv_stack_rank',
'  where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'',
'elsif :P135_SR_ABOVE = ''None'' and :P135_SR_BELOW != ''None'' then',
'',
'  select kb_stack_rank -1 into lv_stack_rank from sp_projects',
'  where initiative_id = :P135_INITIATIVE_ID and id = :P135_SR_BELOW;',
'',
'  update sp_projects set kb_stack_rank = lv_stack_rank',
'  where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'',
'elsif :P135_SR_ABOVE != ''None'' and :P135_SR_BELOW = ''None'' then',
'',
'  select kb_stack_rank +1 into lv_stack_rank from sp_projects',
'  where initiative_id = :P135_INITIATIVE_ID and id = :P135_SR_ABOVE;',
'',
'  update sp_projects set kb_stack_rank = lv_stack_rank ',
'  where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'',
'end if;',
'',
'',
'if :P135_DRAG_FOCUS_AREA_ID != :P135_DROP_FOCUS_AREA_ID then',
'  update sp_projects',
'  set focus_area_id = decode(:P135_DROP_FOCUS_AREA_ID,''Unallocated'',null,:P135_DROP_FOCUS_AREA_ID)',
'  where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'end if;',
'',
'if :P135_DRAG_COLUMN_ID != :P135_DROP_COLUMN_ID then',
'',
'  -- Get the new release name',
'  if :P135_DROP_COLUMN_ID = 0 then',
'',
'    update sp_projects',
'    set release_id = decode(:P135_DROP_COLUMN_ID,0,null,:P135_DROP_COLUMN_ID)',
'    where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'',
'    :P135_DROP_RELEASE := ''TBD'';',
'    ',
'  else',
'',
'    update sp_projects',
'    set release_id = decode(:P135_DROP_COLUMN_ID,0,null,:P135_DROP_COLUMN_ID),',
'        release_dependent_yn = ''N''',
'    where id = :P135_DRAG_ITEM_ID and initiative_id = :P135_INITIATIVE_ID;',
'  ',
'    select           ',
'      re.release_train||'' ''||re.release into :P135_DROP_RELEASE',
'      from sp_release_trains re ',
'      where re.id = :P135_DROP_COLUMN_ID;',
'    end if;',
'',
'end if;',
'',
'exception',
'',
'  when insufficient_data then RAISE_APPLICATION_ERROR(-20001, ''Insufficient Data!'');  ',
'  ',
'end;'))
,p_attribute_02=>'P135_SR_ABOVE,P135_SR_BELOW,P135_DRAG_FOCUS_AREA_ID,P135_DRAG_ITEM_ID,P135_DRAG_COLUMN_ID,P135_DROP_COLUMN_ID,P135_DROP_FOCUS_AREA_ID'
,p_attribute_03=>'P135_DROP_RELEASE'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536761295876236393)
,p_event_id=>wwv_flow_imp.id(6536760263471236388)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var lRel; ',
'',
'lRel = $v(''P135_DROP_RELEASE'');',
'',
'if (lRel) {',
'',
'  $(''#''+$v(''P135_DRAG_ITEM_ID'')+''-release'').text(lRel);',
'',
'  if ($v(''P135_DROP_RELEASE'')==''TBD'') {',
'      $(''#''+$v(''P135_DRAG_ITEM_ID'')+''-release'').next(''span'').hide();',
'  } else{',
'      $(''#''+$v(''P135_DRAG_ITEM_ID'')+''-release'').next(''span'').attr(''class'',''t-Badge-icon fa fa-asterisk'').show();',
'  }',
'',
'apex.message.showPageSuccess(''Project Move Success'');',
'',
'}',
'',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536761748680236393)
,p_name=>'Change Facets'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(141815726291224212782)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'NATIVE_FACETED_SEARCH|REGION TYPE|facetschange'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536762217509236394)
,p_event_id=>wwv_flow_imp.id(6536761748680236393)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536762617388236395)
,p_name=>'Edit Project Dialog Close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536763138160236395)
,p_event_id=>wwv_flow_imp.id(6536762617388236395)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536763508060236396)
,p_name=>'Add Project Dialog Close'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(154851375477332108559)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536763988252236396)
,p_event_id=>wwv_flow_imp.id(6536763508060236396)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536764355095236397)
,p_name=>'Drag & Drop'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536764929529236398)
,p_event_id=>wwv_flow_imp.id(6536764355095236397)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  var originCellID, originRowID, originColumnID, originID;',
'',
'  $(".kb-Sortable").sortable({',
'    connectWith: ".kb-Cell",',
'',
'    start: function(event, ui) {',
'      // Store the ID of the cell and row where the item was originally dragged from',
'      originCellID   = ui.item.closest(''.kb-Cell'').attr(''id'');',
'      originColumnID = ui.item.closest(''.kb-Cell'').attr(''data-id'');',
'      originRowID    = ui.item.closest(''.kb-Row'').attr(''id'');',
'      originID       = ui.item.attr(''id'');',
'    },',
'',
'    stop: function(event, ui) {',
'      // Find the ID of the cell and row where the item is dropped',
'      var parentCellID   = ui.item.closest(''.kb-Cell'').attr(''id'');',
'      var parentColumnID = ui.item.closest(''.kb-Cell'').attr(''data-id'');',
'      var parentRowID    = ui.item.closest(''.kb-Row'').attr(''id'');',
'',
'      // Get the Stack Rank of the divs above and below the current div (if any)',
'      var aboveItem = ui.item.prev().attr(''id'');',
'      var belowItem = ui.item.next().attr(''id'');',
'',
'',
'      $s(''P135_DROP_COLUMN_ID'',parentColumnID);',
'      $s(''P135_DRAG_COLUMN_ID'',originColumnID);',
'      $s(''P135_DRAG_ITEM_ID'',originID);',
'      $s(''P135_DROP_FOCUS_AREA_ID'',parentRowID);',
'      $s(''P135_DRAG_FOCUS_AREA_ID'',originRowID);',
'      $s(''P135_SR_ABOVE'',(aboveItem ? aboveItem : "None"));',
'      $s(''P135_SR_BELOW'',(belowItem ? belowItem : "None"));',
'',
'  ',
'      // Log the details in the console',
'      console.log("P135_SR_ABOVE: "             + $v(''P135_SR_ABOVE''));',
'      console.log("P135_SR_BELOW: "             + $v(''P135_SR_BELOW''));',
'      console.log("P135_DRAG_COLUMN_ID: "       + $v(''P135_DRAG_COLUMN_ID''));',
'      console.log("P135_DRAG_FOCUS_AREA_ID: "   + $v(''P135_DRAG_FOCUS_AREA_ID''));',
'      console.log("P135_DRAG_ITEM_ID: "         + $v(''P135_DRAG_ITEM_ID''));',
'      console.log("P135_DROP_COLUMN_ID: "       + $v(''P135_DROP_COLUMN_ID''));',
'      console.log("P135_DROP_FOCUS_AREA_ID: "   + $v(''P135_DROP_FOCUS_AREA_ID''));',
'    }',
'    ',
'  }).disableSelection();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536765317661236398)
,p_name=>'Change in Columns'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_NO_OF_COLUMNS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536765798594236399)
,p_event_id=>wwv_flow_imp.id(6536765317661236398)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6536766170657236399)
,p_name=>'Change Release Train'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_RELEASE_TRAIN'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536766651966236400)
,p_event_id=>wwv_flow_imp.id(6536766170657236399)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select listagg(release,'':'') within group (order by release_target_date, release_id),',
'count(release) into :P135_COLUMN_NAMES,:P135_COLUMN_COUNT',
'from',
'  (select ',
'  --''Release ''||replace(release||'' (''||release_open_date||'' - ''||release_target_date||'')'','':'',''.'') release, ',
'  to_char(release_open_date,''MON-RR'')||'' to ''||to_char(release_target_date,''MON-RR'')||'' (Release ''||release||'')'' release,',
'  release_target_date, id release_id',
'  from sp_release_trains',
'  where release_train = :P135_RELEASE_TRAIN',
'  and sysdate < release_target_date',
'  and release_type = ''FULL''',
'  order by release_target_date',
'  fetch first 4 rows only',
'  );'))
,p_attribute_02=>'P135_RELEASE_TRAIN'
,p_attribute_03=>'P135_COLUMN_NAMES,P135_COLUMN_COUNT'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6536767227217236401)
,p_event_id=>wwv_flow_imp.id(6536766170657236399)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155584106088334196737)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6536759860036236387)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set Items'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'---------------------------------------------',
'-- Set items for breadcrumb and navication --',
'---------------------------------------------',
'select initiative, area_id',
'into :P135_INITIATIVE, :P135_AREA_ID',
'from   sp_initiatives i',
'where  id = :P135_INITIATIVE_ID;',
'',
'',
'if :P135_RELEASE_TRAIN is null then',
'  select distinct release_train into :P135_RELEASE_TRAIN',
'  from sp_release_trains',
'  order by 1',
'  fetch first rows only;',
'end if;',
'',
'select listagg(release,'':'') within group (order by release_target_date, release_id),',
'count(release) into :P135_COLUMN_NAMES,:P135_COLUMN_COUNT',
'from',
'  (select ',
'    --''Release ''||replace(release||'' (''||release_open_date||'' - ''||release_target_date||'')'','':'',''.'') release,',
'  to_char(release_open_date,''MON-RR'')||'' to ''||to_char(release_target_date,''MON-RR'') release,',
'  release_target_date, id release_id',
'  from sp_release_trains',
'  where release_train = :P135_RELEASE_TRAIN',
'  and sysdate < release_target_date',
'  and release_type = ''FULL''',
'  order by release_target_date',
'  fetch first 4 rows only',
'  );'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>38915887009882309193
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(150994029624892785555)
,p_region_id=>wwv_flow_imp.id(154851375477332108559)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Add &NOMENCLATURE_PROJECT.'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:104:&SESSION.::&DEBUG.:104,24:P104_INITIATIVE:&P135_INITIATIVE_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-plus'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(154851375777911108562)
,p_region_id=>wwv_flow_imp.id(154851375477332108559)
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
 p_id=>wwv_flow_imp.id(128943214956253640194)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Kanban Board'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:4:P4_INITIATIVE_ID:&P135_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-columns'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(142571436918347464269)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Control Chart'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:162:&SESSION.::&DEBUG.:RP,:P162_INITIATIVE_ID:&P135_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-scatter-chart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(150709270797123148627)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>140
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:135:&SESSION.::&DEBUG.:RP,135:P135_INITIATIVE_ID:&P135_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(150709270965740148628)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>60
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(150709274406130148663)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'About Kanban'
,p_display_sequence=>120
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:163:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-info'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(150778280893171765139)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECTS. Interactive Report'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:86:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(151464566686140861349)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>110
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(152073632402743401464)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Cumulative Flow'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:161:&SESSION.::&DEBUG.:RP,:P161_INITIATIVE_ID:&P135_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-line-area-chart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(154851376483818108569)
,p_component_action_id=>wwv_flow_imp.id(154851375777911108562)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>130
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:135:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp.component_end;
end;
/
