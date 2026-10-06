prompt --application/deployment/install/install_sequences
begin
--   Manifest
--     INSTALL: INSTALL-Sequences
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
 p_id=>wwv_flow_imp.id(48836940796879611615)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'Sequences'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create sequence SP_SEQ;',
'',
'create sequence sp_kb_stack_rank_seq',
'start with 1',
'increment by 1',
'cache 20',
'nocycle;'))
);
wwv_flow_imp.component_end;
end;
/
