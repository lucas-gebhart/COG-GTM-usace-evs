prompt --application/pages/page_00131
begin
--   Manifest
--     PAGE: 00131
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
 p_id=>131
,p_name=>'My Activities'
,p_alias=>'MY=CURRENT-AND-FUTURE-ACTIVITY'
,p_page_mode=>'MODAL'
,p_step_title=>'My Activities'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(38311123863894769230)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46793776562426387612)
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
'l_clob := ''<p>',
'An activity is something that consumes time identified by a start and end date.  ',
'This report shows your current and future (planned) activities.  ',
'This report excludes past activities.',
'</P>',
'<p>',
'An activity can be optionally associated with a &NOMENCLATURE_PROJECT!LOWER.. ',
'When an activity is associated with a &NOMENCLATURE_PROJECT!LOWER. the &NOMENCLATURE_PROJECT!LOWER. title becomes a link to the &NOMENCLATURE_PROJECT!LOWER. details.',
'The "2 days ago" style timeframe indicates last change to the activity.',
'</p>',
'<p>',
'     Click the dot-dot-dot actions menu controls to perform actions related to activities.',
'</p>',
'<p>',
'    Activity Attributes:',
'    <ul>',
'        <li><strong>Type</strong>: Type of activity performed, see list below for types of activities defined for this application.</li>',
'        <li><strong>Activity</strong>: Is a short description, up to 280 characters, of what activity is intended to occur between two dates.</li>',
'        <li><strong>Start Date</strong>: Date activity started or is planned to start.</li>',
'        <li><strong>End Date</strong>: Date activity was completed or is planned to be completed.</li>',
'        <li><strong>Optional &NOMENCLATURE_PROJECT!LOWER.:</strong>: Defines related &NOMENCLATURE_PROJECT!LOWER. if work is in support of a specific &NOMENCLATURE_PROJECT!LOWER..</li>',
'        <li><strong>Owner</strong>: Defines who is doing the activity.</li>',
'        <li><strong>Tags</strong>: Comma seperated list of tags to help filter activities.</li>',
'        <li><strong>URL</strong>: Optional URL relating to the activity.</li>',
'    </ul>',
'</p>',
'<br />',
'<br />'';',
'',
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
