prompt --application/pages/page_00118
begin
--   Manifest
--     PAGE: 00118
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
 p_id=>118
,p_name=>'What are Release Comments'
,p_alias=>'WHAT-ARE-RELEASE-COMMENTS'
,p_page_mode=>'MODAL'
,p_step_title=>'Release Comments'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41154735720500244746)
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
 p_id=>wwv_flow_imp.id(45295886647493406344)
,p_plug_name=>'About'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Release comments are comments that track the progression of a specific release.  ',
'',
'</p>',
'',
'<p>',
'    Organization:',
'    <p>',
'        Release Train > Release > <strong>Release Comments</strong>',
'    </p>',
'</p>',
'<br />',
'<br />'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38325328323646304475)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(41154735720500244746)
,p_button_name=>'what_is_a_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'What is a &NOMENCLATURE_PROJECT.?'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:107:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38325328695415304476)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(41154735720500244746)
,p_button_name=>'what_is_a_user'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'What is a &NOMENCLATURE_USER.?'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38325327948653304474)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(41154735720500244746)
,p_button_name=>'what_is_a_release'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'What is a Release?'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:108:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa=info'
);
wwv_flow_imp.component_end;
end;
/
