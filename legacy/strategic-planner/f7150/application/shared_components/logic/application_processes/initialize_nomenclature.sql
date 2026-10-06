prompt --application/shared_components/logic/application_processes/initialize_nomenclature
begin
--   Manifest
--     APPLICATION PROCESS: Initialize nomenclature
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
 p_id=>wwv_flow_imp.id(44808816726609720702)
,p_process_sequence=>1
,p_process_point=>'ON_NEW_INSTANCE'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Initialize nomenclature'
,p_process_sql_clob=>'sp_util.set_nomenclature;'
,p_process_clob_language=>'PLSQL'
,p_version_scn=>45188590803377
);
wwv_flow_imp.component_end;
end;
/
