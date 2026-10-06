prompt --application/create_application
begin
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_owner=>'ORACLE'
);
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'ORACLE')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Mini Planner')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'MINI')
,p_flow_version=>'1.0'
,p_authentication_id=>wwv_flow_imp.id(100)
);
wwv_flow_imp.component_end;
end;
/
