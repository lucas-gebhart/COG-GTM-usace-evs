prompt --application/pages/page_00008
begin
--   Manifest
--     PAGE: 00008
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
 p_id=>8
,p_name=>'Releases'
,p_alias=>'RELEASES'
,p_step_title=>'Releases'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45074294665875875763)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.no-item-ui {',
'  --a-field-input-border-width: 0px;',
'  --a-field-input-background-color: transparent;',
'}',
'',
'.overline {',
'  color: var(--ut-region-text-color, var(--ut-component-text-default-color));',
'}'))
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#:t-PageBody--noContentPadding'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40652051507549630655)
,p_plug_name=>'Releases'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>50
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, ',
'       release_train, ',
'       release_owner_id,',
'       nvl(release_owner,''(No Owner)'') release_owner,',
'       release,',
'       timeline,',
'       days_remaining,',
'       badge_state,',
'       RELEASE_OPEN_DATE,',
'       RELEASE_TARGET_DATE,',
'       to_char(RELEASE_TARGET_DATE,''YYYY'') RELEASE_TARGET_YEAR,',
'       UPDATED,',
'       duration_in_days,',
'       AVG_PCT_COMPLETE,',
'       completed,',
'       not_completed,',
'       contributors,',
'       last_updated,',
'       projects,',
'       --',
'       -- release type Full or Patch',
'       --',
'       initcap(nvl(release_type,''FULL'')) release_type,',
'       --',
'       -- percent of projects fully completed',
'       --',
'       round(',
'           100 *',
'           decode(nvl(not_completed,0),',
'                  0,0,',
'                  completed / (nvl(completed,0) + nvl(not_completed,0))',
'                  )',
'            ) pct_complete,',
'       ''fa-pie-chart-''||round(.1 * ',
'           AVG_PCT_COMPLETE)*10 icon,',
'      window,',
'      --',
'      -- release milestone counts',
'      --',
'      milestones,',
'      completed_milestones',
'from (',
'--',
'-- Inline Query',
'--',
'select ',
'       r.ID,',
'       --',
'       -- release attributes',
'       --',
'       r.RELEASE_OPEN_DATE,',
'       r.RELEASE_TARGET_DATE,',
'       r.UPDATED,',
'       r.RELEASE_TARGET_DATE - r.RELEASE_OPEN_DATE duration_in_days,',
'       r.RELEASE_TRAIN,',
'       r.RELEASE_OWNER_ID,',
'       --',
'       -- release owner',
'       --',
'       (select first_Name||'' ''||last_name from sp_team_members tm where tm.id =  r.RELEASE_OWNER_ID) release_owner,',
'       --',
'       -- release',
'       --',
'       r.RELEASE_TRAIN||'' ''||r.RELEASE RELEASE, ',
'       --',
'       -- release date timeline (from open to targeted complete) for display in UI',
'       --',
'       to_char(r.RELEASE_OPEN_DATE,''Day DD-MON-YYYY'')||'' to ''||to_char(r.RELEASE_TARGET_DATE,''Day DD-MON-YYYY'') timeline,',
'       --',
'       -- Days remaining for release',
'       --',
'       case ',
'           when r.release_completed = ''Y''',
'           then ''Completed''',
'           else trunc(r.RELEASE_TARGET_DATE) - trunc(sysdate) || '' Days Remaining''',
'           end as days_remaining,',
'       --',
'       -- State of release "danger", "warning", or "success"',
'       --',
'       case ',
'           when r.release_completed = ''Y'' then ''success''',
'           when trunc(r.release_open_date) > trunc(sysdate) then ''success''',
'           when trunc(r.RELEASE_TARGET_DATE) > trunc(sysdate) then ''success''',
'           when trunc(r.RELEASE_TARGET_DATE) - trunc(sysdate) < 15 then ''warning''  ',
'           else ''danger''',
'        end as badge_state,',
'       --',
'       -- Count of projects targeted for release',
'       --',
'       (select count(*) ',
'          from sp_projects p ',
'         where p.release_id = r.id  ',
'           and p.ARCHIVED_YN = ''N''',
'           and p.duplicate_of_project_id is null) projects,',
'       --',
'       -- average percent complete of projects for a release',
'       --',
'       nvl((select round(avg(p.PCT_COMPLETE))',
'              from sp_projects p ',
'             where p.release_id = r.id',
'               and p.ARCHIVED_YN = ''N''',
'               and p.duplicate_of_project_id is null), 0) AVG_PCT_COMPLETE,',
'       --',
'       -- fully completed projects for a given release',
'       --',
'       (select count(*) ',
'          from sp_projects p ',
'         where p.release_id = r.id ',
'           and p.pct_complete = 100  ',
'           and p.ARCHIVED_YN = ''N''',
'           and p.duplicate_of_project_id is null) completed,',
'       --',
'       -- Open (not completed) projects for a given release',
'       --',
'       (select count(*) ',
'          from sp_projects p ',
'         where p.release_id = r.id ',
'           and p.pct_complete != 100  ',
'           and p.ARCHIVED_YN = ''N''',
'           and p.duplicate_of_project_id is null)  not_completed,',
'       --',
'       -- Count of distinct team members identified as a task owner',
'       --',
'       (select count(distinct OWNER_ID) ',
'          from SP_TASKS c ',
'         where c.PROJECT_ID in (select id ',
'                                  from sp_projects p',
'                                 where p.release_id = r.id',
'                                   and p.ARCHIVED_YN = ''N''',
'                                   and p.duplicate_of_project_id is null)) contributors,',
'       --',
'       -- Most recent update to release project or release train',
'       --',
'       greatest(nvl((select max(updated) ',
'                       from sp_projects p ',
'                      where p.release_id = r.id',
'                        and p.ARCHIVED_YN = ''N''',
'                        and p.duplicate_of_project_id is null),r.updated),r.updated) last_updated,',
'       case when release_open_completed = ''Y'' and nvl(release_completed,''N'') = ''N''',
'            then ''Open''',
'            when nvl(release_open_completed,''N'') = ''N''',
'            then ''Future''',
'            else ''Closed'' ',
'            end window,',
'       --',
'       -- milestone counts',
'       --',
'       (select count(*) from SP_RELEASE_MILESTONES m where m.RELEASE_ID = r.id) milestones,',
'       (select count(*) from SP_RELEASE_MILESTONES m where m.RELEASE_ID = r.id and m.MILESTONE_COMPLETED_YN = ''Y'') completed_milestones,',
'       release_type',
'  from SP_RELEASE_TRAINS r',
') x'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>'{"orderBys":[{"key":"RELEASE","expr":"release"},{"key":"RELEASE_OPEN_DATE","expr":"release_open_date"},{"key":"RELEASE_TARGET_DATE1","expr":"release_target_date"},{"key":"UPDATED","expr":"updated desc"}],"itemName":"P8_ORDER_BY"}'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>30
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
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
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'DAYS_REMAINING',
  'DESCRIPTION', '&COMPLETED./&PROJECTS. Completed (&AVG_PCT_COMPLETE.% Progress based on status, &PCT_COMPLETE.% Fully Complete)',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    'Updated: &LAST_UPDATED.<br />',
    '&MILESTONES. Milestones, &COMPLETED_MILESTONES. completed')),
  'OVERLINE', '&TIMELINE!HTML.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&RELEASE!HTML. - &RELEASE_TYPE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38394338691212517580)
,p_name=>'RELEASE_TARGET_YEAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TARGET_YEAR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39223155469307110272)
,p_name=>'WINDOW'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WINDOW'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302607617215628102)
,p_name=>'RELEASE_TRAIN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TRAIN'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302607656208628103)
,p_name=>'RELEASE_OWNER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OWNER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302607808119628104)
,p_name=>'RELEASE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302607866508628105)
,p_name=>'RELEASE_OPEN_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OPEN_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608013190628106)
,p_name=>'RELEASE_TARGET_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TARGET_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608095959628107)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608213783628108)
,p_name=>'DURATION_IN_DAYS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DURATION_IN_DAYS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608347469628110)
,p_name=>'AVG_PCT_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AVG_PCT_COMPLETE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608458284628111)
,p_name=>'COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLETED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608547493628112)
,p_name=>'NOT_COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOT_COMPLETED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608631275628113)
,p_name=>'CONTRIBUTORS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CONTRIBUTORS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>130
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40302608821308628114)
,p_name=>'TIMELINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMELINE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40652052020684630661)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_is_required=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40653443648760565124)
,p_name=>'LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41077175476022949186)
,p_name=>'DAYS_REMAINING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS_REMAINING'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41077175618149949187)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41344230241464884607)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41344230382453884608)
,p_name=>'PCT_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PCT_COMPLETE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45195748945259094404)
,p_name=>'PROJECTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECTS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45628233466279527474)
,p_name=>'RELEASE_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>230
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45628233702469527476)
,p_name=>'MILESTONES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MILESTONES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>240
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45628233851862527477)
,p_name=>'COMPLETED_MILESTONES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLETED_MILESTONES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>250
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205373807412421171)
,p_name=>'RELEASE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41556302447891414635)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42420645802924429453)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(41556302447891414635)
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
 p_id=>wwv_flow_imp.id(42420647036430429465)
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
 p_id=>wwv_flow_imp.id(44360479842521793092)
,p_plug_name=>'Faceted Search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_location=>null
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(40652051507549630655)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44360482243870793116)
,p_plug_name=>'Items'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38314990226365349379)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(41556302447891414635)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44360479918999793093)
,p_name=>'P8_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44360480041967793094)
,p_name=>'P8_RELEASE_TARGET_YEAR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Release Year'
,p_source=>'RELEASE_TARGET_YEAR'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'DESC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44360480071621793095)
,p_name=>'P8_RELEASE_TRAIN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Release Train'
,p_source=>'RELEASE_TRAIN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44360480357906793097)
,p_name=>'P8_WINDOW'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Window'
,p_source=>'WINDOW'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44360480428752793098)
,p_name=>'P8_ORDER_BY'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44360482243870793116)
,p_item_display_point=>'NEXT'
,p_item_default=>'RELEASE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Release;RELEASE,Release Open Date;RELEASE_OPEN_DATE,Release Target Date;RELEASE_TARGET_DATE1,Updated - Most Recent First;UPDATED'
,p_cHeight=>1
,p_tag_css_classes=>'w300 no-item-ui'
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-asc'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45628233620662527475)
,p_name=>'P8_RELEASE_OWNER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Owner'
,p_source=>'RELEASE_OWNER'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46901091268981793907)
,p_name=>'P8_RELEASE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(44360479842521793092)
,p_prompt=>'Release Type'
,p_source=>'RELEASE_TYPE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38991626309003857795)
,p_computation_sequence=>10
,p_computation_item=>'LAST_PROJ_JUMP_PG'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'8'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41363080815374330413)
,p_name=>'after edit closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40652051507549630655)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41363080943820330414)
,p_event_id=>wwv_flow_imp.id(41363080815374330413)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(44360479842521793092)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41363081050463330415)
,p_event_id=>wwv_flow_imp.id(41363080815374330413)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40652051507549630655)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(45628233328947527472)
,p_name=>'refresh releases on dc'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(41556302447891414635)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(45628233390654527473)
,p_event_id=>wwv_flow_imp.id(45628233328947527472)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40652051507549630655)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(38579315110017777678)
,p_region_id=>wwv_flow_imp.id(42420645802924429453)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Add Release'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:RP,27::'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-plus'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40302609138413628118)
,p_region_id=>wwv_flow_imp.id(40652051507549630655)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,117:P117_RELEASE_ID:&ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40653443258894565120)
,p_region_id=>wwv_flow_imp.id(40652051507549630655)
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
 p_id=>wwv_flow_imp.id(42420646103503429456)
,p_region_id=>wwv_flow_imp.id(42420645802924429453)
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
 p_id=>wwv_flow_imp.id(29014889833531880761)
,p_component_action_id=>wwv_flow_imp.id(40653443258894565120)
,p_menu_entry_type=>'ENTRY'
,p_label=>'AI Summaries'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:165:&SESSION.::&DEBUG.:RP,165:P165_RELEASE_ID:&ID.'
,p_icon_css_classes=>'fa-ai-sparkle-generate-text'
,p_build_option_id=>wwv_flow_imp.id(30769244999117825609)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39651966832530526722)
,p_component_action_id=>wwv_flow_imp.id(42420646103503429456)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP,8::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39651967023682526723)
,p_component_action_id=>wwv_flow_imp.id(42420646103503429456)
,p_menu_entry_type=>'ENTRY'
,p_label=>'About Releases'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:108:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-info'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40653443433163565122)
,p_component_action_id=>wwv_flow_imp.id(40653443258894565120)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Release'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:RP,27:P27_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40653443611403565123)
,p_component_action_id=>wwv_flow_imp.id(40653443258894565120)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release &NOMENCLATURE_PROJECTS. '
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:RP,:P300_RELEASE_ID:&ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41363080062151330405)
,p_component_action_id=>wwv_flow_imp.id(42420646103503429456)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Copy Release'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:63:&SESSION.::&DEBUG.:RP,63::'
,p_icon_css_classes=>'fa-copy'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41621599380188453070)
,p_component_action_id=>wwv_flow_imp.id(40653443258894565120)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Details'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,117:P117_RELEASE_ID:&ID.'
,p_icon_css_classes=>'fa-ship'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42420646809410429463)
,p_component_action_id=>wwv_flow_imp.id(42420646103503429456)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(48350755581281283545)
,p_component_action_id=>wwv_flow_imp.id(42420646103503429456)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>40
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52002292704324278507)
,p_component_action_id=>wwv_flow_imp.id(40653443258894565120)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>40
);
wwv_flow_imp.component_end;
end;
/
