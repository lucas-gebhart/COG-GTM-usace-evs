prompt --application/pages/page_16015
begin
--   Manifest
--     PAGE: 16015
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
 p_id=>16015
,p_name=>'Subscriptions'
,p_alias=>'SUBSCRIPTIONS'
,p_step_title=>'Subscriptions'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56255561802254367939)
,p_plug_name=>'Subscriptions'
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select apex_escape.html(notification)||apex_item.hidden(1,n_id) notification,',
'       apex_escape.html(email)||apex_item.hidden(3,team_member_id)||apex_item.hidden(4,release_id) team_member,',
'       apex_item.switch(p_idx => 2, p_value => opted_in_yn, ',
'                        p_on_value => ''Y'', p_off_value => ''N'',',
'                        p_item_id => static_id || rownum, p_item_label => ''Opted In'') opted_in,',
'       case when opted_in_yn = ''Y'' then ''Yes'' else ''No'' end opted_in_for_filter,',
'       (select listagg(g.group_name, '', '') within group(order by g.group_name)',
'          from sp_groups g,',
'               sp_group_members m',
'         where g.id = m.group_id',
'           and m.team_member_id = team_member_id) groups,',
'       updated,',
'       updated_by,',
'       created_by,',
'       last_sent,',
'       apex_item.select_list(5,frequency,''Weekly,Weekdays'') frequency,',
'       opted_in_yn opted_in_link,',
'       static_id static_id_link',
'from (',
'select n.name || case when r.id is not null then '' for ''|| r.release_train ||'' ''|| r.release end notification,',
'       n.id n_id,',
'       tm.id team_member_id,',
'       ns.release_id,',
'       tm.email,',
'       ns.id,',
'       ns.opted_in_yn,',
'       ns.updated,',
'       lower(ns.updated_by) updated_by,',
'       lower(ns.created_by) created_by,',
'       ns.last_sent,',
'       n.static_id,',
'       initcap(ns.frequency) frequency',
'  from SP_NOTIFICATIONS n,',
'       SP_NOTIFICATION_SUBSCRIPTIONS ns,',
'       sp_team_members tm,',
'       sp_release_trains r',
' where n.id = ns.notification_id',
'   and ns.team_member_id = tm.id',
'   and ns.release_id = r.id (+)',
')'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
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
,p_plug_footer=>'This report includes only those that have explicitly subscribed or then unsubscribed.  Use ''Add New'' to add anything not on this report.'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(56255562426017367940)
,p_name=>'Configuration Options'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_control_break=>'N'
,p_show_highlight=>'N'
,p_show_computation=>'N'
,p_show_aggregate=>'N'
,p_show_chart=>'N'
,p_show_group_by=>'N'
,p_show_pivot=>'N'
,p_show_flashback=>'N'
,p_show_download=>'N'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>19356204560615400171
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020572057784669493)
,p_db_column_name=>'NOTIFICATION'
,p_display_order=>11
,p_column_identifier=>'I'
,p_column_label=>'Notification'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020572222801669495)
,p_db_column_name=>'TEAM_MEMBER'
,p_display_order=>21
,p_column_identifier=>'K'
,p_column_label=>'Team Member'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48401071732894018704)
,p_db_column_name=>'FREQUENCY'
,p_display_order=>31
,p_column_identifier=>'X'
,p_column_label=>'Frequency'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020572808678669501)
,p_db_column_name=>'OPTED_IN'
,p_display_order=>41
,p_column_identifier=>'P'
,p_column_label=>'Update Opt In'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020572930410669502)
,p_db_column_name=>'OPTED_IN_FOR_FILTER'
,p_display_order=>51
,p_column_identifier=>'Q'
,p_column_label=>'Opted In'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020573054207669503)
,p_db_column_name=>'GROUPS'
,p_display_order=>61
,p_column_identifier=>'R'
,p_column_label=>'Groups'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_rpt_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select group_name',
'  from sp_groups',
' order by 1'))
,p_rpt_show_filter_lov=>'C'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48401069104502018678)
,p_db_column_name=>'LAST_SENT'
,p_display_order=>71
,p_column_identifier=>'T'
,p_column_label=>'Last Sent'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48020573753202669510)
,p_db_column_name=>'UPDATED'
,p_display_order=>81
,p_column_identifier=>'S'
,p_column_label=>'Last Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48401070661620018693)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>91
,p_column_identifier=>'U'
,p_column_label=>'Last Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48401070752317018694)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>101
,p_column_identifier=>'V'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51825529730039349281)
,p_db_column_name=>'OPTED_IN_LINK'
,p_display_order=>111
,p_column_identifier=>'Y'
,p_column_label=>'Just Opted In'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51825529852355349282)
,p_db_column_name=>'STATIC_ID_LINK'
,p_display_order=>121
,p_column_identifier=>'Z'
,p_column_label=>'Selected Notification'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(56255567951385367960)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'82306002'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TEAM_MEMBER:NOTIFICATION:FREQUENCY:OPTED_IN:OPTED_IN_FOR_FILTER:LAST_SENT:UPDATED:'
,p_sort_column_1=>'TEAM_MEMBER'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'NOTIFICATION'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66034073855699329174)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48024972238268138992)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(66034073855699329174)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:16015:&SESSION.::&DEBUG.:RR,16015::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48401069901276018686)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(66034073855699329174)
,p_button_name=>'ADD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add New'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:16016:&SESSION.::&DEBUG.:16016::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(51825529919814349283)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(66034073855699329174)
,p_button_name=>'INFO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Information'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:16017:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-question-circle-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48024972627528138993)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(66034073855699329174)
,p_button_name=>'APPLY_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48024971826174138991)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(66034073855699329174)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48401070024974018687)
,p_name=>'refresh after add'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(66034073855699329174)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48401070099017018688)
,p_event_id=>wwv_flow_imp.id(48401070024974018687)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56255561802254367939)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48024973504429138997)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for i in 1..apex_application.g_f01.count loop',
'',
'    if apex_application.g_f02(i) = ''Y'' then',
'        sp_util.notification_opt_in (',
'            p_team_member_id  => apex_application.g_f03(i),',
'            p_notification_id => apex_application.g_f01(i),',
'            p_frequency       => upper(apex_application.g_f05(i)),',
'            p_release_id      => apex_application.g_f04(i));',
'    else',
'        sp_util.notification_opt_out (',
'            p_team_member_id  => apex_application.g_f03(i),',
'            p_notification_id => apex_application.g_f01(i),',
'            p_release_id      => apex_application.g_f04(i));',
'    end if;',
'',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Notification Subscriptions updated. '
,p_internal_uid=>11125615639027171228
);
wwv_flow_imp.component_end;
end;
/
