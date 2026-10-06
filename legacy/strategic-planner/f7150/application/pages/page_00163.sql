prompt --application/pages/page_00163
begin
--   Manifest
--     PAGE: 00163
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
 p_id=>163
,p_name=>'About Kanban'
,p_alias=>'ABOUT-KANBAN'
,p_page_mode=>'MODAL'
,p_step_title=>'About Kanban'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(38311123863894769230)
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(48520462122696828334)
,p_dialog_height=>'600'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38033423287307290419)
,p_plug_name=>'Kanban Board'
,p_region_template_options=>'#DEFAULT#:margin-top-none'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    <h3>Kanban Board</h3>',
'    <p>A Kanban board provides a multi-dimensional view of projects to assist with the management and planning of projects at a Programme level. A Kanban board tracks three stages: To Do, In Progress, and Done, which in Strategic Planner is represent'
||'ed by five columns:</p>',
'',
'    <ol>',
'        <li><strong>New:</strong> Candidate projects (10%-20% complete).</li>',
'        <li><strong>Architecting:</strong> Being scoped and estimated (30% complete).</li>',
'        <li><strong>Ready:</strong> Approved and ready to start (40% complete).</li>',
'        <li><strong>In Progress:</strong> Actively in development (50%-70% complete).</li>',
'        <li><strong>Done:</strong> Development finished, verifying or merging (80%-100% complete).</li>',
'    </ol>',
'',
'    <p>Completed projects that are not release-dependent and projects that have been released are not displayed. Rejected projects are also not displayed.</p>',
'',
'    <h4>Drag and Drop</h4>',
'    <p>Projects can be dragged between columns and groups, providing a quick method to update projects. To drag a project, click and hold, then move it to the new location. A single click on the project will open a detailed view and edit drawer.</p>',
'',
'    <h4>Weighted Shortest Job First (WSJF)</h4>',
'    <p>Projects are listed by priority multiplied by the estimated days effort, in ascending order . This ordering ensures that projects with the highest value for the least effort are likely to be done next.</p>',
'',
'    <h4>Bottlenecks</h4>',
'    <p>The Kanban board can be used to identify bottlenecks, where projects in progress will begin to pile up. It is good practice to limit the amount of work in progress for each group and prioritize resolving problems over starting new projects.</p'
||'>',
'',
'    <h3>Cumulative Flow</h3>',
'    <p>Click the ellipsis to view an accompanying Cumulative Flow chart. The Cumulative Flow shows the number of projects at each stage of completion over time. Consistent spacing and angles indicate an even flow through the system, whereas diverging'
||' lines indicate uneven flow and bottlenecks. Use the Timescale, Resolution, and Zoom functions to examine different points in the process in more detail.</p>',
'',
'    <h3>Control Chart</h3>',
'    <p>Another visualization is the Control Chart, which shows how long projects take between various stages. This is used to compare how long projects of equal size take to complete. Variances can indicate poor estimating or bottlenecks. Trend analy'
||'sis can be used to evaluate the effect new strategies are having on efficiency.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp.component_end;
end;
/
