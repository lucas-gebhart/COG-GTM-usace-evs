prompt --application/shared_components/logic/application_processes/viewtaskpdf
begin
--   Manifest
--     APPLICATION PROCESS: viewTaskPDF
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
 p_id=>wwv_flow_imp.id(55060103427883061029)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'viewTaskPDF'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_doc blob;',
'begin',
'for c1 in (',
'    select DOCUMENT_BLOB, DOCUMENT_FILENAME, DOCUMENT_MIMETYPE, dbms_lob.getlength(DOCUMENT_BLOB) doc_length',
'    from SP_TASK_DOCUMENTS',
'    where id = :P42_ID',
' ) loop',
'',
'    l_doc := c1.DOCUMENT_BLOB;',
'',
'    sys.htp.init;',
'    sys.owa_util.mime_header( ''application/pdf'', FALSE );',
'    sys.htp.p(''Content-length: '' || c1.doc_length);',
'    sys.htp.p(''Content-Disposition: '' || ''inline'' || ''; filename="''|| wwv_flow_utilities.escape_url(c1.DOCUMENT_FILENAME) || ''"'' );',
'    sys.htp.p(''Cache-Control: max-age=1'');  ',
'    sys.owa_util.http_header_close;',
'    sys.wpg_docload.download_file(l_doc);',
'',
' end loop;',
' apex_application.stop_apex_engine;',
' end;'))
,p_process_clob_language=>'PLSQL'
,p_version_scn=>44689047282939
);
wwv_flow_imp.component_end;
end;
/
