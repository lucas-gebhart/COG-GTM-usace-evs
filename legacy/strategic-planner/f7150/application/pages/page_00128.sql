prompt --application/pages/page_00128
begin
--   Manifest
--     PAGE: 00128
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
 p_id=>128
,p_name=>'Favorite'
,p_alias=>'FAVORITE'
,p_page_mode=>'MODAL'
,p_step_title=>'Favorite'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38623446477306817714)
,p_plug_name=>'FavorIte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38804212931570716573)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38804214077481716585)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38804212931570716573)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38804213004913716574)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38804212931570716573)
,p_button_name=>'apply_changes'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38623446651412817715)
,p_name=>'P128_PROJECT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38623446477306817714)
,p_prompt=>'Project'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38623446718749817716)
,p_name=>'P128_PROJECT_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38623446477306817714)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38623446877719817718)
,p_name=>'P128_FAVORITE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(38623446477306817714)
,p_prompt=>'Favorite'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38623446970452817719)
,p_computation_sequence=>10
,p_computation_item=>'P128_PROJECT'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select project from sp_projects where id = :P128_PROJECT_ID'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38804212689499716571)
,p_computation_sequence=>30
,p_computation_item=>'P128_FAVORITE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_favorite varchar(1) := ''N'';',
'begin',
'   for c1 in (',
'       select 1 ',
'       from sp_favorites f',
'       where project_id = :P128_PROJECT_ID and',
'             team_member_id = :APP_USER_ID) loop',
'       -- if a row exists then project is user favorite',
'       l_favorite := ''Y'';',
'   end loop;',
'   return l_favorite;',
'end;'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38804214440109716588)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38804214077481716585)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38804214535274716589)
,p_event_id=>wwv_flow_imp.id(38804214440109716588)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38804213098079716575)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update favorites'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_count   int := 0;',
'   l_rows    int := 0;',
'begin',
'    if nvl(:P128_FAVORITE,''N'') = ''N'' then',
'        delete from SP_FAVORITES f where team_member_id = :APP_USER_ID and project_id = :P128_PROJECT_ID;',
'    end if;',
'    if nvl(:P128_FAVORITE,''N'') = ''Y'' then',
'       select count(*) into l_count from SP_FAVORITES f where team_member_id = :APP_USER_ID and project_id = :P128_PROJECT_ID;',
'       if l_count = 0 then',
'           insert into SP_FAVORITES (team_member_id, PROJECT_ID) values (:APP_USER_ID, :P128_PROJECT_ID);',
'       end if;',
'    end if;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Preferences Set'
,p_internal_uid=>1904855232677748806
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38804214615378716590)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>1904856749976748821
);
wwv_flow_imp.component_end;
end;
/
