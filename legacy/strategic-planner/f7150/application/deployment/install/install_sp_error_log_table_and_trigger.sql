prompt --application/deployment/install/install_sp_error_log_table_and_trigger
begin
--   Manifest
--     INSTALL: INSTALL-sp_error_log table and trigger
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
 p_id=>wwv_flow_imp.id(31603191139457780152)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_error_log table and trigger'
,p_sequence=>65
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_error_log (',
'   id                     number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                              constraint sp_error_log_pk primary key,',
'   --',
'   package_name           varchar2(255 char),',
'   procedure_name         varchar2(500 char),',
'   error                  varchar2(4000 char)  not null,',
'   --',
'   arg1_name              varchar2(255 char),',
'   arg1_val               varchar2(4000 char),',
'   arg2_name              varchar2(255 char),',
'   arg2_val               varchar2(4000 char),',
'   arg3_name              varchar2(255 char),',
'   arg3_val               varchar2(4000 char),',
'   arg4_name              varchar2(255 char),',
'   arg4_val               varchar2(4000 char),',
'   arg5_name              varchar2(255 char),',
'   arg5_val               varchar2(4000 char),',
'   --',
'   created                date,',
'   created_trunc          date,',
'   created_by             varchar2(255 char)',
');',
'create index sp_error_log_i1 on sp_error_log (created_trunc);',
'',
'create or replace trigger sp_error_log_bi',
'    before insert',
'    on sp_error_log',
'    for each row',
'begin',
'    :new.created       := sysdate;',
'    :new.created_trunc := trunc(sysdate);',
'    :new.created_by    := coalesce(sys_context(''APEX$SESSION'',''APP_USER''),user); ',
'end sp_error_log_bi;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
