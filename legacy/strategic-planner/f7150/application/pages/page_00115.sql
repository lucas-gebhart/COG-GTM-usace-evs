prompt --application/pages/page_00115
begin
--   Manifest
--     PAGE: 00115
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
 p_id=>115
,p_name=>'What is Release Milestones'
,p_alias=>'WHAT-IS-RELEASE-MILESTONES'
,p_page_mode=>'MODAL'
,p_step_title=>'Release Milestones'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39728766699136908047)
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
 p_id=>wwv_flow_imp.id(43869917626130069645)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'A release milestones are dates assocated with a specific release.  ',
'Release milestones are displayed in the release calendar.',
'</p>',
'',
'<p>',
'    Organization:',
'    <p>',
'        Release Train > Release > <strong>Release Milestones</strong>',
'    </p>',
'</p>',
'<br />',
'<br />'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38322786419016114250)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39728766699136908047)
,p_button_name=>'what_is_a_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_PROJECTS.'
,p_button_redirect_url=>'f?p=&APP_ID.:107:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38322785985814114248)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39728766699136908047)
,p_button_name=>'what_is_a_user'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About &NOMENCLATURE_USERS.'
,p_button_redirect_url=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38317530990249869274)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(39728766699136908047)
,p_button_name=>'what_is_a_release'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'About Releases'
,p_button_redirect_url=>'f?p=&APP_ID.:108:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
);
wwv_flow_imp.component_end;
end;
/
