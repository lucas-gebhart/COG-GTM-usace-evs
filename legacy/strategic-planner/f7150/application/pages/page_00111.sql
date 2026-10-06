prompt --application/pages/page_00111
begin
--   Manifest
--     PAGE: 00111
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
 p_id=>111
,p_name=>'Project Milestone Calendar'
,p_alias=>'PROJECT-MILESTONE-CALENDAR'
,p_step_title=>'Project Milestone Calendar'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45067720961302709863)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48953555149842086112)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48953555854886086123)
,p_plug_name=>'Search Results'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--hiddenOverflow'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, ',
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
'       case when is_completed = ''Completed'' then ''apex-cal-green''',
'            when trunc("DATE") < trunc(sysdate) then ''apex-cal-red''',
'            else ''apex-cal-yellow''',
'       end as event_color,',
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
'       apex_page.get_url(p_page   => 3,',
'                         p_items  => ''FI,PN'',',
'                         p_values => fi||'',''||pn,',
'                         p_clear_cache => 3) link,',
'       fi,',
'       pn,',
'       initiative,',
'       RELEASE',
'from (',
'--',
'-- milestones',
'--',
'select p.id as "ID",',
'       case when tm.id is null then ''No Owner''',
'            else tm.first_name||'' ''||tm.last_Name',
'            end owner,',
'       t.target_complete                                                 as "START_DATE",',
'       t.target_complete                                                 as "DATE",',
'       to_char(t.target_complete,''YYYY.MM'')                                as "MONTH",',
'       tt.task_type                                                      as milestone_type,',
'       tt.task_type                                                      as milestone,',
'       p.project                                                         as event,',
'       tm.first_name||'' ''||tm.last_Name||'', P''||p.priority_id||'', ''||p.PROJECT_SIZE  as event_detail,',
'       decode(s.indicates_complete_yn,''N'',''Open'',''Y'',''Completed'',''Unknown'')    as is_completed,',
'       p.FRIENDLY_IDENTIFIER fi,',
'       p.PROJECT_URL_NAME pn,',
'       p.priority_id,',
'       NVL((select focus_area from sp_initiative_focus_areas',
'             where id = p.focus_area_id),''Not Identified'') focus_area,',
'       nvl((select initiative from sp_initiatives',
'             where p.initiative_id = id),''None Identified'') initiative,',
'       nvl((select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id),''Not Targeted'') release',
'  from sp_projects p,',
'       SP_TEAM_MEMBERS tm,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_statuses s',
'  where t.OWNER_ID = tm.id (+) and',
'        p.ARCHIVED_YN = ''N'' and ',
'        p.duplicate_of_project_id is null and',
'        p.id = t.project_id and',
'        nvl(t.task_sub_type_id,t.task_type_id) = tt.id and',
'        tt.static_id like ''MILESTONE%'' and',
'        t.status_id = s.id and',
'        t.target_complete is not null',
') x'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CSS_CALENDAR'
,p_plug_footer=>'<small><span style="background-color:#2ecc71;">Green</span> = Completed, <span style="background-color:#d91e18;">Red</span> = Past Due, <span style="background-color:#f1c40f;">Yellow</span> = Future</small>'
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
,p_ai_enabled=>false
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
 p_id=>wwv_flow_imp.id(48953555924004086123)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(48953555854886086123)
,p_landmark_label=>'Filters'
,p_ai_enabled=>false
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
 p_id=>wwv_flow_imp.id(48953558305628086128)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>'<div id="active_facets"></div>'
,p_plug_query_num_rows=>15
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(115119005161014820038)
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
'          from sp_projects p ',
'         where p.release_id = r.id ',
'           and p.ARCHIVED_YN = ''N''  ',
'           and p.DUPLICATE_OF_PROJECT_ID is null) projects,',
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
' where r.id = :P111_RELEASE_ID and ',
'       r.RELEASE_OWNER_ID = t.id(+)'))
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(43859224680642711648)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43859225149182711649)
,p_query_column_id=>2
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43859223142263711646)
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
 p_id=>wwv_flow_imp.id(43859223477135711646)
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
 p_id=>wwv_flow_imp.id(43859225547131711649)
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
 p_id=>wwv_flow_imp.id(43859223950490711647)
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
 p_id=>wwv_flow_imp.id(43859224321687711647)
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
 p_id=>wwv_flow_imp.id(43859225921866711650)
,p_query_column_id=>8
,p_column_alias=>'OWNER'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43859226312439711650)
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
 p_id=>wwv_flow_imp.id(43859222667331711645)
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
 p_id=>wwv_flow_imp.id(43859233754540711667)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(48953558305628086128)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:111:&APP_SESSION.::&DEBUG.:RR,203::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(43859227729276711654)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(48953555149842086112)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42765985492842148796)
,p_name=>'P111_INITIATIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
,p_prompt=>'Initiative'
,p_source=>'INITIATIVE'
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
 p_id=>wwv_flow_imp.id(42765985624601148797)
,p_name=>'P111_RELEASE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47932105669699479980)
,p_name=>'P111_MILESTONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47932105796629479981)
,p_name=>'P111_FOCUS_AREA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47932106780582479991)
,p_name=>'P111_MILESTONE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48953569833842086157)
,p_name=>'P111_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
,p_prompt=>'Search'
,p_source=>'FOCUS_AREA,OWNER,MILESTONE,EVENT,EVENT_DETAIL,PRIORITY,IS_COMPLETED,INITIATIVE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48953570183670086160)
,p_name=>'P111_OWNER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48953570659812086160)
,p_name=>'P111_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48953570989002086160)
,p_name=>'P111_IS_COMPLETED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(48953555924004086123)
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
,p_ai_enabled=>false
);
wwv_flow_imp.component_end;
end;
/
