prompt --application/deployment/install/install_seed_nomenclature
begin
--   Manifest
--     INSTALL: INSTALL-seed nomenclature
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(44813380052383904985)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed nomenclature'
,p_sequence=>780
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''STRATEGIC_PLANNER'', 1, ''Our Strategic Planner'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''AREA'', 2, ''Area'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''AREAS'', 3, ''Areas'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''INITIATIVE'', 4, ''Initiative'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''INITIATIVES'', 5, ''Initiatives'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''PROJECT'', 6, ''Project'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''PROJECTS'', 7, ''Projects'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''USER'', 10, ''Person'');',
'insert into SP_APP_NOMENCLATURE (static_ID, default_order, default_value) values (''USERS'', 11, ''People'');'))
);
wwv_flow_imp.component_end;
end;
/
