prompt --application/shared_components/logic/application_computations/complete_task_status_ids
begin
--   Manifest
--     APPLICATION COMPUTATION: COMPLETE_TASK_STATUS_IDS
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_computation(
 p_id=>wwv_flow_imp.id(55378353918189543483)
,p_computation_sequence=>10
,p_computation_item=>'COMPLETE_TASK_STATUS_IDS'
,p_computation_point=>'ON_NEW_INSTANCE'
,p_computation_type=>'QUERY'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select '':''||listagg(id, '':'')||'':''',
'  from sp_task_statuses',
' where indicates_complete_yn = ''Y'''))
,p_version_scn=>41350845298528
);
wwv_flow_imp.component_end;
end;
/
