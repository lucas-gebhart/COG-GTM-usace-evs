prompt --application/pages/page_00093
begin
--   Manifest
--     PAGE: 00093
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
 p_id=>93
,p_name=>'Project Exceptions'
,p_alias=>'PROJECT-EXCEPTIONS'
,p_page_mode=>'MODAL'
,p_step_title=>'Project Exceptions'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42765983996857148781)
,p_plug_name=>'contents'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_util.exceptions_for_project (',
'           p_project_id     => :P93_PROJECT_ID,',
'           p_one_project_yn => ''Y'',',
'           p_team_member_id => null,',
'           p_link_type      => ''APP'',',
'           p_app_prefix_url => null,',
'           p_app_id         => :APP_ID,',
'           p_apex_session   => :APP_SESSION_ID,',
'           p_reviews_yn     => case when apex_util.get_build_option_status (',
'                                             p_application_id    => :APP_ID,',
'                                             p_build_option_name => ''Reviews'') = ''INCLUDE'' ',
'                                    then ''Y''',
'                                    else ''N''',
'                                    end,',
'           p_approvals_yn   => case when apex_util.get_build_option_status (',
'                                             p_application_id    => :APP_ID,',
'                                             p_build_option_name => ''Approvals'') = ''INCLUDE'' ',
'                                    then ''Y''',
'                                    else ''N''',
'                                    end );'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42765984137919148782)
,p_name=>'P93_PROJECT_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'SP_PROJECTS.PROJECT'
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large:margin-top-none:t-Form-fieldContainer--boldDisplay'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'LOV',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp.component_end;
end;
/
