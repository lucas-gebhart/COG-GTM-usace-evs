prompt --application/pages/page_00110
begin
--   Manifest
--     PAGE: 00110
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
 p_id=>110
,p_name=>'Activity'
,p_alias=>'ACTIVITY2'
,p_page_mode=>'MODAL'
,p_step_title=>'Activity'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(38311123863894769230)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39712397764304976912)
,p_plug_name=>'button container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(43853548691298138510)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'An activity is something that consumes the time.  ',
'Typically, but not always, an activity is work relating to a specific &NOMENCLATURE_PROJECT.. ',
'</P>',
'<p>',
'Activity is time bound, activity starts at a given day and is estimated to complete by an end date.',
'</p>',
'<p>',
'    Activity Attributes:',
'    <ul>',
'        <li><strong>Type</strong>: Type of activity performed, see list below for types of activities defined for this application.</li>',
'        <li><strong>Activity</strong>: Is a short description, up to 280 characters, of what activity is intended to occur between two dates.</li>',
'        <li><strong>Start Date</strong>: Date activity started or is planned to start</li>',
'        <li><strong>End Date</strong>: Date activity was completed or is planned to be completed</li>',
'        <li><strong>Optional &NOMENCLATURE_PROJECT.:</strong>: Defines related &NOMENCLATURE_PROJECT. if work is in support of a specific &NOMENCLATURE_PROJECT.</li>',
'        <li><strong>Owner:</strong>: Defines who is doing the activity</li>',
'        <li><strong>Tags</strong>: Comma seperated list of tags to help filter activities.</li>',
'        <li><strong>URL</strong>: Optional URL relating to the activity.</li>',
'    </ul>',
'</p>',
'<p>',
'    Organization of Activities Associated with &NOMENCLATURE_PROJECTS.:',
'    <p>',
'        &NOMENCLATURE_AREA. > &NOMENCLATURE_INITIATIVE. > &NOMENCLATURE_PROJECT. > <strong>Activity</strong>',
'    </p>',
'</p>',
'<p>',
'    Organization of Activities Associated with &NOMENCLATURE_USER. and not a &NOMENCLATURE_PROJECT.:',
'    <p>',
'        &NOMENCLATURE_USER. > <strong>Activity</strong>',
'    </p>',
'</p>',
'<br />',
'<br />'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305340072372761581)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39712397764304976912)
,p_button_name=>'what_is_an_area'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_AREAS.'
,p_button_redirect_url=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339992133761580)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39712397764304976912)
,p_button_name=>'what_is_an_initiative'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_INITIATIVES.'
,p_button_redirect_url=>'f?p=&APP_ID.:106:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38306417507203183116)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(39712397764304976912)
,p_button_name=>'what_is_a_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_PROJECTS.'
,p_button_redirect_url=>'f?p=&APP_ID.:107:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38306417123658183115)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(39712397764304976912)
,p_button_name=>'what_is_a_user'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_USERS.'
,p_button_redirect_url=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp.component_end;
end;
/
