prompt --application/shared_components/logic/application_processes/post_comment_image
begin
--   Manifest
--     APPLICATION PROCESS: POST_COMMENT_IMAGE
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(21933077275722768746)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST_COMMENT_IMAGE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.upload_image (',
'    p_file_base64  => apex_application.g_clob_01,',
'    p_filename     => apex_application.g_x02,',
'    p_mimetype     => apex_application.g_x03,',
'    p_image_ref_id => json_value(apex_application.g_x01, ''$.imageRefId'') );'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
,p_version_scn=>45188590240662
);
wwv_flow_imp.component_end;
end;
/
