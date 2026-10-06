prompt --application/pages/page_00107
begin
--   Manifest
--     PAGE: 00107
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
 p_id=>107
,p_name=>'Project'
,p_alias=>'PROJECT1'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_PROJECTS.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39711610362913572855)
,p_plug_name=>'button container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41042297043203323872)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'This application primarily tracks &NOMENCLATURE_PROJECTS.. ',
'A &NOMENCLATURE_PROJECT. typically has an owner, can optionally be assigned to a release, has a priority, and a size.',
'People who work on a given &NOMENCLATURE_PROJECT. can record their work as an activity.',
'</p>',
'<p>',
'    Click the dot-dot-dot actions menu control to perform other functions related to &NOMENCLATURE_PROJECTS..',
'</p>',
'<p>',
'    &NOMENCLATURE_PROJECT. Organization:<br><br>',
'    &NOMENCLATURE_AREAS. >  &NOMENCLATURE_INITIATIVES. >  <strong>&NOMENCLATURE_PROJECTS.</strong>',
'</p>',
'<p>',
'    &NOMENCLATURE_PROJECT. Attributes:',
'    <ul>',
'        <li><strong>&NOMENCLATURE_INITIATIVE.</strong>: Defines how this &NOMENCLATURE_PROJECT. is organized.</li>',
'        <li><strong>&NOMENCLATURE_PROJECT.</strong>: Name of &NOMENCLATURE_PROJECT..</li>',
'        <li><strong>Owner</strong>: Person most responsible for this project</li>',
'        <li><strong>Status</strong>: Defines progress on completing a &NOMENCLATURE_PROJECT. in 10% increments from 0% to 100%.  ',
'        Status values are also organized into 3 categories backlog (between 10% and 40% complete), ',
'        actioning (between 50% and 90% complete) and delivered (100% complete).</li>',
'        <li><strong>Priority</strong>: Defines how important this &NOMENCLATURE_PROJECT. is compared with other &NOMENCLATURE_PROJECTS.</li>',
'        <li><strong>Size</strong>: T-shirt sized project size.  Sizes roughly correspond to hours of effort.</li>',
'        <li><strong>Dates</strong>: A number of dates are provided to provide milestones within a &NOMENCLATURE_PROJECT. life cycle.</li>',
'        <li><strong>Tags</strong>: Used to filter and categorize &NOMENCLATURE_PROJECTS..</li>',
'        <li><strong>Release Dependent</strong>: Defines is the target complete date is set to a release or is set to a calendar date</li>',
'        <li><strong>Release</strong>: Choose release if release dependent is set to true</li>',
'        <li><strong>Target Date</strong>: Choose a calendar date if release dependent is set to false</li>',
'        <li><strong>Target</strong>: Is a filter that combines both target dates and releases, e.g. a way to filter &NOMENCLATURE_PROJECTS.</li>',
'    </ul>',
'    <i>Note: depending on how your instance of this application is configured you may see a subset of these attributes.</i>',
'</p>',
'<br />',
'<br />'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305641300183783768)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39711610362913572855)
,p_button_name=>'what_is_a_release'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About Releases'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:108:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339873984761579)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39711610362913572855)
,p_button_name=>'what_is_an_area'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_AREAS.'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339314652761573)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(39711610362913572855)
,p_button_name=>'what_is_a_initiative'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_INITIATIVES.'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:106:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339630603761576)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(39711610362913572855)
,p_button_name=>'what_is_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About Activities'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp.component_end;
end;
/
