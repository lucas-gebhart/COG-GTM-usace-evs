prompt --application/shared_components/logic/application_items/complete_task_status_ids
begin
--   Manifest
--     APPLICATION ITEM: COMPLETE_TASK_STATUS_IDS
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
 p_id=>wwv_flow_imp.id(55378136162362816266)
,p_name=>'COMPLETE_TASK_STATUS_IDS'
,p_protection_level=>'I'
,p_version_scn=>41350754188738
);
wwv_flow_imp.component_end;
end;
/
