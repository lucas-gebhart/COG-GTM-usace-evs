prompt --application/deployment/install/install_sp_comment_images_table_and_trigger
begin
--   Manifest
--     INSTALL: INSTALL-sp_comment_images table and trigger
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
 p_id=>wwv_flow_imp.id(22329370449840904580)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'sp_comment_images table and trigger'
,p_sequence=>285
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table sp_comment_images (',
'    id                 number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                           constraint sp_comment_images_pk primary key,',
'    --',
'    file_blob          blob               not null,',
'    unique_filename    varchar2(512 char) not null,',
'    filename           varchar2(512 char), -- image.png for screensnaps',
'    mimetype           varchar2(512 char),',
'    blob_size          number,',
'    image_ref_id       number             not null,',
'    --',
'    created            date not null,',
'    created_by         varchar2(255 char) not null',
');',
'',
'alter table sp_comment_images add constraint sp_comment_images_uk ',
'    unique (unique_filename);',
'',
'create index sp_comment_images_i1 on sp_comment_images (image_ref_id);'))
);
wwv_flow_imp.component_end;
end;
/
