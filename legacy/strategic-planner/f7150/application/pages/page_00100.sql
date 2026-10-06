prompt --application/pages/page_00100
begin
--   Manifest
--     PAGE: 00100
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
 p_id=>100
,p_name=>'Comments'
,p_alias=>'COMMENTS1'
,p_page_mode=>'MODAL'
,p_step_title=>'Comments'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(23383229861175838758)
,p_name=>'Comment Report'
,p_region_name=>'COMMENTS'
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pc.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       apex_util.get_since(pc.created) comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       pc.body_html comment_text,',
'       case when pc.author_id = :APP_USER_ID',
'            then ''<a href="''||apex_util.prepare_URL(',
'                              p_url => ''f?p=''||:APP_ID||'':28:''||:APP_SESSION||''::NO::P28_ID:''||pc.id,',
'                              p_checksum_type => ''3''',
'                  )||''">edit</a>''',
'             end ||',
'             decode(pc.private_yn,null,null,''N'',null,''Y'','' <strong>Private</strong>'') actions,',
'       '' '' attribute_1,',
'       '' '' attribute_2,',
'       '' '' attribute_3,',
'       '' '' attribute_4,',
'       ''u-color-''||ora_hash(pc.created_by,45) icon_modifier,',
'',
'       -- Data Columns',
'       pc.PROJECT_ID,',
'       pc.BODY,',
'       pc.BODY_HTML,',
'       --',
'       pc.CREATED,',
'       pc.CREATED_BY,',
'       pc.UPDATED,',
'       pc.UPDATED_BY,',
'       tm.id team_member_id',
'  from SP_PROJECT_COMMENTS_V pc, ',
'       sp_team_members tm',
'where pc.author_id = tm.id (+)',
'  and pc.project_id = :P100_PROJECT_ID',
'  and (nvl(pc.private_yn,''N'') = ''N'' or lower(pc.created_by) = lower(:app_user) )',
'order by created desc'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No Comments'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383229955249838759)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231087394838771)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>130
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231254407838772)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>140
,p_column_heading=>'Comment Date'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231374304838773)
,p_query_column_id=>4
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>150
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231462553838774)
,p_query_column_id=>5
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Text'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231522336838775)
,p_query_column_id=>6
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>170
,p_column_heading=>'Actions'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231602533838776)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>180
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231692154838777)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>190
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231783853838778)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23674846027111341029)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23674846154194341030)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>220
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230042435838760)
,p_query_column_id=>12
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>20
,p_column_heading=>'Project Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230103962838761)
,p_query_column_id=>13
,p_column_alias=>'BODY'
,p_column_display_sequence=>30
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230213763838762)
,p_query_column_id=>14
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>40
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230729218838767)
,p_query_column_id=>15
,p_column_alias=>'CREATED'
,p_column_display_sequence=>90
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230858457838768)
,p_query_column_id=>16
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>100
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383230922076838769)
,p_query_column_id=>17
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383231037725838770)
,p_query_column_id=>18
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23674846259640341031)
,p_query_column_id=>19
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>230
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39949550201445729420)
,p_plug_name=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(144390210559154653886)
,p_plug_name=>'Comments'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41806956626296483911)
,p_plug_name=>'Post Comment Button Container'
,p_parent_plug_id=>wwv_flow_imp.id(144390210559154653886)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>40
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38429526982262414380)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39949550201445729420)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38429526643647414378)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39949550201445729420)
,p_button_name=>'View_Project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'View Project'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:&P100_PROJECT_ID.'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38429474055214379311)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(41806956626296483911)
,p_button_name=>'POST_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Post Comment'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722865018088623548)
,p_name=>'P100_IMAGE_REF_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(144390210559154653886)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38429381635151341674)
,p_name=>'P100_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(144390210559154653886)
,p_prompt=>'Project'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_PROJECTS.PROJECT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46944032838013679807)
,p_name=>'P100_PRIVATE_YN'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(41806956626296483911)
,p_item_default=>'N'
,p_prompt=>'This is a private comment'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(152961120493286911082)
,p_name=>'P100_COMMENT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(144390210559154653886)
,p_prompt=>'Comment'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(options) {',
'    return spCommentImageSupport.markdown.configEditor(options, {',
'        apexUpload: {',
'            // Application process name that that will handle the POST request when an image is dropped into',
'            // text box',
'            uploadApplicationProcess: ''POST_COMMENT_IMAGE'',',
'            // Pass in any data that you want in the POST process ',
'            // Will be passed in as a JSON object and available in apex_application.g_x01',
'            data: {',
'                imageRefId: apex.item(''P100_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23673717968001910981)
,p_name=>'Add Comment'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38429474055214379311)
,p_condition_element=>'P100_COMMENT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23673720868872910983)
,p_event_id=>wwv_flow_imp.id(23673717968001910981)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(38429474055214379311)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23673718807689910982)
,p_event_id=>wwv_flow_imp.id(23673717968001910981)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'add comment and do alerts'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_project_comment (',
'    p_app_user_id   => :APP_USER_ID,',
'    p_app_user      => :APP_USER,',
'    p_comment       => :P100_COMMENT,',
'    p_project_id    => :P100_PROJECT_ID,',
'    p_private_yn    => nvl(:P100_PRIVATE_YN,''N''),',
'    p_app_id        => :APP_ID,',
'    p_permalink_pre => APEX_UTIL.HOST_URL(''SCRIPT'') || ''project-details?fi='',',
'    p_nomen_sp      => :NOMENCLATURE_STRATEGIC_PLANNER,',
'    p_nomen_project => :NOMENCLATURE_PROJECT,',
'    p_image_ref_id  => :P100_IMAGE_REF_ID );',
'',
':P100_COMMENT      := null;',
':P100_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P100_COMMENT,P100_PRIVATE_YN,P100_PROJECT_ID,P100_PERMALINK_PREFIX,P100_IMAGE_REF_ID'
,p_attribute_03=>'P100_COMMENT,P100_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23673719372258910982)
,p_event_id=>wwv_flow_imp.id(23673717968001910981)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(23383229861175838758)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23673719892556910983)
,p_event_id=>wwv_flow_imp.id(23673717968001910981)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23673721479487910983)
,p_event_id=>wwv_flow_imp.id(23673717968001910981)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(38429474055214379311)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38429382031006341678)
,p_name=>'close dialog'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38429526982262414380)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38429382097167341679)
,p_event_id=>wwv_flow_imp.id(38429382031006341678)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25423961467478543469)
,p_name=>'links in comments in new tab'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25423961540584543470)
,p_event_id=>wwv_flow_imp.id(25423961467478543469)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp.component_end;
end;
/
