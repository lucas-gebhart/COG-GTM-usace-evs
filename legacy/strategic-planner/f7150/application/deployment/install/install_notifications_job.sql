prompt --application/deployment/install/install_notifications_job
begin
--   Manifest
--     INSTALL: INSTALL-Notifications job
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
 p_id=>wwv_flow_imp.id(47920976346810727620)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'Notifications job'
,p_sequence=>910
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    sys.dbms_scheduler.create_job    ',
'     (job_name        => ''SP_NOTIF_SUBSCRIPTIONS'',',
'      job_type        => ''STORED_PROCEDURE'',',
'      job_action      => ''SP_UTIL.SEND_NOTIF_SUBSCRIPTIONS'',',
'      start_date      => systimestamp,',
'      repeat_interval => ''FREQ=DAILY; BYDAY=MON,TUE,WED,THU,FRI; BYHOUR=8; BYMINUTE=0;'',',
'      enabled         => true,',
'      auto_drop       => false);',
'end;',
'/'))
);
wwv_flow_imp.component_end;
end;
/
