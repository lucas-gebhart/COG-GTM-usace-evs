prompt --application/pages/page_00139
begin
--   Manifest
--     PAGE: 00139
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
 p_id=>139
,p_name=>'My Subscriptions'
,p_alias=>'MY-SUBSCRIPTIONS'
,p_step_title=>'My Subscriptions'
,p_autocomplete_on_off=>'OFF'
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
'.resize-region {',
'  resize: vertical;',
'  overflow: auto;',
'}',
'',
'.a-CardView-iconWrap,',
'.a-CardView-badge { align-self: flex-start; }'))
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(40988168023730966484)
,p_name=>'Notification Subscriptions'
,p_template=>4072358936313175081
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody:margin-left-lg'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_new_grid_row=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select n.name || case when r.id is not null then '' for ''|| r.release_train ||'' ''|| r.release end notification,',
'       initcap(ns.frequency) frequency,',
'       ns.UPDATED,',
'       ns.last_sent,',
'       ns.notification_id for_link,',
'       ns.release_id',
'  from SP_NOTIFICATION_SUBSCRIPTIONS ns,',
'       SP_NOTIFICATIONS n,',
'       sp_release_trains r',
'where n.id = ns.NOTIFICATION_ID',
'  and ns.team_member_id = :APP_USER_ID',
'  and ns.opted_in_yn = ''Y''',
'  and ns.release_id = r.id (+)',
'order by 1'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No notification subscriptions found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40988169062297966494)
,p_query_column_id=>1
,p_column_alias=>'NOTIFICATION'
,p_column_display_sequence=>20
,p_column_heading=>'Notification'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48401071565348018702)
,p_query_column_id=>2
,p_column_alias=>'FREQUENCY'
,p_column_display_sequence=>30
,p_column_heading=>'Frequency'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40988168677237966491)
,p_query_column_id=>3
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>50
,p_column_heading=>'Opted In'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48401071821508018705)
,p_query_column_id=>4
,p_column_alias=>'LAST_SENT'
,p_column_display_sequence=>40
,p_column_heading=>'Last Sent'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48401072349410018710)
,p_query_column_id=>5
,p_column_alias=>'FOR_LINK'
,p_column_display_sequence=>60
,p_column_heading=>'Send'
,p_column_link=>'f?p=&APP_ID.:139:&SESSION.:EMAIL:&DEBUG.:139:P139_NOTIFICATION_ID,P139_RELEASE_ID,P139_FREQUENCY:#FOR_LINK#,#RELEASE_ID#,#FREQUENCY#'
,p_column_linktext=>'Email Now'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48401072460804018711)
,p_query_column_id=>6
,p_column_alias=>'RELEASE_ID'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48691105037396928452)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>70
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40988170158970966505)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40988168023730966484)
,p_button_name=>'Manage_my_subscriptions'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Manage My Subscriptions'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:149:&SESSION.::&DEBUG.:149::'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40988124023877948988)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(48691105037396928452)
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
 p_id=>wwv_flow_imp.id(48401072128545018708)
,p_name=>'P139_NOTIFICATION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40988168023730966484)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48401072220557018709)
,p_name=>'P139_RELEASE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(40988168023730966484)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248168336018784014)
,p_name=>'P139_FREQUENCY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(40988168023730966484)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41376453208988866273)
,p_name=>'refresh info'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(48691105037396928452)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48020573161582669504)
,p_name=>'refresh subscrption'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40988168023730966484)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48020573223423669505)
,p_event_id=>wwv_flow_imp.id(48020573161582669504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40988168023730966484)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48401071903805018706)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email Now'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary     clob;',
'    l_subject     varchar2(4000);',
'    l_changes_yn  varchar2(1);',
'begin',
'',
'    if :P139_NOTIFICATION_ID = sp_util.get_notification_id(''WEEKLY_SUMMARY'')',
'    then l_subject := :NOMENCLATURE_STRATEGIC_PLANNER ||'' Weekly Summary'';',
'         l_summary := sp_contributor_summary.generate (',
'                          p_team_member_id  => :APP_USER_ID,',
'                          p_links           => ''EMAIL'');',
'',
'    elsif :P139_NOTIFICATION_ID = sp_util.get_notification_id(''PROJECT_EXCEPTIONS'')',
'    then l_subject := :NOMENCLATURE_STRATEGIC_PLANNER ||'' Project Exceptions'';',
'         l_summary := sp_contributor_summary.project_exceptions (',
'                          p_team_member_id  => :APP_USER_ID,',
'                          p_links           => ''EMAIL'');',
'',
'    elsif :P139_NOTIFICATION_ID = sp_util.get_notification_id(''RELEASE_EXCEPTIONS'') and',
'          :P139_RELEASE_ID is not null',
'    then for c1 in (',
'             select release_train||'' ''||release release',
'               from sp_release_trains',
'              where id = :P139_RELEASE_ID',
'          ) loop',
'              l_subject := :NOMENCLATURE_STRATEGIC_PLANNER || '' '' || c1.release ||'' Release Exceptions'';',
'          end loop;',
'          l_summary := sp_release_timeline.release_exceptions (',
'                           p_release_id => :P139_RELEASE_ID,',
'                           p_links      => ''EMAIL'');',
'',
'    elsif :P139_NOTIFICATION_ID = sp_util.get_notification_id(''PROJECT_CHANGES'') and',
'          :P139_FREQUENCY is not null',
'    then l_subject := :NOMENCLATURE_STRATEGIC_PLANNER ||'' Project Changes'';',
'         sp_contributor_summary.project_changes (',
'             p_team_member_id => :APP_USER_ID,',
'             p_frequency      => upper(:P139_FREQUENCY),',
'             p_links          => ''EMAIL'',',
'             p_changes_yn     => l_changes_yn,',
'             p_change_summary => l_summary );',
'',
'         if l_changes_yn = ''N'' then',
'            l_summary := null;',
'         end if;',
'',
'    end if;',
'',
'    if l_summary is not null then',
'',
'        apex_mail.send ( ',
'                p_to                 => :APP_USER,   ',
'                p_from               => :APP_USER,  ',
'                p_application_id     => :APP_ID,  ',
'                p_template_static_id => ''EMAIL_ME'',  ',
'                p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                               ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                               ''"SUBJECT": ''    || apex_json.stringify( l_subject ) ||'', ''||',
'                                               ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                         ''}'' ); ',
'',
'    end if;',
'',
'    :P139_NOTIFICATION_ID := null;',
'    :P139_RELEASE_ID      := null;',
'    :P139_FREQUENCY       := null;',
'',
'exception when others then ',
'    :P139_NOTIFICATION_ID := null;',
'    :P139_RELEASE_ID      := null;',
'    :P139_FREQUENCY       := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P139_NOTIFICATION_ID is not null and',
':REQUEST = ''EMAIL'''))
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_process_success_message=>'Email sent.'
,p_internal_uid=>11501714038403050937
);
wwv_flow_imp.component_end;
end;
/
