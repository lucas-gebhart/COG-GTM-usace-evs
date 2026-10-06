prompt --application/deployment/install/install_seed_release_milestone_types
begin
--   Manifest
--     INSTALL: INSTALL-seed release_milestone_types
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
 p_id=>wwv_flow_imp.id(43086636335923933873)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed release_milestone_types'
,p_sequence=>855
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (1, ''Build'', 1);',
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (2, ''Doc'', 2);',
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (3, ''Merge'', 3);',
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (4, ''Milestone'', 4);',
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (6, ''Translation Drop'', 6);',
'insert into sp_release_milestone_types (id, milestone_type, display_seq)',
'    values (7, ''Upgrade'', 7);'))
);
wwv_flow_imp.component_end;
end;
/
