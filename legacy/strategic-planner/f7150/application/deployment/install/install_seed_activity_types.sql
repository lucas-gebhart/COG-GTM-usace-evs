prompt --application/deployment/install/install_seed_activity_types
begin
--   Manifest
--     INSTALL: INSTALL-seed activity_types
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
 p_id=>wwv_flow_imp.id(50992527092817901158)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed activity_types'
,p_sequence=>850
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 1, 1, ''Development'', '''', ''Y'', ''DEV'');',
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 2, 2, ''Prod Mgt'', ''Product Management'', ''N'', ''PM'');',
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 3, 3, ''Review'', '''', ''N'', ''REVIEW'');',
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 4, 4, ''Conference'', ''Conference preparation, travel, attendance or other related work'', ''N'', ''CONF'');',
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 5, 5, ''Customer Engagement'', '''', ''N'', ''CUSTOMER'');',
'insert into SP_ACTIVITY_TYPES (ID, DISPLAY_SEQUENCE, ACTIVITY_TYPE, ACTIVITY_TYPE_DESCRIPTION, is_default_yn, static_id ) values ( 6, 6, ''Out of Office'', '''', ''N'', ''OOO'');'))
);
wwv_flow_imp.component_end;
end;
/
