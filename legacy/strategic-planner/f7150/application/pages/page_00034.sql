prompt --application/pages/page_00034
begin
--   Manifest
--     PAGE: 00034
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
 p_id=>34
,p_name=>'Size'
,p_alias=>'SIZE'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_PROJECT. Size'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42660676159698284305)
,p_plug_name=>'Size'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   x clob;',
'   l_remaining_days number;',
'begin',
'   for c1 in (',
'       select p.PCT_COMPLETE, ',
'              p.PROJECT_SIZE, ',
'              p.project, ',
'              ps.EFFORT_DAYS,',
'              ps.SIZE_DESCRIPTION, ',
'              round(ps.EFFORT_DAYS * .01 * p.PCT_COMPLETE) days_remaining',
'       from   SP_PROJECT_SIZES ps, SP_PROJECTS p',
'       where  p.id = :P34_ID and ',
'              p.PROJECT_SIZE = ps.PROJECT_SIZE',
'   ) loop',
'   l_remaining_days := round(c1.effort_days - c1.days_remaining);',
'   x := :NOMENCLATURE_PROJECT||'' "''||c1.project||''" is ''||c1.pct_complete||''% complete.  ''||',
'        :NOMENCLATURE_PROJECT||'' has an estimated size of ''||c1.project_size||'' which corresponds to ''||c1.effort_days||'' days of effort.  ''||',
'        ''The remaining effort is estimated to be ''||l_remaining_days||'' days.'';',
'   end loop;',
'   return x;',
'   ',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P34_ID'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42660676217485284306)
,p_name=>'P34_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(42660676159698284305)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp.component_end;
end;
/
