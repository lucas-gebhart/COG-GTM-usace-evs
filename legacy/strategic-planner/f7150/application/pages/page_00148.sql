prompt --application/pages/page_00148
begin
--   Manifest
--     PAGE: 00148
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
 p_id=>148
,p_name=>'Weekly Summary'
,p_alias=>'WEEKLY-SUMMARY'
,p_step_title=>'Weekly Summary'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066659146316698292)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.sp-tag {',
'  padding: .125rem .25rem;',
'  display: inline-block;',
'  vertical-align: text-bottom;',
'  border-radius: .1875rem;',
'  background-color: rgba(0, 0, 0, .1);',
'  text-overflow: ellipsis;',
'  white-space: nowrap;',
'}',
'',
'.sp-tags-container {',
'  display: flex;',
'  align-items: center;',
'  flex-wrap: wrap;',
'  gap: .25rem;',
'  justify-content: flex-start;',
'}',
'',
'h3:first-of-type {',
'  margin-block-start: 0;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20511112803004173153)
,p_plug_name=>'hidden stuff'
,p_plug_display_sequence=>1
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61530691414446005848)
,p_plug_name=>'Weekly Summary'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>101
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69638681055520388454)
,p_plug_name=>'buttons'
,p_parent_plug_id=>wwv_flow_imp.id(61530691414446005848)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(53728659243476523541)
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69638681214650388455)
,p_plug_name=>'Weekly Summary content'
,p_title=>'Weekly Summary'
,p_parent_plug_id=>wwv_flow_imp.id(61530691414446005848)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>81
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_contributor_summary.generate (',
'           p_team_member_id   => :P148_ID,',
'           p_show_approvals   => case when apex_application_admin.get_build_option_status (',
'                                             p_application_id    => :APP_ID,',
'                                             p_build_option_name => ''Approvals'' ) = ''INCLUDE''',
'                                      then ''Y''',
'                                      else ''N''',
'                                      end,',
'           p_links            => ''APP'',',
'           p_include_title_yn => ''N'',',
'           p_apex_session     => :APP_SESSION );'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P148_ID'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66423065991291184996)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>7
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20625131355666085479)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(69638681055520388454)
,p_button_name=>'SUBSCRIBE_ME_SUMMARY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Subscribe me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''WEEKLY_SUMMARY''',
'   and is_active_yn = ''Y''',
'   and not exists (select 1 from sp_notification_subscriptions',
'                    where notification_id = n.id',
'                      and team_member_id = :APP_USER_ID',
'                      and opted_in_yn = ''Y'')',
'   and :APP_USER_ID is not null',
'   and :P148_ID = :APP_USER_ID'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20625131691818085479)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(69638681055520388454)
,p_button_name=>'UNSUBSCRIBE_ME_SUMMARY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Unsubscribe'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_notifications n',
' where static_id = ''WEEKLY_SUMMARY''',
'   and is_active_yn = ''Y''',
'   and exists (select 1 from sp_notification_subscriptions',
'                where notification_id = n.id',
'                  and team_member_id = :APP_USER_ID',
'                  and opted_in_yn = ''Y'')',
'   and :P148_ID = :APP_USER_ID'))
,p_button_condition_type=>'EXISTS'
,p_required_patch=>wwv_flow_imp.id(48021503892065797891)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20625132180198085480)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(66423065991291184996)
,p_button_name=>'EMAIL_ME_SUMMARY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Email to me'
,p_button_position=>'CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20625142914726085497)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(66423065991291184996)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_ID:&P148_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64310862750643604349)
,p_name=>'P148_EMAIL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(20511112803004173153)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64310862939873604351)
,p_name=>'P148_FIRST_NAME'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(20511112803004173153)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64310863065700604352)
,p_name=>'P148_LAST_NAME'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(20511112803004173153)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(172569987459447635077)
,p_name=>'P148_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(20511112803004173153)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20625158775530085520)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Email summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_summary      clob;',
'begin',
'',
'    l_summary := sp_contributor_summary.generate (',
'                     p_team_member_id    => :P148_ID,',
'                     p_show_activities   => ''Y'',',
'                     p_show_projects     => ''Y'',',
'                     p_links             => ''EMAIL''',
'                     );',
'',
'    apex_mail.send ( ',
'            p_to                 => :APP_USER,   ',
'            p_from               => :APP_USER,  ',
'            p_application_id     => :APP_ID,  ',
'            p_template_static_id => ''EMAIL_ME'',  ',
'            p_placeholders       => ''{'' || ''"APPLICATION_LINK": "'' || sp_util.get_setting(p_static_id => ''APP_HOME_URL'') ||''", ''|| ',
'                                           ''"APP_NAME": ''   || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ) ||'', ''||',
'                                           ''"SUBJECT": ''    || apex_json.stringify( :NOMENCLATURE_STRATEGIC_PLANNER ||'' Weekly Summary'') ||'', ''||',
'                                           ''"SUMMARY": ''    || apex_json.stringify( l_summary ) ||',
'                                     ''}'' ); ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20625132180198085480)
,p_process_success_message=>'Weekly Summary email sent.'
,p_internal_uid=>20623619193662027392
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20625159140567085520)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Subscribe summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_in (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''WEEKLY_SUMMARY'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20625131355666085479)
,p_process_success_message=>'Subscribed to Weekly Summary.'
,p_internal_uid=>20623619558699027392
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20625160318170085522)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unsubscribe summary'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.notification_opt_out (',
'    p_team_member_id  => :APP_USER_ID,',
'    p_notification_id => sp_util.get_notification_id(''WEEKLY_SUMMARY'') );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20625131691818085479)
,p_process_success_message=>'Unsubscribed from Weekly Summary.'
,p_internal_uid=>20623620736302027394
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20625157975814085519)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set name details in session state'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select first_name, last_name, email',
'      from sp_team_members',
'     where id = :P148_ID',
') loop',
'    :P148_FIRST_NAME := c1.first_name;',
'    :P148_LAST_NAME  := c1.last_Name;',
'    :P148_EMAIL      := c1.email;',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>20623618393946027391
);
wwv_flow_imp.component_end;
end;
/
