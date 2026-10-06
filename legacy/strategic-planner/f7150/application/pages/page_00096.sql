prompt --application/pages/page_00096
begin
--   Manifest
--     PAGE: 00096
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_page.create_page(
 p_id=>96
,p_name=>'Involved People'
,p_alias=>'INVOLVED-PEOPLE'
,p_page_mode=>'MODAL'
,p_step_title=>'Involved People'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(68426539949819487770)
,p_plug_name=>'Users '
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    t.ID,',
'    t.FIRST_NAME||'' ''||t.last_name name,',
'    t.location,',
'    lower(t.TAGS) tags,',
'    t.app_role,',
'    t.UPDATED,',
'    t.created,',
'    t.email,',
'    t.photo,',
'    t.photo_mimetype,',
'    t.screen_name',
'--',
'from SP_TEAM_MEMBERS t',
'where nvl(t.IS_CURRENT_YN,''Y'') = ''Y'' and',
'      t.id in ',
'      (',
'        select id from SP_PROJECT_COMMENTS pc where pc.AUTHOR_ID = :P96_ID',
'        union',
'        --',
'        select OWNER_ID id from sp_projects p where id = :P96_ID',
'        union ',
'        --',
'        select tm.id',
'        from SP_PROJECTS p, SP_TEAM_MEMBERS tm',
'        where tm.email = lower(p.CREATED_BY) and p.id = :P96_ID',
'        union',
'        --',
'        select tm.id',
'        from SP_PROJECTS p, SP_TEAM_MEMBERS tm',
'        where tm.email = lower(p.UPDATED_BY) and p.id = :P96_ID',
'        union',
'        --',
'        select tm.id',
'        from SP_PROJECT_DOCUMENTS pd, SP_TEAM_MEMBERS tm',
'        where tm.email = lower(pd.CREATED_BY) and pd.project_id = :P96_ID',
'        union',
'        --',
'        select pc.TEAM_MEMBER_ID id',
'        from   SP_PROJECT_CONTRIBUTORS pc',
'        where  pc.PROJECT_ID = :P96_ID',
'        union',
'        --',
'        select tm.id',
'        from   SP_PROJECT_LINKS PL, SP_TEAM_MEMBERS tm',
'        where  tm.email = lower(pl.CREATED_BY) and pl.project_id = :P96_ID',
'        union',
'        --',
'        select t.OWNER_ID id',
'        from   sp_tasks t',
'        where  t.PROJECT_ID = :P96_ID',
'      )',
''))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'2'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"PHOTO","filenameColumn":"NAME","mimeTypeColumn":"PHOTO_MIMETYPE","lastUpdatedColumn":"UPDATED"}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&EMAIL. {if COUNTRY/}<br>-  &COUNTRY.{endif/}&COUNTRY!HTML.',
    '{if TAGS/}<br>Tags: &TAGS.{endif/}',
    '{if GROUP_MEMBERSHIP/}<br>Groups: &GROUP_MEMBERSHIP.{endif/}',
    '<br>Screen Name: &SCREEN_NAME!RAW.')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N',
  'TITLE', '&NAME!HTML.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(59471908710765895756)
,p_name=>'LOCATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOCATION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>300
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462459081786318216)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462459201191318217)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462459454423318219)
,p_name=>'EMAIL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMAIL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462459575849318220)
,p_name=>'TAGS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TAGS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462459726338318222)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462460779531318232)
,p_name=>'APP_ROLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_ROLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462461807147318243)
,p_name=>'PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62462461933008318244)
,p_name=>'PHOTO_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>290
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62893767863696978151)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>310
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(67900936471354797116)
,p_name=>'SCREEN_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCREEN_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>360
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46709713684945593089)
,p_name=>'P96_ID'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp.component_end;
end;
/
