prompt --application/shared_components/logic/application_items/approvals_pending_cnt
begin
--   Manifest
--     APPLICATION ITEM: APPROVALS_PENDING_CNT
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(53826448132989098553)
,p_name=>'APPROVALS_PENDING_CNT'
,p_protection_level=>'I'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_version_scn=>44801038312707
);
wwv_flow_imp.component_end;
end;
/
