prompt --application/deployment/install/install_sp_app_log_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_app_log table
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
 p_id=>wwv_flow_imp.id(42149500391759633344)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_app_log table'
,p_sequence=>60
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_app_log (',
'    id                     number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                           constraint sp_app_log_pk primary key,',
'    --',
'    activity               varchar2(255 char)  not null,',
'    details                varchar2(4000 char),',
'    --',
'    created                date not null,',
'    created_trunc          date not null,',
'    created_by             varchar2(255 char) not null',
'   )',
'/',
'create index sp_app_log_i1',
'   on sp_app_log (created_trunc);',
'',
'create or replace trigger sp_app_log_bi',
'   before insert on sp_app_log',
'   for each row',
'begin',
'   :new.created       := sysdate;',
'   :new.created_trunc := trunc(sysdate);',
'   :new.created_by    := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end sp_app_log_bi;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
