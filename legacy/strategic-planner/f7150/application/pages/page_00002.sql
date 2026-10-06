prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
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
 p_id=>2
,p_name=>'My Alerts'
,p_alias=>'MY-ALERTS'
,p_page_mode=>'MODAL'
,p_step_title=>'My Alerts'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(() => { ',
'    apex.actions.add({',
'        name: ''dismissNotif'',',
'        action: function(event, focusElement, args) {',
'            $(event.currentTarget).addClass(''js-notif-to-dismiss'');',
'            apex.item(''P2_NOTIF_TO_DISMISS'').setValue(args.id);',
'            return true;',
'            }',
'    });',
'});'))
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44111607551264274217)
,p_plug_name=>'Notifications'
,p_icon_css_classes=>'fa-window-close-o'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>40
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id,',
'       case notification_type ',
'            when ''APPROVAL'' then ''fa-workflow''',
'            when ''APPROVAL-CLARIFICATION'' then ''fa-question-circle-o''',
'            when ''MENTION'' then ''fa-at''',
'            when ''COMMENT'' then ''fa-comment-o''',
'            when ''ASSIGNMENT'' then ''fa-tasks-alt''',
'            when ''OWNER'' then ''fa-user''',
'            end icon,',
'       apex_page.get_url(',
'           p_application => :APP_ID,',
'           p_page        => case when task_id is not null then 502',
'                                 when project_id is not null then 3',
'                                 end,',
'           p_session     => :APP_SESSION,',
'           p_clear_cache => case when task_id is not null then 502',
'                                 when project_id is not null then 3',
'                                 end,',
'           p_items       => case when task_id is not null then ''P502_PREV_PAGE,P502_TASK_ID,P502_PROJECT_ID''',
'                                 when project_id is not null then ''P3_PROJECT_ID''',
'                                 end,',
'           p_values      => case when task_id is not null then ''3,''||task_id||'',''||project_id',
'                                 when project_id is not null then to_char(project_id)',
'                                 end ) link,',
'       title,',
'       created,',
'       lower(created_by) created_by',
'  from sp_team_member_notifications',
' where team_member_id = :APP_USER_ID',
'   and dismissed_yn = ''N''',
'   and instr('':''||notification_pref||'':'','':APP:'') > 0'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'created desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'No active alerts.'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'OVERLINE', '&CREATED. by &CREATED_BY.',
  'REMOVE_PADDING', 'N',
  'STYLE', 't-ContentRow--styleCompact',
  'TITLE', '&TITLE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36096048872506000058)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40690389181426052911)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40690389341344052912)
,p_name=>'TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(44508543201866635296)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(44508543693387635301)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48139344049258521292)
,p_name=>'LINK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LINK'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56010940732705407238)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40717300143746853241)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56010940732705407238)
,p_button_name=>'CLOSE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40690388894242052908)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56010940732705407238)
,p_button_name=>'DISMISS_ALL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Dismiss All'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'Are you sure you want to dismiss all your alerts?'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_team_member_notifications',
' where team_member_id = :APP_USER_ID',
'   and dismissed_yn = ''N''',
'   and instr('':''||notification_pref||'':'','':APP:'') > 0'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44508546508662635310)
,p_name=>'P2_NOTIF_TO_DISMISS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44111607551264274217)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40717301903374853243)
,p_name=>'close'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(40717300143746853241)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40717302367123853243)
,p_event_id=>wwv_flow_imp.id(40717301903374853243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40717338072766859596)
,p_name=>'dismiss notif'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_NOTIF_TO_DISMISS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40717339497811859598)
,p_event_id=>wwv_flow_imp.id(40717338072766859596)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update sp_team_member_notifications',
'   set dismissed_yn = ''Y''',
' where id = :P2_NOTIF_TO_DISMISS',
'   and team_member_id =  :APP_USER_ID;'))
,p_attribute_02=>'P2_NOTIF_TO_DISMISS'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40717338529256859598)
,p_event_id=>wwv_flow_imp.id(40717338072766859596)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.items.P2_NOTIF_TO_DISMISS.setValue('''',undefined,true);'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40717339010580859598)
,p_event_id=>wwv_flow_imp.id(40717338072766859596)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(44111607551264274217)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40690389052651052909)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'dismiss all'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update sp_team_member_notifications',
'   set dismissed_yn = ''Y''',
' where team_member_id = :APP_USER_ID',
'   and dismissed_yn = ''N''',
'   and instr('':''||notification_pref||'':'','':APP:'') > 0;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(40690388894242052908)
,p_process_success_message=>'Alerts dismissed.'
,p_internal_uid=>3791031187249085140
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40717301530349853242)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'close'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(40690388894242052908)
,p_internal_uid=>3817943664947885473
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(44508543388451635298)
,p_region_id=>wwv_flow_imp.id(44111607551264274217)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Dismiss'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$dismissNotif?id=&ID.'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-times'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(44508543497172635299)
,p_region_id=>wwv_flow_imp.id(44111607551264274217)
,p_position_id=>348722977165395441
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&LINK.'
);
wwv_flow_imp.component_end;
end;
/
