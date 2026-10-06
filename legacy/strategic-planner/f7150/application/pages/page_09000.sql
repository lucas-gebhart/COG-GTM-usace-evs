prompt --application/pages/page_09000
begin
--   Manifest
--     PAGE: 09000
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
 p_id=>9000
,p_name=>'Get Image'
,p_alias=>'GET-IMAGE'
,p_step_title=>'Get Image'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_deep_linking=>'Y'
,p_rejoin_existing_sessions=>'Y'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21932650969491763725)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download Image'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_file_blob  sp_comment_images.file_blob%type;',
'    l_mimetype   sp_comment_images.mimetype%type;',
'begin',
'',
'    select file_blob, mimetype',
'      into l_file_blob, l_mimetype',
'      from sp_comment_images',
'     where unique_filename = apex_application.g_x01;',
'',
'    apex_http.download (',
'        p_blob         => l_file_blob,',
'        p_content_type => l_mimetype,',
'        p_is_inline    => true );',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>21931111387623705597
);
wwv_flow_imp.component_end;
end;
/
