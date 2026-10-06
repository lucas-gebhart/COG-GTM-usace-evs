prompt --application/deployment/install/install_seed_default_tags
begin
--   Manifest
--     INSTALL: INSTALL-seed default tags
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
 p_id=>wwv_flow_imp.id(46925976959363308314)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed default tags'
,p_sequence=>820
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (1, 10, ''COMMITTED'');',
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (2, 20, ''MVP'');',
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (3, 30, ''URGENT'');',
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (4, 40, ''CUSTOMER FACING'');',
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (5, 50, ''NEEDS REVIEW'');',
'insert into SP_DEFAULT_TAGS (ID, DISPLAY_SEQUENCE, TAG) values (6, 60, ''IMPORTANT'');'))
);
wwv_flow_imp.component_end;
end;
/
