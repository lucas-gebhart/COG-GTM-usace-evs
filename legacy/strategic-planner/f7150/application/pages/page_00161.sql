prompt --application/pages/page_00161
begin
--   Manifest
--     PAGE: 00161
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
 p_id=>161
,p_name=>'Cumulative Flow'
,p_alias=>'CUMULATIVE-FLOW'
,p_page_mode=>'MODAL'
,p_step_title=>'Cumulative Flow'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_patch=>wwv_flow_imp.id(48520462122696828334)
,p_dialog_height=>'600'
,p_dialog_width=>'800'
,p_protection_level=>'C'
,p_page_component_map=>'04'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42859275455620048092)
,p_plug_name=>'Cumulative Flow'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(36899988340058715238)
,p_region_id=>wwv_flow_imp.id(42859275455620048092)
,p_chart_type=>'area'
,p_height=>'800'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'value-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'liveScrollOnly'
,p_initial_zooming=>'none'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_legend_rendered=>'on'
,p_legend_title=>'% Complete'
,p_legend_position=>'auto'
,p_overview_rendered=>'on'
,p_time_axis_type=>'enabled'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(36899990055076715242)
,p_chart_id=>wwv_flow_imp.id(36899988340058715238)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  ',
'       x.d,',
'       nvl(y.pct_complete,0) pct_complete,',
'       count(y.id) Qty',
'  from',
'       (select sysdate - ((level - 1) * to_number(:P161_RESOLUTION)) d',
'          from   dual',
'       connect by level <= (sysdate - add_months(sysdate, 0 - to_number(:P161_SCOPE))) / to_number(:P161_RESOLUTION)) x',
'  left outer join',
'       (select',
'               id,',
'               case lead(first_value) over (partition by id order by changed_date)',
'                 -- if next first value is first in history then use the old value',
'                 when 1 then lead(old_value) over (partition by id order by changed_date)',
'                 else new_value',
'               end pct_complete,',
'               changed_date from_date,',
'               nvl(lead(changed_date) over (partition by id order by changed_date),sysdate) to_date',
'          from (',
'                 select',
'                        pr.id,',
'                        0            first_value,',
'                        null         old_value,',
'                        to_char(pr.pct_complete) new_value,',
'                        pr.created    changed_date,',
'                        pr.initiative_id,',
'                        pr.status_scale,',
'                        pr.duplicate_of_project_id,',
'                        pr.archived_yn,',
'                        pr.focus_area_id',
'                   from sp_projects pr',
'                  union all',
'                 select',
'                        pr.id,',
'                        rank() over (partition by ph.project_id order by ph.changed_on) as first_value,',
'                        ph.old_value,',
'                        ph.new_value,',
'                        ph.changed_on,',
'                        pr.initiative_id,',
'                        pr.status_scale,',
'                        pr.duplicate_of_project_id,',
'                        pr.archived_yn,',
'                        pr.focus_area_id',
'                   from sp_projects pr',
'                  inner join sp_project_history ph on pr.id = ph.project_id',
'                                                 and ph.attribute_column = ''PCT_COMPLETE''',
'                                                 and ph.new_value is not null',
'               )',
'            where initiative_id = :P161_INITIATIVE_ID',
'            --and status_scale = ''A''',
'            and archived_yn = ''N'' ',
'            and duplicate_of_project_id is null',
'            and (nvl(focus_area_id,''0'') = :P161_FOCUS_AREA or :P161_FOCUS_AREA is null)',
'        ) y ',
'    on x.d between y.from_date and y.to_date',
' group by x.d, y.pct_complete  ',
'order by to_number(pct_complete) desc'))
,p_ajax_items_to_submit=>'P161_RESOLUTION,P161_SCOPE,P161_FOCUS_AREA'
,p_series_name_column_name=>'PCT_COMPLETE'
,p_items_value_column_name=>'QTY'
,p_items_label_column_name=>'D'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(36899988868710715239)
,p_chart_id=>wwv_flow_imp.id(36899988340058715238)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Time'
,p_format_type=>'date-short'
,p_numeric_pattern=>'MMM yyyy'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'min'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'on'
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
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(36899989378939715240)
,p_chart_id=>wwv_flow_imp.id(36899988340058715238)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Count'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'off'
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38033422654941290412)
,p_name=>'P161_RESOLUTION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(42859275455620048092)
,p_item_default=>'1'
,p_prompt=>'Resolution'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Daily;1,Weekly;7,2 Weeks;14,4 Weeks;28'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38033422973557290415)
,p_name=>'P161_SCOPE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(42859275455620048092)
,p_item_default=>'24'
,p_prompt=>'Timescale'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:3 Months;3,6 Months;6,1 Year;12,2 Years;24,3 Years;36,5 Years;60'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42791622685360347754)
,p_name=>'P161_INITIATIVE_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(42859275455620048092)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48553470962634015353)
,p_name=>'P161_FOCUS_AREA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(42859275455620048092)
,p_prompt=>'Focus Area'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select focus_area, id',
'  from sp_initiative_focus_areas',
' where initiative_id = :P161_INITIATIVE_ID',
'   and active_yn = ''Y'' ',
'union all',
'select',
'  ''Unallocated'',',
'  0',
'from dual',
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
 p_id=>wwv_flow_imp.id(38033422723574290413)
,p_name=>'Change Resolution'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P161_RESOLUTION,P161_SCOPE,P161_FOCUS_AREA'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38033422875068290414)
,p_event_id=>wwv_flow_imp.id(38033422723574290413)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(42859275455620048092)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
