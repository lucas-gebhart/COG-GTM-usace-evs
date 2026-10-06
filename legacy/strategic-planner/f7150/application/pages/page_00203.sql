prompt --application/pages/page_00203
begin
--   Manifest
--     PAGE: 00203
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
 p_id=>203
,p_name=>'Release Calendar'
,p_alias=>'RELEASE-CALENDAR'
,p_step_title=>'Release Calendar'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45074294665875875763)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41993691238844342243)
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
 p_id=>wwv_flow_imp.id(91984153119641931912)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(41993691238844342243)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>30
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
 p_id=>wwv_flow_imp.id(91984154353147931924)
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
 p_id=>wwv_flow_imp.id(41993691943888342254)
,p_plug_name=>'Search Results'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--hiddenOverflow'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, ',
'       event_type,',
'       focus_area,',
'       --',
'       -- attributes',
'       --',
'       owner,',
'       start_date,',
'       "DATE" the_date,',
'       milestone_type,',
'       milestone,',
'       milestone||'': ''||event display_value,',
'       event,',
'       event_detail,',
'       case when priority_id is not null then ''P''||to_char(priority_id) end priority,',
'       --',
'       -- badge state',
'       --',
'--       case when is_completed = ''Completed'' then ''apex-cal-green''',
'--            when trunc("DATE") < trunc(sysdate) then ''apex-cal-red''',
'--            else ''apex-cal-yellow''',
'--       end as event_color,',
'       case when calendar_event_color is not null',
'            then ''apex-cal-''||calendar_event_color',
'            end event_color,',
'       --',
'       -- is completed, past due or open',
'       --',
'       case when "DATE" is null then ''Missing''',
'            when is_completed = ''Completed'' then ''Completed''',
'            when trunc("DATE") < trunc(sysdate) then ''Past Due''',
'            else ''Open''',
'       end as is_completed,',
'       --',
'       -- badge icon',
'       --',
'       case when is_completed = ''Completed'' then ''fa-check''',
'            when trunc("DATE") < trunc(sysdate) then ''fa-exclamation-triangle-o''',
'            else ''fa-play''',
'       end as badge_icon,',
'       --',
'       -- icon',
'       --',
'       case milestone ',
'            when ''Spec Complete'' then ''fa-file-text-o''',
'            when ''Demonstrable'' then ''fa-window-play''',
'            when ''Code Complete'' then ''fa-file-check''',
'            when ''Merged'' then ''fa-code-fork''',
'       end as icon,',
'       --',
'       -- link info',
'       --',
'       case when link_type = ''P'' then apex_page.get_url(p_page   => 3,',
'                                                        p_items  => ''FI,PN'',',
'                                                        p_values => fi||'',''||pn,',
'                                                        p_clear_cache => 3)',
'            when link_type = ''R'' then apex_page.get_url(p_page   => 117,',
'                                                        p_items  => ''P117_RELEASE_ID'',',
'                                                        p_values => ID,',
'                                                        p_clear_cache => 117)',
'            end link,',
'       fi,',
'       pn',
'from (',
'--',
'-- milestones',
'--',
'select ''P'' link_type,',
'       :NOMENCLATURE_PROJECT event_type,',
'       p.id as "ID",',
'       case when tm.id is not null',
'            then tm.first_name||'' ''||tm.last_Name',
'            end  owner,',
'       t.target_complete                                                 as "START_DATE",',
'       t.target_complete                                                 as "DATE",',
'       to_char(t.target_complete,''YYYY.MM'')                                as "MONTH",',
'       tt.task_type                                                      as milestone_type,',
'       tt.task_type                                                      as milestone,',
'       p.project                                                         as event,',
'       case when tm.id is not null ',
'            then tm.first_name||'' ''||tm.last_Name||'', ''',
'            end ||''P''||p.priority_id||'', ''||p.PROJECT_SIZE  as event_detail,',
'       decode(s.indicates_complete_yn,''N'',''Open'',''Y'',''Completed'',''Unknown'')    as is_completed,',
'       p.FRIENDLY_IDENTIFIER fi,',
'       p.PROJECT_URL_NAME pn,',
'       p.priority_id,',
'       NVL((select focus_area from sp_initiative_focus_areas',
'             where id = p.focus_area_id),''Not Identified'') focus_area,',
'       null calendar_event_color',
'  from sp_projects p,',
'       SP_TEAM_MEMBERS tm,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_statuses s',
'  where t.OWNER_ID = tm.id (+) and',
'        t.target_complete is not null and',
'        p.RELEASE_ID = :P203_RELEASE_ID and',
'        p.ARCHIVED_YN = ''N'' and ',
'        p.duplicate_of_project_id is null and',
'        p.id = t.project_id and',
'        nvl(t.task_sub_type_id,t.task_type_id) = tt.id and',
'        tt.static_id like ''MILESTONE%'' and',
'        t.status_id = s.id',
'union all',
'select ''R'' link_type,',
'       ''Release'' event_type,',
'       RELEASE_ID as "ID",',
'       null                               as owner,',
'       nvl(milestone_start_date,milestone_date) as "START_DATE",',
'       milestone_date                     as "DATE",',
'       to_char(milestone_date,''YYYY.MM'')  as "MONTH",',
'       t.milestone_type                   as milestone_type,',
'       milestone_name                     as milestone,',
'       null                               as event,',
'       milestone_description              as event_detail,',
'       decode(milestone_completed_yn,''Y'',''Completed'',''Open'')    as is_completed,',
'       null fi,',
'       null pn,',
'       null priority_id,',
'       null focus_area,',
'       t.calendar_event_color',
'  from sp_release_milestones m,',
'       sp_release_milestone_types t',
'  where RELEASE_ID = :P203_RELEASE_ID     ',
'    and m.milestone_type_id = t.id (+) ',
') x'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CSS_CALENDAR'
,p_plug_footer=>'&nbsp;&nbsp;Event colors come from Release Milestone Types'
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function (pOptions) {   ',
'',
'    //If you like to know what pOptions contains, uncomment below',
'    console.log(pOptions);',
'',
'    pOptions.contentHeight = 500;',
'    //return pOptions',
'    return pOptions;',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'additional_calendar_views', 'list:navigation',
  'css_class', 'EVENT_COLOR',
  'display_column', 'DISPLAY_VALUE',
  'drag_and_drop', 'N',
  'end_date_column', 'THE_DATE',
  'event_sorting', 'AUTOMATIC',
  'maximum_events_day', '10',
  'multiple_line_event', 'Y',
  'primary_key_column', 'ID',
  'show_time', 'N',
  'show_tooltip', 'Y',
  'show_weekend', 'Y',
  'start_date_column', 'START_DATE',
  'supplemental_information', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&OWNER. &PRIORITY.<br/>',
    '&IS_COMPLETED.')),
  'view_edit_link', '&LINK.')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41993692013006342254)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(41993691943888342254)
,p_landmark_label=>'Filters'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'current_facets_selector', '#active_facets',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'E',
  'show_total_row_count', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41993694394630342259)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>'<div id="active_facets"></div>'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(108159141250017076169)
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
' where r.id = :P203_RELEASE_ID and ',
'       r.RELEASE_OWNER_ID = t.id(+)'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_RELEASE_ID'
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
 p_id=>wwv_flow_imp.id(41998021141128062154)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41998021519075062155)
,p_query_column_id=>2
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41998019469997062153)
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
 p_id=>wwv_flow_imp.id(41998019885840062153)
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
 p_id=>wwv_flow_imp.id(41998021873853062155)
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
 p_id=>wwv_flow_imp.id(41998020343370062154)
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
 p_id=>wwv_flow_imp.id(41998020736491062154)
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
 p_id=>wwv_flow_imp.id(41998022303669062155)
,p_query_column_id=>8
,p_column_alias=>'OWNER'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41998022760917062156)
,p_query_column_id=>9
,p_column_alias=>'RELEASE_OPENED'
,p_column_display_sequence=>140
,p_column_heading=>'Release Opened'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41998019149689062152)
,p_query_column_id=>10
,p_column_alias=>'RELEASE_COMPLETED'
,p_column_display_sequence=>130
,p_column_heading=>'Release Completed'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40972228752497736081)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(41993694394630342259)
,p_button_name=>'report_view'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Report View'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RR,::'
,p_icon_css_classes=>'fa-table'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41993694872209342260)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(41993694394630342259)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:203:&APP_SESSION.::&DEBUG.:RR,203::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41998013657319060883)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(41993691238844342243)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40972228180514736076)
,p_name=>'P203_EVENT_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'Associated With'
,p_source=>'EVENT_TYPE'
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
 p_id=>wwv_flow_imp.id(40972228369314736078)
,p_name=>'P203_MILESTONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'Milestone'
,p_source=>'MILESTONE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_display_when_type=>'NEVER'
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
 p_id=>wwv_flow_imp.id(40972228496244736079)
,p_name=>'P203_FOCUS_AREA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'&NOMENCLATURE_PROJECT. Focus Area'
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
 p_id=>wwv_flow_imp.id(40972229480197736089)
,p_name=>'P203_MILESTONE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'Type'
,p_source=>'MILESTONE_TYPE'
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
 p_id=>wwv_flow_imp.id(41993692533457342255)
,p_name=>'P203_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'Search'
,p_source=>'OWNER,MILESTONE,DISPLAY_VALUE,EVENT,EVENT_DETAIL,PRIORITY,EVENT_COLOR,IS_COMPLETED,BADGE_ICON,ICON,LINK,FI,PN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'collapsed_search_field', 'N',
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_collapsible=>false
,p_fc_initial_collapsed=>false
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41993692883285342258)
,p_name=>'P203_OWNER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'&NOMENCLATURE_PROJECT. Owner'
,p_source=>'OWNER'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
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
 p_id=>wwv_flow_imp.id(41993693359427342258)
,p_name=>'P203_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'&NOMENCLATURE_PROJECT. Priority'
,p_source=>'PRIORITY'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
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
 p_id=>wwv_flow_imp.id(41993693688617342258)
,p_name=>'P203_IS_COMPLETED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(41993692013006342254)
,p_prompt=>'Completed'
,p_source=>'IS_COMPLETED'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
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
 p_id=>wwv_flow_imp.id(69944343541826280882)
,p_name=>'P203_RELEASE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(108159141250017076169)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(70923227505021419539)
,p_name=>'P203_RELEASE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(108159141250017076169)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41998261287031783906)
,p_computation_sequence=>40
,p_computation_item=>'P203_RELEASE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select release_train||'' ''||release d ',
'  from sp_release_trains',
' where id = :P203_RELEASE_ID'))
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(91984153420220931915)
,p_region_id=>wwv_flow_imp.id(91984153119641931912)
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
 p_id=>wwv_flow_imp.id(55480496000217150482)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Dashboard'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:202:&SESSION.::&DEBUG.:RP,202:P202_RELEASE_ID:&P203_RELEASE_ID.'
,p_icon_css_classes=>'fa-area-chart'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55480496110822150483)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:RP,14:P14_RELEASE_ID:&P203_RELEASE_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55480497249700150494)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Home'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,:P117_RELEASE_ID:&P203_RELEASE_ID.'
,p_icon_css_classes=>'fa-ship'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55480497348551150495)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>70
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(78002359242187996065)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release &NOMENCLATURE_PROJECTS.'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:RP,300:P300_RELEASE_ID:&P203_RELEASE_ID.'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(91984153499880931916)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(91984154126127931922)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:RR,201:P203_RELEASE_ID:&P203_RELEASE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(91984154270146931923)
,p_component_action_id=>wwv_flow_imp.id(91984153420220931915)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>20
);
wwv_flow_imp.component_end;
end;
/
