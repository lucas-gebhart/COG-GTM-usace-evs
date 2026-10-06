prompt --application/pages/page_00162
begin
--   Manifest
--     PAGE: 00162
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
 p_id=>162
,p_name=>'Control Chart'
,p_alias=>'CONTROL-CHART'
,p_page_mode=>'MODAL'
,p_step_title=>'Control Chart'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_patch=>wwv_flow_imp.id(48520462122696828334)
,p_protection_level=>'C'
,p_page_component_map=>'04'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42983730937643879396)
,p_plug_name=>'Control Chart'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P162_PROJECT_SIZE,P162_PRIORITY,P162_IN_PROGRESS_FROM,P162_IN_PROGRESS_TO'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(36900047144511726086)
,p_region_id=>wwv_flow_imp.id(42983730937643879396)
,p_chart_type=>'scatter'
,p_height=>'800'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_title=>'Sizes'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(36900048814693726088)
,p_chart_id=>wwv_flow_imp.id(36900047144511726086)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select y.*, rownum from (',
'select',
'  x.id,',
'  x.project,',
'  x.created,',
'  x.project_size,',
'  x.status_scale,',
'  x.pct_complete,',
'  max(decode(x.new_value,:P162_IN_PROGRESS_TO,changed_on)) - min(decode(x.new_value,:P162_IN_PROGRESS_FROM,changed_on)) days',
'from ',
'(',
'  select',
'    pr.id,',
'    pr.project,',
'    pr.status_scale,',
'    pr.created,',
'    pr.pct_complete,',
'    decode(ph.change_type,''CREATE'',10, ph.new_value) new_value,',
'    ph.changed_on,',
'    pr.project_size',
'  from sp_projects pr',
'  inner join sp_project_history ph on pr.id = ph.project_id',
'                                                 and (ph.attribute_column = ''PCT_COMPLETE'' or ph.change_type = ''CREATE'')',
'  where (pr.priority_id = :P162_priority or :P162_PRIORITY is null)',
'  and pr.initiative_id = :P162_INITIATIVE_ID',
'  and pr.archived_yn = ''N'' ',
'  and (nvl(pr.focus_area_id,0) = :P162_FOCUS_AREA or :P162_FOCUS_AREA is null)',
'  and pr.duplicate_of_project_id is null',
'  --and pr.status_scale = ''A''',
'  and (project_size = :P162_PROJECT_SIZE or :P162_PROJECT_SIZE is null)) x',
'where x.new_value in (:P162_IN_PROGRESS_FROM,:P162_IN_PROGRESS_TO)',
'group by ',
'  x.id,',
'  x.project,',
'  x.project_size,',
'  x.status_scale,',
'  x.pct_complete,',
'  x.created',
'order by x.created) y'))
,p_ajax_items_to_submit=>'P162_PROJECT_SIZE,P162_PRIORITY,P162_IN_PROGRESS_FROM,P162_IN_PROGRESS_TO,P162_FOCUS_AREA'
,p_series_name_column_name=>'PROJECT_SIZE'
,p_items_x_column_name=>'ROWNUM'
,p_items_y_column_name=>'DAYS'
,p_group_short_desc_column_name=>'PROJECT'
,p_items_label_column_name=>'PROJECT'
,p_items_short_desc_column_name=>'PROJECT'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::P3_PROJECT_ID:&ID.'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(36900047659878726087)
,p_chart_id=>wwv_flow_imp.id(36900047144511726086)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Days In Progress'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(36900048220250726088)
,p_chart_id=>wwv_flow_imp.id(36900047144511726086)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Projects Over Time'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(36900674734193088110)
,p_name=>'P162_INITIATIVE_ID'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42791682345120358609)
,p_name=>'P162_IN_PROGRESS_FROM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_item_default=>'50'
,p_prompt=>'% Complete From'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:0,10,20,30,40,50,60,70,80,90,100'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42791682461752358610)
,p_name=>'P162_IN_PROGRESS_TO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_item_default=>'80'
,p_prompt=>'% Complete To'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:0,10,20,30,40,50,60,70,80,90,100'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42998970873822690315)
,p_name=>'P162_PROJECT_SIZE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_prompt=>'Size'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_size d, project_size r ',
'from sp_project_sizes ps',
'where include_yn = ''Y''',
'order by EFFORT_DAYS'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'YES'
,p_help_text=>'&P24_SIZE_HELP_TEXT!RAW.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43022203688055828262)
,p_name=>'P162_PRIORITY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Priority'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select description, id',
'from sp_project_priorities'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48553673260473354101)
,p_name=>'P162_FOCUS_AREA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(42983730937643879396)
,p_prompt=>'Focus Area'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select focus_area, id',
'  from sp_initiative_focus_areas',
' where initiative_id = :P161_INITIATIVE_ID',
'   and active_yn = ''Y''',
'union all',
'select',
'  ''Unallocated'',',
'  0',
'from dual ',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(36900051313297726094)
,p_name=>'Size Change'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P162_PROJECT_SIZE,P162_PRIORITY,P162_IN_PROGRESS_FROM,P162_IN_PROGRESS_TO,P162_FOCUS_AREA'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(36900051861125726095)
,p_event_id=>wwv_flow_imp.id(36900051313297726094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(42983730937643879396)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
