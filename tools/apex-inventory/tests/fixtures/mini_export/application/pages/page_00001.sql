prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'home'
,p_alias=>'HOME'
,p_step_title=>'&NOMENCLATURE_STRATEGIC_PLANNER. home'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(900)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(500)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#'
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source_type=>'NATIVE_BREADCRUMB'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11)
,p_plug_name=>'My &NOMENCLATURE_PROJECTS.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.id, p.name, ''it''''s'' note',
'  from sp_projects p, sp_favorites f',
' where f.project_id = p.id'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1_X'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(12)
,p_region_id=>wwv_flow_imp.id(11)
,p_name=>'My Projects'
,p_max_row_count=>'1000000'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_detail_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_ID:#ID#'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(13)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(14)
,p_db_column_name=>'NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'&NOMENCLATURE_PROJECT. Name'
,p_column_type=>'STRING'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(15)
,p_worksheet_id=>wwv_flow_imp.id(12)
,p_name=>'Primary'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16)
,p_plug_name=>'Burn down'
,p_plug_display_sequence=>30
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(17)
,p_region_id=>wwv_flow_imp.id(16)
,p_chart_type=>'area'
,p_orientation=>'vertical'
,p_stack=>'off'
,p_legend_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(18)
,p_chart_id=>wwv_flow_imp.id(17)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select trunc(h.changed,''MM'') m, count(*) c',
'from sp_project_history h',
'group by trunc(h.changed,''MM'')'))
,p_items_value_column_name=>'C'
,p_items_label_column_name=>'M'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(19)
,p_name=>'Recently Changed'
,p_region_template_options=>'#DEFAULT#'
,p_display_sequence=>40
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, name from sp_projects order by updated desc'))
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(20)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_image_alt=>'Add &NOMENCLATURE_PROJECT.'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3::'
,p_required_role=>wwv_flow_imp.id(500)
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(22)
,p_name=>'P1_X'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(11)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23)
,p_name=>'P1_OWNER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(11)
,p_prompt=>'&NOMENCLATURE_USER.'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'.'||wwv_flow_imp.id(600)||'.'
,p_is_required=>true
,p_lov_display_null=>'YES'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(24)
,p_computation_sequence=>10
,p_computation_item=>'P1_X'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'42'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25)
,p_validation_name=>'owner required'
,p_validation_sequence=>10
,p_validation=>'P1_OWNER'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Pick a &NOMENCLATURE_USER..'
,p_associated_item=>wwv_flow_imp.id(23)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(26)
,p_name=>'refresh on change'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1_OWNER'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27)
,p_event_id=>wwv_flow_imp.id(26)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_owner => :P1_OWNER);'))
,p_attribute_02=>'P1_OWNER'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28)
,p_event_id=>wwv_flow_imp.id(26)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(11)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(29)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Log view'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_view(:APP_PAGE_ID);',
'sp_util.touch(''HOME'');'))
,p_process_clob_language=>'PLSQL'
,p_process_when_button_id=>wwv_flow_imp.id(21)
,p_process_success_message=>'Saved (it''s done).'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(30)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(31)
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
end;
/
