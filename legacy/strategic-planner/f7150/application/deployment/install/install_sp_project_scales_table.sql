prompt --application/deployment/install/install_sp_project_scales_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_project_scales table
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
 p_id=>wwv_flow_imp.id(42543480402256683666)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_project_scales table'
,p_sequence=>180
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_project_scales (',
'    scale_letter                   varchar2(1 char) not null',
'                                   constraint sp_project_scales_pk primary key,',
'    scale_name                     varchar2(50 char) not null,',
'    is_active_yn                   varchar2(1 char) not null',
'                                      constraint sp_project_scales_active_yn_ck',
'                                      check (is_active_yn in (''Y'',''N'')),',
'    min_pc_for_status              number,',
'    pc0_label                      varchar2(60 char),',
'    pc0_desc                       varchar2(4000 char),',
'    pc10_label                     varchar2(60 char),',
'    pc10_desc                      varchar2(4000 char),',
'    pc20_label                     varchar2(60 char),',
'    pc20_desc                      varchar2(4000 char),',
'    pc30_label                     varchar2(60 char),',
'    pc30_desc                      varchar2(4000 char),',
'    pc40_label                     varchar2(60 char),',
'    pc40_desc                      varchar2(4000 char),',
'    pc50_label                     varchar2(60 char),',
'    pc50_desc                      varchar2(4000 char),',
'    pc60_label                     varchar2(60 char),',
'    pc60_desc                      varchar2(4000 char),',
'    pc70_label                     varchar2(60 char),',
'    pc70_desc                      varchar2(4000 char),',
'    pc80_label                     varchar2(60 char),',
'    pc80_desc                      varchar2(4000 char),',
'    pc90_label                     varchar2(60 char),',
'    pc90_desc                      varchar2(4000 char),',
'    pc100_label                    varchar2(60 char),',
'    pc100_desc                     varchar2(4000 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'alter table sp_project_scales add constraint sp_project_scale_ck',
'      check (scale_letter in (''A'',''B'',''C'',''D'',''E''));',
'create unique index sp_project_scale_uk on sp_project_scales (scale_name);'))
);
wwv_flow_imp.component_end;
end;
/
