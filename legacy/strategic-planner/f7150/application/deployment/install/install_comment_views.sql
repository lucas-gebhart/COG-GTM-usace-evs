prompt --application/deployment/install/install_comment_views
begin
--   Manifest
--     INSTALL: INSTALL-comment views
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
 p_id=>wwv_flow_imp.id(23779261811863204215)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'comment views'
,p_sequence=>736
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace view sp_initiative_comments_v as',
'select id, ',
'       initiative_id,',
'       sp_comment_util.replace_session_on_display(body, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body,',
'       sp_comment_util.replace_session_on_display(body_html, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body_html,',
'       body_no_images, ',
'       author_id, private_yn,',
'       image_ref_id,',
'       created, created_by, updated, updated_by',
'  from sp_initiative_comments;',
'',
'',
'create or replace view sp_init_focus_area_comments_v as',
'select id, ',
'       init_focus_area_id,',
'       sp_comment_util.replace_session_on_display(body, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body,',
'       sp_comment_util.replace_session_on_display(body_html, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body_html,',
'       body_no_images, ',
'       author_id, private_yn,',
'       image_ref_id,',
'       created, created_by, updated, updated_by',
'  from sp_init_focus_area_comments;',
'',
'',
'create or replace view sp_project_comments_v as',
'select id, ',
'       project_id,',
'       sp_comment_util.replace_session_on_display(body, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body,',
'       sp_comment_util.replace_session_on_display(body_html, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body_html,',
'       body_no_images, ',
'       author_id, private_yn,',
'       image_ref_id,',
'       created, created_by, updated, updated_by',
'  from sp_project_comments;',
'',
'',
'create or replace view sp_task_comments_v as',
'select id, ',
'       task_id,',
'       sp_comment_util.replace_session_on_display(body, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body,',
'       sp_comment_util.replace_session_on_display(body_html, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body_html,',
'       body_no_images, ',
'       author_id, private_yn,',
'       image_ref_id,',
'       created, created_by, updated, updated_by',
'  from sp_task_comments;',
'',
'',
'create or replace view sp_release_comments_v as',
'select id, ',
'       release_id,',
'       sp_comment_util.replace_session_on_display(body, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body,',
'       sp_comment_util.replace_session_on_display(body_html, sys_context(''APEX$SESSION'', ''APP_SESSION'') ) body_html,',
'       body_no_images, ',
'       author_id, private_yn,',
'       image_ref_id,',
'       created, created_by, updated, updated_by',
'  from sp_release_comments;'))
);
wwv_flow_imp.component_end;
end;
/
