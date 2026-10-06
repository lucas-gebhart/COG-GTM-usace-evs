prompt --application/deployment/install/install_sp_app_nomenclature_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_app_nomenclature table
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
 p_id=>wwv_flow_imp.id(38667763112512391444)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_app_nomenclature table'
,p_sequence=>90
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table SP_APP_NOMENCLATURE (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint SP_APP_NOMENCLATURE_pk primary key,',
'    static_id                      varchar2(50 char),',
'    default_order                  number,',
'    custom_value                   varchar2(50 char),',
'    default_value                  varchar2(50 char),',
'    --',
'    description                    varchar2(4000 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
')',
';',
'',
'create unique index SP_APP_NOMENCLATURE_u1 on SP_APP_NOMENCLATURE (static_id);'))
);
wwv_flow_imp.component_end;
end;
/
