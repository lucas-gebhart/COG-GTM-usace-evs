prompt --application/shared_components/logic/application_computations/approvals_more_info_cnt
begin
--   Manifest
--     APPLICATION COMPUTATION: APPROVALS_MORE_INFO_CNT
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
 p_id=>wwv_flow_imp.id(53826587548064352996)
,p_computation_sequence=>10
,p_computation_item=>'APPROVALS_MORE_INFO_CNT'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>'return sp_approvals.more_info_pending_cnt (p_team_member_id => :APP_USER_ID);'
,p_compute_when=>'APP_USER_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_version_scn=>44801050389426
);
wwv_flow_imp.component_end;
end;
/
