prompt --application/pages/page_16016
begin
--   Manifest
--     PAGE: 16016
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
 p_id=>16016
,p_name=>'Add Subscription'
,p_alias=>'ADD-SUBSCRIPTION'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Subscription'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(56716201004234736938)
,p_name=>'Subscriptions'
,p_template=>2100526641005906379
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlightOff:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ns.ID,',
'       apex_escape.html(n.name || case when r.id is not null then '' for ''|| r.release_train ||'' ''|| r.release end) ||apex_item.hidden(1,n.id) notification,',
'       ns.NOTIFICATION_ID,',
'       apex_item.switch(p_idx => 2, p_value => nvl(ns.opted_in_yn,''N''), ',
'                        p_on_value => ''Y'', p_off_value => ''N'',',
'                        p_item_label => ''Opted In'') opted_in,',
'       ns.CREATED,',
'       ns.CREATED_BY,',
'       ns.UPDATED,',
'       ns.UPDATED_BY',
'  from SP_NOTIFICATION_SUBSCRIPTIONS ns,',
'       SP_NOTIFICATIONS n,',
'       sp_release_trains r',
'where n.id = ns.NOTIFICATION_ID (+)',
'  and ns.id is null ',
'  and n.static_id = ''WEEKLY_SUMMARY''',
'  and ns.release_id = r.id (+)',
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
 p_id=>wwv_flow_imp.id(48532865957400790702)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532866303198790703)
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
 p_id=>wwv_flow_imp.id(48532866741837790704)
,p_query_column_id=>3
,p_column_alias=>'NOTIFICATION_ID'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532868683755790705)
,p_query_column_id=>4
,p_column_alias=>'OPTED_IN'
,p_column_display_sequence=>30
,p_column_heading=>'Opted In'
,p_column_format=>'SINCE'
,p_column_alignment=>'CENTER'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532867142244790704)
,p_query_column_id=>5
,p_column_alias=>'CREATED'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532867524400790704)
,p_query_column_id=>6
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532867897017790705)
,p_query_column_id=>7
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>70
,p_column_heading=>'Last Updated'
,p_column_format=>'Since'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48532868303106790705)
,p_query_column_id=>8
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(63826509264227344698)
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
 p_id=>wwv_flow_imp.id(48532865153836790700)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(63826509264227344698)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48532864707967790699)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(63826509264227344698)
,p_button_name=>'ADD'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Subscription'
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48401069192465018679)
,p_name=>'P16016_NOTIFICATION_ID'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56716201004234736938)
,p_prompt=>'Notification'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select name d, id v',
'  from sp_notifications',
' where is_active_yn = ''Y''',
' order by name'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48401069272306018680)
,p_name=>'P16016_RELEASE_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56716201004234736938)
,p_prompt=>'Release'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select release_train ||'' ''|| release d, id v',
'  from sp_release_trains',
' where nvl(release_completed,''N'') = ''N''',
' order by 1'))
,p_cSize=>30
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48401069703920018684)
,p_name=>'P16016_RELEASE_EXCEPTIONS_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56716201004234736938)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48401071157017018698)
,p_name=>'P16016_FREQUENCY'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(56716201004234736938)
,p_prompt=>'Frequency'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Weekly;WEEKLY,Weekdays;WEEKDAYS'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52621681405758789443)
,p_name=>'P16016_TEAM_MEMBER_ID'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56716201004234736938)
,p_prompt=>'Team Member'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SP_TEAM_MEMBERS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select last_name||'', ''||first_name||'' (''||lower(email)||'')'' d, id r',
'from SP_TEAM_MEMBERS',
'order by 1'))
,p_cSize=>30
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48401069794946018685)
,p_computation_sequence=>10
,p_computation_item=>'P16016_RELEASE_EXCEPTIONS_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
'  from sp_notifications',
' where static_id = ''RELEASE_EXCEPTIONS'''))
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(48401070338378018690)
,p_validation_name=>'when release'
,p_validation_sequence=>10
,p_validation=>'P16016_RELEASE_ID'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Must select a Release.'
,p_validation_condition=>'P16016_NOTIFICATION_ID'
,p_validation_condition2=>'&P16016_RELEASE_EXCEPTIONS_ID.'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_when_button_pressed=>wwv_flow_imp.id(48532864707967790699)
,p_associated_item=>wwv_flow_imp.id(48401069272306018680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(48401070436058018691)
,p_validation_name=>'check for dups'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_notification_subscriptions',
' where notification_id = :P16016_NOTIFICATION_ID',
'   and team_member_id = :P16016_TEAM_MEMBER_ID',
'   and (release_id = :P16016_RELEASE_ID or :P16016_RELEASE_ID is null)',
'   and opted_in_yn = ''Y'''))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'This subscription already exists.'
,p_when_button_pressed=>wwv_flow_imp.id(48532864707967790699)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48532870379758790709)
,p_name=>'close'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48532865153836790700)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48532870885369790709)
,p_event_id=>wwv_flow_imp.id(48532870379758790709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48401069366277018681)
,p_name=>'hide/show release'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16016_NOTIFICATION_ID'
,p_condition_element=>'P16016_NOTIFICATION_ID'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'&P16016_RELEASE_EXCEPTIONS_ID.'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48401069492197018682)
,p_event_id=>wwv_flow_imp.id(48401069366277018681)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P16016_RELEASE_ID'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48401069634144018683)
,p_event_id=>wwv_flow_imp.id(48401069366277018681)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P16016_RELEASE_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48532869989680790708)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Add Subscription'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id  => :P16016_TEAM_MEMBER_ID,',
'    p_notification_id => :P16016_NOTIFICATION_ID,',
'    p_frequency       => case when :P16016_FREQUENCY = ''Weekly''',
'                              then ''WEEKLY''',
'                              else ''WEEKDAYS'' end,',
'    p_release_id      => case when :P16016_NOTIFICATION_ID = :P16016_RELEASE_EXCEPTIONS_ID ',
'                              then :P16016_RELEASE_ID end);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48532864707967790699)
,p_process_success_message=>'Subscription added.'
,p_internal_uid=>11633512124278822939
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48401070169091018689)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48532864707967790699)
,p_internal_uid=>11501712303689050920
);
wwv_flow_imp.component_end;
end;
/
