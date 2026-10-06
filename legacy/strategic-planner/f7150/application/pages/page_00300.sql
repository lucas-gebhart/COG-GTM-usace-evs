prompt --application/pages/page_00300
begin
--   Manifest
--     PAGE: 00300
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
 p_id=>300
,p_name=>'release_projects'
,p_alias=>'RELEASE-PROJECTS'
,p_step_title=>'Release &NOMENCLATURE_PROJECTS.'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45074294665875875763)
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(() => { ',
'    apex.actions.add({',
'        name: ''favoriteProject'',',
'        action: function(event, focusElement, args) {',
'            $(event.currentTarget).addClass(''js-project-to-favorite'');',
'            apex.item(''P300_PROJECT_TO_FAVORITE'').setValue(args.id);',
'            return true;',
'            }',
'    });',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.no-item-ui {',
'  --a-field-input-border-width: 0px;',
'  --a-field-input-background-color: transparent;',
'}',
'',
'.overline {',
'  color: var(--ut-region-text-color, var(--ut-component-text-default-color));',
'}',
'',
'/* Vertically Align cells to top */',
'.t-Report td {',
'  vertical-align: top;',
'}',
'',
'@media (min-width: 640px) {',
'  .t-ContentRow-body {',
'    align-items: flex-start;',
'    /* Setting content row alignment to top */',
'  }',
'',
'  .t-ContentRow-misc {',
'    flex-basis: 40%;',
'    /* Setting misc column width so they all line up */',
'  }',
'}'))
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#:t-PageBody--noContentPadding'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38605321461051383087)
,p_plug_name=>'Facets'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_02'
,p_location=>null
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'current_facets_selector', '#active_facets',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'E',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38704363030736416965)
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
 p_id=>wwv_flow_imp.id(44284528172156809216)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(38704363030736416965)
,p_region_css_classes=>'u-flex-grow-1'
,p_region_sub_css_classes=>'header-actions'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'AVATAR_ICON', 'fa-user',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL_DISPLAY', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'Y',
  'REMOVE_PADDING', 'Y',
  'STYLE', 't-ContentRow--styleCompact')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(44284528346051809217)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39304239158551473997)
,p_plug_name=>'&NOMENCLATURE_PROJECTS.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       --',
'       -- project',
'       --',
'       p.project,',
'       p.project_size,',
'       p.TAGS project_tags,',
'       ''P''||to_char(p.priority_id) priority, ',
'       ''P''||to_char(p.priority_id) as badge_label,',
'       ''fa-pie-chart-''||p.PCT_COMPLETE as icon,',
'       p.PCT_COMPLETE||''%'' pct_complete,',
'       p.PCT_COMPLETE pct_complete_sort,',
'       p.project_url_name,',
'       p.friendly_identifier,',
'       decode(p.ACTIVE_YN,''Y'',''Active'',''Not Active'') active,',
'       decode(p.owner_id,null,''No Owner Defined'', (select first_name||'' ''||last_name from sp_team_members tm where tm.id = p.owner_id)) project_owner,',
'       decode(p.owner_id,null,''No Owner Defined'', (select email from sp_team_members tm where tm.id = p.owner_id)) owner_emails,',
'       --',
'       -- favorite',
'       --',
'       nvl((select ''Yes'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''No'') favorite,',
'       nvl((select ''fa-heart u-danger-text'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''fa-heart-o'') favorite_icon,',
'       --',
'       -- contributor list',
'       --',
'       substr((select listagg(''<br>''||apex_escape.html(xrt.RESOURCE_TYPE||'': ''||xtm.first_name||'' ''||xtm.last_name), '', '') within group (order by 1) names',
'                 from SP_PROJECT_CONTRIBUTORS xpc, SP_TEAM_MEMBERS xtm, SP_RESOURCE_TYPES xrt',
'                where xpc.project_id = p.id and',
'                      xpc.TEAM_MEMBER_ID = xtm.id and',
'                      xrt.id = xpc.RESPONSIBILITY_ID',
'             ),5) contributors,',
'       --',
'       -- reviewers list',
'       --',
'       ''<br>Reviewers: ''||(select count(*) from SP_TASKS xpr, sp_task_types tt, sp_task_statuses s',
'                            where xpr.project_id = p.id',
'                              and nvl(xpr.task_sub_type_id,xpr.task_type_id) = tt.id',
'                              and xpr.status_id = s.id',
'                              and tt.static_id like ''REVIEW%'') reviewers,',
'       --',
'       -- contributor facets',
'       --',
'       (select listagg(xtm.first_name||'' ''||xtm.last_name, '', '') within group (order by 1) names',
'       from SP_PROJECT_CONTRIBUTORS xpc, SP_TEAM_MEMBERS xtm',
'       where xpc.project_id = p.id and',
'             xpc.TEAM_MEMBER_ID = xtm.id) contributor_names,',
'       --',
'       -- reviewer facets',
'       --',
'       (select listagg(xtm.first_name||'' ''||xtm.last_name, '', '') within group (order by 1) names',
'          from SP_TASKS xpr, sp_task_types tt, SP_TEAM_MEMBERS xtm',
'         where xpr.project_id = p.id',
'           and nvl(xpr.task_sub_type_id,xpr.task_type_id) = tt.id',
'           and tt.static_id like ''REVIEW%''',
'           and xpr.OWNER_ID = xtm.id) reviewer_names,',
'       --',
'       -- review status facet',
'       --',
'       (select listagg(initcap(s.status),'', '') within group (order by 1)',
'          from SP_TASKS xpr, sp_task_types tt, sp_task_statuses s',
'         where xpr.project_id = p.id',
'           and nvl(xpr.task_sub_type_id,xpr.task_type_id) = tt.id',
'           and xpr.status_id = s.id',
'           and tt.static_id like ''REVIEW%'') review_status,',
'       --',
'       -- dates',
'       --',
'       p.updated,',
'       p.created,',
'       --',
'       -- active activity',
'       --',
'       nvl((select ''Yes'' from dual where exists (select 1 from SP_ACTIVITIES ap where ap.project_id = p.id and trunc(sysdate) between trunc(ap.start_date) and trunc(ap.end_date))),''No'') active_activity,',
'       (select ''<span class="fa fa-badge-check" aria-hidden="true" title="Current Activity Exists"></span> '' from dual where exists (',
'           select 1 ',
'           from SP_ACTIVITIES ap ',
'           where ap.project_id = p.id and trunc(sysdate) between trunc(ap.start_date) and trunc(ap.end_date))) active_activity_icon',
'',
'  from SP_PROJECTS p,',
'       SP_RELEASE_TRAINS rt',
'  where p.RELEASE_ID = rt.id and ',
'        rt.id = :P300_RELEASE_ID and',
'        p.ARCHIVED_YN = ''N'' and',
'        p.DUPLICATE_OF_PROJECT_ID is null'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>'{"orderBys":[{"key":"PRIORITY","expr":"priority asc, project"},{"key":"PCT_COMPLETE","expr":"pct_complete_sort asc, project"},{"key":"PCT_COMPLETE1","expr":"pct_complete_sort desc, project"},{"key":"PROJECT","expr":"project"},{"key":"UPDATED","expr":'
||'"updated desc, project"},{"key":"UPDATED1","expr":"updated"},{"key":"CREATED","expr":"created desc"},{"key":"CREATED1","expr":"created"}],"itemName":"P300_ORDER_BY"}'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'APP_USER_ID,P300_RELEASE_ID'
,p_plug_query_num_rows=>25
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'AVATAR_DESCRIPTION', '&PCT_COMPLETE.',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--noShape',
  'AVATAR_SIZE', 't-Avatar--sm',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'Ticket',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_VALUE', 'BADGE_LABEL',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&CONTRIBUTORS!RAW.',
    '&REVIEWERS!RAW.<br>',
    'Last Updated: &UPDATED.')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N',
  'TITLE', '&ACTIVE_ACTIVITY_ICON!RAW. &PROJECT.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38028687865388872689)
,p_name=>'REVIEWERS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REVIEWERS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38804215138596716595)
,p_name=>'FAVORITE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAVORITE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>290
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38804215256564716596)
,p_name=>'FAVORITE_ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAVORITE_ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>300
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38805633102234338679)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>310
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38805636787143338716)
,p_name=>'ACTIVE_ACTIVITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVE_ACTIVITY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>320
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38991625127343857783)
,p_name=>'ACTIVE_ACTIVITY_ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVE_ACTIVITY_ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>330
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603195954602442571)
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
 p_id=>wwv_flow_imp.id(43603196048765442572)
,p_name=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196085975442573)
,p_name=>'PROJECT_SIZE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_SIZE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196209838442574)
,p_name=>'PROJECT_TAGS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_TAGS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196319850442575)
,p_name=>'PRIORITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRIORITY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196458813442576)
,p_name=>'BADGE_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196513185442577)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196624652442578)
,p_name=>'PCT_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PCT_COMPLETE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196721770442579)
,p_name=>'PCT_COMPLETE_SORT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PCT_COMPLETE_SORT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196916568442581)
,p_name=>'PROJECT_URL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_URL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603196976512442582)
,p_name=>'FRIENDLY_IDENTIFIER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FRIENDLY_IDENTIFIER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603197393861442586)
,p_name=>'ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603197475062442587)
,p_name=>'PROJECT_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603197618586442588)
,p_name=>'OWNER_EMAILS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OWNER_EMAILS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603197823137442590)
,p_name=>'CONTRIBUTORS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CONTRIBUTORS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603197969103442592)
,p_name=>'CONTRIBUTOR_NAMES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CONTRIBUTOR_NAMES'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603198127783442593)
,p_name=>'REVIEWER_NAMES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REVIEWER_NAMES'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>230
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603198427441442596)
,p_name=>'REVIEW_STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REVIEW_STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(43603198539976442597)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>270
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(43687280926275577011)
,p_plug_name=>'sorting'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>3
,p_location=>null
,p_plug_source=>'<div id="active_facets"></div>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(48811493004929823762)
,p_name=>'Release'
,p_template=>4072358936313175081
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody:t-Region-orderBy--end'
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
'       -- release projects',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.release_id = r.id and ',
'              p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       round(r.RELEASE_TARGET_DATE - r.RELEASE_OPEN_DATE) release_length,',
'       --',
'       -- contributors',
'       --',
'       (select count(distinct TEAM_MEMBER_ID) ',
'        from SP_PROJECT_CONTRIBUTORS c ',
'        where c.PROJECT_ID in (',
'            select id ',
'            from sp_projects p ',
'            where p.release_id = r.id and ',
'                  p.ARCHIVED_YN = ''N'' and ',
'                  p.DUPLICATE_OF_PROJECT_ID is null)',
'                  ) contributors,',
'       --',
'       r.RELEASE_MANAGEMENT_URL url,',
'       --',
'       -- current activity',
'       --',
'       (select count(*) ',
'        from  sp_projects p, SP_ACTIVITIES a',
'        where p.ARCHIVED_YN = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and ',
'              p.release_id = r.id and',
'              p.id = a.project_id and',
'              sysdate >= a.START_DATE and',
'              trunc(sysdate) <= a.END_DATE',
'              ) projects_with_current_activity,',
'       --',
'       -- milestones',
'       --',
'       (select count(*) from SP_RELEASE_MILESTONES m where m.release_id = r.id) milestones',
'  from SP_RELEASE_TRAINS r',
' where r.id = :P300_RELEASE_ID '))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P300_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(39144389351866300306)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39144389665756300307)
,p_query_column_id=>2
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39144390110449300308)
,p_query_column_id=>3
,p_column_alias=>'RELEASE_TARGET_DATE'
,p_column_display_sequence=>90
,p_column_heading=>'Target Complete'
,p_column_format=>'DD-MON-YY'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39144387668139300300)
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
 p_id=>wwv_flow_imp.id(39144971187185047687)
,p_query_column_id=>5
,p_column_alias=>'DAYS_REMAINING'
,p_column_display_sequence=>110
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
 p_id=>wwv_flow_imp.id(39144388146666300302)
,p_query_column_id=>6
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>120
,p_column_heading=>'&NOMENCLATURE_PROJECTS.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39144971738767047692)
,p_query_column_id=>7
,p_column_alias=>'RELEASE_LENGTH'
,p_column_display_sequence=>100
,p_column_heading=>'Length'
,p_column_html_expression=>'#RELEASE_LENGTH# days'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39144388885681300304)
,p_query_column_id=>8
,p_column_alias=>'CONTRIBUTORS'
,p_column_display_sequence=>140
,p_column_heading=>'Contributors'
,p_column_link=>'f?p=&APP_ID.:38:&SESSION.::&DEBUG.:RP,38:P38_ID:&P300_RELEASE_ID.'
,p_column_linktext=>'#CONTRIBUTORS#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38317532339414869287)
,p_query_column_id=>9
,p_column_alias=>'URL'
,p_column_display_sequence=>170
,p_column_heading=>'URL'
,p_column_html_expression=>'<a href="#URL#" target="_blank">Open URL</a>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from SP_RELEASE_TRAINS ',
'where RELEASE_MANAGEMENT_URL is not null and id = :P300_RELEASE_ID'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39342258741978282788)
,p_query_column_id=>10
,p_column_alias=>'PROJECTS_WITH_CURRENT_ACTIVITY'
,p_column_display_sequence=>180
,p_column_heading=>'Projects With Current Activity'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39342258862008282789)
,p_query_column_id=>11
,p_column_alias=>'MILESTONES'
,p_column_display_sequence=>190
,p_column_heading=>'Milestones'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38705474456947000506)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38704363030736416965)
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
 p_id=>wwv_flow_imp.id(38605321524862383088)
,p_name=>'P300_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
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
 p_id=>wwv_flow_imp.id(38605321632211383089)
,p_name=>'P300_PROJECT_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'&NOMENCLATURE_PROJECT. Tags'
,p_source=>'PROJECT_TAGS'
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
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38605323188122383105)
,p_name=>'P300_PROJECT_SIZE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'&NOMENCLATURE_PROJECT.  Size'
,p_source=>'PROJECT_SIZE'
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
,p_fc_display_as=>'FILTER_DIALOG'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38794135996502110674)
,p_name=>'P300_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'&NOMENCLATURE_PROJECT. Priority'
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
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38794137809359110692)
,p_name=>'P300_REVIEW_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Review Status'
,p_source=>'REVIEW_STATUS'
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
,p_fc_display_as=>'FILTER_DIALOG'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38804215540894716599)
,p_name=>'P300_FAVORITE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'My Favorites'
,p_source=>'FAVORITE'
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
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38805636891835338717)
,p_name=>'P300_ACTIVE_ACTIVITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Current Activity'
,p_source=>'ACTIVE_ACTIVITY'
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
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38991625228270857784)
,p_name=>'P300_PROJECT_TO_FAVORITE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39304239158551473997)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39144970292613047678)
,p_name=>'P300_REVIEWER_NAMES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Reviewers'
,p_source=>'REVIEWER_NAMES'
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
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39144970649548047681)
,p_name=>'P300_CONTRIBUTOR_NAMES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Contributors'
,p_source=>'CONTRIBUTOR_NAMES'
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
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39144970933467047684)
,p_name=>'P300_PCT_COMPLETE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'% Complete'
,p_source=>'PCT_COMPLETE'
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
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39320602053662315801)
,p_name=>'P300_RELEASE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38704363030736416965)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39320602988591315811)
,p_name=>'P300_RELEASE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38704363030736416965)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39433016912848377583)
,p_name=>'P300_ORDER_BY'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(43687280926275577011)
,p_item_display_point=>'NEXT'
,p_item_default=>'PRIORITY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Priority;PRIORITY,% Complete;PCT_COMPLETE,% Complete desc;PCT_COMPLETE1,Project;PROJECT,Updated Desc;UPDATED,Updated Asc;UPDATED1,Created Desc;CREATED,Created Asc;CREATED1'
,p_cHeight=>1
,p_tag_css_classes=>'w200 no-item-ui'
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-asc'
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39666354064600177612)
,p_name=>'P300_INITIATIVE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38704363030736416965)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40990338913474247800)
,p_name=>'P300_PROJECT_OWNER1'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Owner'
,p_source=>'PROJECT_OWNER'
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
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40990339117182247802)
,p_name=>'P300_OWNER_EMAILS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(38605321461051383087)
,p_prompt=>'Owner Emails'
,p_source=>'OWNER_EMAILS'
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
,p_fc_display_as=>'FILTER_DIALOG'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(39320603068288315812)
,p_computation_sequence=>10
,p_computation_item=>'P300_RELEASE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.RELEASE_TRAIN||'' ''||r.RELEASE release',
'  from SP_RELEASE_TRAINS r',
' where r.id = :P300_RELEASE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(39666354130936177613)
,p_computation_sequence=>20
,p_computation_item=>'P300_INITIATIVE_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initiative_id ',
'from SP_projects',
'where release_id = :P300_RELEASE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40990338286824247794)
,p_computation_sequence=>30
,p_computation_item=>'LAST_PROJECT_VIEW'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'300'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38711487671729367415)
,p_name=>'change'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_RELEASE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38711487858934367416)
,p_event_id=>wwv_flow_imp.id(38711487671729367415)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P300_RELEASE_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38711488001087367418)
,p_event_id=>wwv_flow_imp.id(38711487671729367415)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38605321461051383087)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38794140145659110715)
,p_event_id=>wwv_flow_imp.id(38711487671729367415)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48811493004929823762)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39144971477604047690)
,p_name=>'dialog close bc'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(38704363030736416965)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39144971577148047691)
,p_event_id=>wwv_flow_imp.id(39144971477604047690)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48811493004929823762)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39433017094031377585)
,p_name=>'refresh on dialog close'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39433017199830377586)
,p_event_id=>wwv_flow_imp.id(39433017094031377585)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39433017319820377587)
,p_event_id=>wwv_flow_imp.id(39433017094031377585)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38605321461051383087)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40288904722763420809)
,p_name=>'refresh on dialog closed 1'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(38704363030736416965)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40288904838569420810)
,p_event_id=>wwv_flow_imp.id(40288904722763420809)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48811493004929823762)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40288904928039420811)
,p_event_id=>wwv_flow_imp.id(40288904722763420809)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38605321461051383087)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38991625317231857785)
,p_name=>'set favorite'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_PROJECT_TO_FAVORITE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38991625366992857786)
,p_event_id=>wwv_flow_imp.id(38991625317231857785)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_favorite_toggle(',
'    p_project_id  => :P300_PROJECT_TO_FAVORITE, ',
'    p_app_user_id => :APP_USER_ID',
'    );'))
,p_attribute_02=>'P300_PROJECT_TO_FAVORITE,APP_USER_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38991625476438857787)
,p_event_id=>wwv_flow_imp.id(38991625317231857785)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var favButton$ = $(".js-project-to-favorite");',
'var favButtonIcon$ = favButton$.find(".t-Icon");',
'',
'// we use the class to get the active element, can be cleared now',
'favButton$.removeClass("js-project-to-favorite"); ',
'',
'if ( favButtonIcon$.hasClass("fa-heart") ) {',
'    favButtonIcon$.removeClass("fa-heart u-danger-text").addClass("fa-heart-o");',
'    // hide success message, no API to do this so done with classes',
'    $( "#APEX_SUCCESS_MESSAGE" ).removeClass("u-visible").addClass("u-hidden"); ',
'} else if ( favButtonIcon$.hasClass("fa-heart-o") ) {',
'    favButtonIcon$.removeClass("fa-heart-o").addClass("fa-heart u-danger-text");',
'    apex.message.showPageSuccess(''Project favorited!'');',
'}',
'apex.items.P300_PROJECT_TO_FAVORITE.setValue('''',undefined,true); //third parameter used to suppress change event'))
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(38991625643657857788)
,p_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_position_id=>362316004162771045
,p_display_sequence=>30
,p_template_id=>362316605839802174
,p_label=>'Favorite'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$favoriteProject?id=&ID.'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'&FAVORITE_ICON.'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(43603198692649442599)
,p_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_position_id=>348722977165395441
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&FRIENDLY_IDENTIFIER.,&PROJECT_URL_NAME.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(43603198900555442601)
,p_region_id=>wwv_flow_imp.id(39304239158551473997)
,p_position_id=>362316004162771045
,p_display_sequence=>40
,p_template_id=>362317865359806322
,p_label=>'Actions Menu'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(44284528376142809218)
,p_region_id=>wwv_flow_imp.id(44284528172156809216)
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
 p_id=>wwv_flow_imp.id(37964439389580036071)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>120
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(37964439517020036072)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>110
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(37964440535936036082)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Release'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:RP,27:P27_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(37964440595263036083)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>40
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(37964440752684036084)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>130
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:RP,300:P300_RELEASE_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38072385266983321319)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Quick View'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:&ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38305341023308761590)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'About Releases'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:108:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-info'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39007334261251180993)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Activity Quick View'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:130:&SESSION.::&DEBUG.:RP,130:P130_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-badge-check'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39600687976039397870)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39600689518154397885)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Add Activity'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-plus'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39600689821187397888)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>90
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39600689902423397889)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Change History'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:124:&SESSION.::&DEBUG.:RP,124:P124_ID:&ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39600689990444397890)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Tag Change History'
,p_display_sequence=>110
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:82:&SESSION.::&DEBUG.:RP,82:P82_ID:&ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41621599570865453072)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Home'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,:P117_RELEASE_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-ship'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(43603198976073442602)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit &NOMENCLATURE_PROJECT.'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:24:P24_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(43603199160552442603)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Details'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&FRIENDLY_IDENTIFIER.,&PROJECT_URL_NAME.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(43603199182108442604)
,p_component_action_id=>wwv_flow_imp.id(43603198900555442601)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Comment'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.:RP,100:P100_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-comment-o'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382010957114366511)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>80
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382010990744366512)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Dashboard'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:202:&SESSION.::&DEBUG.:RP,202:P202_RELEASE_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-area-chart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382011148949366513)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Calendar'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:RP,203:P203_RELEASE_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-calendar-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(50382011215220366514)
,p_component_action_id=>wwv_flow_imp.id(44284528376142809218)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:RP,14:P14_RELEASE_ID:&P300_RELEASE_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp.component_end;
end;
/
