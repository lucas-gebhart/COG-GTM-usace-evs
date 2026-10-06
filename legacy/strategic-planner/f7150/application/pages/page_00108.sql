prompt --application/pages/page_00108
begin
--   Manifest
--     PAGE: 00108
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
 p_id=>108
,p_name=>'Release'
,p_alias=>'RELEASE1'
,p_page_mode=>'MODAL'
,p_step_title=>'Release'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38305339152152761571)
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
 p_id=>wwv_flow_imp.id(42446490079145923169)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'A release is used to bucket &NOMENCLATURE_PROJECTS.. ',
'Releases have milestones, comments, a open date and a release date.',
'An active release is a release has an open date on or before today and a release date on or before today.',
'</p>',
'<p>',
'     Click the dot-dot-dot actions menu control to perform other functions related to releases.',
'</p>',
'<p>',
'    Release Attributes:',
'    <ul>',
'        <li><strong>Release Train</strong>: Defines the product family, for example APEX.  A release train can have many releases.</li>',
'        <li><strong>Release</strong>: Defines the release within the release train, for example 7, thus APEX 7.</li>',
'        <li><strong>Owner</strong>: &NOMENCLATURE_USER. who is most responsible for the release.</li>',
'        <li><strong>Open Date</strong>: Date contributions are allowed to start</li>',
'        <li><strong>Release Open Completed</strong>: Switch that defines that the release is or is not opened</li>',
'        <li><strong>Release Target Date:</strong>: Defines the plan of record date the release is targeted to ship e.g. be formally completed.</li>',
'        <li><strong>Release Completed:</strong>: Switch that defines that the release is or is not completed.</li>',
'        <li><strong>Description:</strong>: Optional text that defines the release.</li>',
'    </ul>',
'</p>',
'<p>',
'    Organization:',
'    <p>',
'        Release Train > <strong>Release</strong> > &NOMENCLATURE_PROJECTS.',
'    </p>',
'</p>',
'<br />',
'<br />'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339042505761570)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38305339152152761571)
,p_button_name=>'what_is_a_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_PROJECTS.'
,p_button_redirect_url=>'f?p=&APP_ID.:107:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38305339173643761572)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38305339152152761571)
,p_button_name=>'what_is_a_user'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_USERS.'
,p_button_redirect_url=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38317531084862869275)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(38305339152152761571)
,p_button_name=>'what_are_release_milestones'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About Release Milestones'
,p_button_redirect_url=>'f?p=&APP_ID.:115:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp.component_end;
end;
/
