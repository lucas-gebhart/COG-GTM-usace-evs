prompt --application/shared_components/security/app_access_control/administrator
begin
--   Manifest
--     ACL ROLE: Administrator
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_acl_role(
 p_id=>wwv_flow_imp.id(176222233470920897792)
,p_static_id=>'ADMINISTRATOR'
,p_name=>'Administrator'
,p_description=>'Role assigned to application administrators.'
,p_version_scn=>1
);
wwv_flow_imp.component_end;
end;
/
