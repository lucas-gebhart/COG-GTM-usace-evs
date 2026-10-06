prompt --application/pages/page_00025
begin
--   Manifest
--     PAGE: 00025
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
 p_id=>25
,p_name=>'About Release Dashboard'
,p_alias=>'ABOUT-RELEASE-DASHBOARD'
,p_page_mode=>'MODAL'
,p_step_title=>'About Release Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39340212909823352597)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The release dashboard provides a distribution of data by priority, size, and owner.  Use this dashboard to track release progress.<p>',
'',
'<strong>Column Descriptions</strong>',
'<ul>',
'<li><strong>Priority</strong>: P1 through P5 with P1 most important</li>',
'<li><strong>&NOMENCLATURE_PROJECT. Count</strong>>: Number of projects associated with the release that correspond to the grouping.</li>',
'</ul>',
'<ul>',
'<li><strong>Percent Complete</strong>: Distribution of &NOMENCLATURE_PROJECT. percent complete in 10% increments from 0% to 100%.</li>',
'<li><strong>Complete</strong>: For all &NOMENCLATURE_PROJECTS. in the grouping what is the overall percent complete.</li>',
'</ul>',
'<ul>',
'<li><strong>Budgeted Days of Effort</strong>: Each &NOMENCLATURE_PROJECT. has a size (S, M, L, XL, 2XL), ',
'    and each size has a budgeted level of effort in days.  ',
'    The budgeted days of effort is the total number of days estimated to complete all &NOMENCLATURE_PROJECTS. in the grouping.</li>',
'<li><strong>Days Completed</strong>: Based on the percent complete for each project how much of the estimated days of effort have been completed.</li>',
'<li><strong>Days Outstanding</strong>: Budgeted days of effort <i>minus</i> days completed <i>equals</i> estimated days of effort outstanding.</li>',
'</ul>',
'<ul>',
'<li><strong>Last Comment</strong>: The most recent comment by any person about a &NOMENCLATURE_PROJECT. within the selected grouping.</li>',
'<li><strong>Current Activity</strong>: The count of distinct  &NOMENCLATURE_PROJECTS. that have active activity, ',
'    e.g. activity start and end dates intersect today''s date.  ',
'    Activity recorded with an end date before today does not count.  ',
'    Activity recorded to start after today is also not counted.</li>',
'</ul>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp.component_end;
end;
/
