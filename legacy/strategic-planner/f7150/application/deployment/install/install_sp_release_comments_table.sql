prompt --application/deployment/install/install_sp_release_comments_table
begin
--   Manifest
--     INSTALL: INSTALL-sp_release_comments table
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
 p_id=>wwv_flow_imp.id(44988374066091303204)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_release_comments table'
,p_sequence=>280
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_release_comments (',
'    id                             number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                                   constraint sp_release_comments_id_pk primary key,',
'    release_id                     number',
'                                   constraint sp_release_comm_proj_id_fk',
'                                   references SP_RELEASE_TRAINS on delete cascade,',
'    --',
'    body                           clob,',
'    body_html                      clob,',
'    body_no_images                 clob,',
'    image_ref_id                   number, ',
'    author_id                      number,',
'    PRIVATE_YN                     varchar2(1 char),',
'    --',
'    created                        date not null,',
'    created_by                     varchar2(255 char) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255 char) not null',
');',
'',
'create index sp_release_comments_i1 on sp_release_comments (release_id);',
'create index sp_release_comments_i2 on sp_release_comments (author_id);',
'create index sp_release_comments_i3 on sp_release_comments (image_ref_id);',
''))
);
wwv_flow_imp.component_end;
end;
/
