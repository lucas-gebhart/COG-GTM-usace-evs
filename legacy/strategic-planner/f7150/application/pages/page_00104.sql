prompt --application/pages/page_00104
begin
--   Manifest
--     PAGE: 00104
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
 p_id=>104
,p_name=>'Add Project'
,p_alias=>'ADD-PROJECT'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Project'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_protection_level=>'C'
,p_page_component_map=>'17'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38236331016292145079)
,p_plug_name=>'Content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38236332587249145095)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38236332922892145098)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38236332587249145095)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38236332693357145096)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38236332587249145095)
,p_button_name=>'Next'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(38236333697903145106)
,p_branch_name=>'go to step 2'
,p_branch_action=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_INITIATIVE_ID,P24_RELEASE_ID,P24_RELEASE_ID:&P104_INITIATIVE.,&P104_RELEASE_ID.,&P104_RELEASE_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38236331340061145082)
,p_name=>'P104_AREA'
,p_is_required=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(38236331016292145079)
,p_item_default=>'P104_DEFAULT_AREA'
,p_item_default_type=>'ITEM'
,p_prompt=>'Select &NOMENCLATURE_AREA.'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.area d, a.id r',
'from sp_areas a',
'where HIDDEN_BY_DEFAULT_YN = ''N''',
'order by upper(a.area)'))
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'&NOMENCLATURE_AREAS. are a top level "folders" that are subdivided into &NOMENCLATURE_INITIATIVES..   &NOMENCLATURE_INITIATIVES. are used to organize &NOMENCLATURE_PROJECTS.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38236331522861145084)
,p_name=>'P104_INITIATIVE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38236331016292145079)
,p_item_default=>'P104_DEFAULT_INITIATIVE'
,p_item_default_type=>'ITEM'
,p_prompt=>'Select &NOMENCLATURE_INITIATIVE.'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initiative, id',
'from SP_INITIATIVES i',
'where area_id = :P104_area and',
'      nvl(HIDDEN_BY_DEFAULT_YN,''N'') = ''N''',
'order by upper(initiative)'))
,p_lov_cascade_parent_items=>'P104_AREA'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'&NOMENCLATURE_INITIATIVES. organize &NOMENCLATURE_PROJECTS. within &NOMENCLATURE_AREAS.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38317534636001869310)
,p_name=>'P104_DEFAULT_AREA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38236331016292145079)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38317534765095869311)
,p_name=>'P104_DEFAULT_INITIATIVE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38236331016292145079)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52590898709650963413)
,p_name=>'P104_RELEASE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(38236331016292145079)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38236333864587145107)
,p_validation_name=>'Initiative must be specified'
,p_validation_sequence=>10
,p_validation=>'P104_INITIATIVE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'&NOMENCLATURE_INITIATIVE. must be specified.'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38236333024942145099)
,p_name=>'close dialog on cancel'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38236332922892145098)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38236333082747145100)
,p_event_id=>wwv_flow_imp.id(38236333024942145099)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38317534815375869312)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set defaults based on last project view'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P104_DEFAULT_AREA := null;',
':P104_DEFAULT_INITIATIVE := null;',
'for c1 in (',
'    select l.project_id, i.area_id, p.INITIATIVE_ID, l.PAGE_RENDERED',
'    from   SP_PROJ_INTERACTIONS_LOG l, sp_projects P, sp_initiatives i ',
'    where  l.APP_USER = lower(:APP_USER) and',
'           l.project_id = p.id and',
'           p.INITIATIVE_ID = i.id and',
'           p.archived_yn = ''N''',
'    order by l.PAGE_RENDERED desc',
'    fetch first 1 rows only',
'',
') loop',
'    :P104_DEFAULT_AREA := c1.area_id;',
'    :P104_DEFAULT_INITIATIVE := c1.INITIATIVE_ID;',
'end loop;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1418176949973901543
);
wwv_flow_imp.component_end;
end;
/
