prompt --application/deployment/definition
begin
wwv_flow_imp_shared.create_install(
 p_id=>wwv_flow_imp.id(700)
,p_welcome_message=>'hi'
,p_deinstall_script=>wwv_flow_string.join(wwv_flow_t_varchar2(
'drop table sp_projects cascade constraints;',
'drop package sp_log;'))
);
end;
/
