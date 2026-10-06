prompt --application/deployment/install/install_seed_project_sizes
begin
--   Manifest
--     INSTALL: INSTALL-seed project sizes
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
 p_id=>wwv_flow_imp.id(42557164592890137725)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed project sizes'
,p_sequence=>840
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'insert into sp_project_sizes (Project_size, size_description, effort_days) values (''S'',''Small'',2);   -- 2 days',
'insert into sp_project_sizes (Project_size, size_description, effort_days) values (''M'',''Medium'',10); -- 2 weeks',
'insert into sp_project_sizes (Project_size, size_description, effort_days) values (''L'',''Large'',40);  -- 2 months',
'insert into sp_project_sizes (Project_size, size_description, effort_days) values (''XL'',''Extra Large'',120); -- 6 months',
'insert into sp_project_sizes (Project_size, size_description, effort_days) values (''2XL'',''2 Times Extra Large'',240);  -- 12 months, 1 year',
'insert into sp_project_sizes (Project_size, size_description, effort_days, include_yn) values (''3XL'',''3 Times Extra Large'',360,''N'');  -- 18 months, 1.5 years',
'insert into sp_project_sizes (Project_size, size_description, effort_days, include_yn) values (''4XL'',''4 Times Extra Large'',640,''N'');  -- 24 months, 2 years',
'insert into sp_project_sizes (Project_size, size_description, effort_days, include_yn) values (''8XL'',''8 Times Extra Large'',960,''N'');  -- 48 months, 4 years',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
