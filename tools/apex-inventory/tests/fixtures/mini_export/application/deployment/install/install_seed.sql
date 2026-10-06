prompt --application/deployment/install/install_seed
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(702)
,p_install_id=>wwv_flow_imp.id(700)
,p_name=>'seed'
,p_sequence=>20
,p_script_type=>'INSTALL'
,p_script=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into sp_projects (name) values (''Lock 52 rehab'');',
'commit;'))
);
end;
/
