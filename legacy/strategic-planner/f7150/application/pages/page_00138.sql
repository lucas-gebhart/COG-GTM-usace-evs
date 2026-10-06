prompt --application/pages/page_00138
begin
--   Manifest
--     PAGE: 00138
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
 p_id=>138
,p_name=>'My Projects'
,p_alias=>'MY-PROJECTS-HOME-PAGE'
,p_page_mode=>'MODAL'
,p_step_title=>'My &NOMENCLATURE_PROJECTS.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(38311123863894769230)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49738645256633218288)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_clob clob;',
'begin',
'   l_clob := ''<p>',
'This report shows &NOMENCLATURE_PROJECTS!LOWER. you are the owner of or if you have incomplete tasks assigned.',
'You can be associated with &NOMENCLATURE_PROJECTS!LOWER. in may ways which include:',
'</P>',
'<ul>',
'    <li><strong>Owner</strong>: You are identified as the owner of the &NOMENCLATURE_PROJECT!LOWER.</li>',
'    <li><strong>Contributor</strong>: You are assigned a task (Milestone, Review or other) on the &NOMENCLATURE_PROJECT!LOWER.</li>',
'    <li><strong>Activity</strong>: You are performing some activities related to the &NOMENCLATURE_PROJECT!LOWER.</li>',
'</ul>',
'<p>',
'    Consider this list of &NOMENCLATURE_PROJECTS!LOWER. as good candidates to associate activity with.  These are &NOMENCLATURE_PROJECTS!LOWER. you are likely to work on.',
'</p>',
'<p>',
'    An open &NOMENCLATURE_PROJECT!LOWER. is a &NOMENCLATURE_PROJECT!LOWER. that is not 100% complete and is not 0% complete.',
'</p>',
'<br />',
'<br />'';',
'l_clob := replace(l_clob,''&NOMENCLATURE_PROJECTS.'',:NOMENCLATURE_PROJECTS);',
'l_clob := replace(l_clob,''&NOMENCLATURE_PROJECT.'',:NOMENCLATURE_PROJECT);',
'l_clob := replace(l_clob,''&NOMENCLATURE_PROJECTS!LOWER.'',lower(:NOMENCLATURE_PROJECTS));',
'l_clob := replace(l_clob,''&NOMENCLATURE_PROJECT!LOWER.'',lower(:NOMENCLATURE_PROJECT));',
'return l_clob;',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp.component_end;
end;
/
