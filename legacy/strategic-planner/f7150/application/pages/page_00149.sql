prompt --application/pages/page_00149
begin
--   Manifest
--     PAGE: 00149
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
 p_id=>149
,p_name=>'Manage My Subscriptions'
,p_alias=>'MANAGE-MY-SUBSCRIPTIONS'
,p_page_mode=>'MODAL'
,p_step_title=>'Manage My Subscriptions'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(45082695178511914015)
,p_name=>'Notification Subscriptions'
,p_template=>2100526641005906379
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlightOff:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ns.ID,',
'       apex_escape.html(n.name) || apex_item.hidden(1,n.id)||apex_item.hidden(3,null) notification,',
'       ns.NOTIFICATION_ID,',
'       apex_item.select_list(4,initcap(frequency),''Weekly,Weekdays'') frequency,',
'       apex_item.switch(p_idx        => 2, ',
'                        p_value      => nvl(ns.opted_in_yn,''N''), ',
'                        p_on_value   => ''Y'', p_off_value => ''N'',',
'                        p_item_id    => ''SUB_'' || rownum,',
'                        p_item_label => ''Opted In'') opted_in,',
'       ns.CREATED,',
'       ns.CREATED_BY,',
'       ns.UPDATED,',
'       ns.UPDATED_BY',
'  from SP_NOTIFICATION_SUBSCRIPTIONS ns,',
'       SP_NOTIFICATIONS n',
'where n.id = ns.NOTIFICATION_ID',
'  and ns.team_member_id = :APP_USER_ID',
'  and n.static_id != ''RELEASE_EXCEPTIONS''',
'union all',
'select null ID,',
'       apex_escape.html(n.name) || apex_item.hidden(1,n.id)||apex_item.hidden(3,null) notification,',
'       n.id NOTIFICATION_ID,',
'       apex_item.select_list(4,''Weekly'',''Weekly,Weekdays'') frequency,',
'       apex_item.switch(p_idx        => 2, ',
'                        p_value      => ''N'', ',
'                        p_on_value   => ''Y'', p_off_value => ''N'',',
'                        p_item_id    => ''SUB3_'' || rownum,',
'                        p_item_label => ''Opted In'') opted_in,',
'       null CREATED,',
'       null CREATED_BY,',
'       null UPDATED,',
'       null UPDATED_BY',
'  from SP_NOTIFICATIONS n',
' where n.id not in (select NOTIFICATION_ID from SP_NOTIFICATION_SUBSCRIPTIONS',
'                     where team_member_id = :APP_USER_ID)',
'  and n.static_id != ''RELEASE_EXCEPTIONS''',
'union all',
'select ns.ID,',
'       apex_escape.html(n.name || '' for ''|| r.release_train ||'' ''|| r.release) ||',
'           apex_item.hidden(1,n.id)||apex_item.hidden(3,ns.release_id) notification,',
'       ns.NOTIFICATION_ID,',
'       apex_item.select_list(4,initcap(frequency),''Weekly,Weekdays'') frequency,',
'       apex_item.switch(p_idx        => 2, ',
'                        p_value      => nvl(ns.opted_in_yn,''N''), ',
'                        p_on_value   => ''Y'', p_off_value => ''N'',',
'                        p_item_id    => ''SUB2_'' || rownum,',
'                        p_item_label => ''Opted In'') opted_in,',
'       ns.CREATED,',
'       ns.CREATED_BY,',
'       ns.UPDATED,',
'       ns.UPDATED_BY',
'  from SP_NOTIFICATION_SUBSCRIPTIONS ns,',
'       SP_NOTIFICATIONS n,',
'       sp_release_trains r',
'where n.id = ns.NOTIFICATION_ID',
'  and ns.team_member_id = :APP_USER_ID',
'  and n.static_id = ''RELEASE_EXCEPTIONS''',
'  and ns.release_id = r.id',
'order by 2'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Notification Subscriptions'
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
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020570786387669481)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020570871843669482)
,p_query_column_id=>2
,p_column_alias=>'NOTIFICATION'
,p_column_display_sequence=>20
,p_column_heading=>'Notification'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571000115669483)
,p_query_column_id=>3
,p_column_alias=>'NOTIFICATION_ID'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48401071577533018703)
,p_query_column_id=>4
,p_column_alias=>'FREQUENCY'
,p_column_display_sequence=>30
,p_column_heading=>'Frequency'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571669871669490)
,p_query_column_id=>5
,p_column_alias=>'OPTED_IN'
,p_column_display_sequence=>40
,p_column_heading=>'Opted In'
,p_column_format=>'SINCE'
,p_column_alignment=>'CENTER'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571264012669485)
,p_query_column_id=>6
,p_column_alias=>'CREATED'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571347470669486)
,p_query_column_id=>7
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571404865669487)
,p_query_column_id=>8
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>80
,p_column_heading=>'Last Updated'
,p_column_format=>'Since'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48020571547320669488)
,p_query_column_id=>9
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48401068573716018673)
,p_plug_name=>'Info'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_source=>'Add new Release Exceptions by viewing the Exceptions subtab for a selected Release.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(52193003438504521775)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48104094241117444091)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(52193003438504521775)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48104094587006444093)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(52193003438504521775)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'APP_USER_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48020573493216669508)
,p_name=>'close'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48104094241117444091)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48020573594950669509)
,p_event_id=>wwv_flow_imp.id(48020573493216669508)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48020571798621669491)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update Subscriptions'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for i in 1..apex_application.g_f01.count loop',
'',
'    if apex_application.g_f02(i) = ''Y'' then',
'        sp_util.notification_opt_in (',
'            p_team_member_id  => :APP_USER_ID,',
'            p_notification_id => apex_application.g_f01(i),',
'            p_frequency       => case when apex_application.g_f04(i) = ''Weekly'' then ''WEEKLY'' else ''WEEKDAYS'' end,',
'            p_release_id      => apex_application.g_f03(i));',
'    else',
'        sp_util.notification_opt_out (',
'            p_team_member_id  => :APP_USER_ID,',
'            p_notification_id => apex_application.g_f01(i),',
'            p_release_id      => apex_application.g_f03(i));',
'    end if;',
'',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48104094587006444093)
,p_process_success_message=>'Subscriptions updated.'
,p_internal_uid=>11121213933219701722
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48401071430067018701)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'close'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48104094587006444093)
,p_internal_uid=>11501713564665050932
);
wwv_flow_imp.component_end;
end;
/
