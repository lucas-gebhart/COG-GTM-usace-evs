prompt --application/pages/page_00074
begin
--   Manifest
--     PAGE: 00074
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
 p_id=>74
,p_name=>'People'
,p_alias=>'PEOPLE'
,p_step_title=>'&NOMENCLATURE_USERS.'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066659146316698292)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.no-item-ui {',
'  --a-field-input-border-width: 0px;',
'  --a-field-input-background-color: transparent;',
'}'))
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#:t-PageBody--noContentPadding'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44192547144049567909)
,p_plug_name=>'filters'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>3
,p_location=>null
,p_plug_source=>'<div id="active_facets"></div>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45917384960298204390)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46781728315331219208)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(45917384960298204390)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', 'fa-user',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL_DISPLAY', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46781729548837219220)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47235315433794283725)
,p_plug_name=>'Users '
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>33
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'   x.id, ',
'   x.name,',
'   x.email_domain,',
'   x.email,',
'   x.tags,',
'   x.updated,',
'   x.created,',
'   nvl(x.activities,0) activities,',
'   nvl(x.reviews,0) reviews,',
'   x.photo,',
'   x.photo_mimetype,',
'   x.competencies,',
'   --',
'   -- screen name',
'   --',
'   screen_name,',
'   decode(screen_name,null,''No'',''Yes'') has_screen_name,',
'   --',
'   -- total',
'   --',
'   nvl(x.focus_area_leads,0) + ',
'   nvl(x.initiatives_leads,0) + ',
'   nvl(x.project_leads,0) + ',
'   nvl(x.tasks,0) + ',
'   nvl(x.proj_docs,0) + nvl(x.init_docs,0) + nvl(x.rel_docs,0) + nvl(x.task_docs,0) +',
'   nvl(x.proj_comments,0) + nvl(x.init_comments,0) + nvl(x.rel_comments,0) + nvl(x.task_comments,0) +',
'   nvl(x.comment_mentions,0) +',
'   nvl(x.activities,0) +',
'   nvl(x.reviews,0) total,',
'   --',
'   -- project lead',
'   --',
'   decode(nvl(x.project_leads,0),0,''No'',''Yes'') project_lead,',
'   x.comment_mentions,',
'   x.app_role,',
'   x.location,',
'   nvl((select COUNTRY_NAME from sp_countries cc where cc.id = x.country_id),''Unknown'') country,',
'   nvl((select region from sp_countries cc where cc.id = x.country_id),''Unknown'') region,',
'   has_activities,',
'   --',
'   has_profile_photo,',
'   decode(nvl(reviews,0),0,''No'',''Yes'') has_open_reviews,',
'   --',
'   -- groups',
'   --',
'   group_membership',
'from (',
'select ',
'    t.ID,',
'    t.FIRST_NAME||'' ''||t.last_name name,',
'    t.location,',
'    t.country_id,',
'    lower(t.TAGS) tags,',
'    t.app_role,',
'    decode(t.IS_CURRENT_YN,''Y'',''Yes'',''N'',''No'',IS_CURRENT_YN) IS_CURRENT,',
'    t.UPDATED,',
'    t.created,',
'    t.email,',
'    t.competencies,',
'    t.email_domain,',
'    t.photo,',
'    t.photo_mimetype,',
'    t.screen_name,',
'    --',
'    --flags',
'    --',
'    nvl((select ''Yes'' from dual where exists (',
'        select 1 ',
'        from SP_ACTIVITIES ap ',
'        where ap.TEAM_MEMBER_ID = t.id and ',
'              ap.end_date >= trunc(sysdate)',
'        )),''No'') has_activities,',
'    --',
'    -- project child attributes',
'    --',
'    (select count(*) from SP_AREAS f where f.owner_id = t.id) focus_area_leads,',
'    (select count(*) from SP_INITIATIVES i where i.sponsor_id = t.id) initiatives_leads,',
'    (select count(*) from sp_projects p where p.owner_id = t.id and ARCHIVED_YN = ''N'') project_leads,',
'    (select count(*) from sp_tasks t, sp_projects p where t.owner_id = t.id and t.project_id = p.id and p.ARCHIVED_YN = ''N'') tasks,    ',
'    (select count(*) from SP_PROJECT_DOCUMENTS d where d.created_by = upper(t.email)) proj_docs,',
'    (select count(*) from SP_INITIATIVE_DOCUMENTS d where d.created_by = upper(t.email)) init_docs,',
'    (select count(*) from SP_RELEASE_DOCUMENTS d where d.created_by = upper(t.email)) rel_docs,',
'    (select count(*) from SP_TASK_DOCUMENTS d where d.created_by = upper(t.email)) task_docs,',
'    (select count(*) from SP_PROJECT_COMMENTS c where c.AUTHOR_ID = t.id) proj_comments,',
'    (select count(*) from SP_INITIATIVE_COMMENTS c where c.AUTHOR_ID = t.id) init_comments,',
'    (select count(*) from SP_RELEASE_COMMENTS c where c.AUTHOR_ID = t.id) rel_comments,',
'    (select count(*) from SP_TASK_COMMENTS c where c.AUTHOR_ID = t.id) task_comments,',
'    (select count(*) from SP_ACTIVITIES ap where ap.TEAM_MEMBER_ID = t.id and ap.end_date >= trunc(sysdate)) activities,',
'    --',
'    -- profile photo',
'    --',
'    decode(dbms_lob.getlength(photo),null,''No'',decode(dbms_lob.getlength(photo),0,''No'',''Yes'')) has_profile_photo,',
'    --',
'    -- comment mentions',
'    --',
'    (   ',
'    select count(distinct p.id)',
'    from SP_PROJECT_COMMENTS_EMAILS e,',
'         sp_projects p, ',
'         sp_team_members tm,',
'         SP_PROJECT_COMMENTS c',
'    where t.id = tm.id and',
'          e.email = tm.email and',
'          c.id = e.COMMENT_ID and',
'          c.project_id = p.id) comment_mentions,',
'    --',
'    -- open reviews',
'    --',
'    (select count(*) from SP_TASKS r, SP_TASK_TYPES tt, sp_task_statuses s',
'      where r.OWNER_ID = t.id ',
'        and nvl(r.task_sub_type_id,r.task_type_id) = tt.id',
'        and tt.static_id like ''REVIEW%''',
'        and r.status_id = s.id',
'        and s.INDICATES_COMPLETE_YN != ''Y'') reviews,',
'    --',
'    -- groups',
'    --',
'    (select LISTAGG(g.group_name, '', '') within group (order by 1) the_groups',
'    from  SP_GROUP_MEMBERS gm, SP_GROUPS g',
'    where gm.group_id = g.id and gm.team_member_id = t.id) group_membership',
'--',
'from SP_TEAM_MEMBERS t',
'where nvl(t.IS_CURRENT_YN,''Y'') = ''Y''',
') x'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>'{"orderBys":[{"key":"NAME","expr":"name"},{"key":"EMAIL","expr":"email"},{"key":"ACTIVITIES","expr":"activities desc"},{"key":"COUNTRY","expr":"country, name"},{"key":"PROJECT_LEAD","expr":"PROJECT_LEAD desc"},{"key":"CREATED","expr":"created desc"},'
||'{"key":"UPDATED","expr":"updated desc"},{"key":"REVIEWS","expr":"reviews desc"}],"itemName":"P74_ORDER_BY"}'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"PHOTO","filenameColumn":"NAME","mimeTypeColumn":"PHOTO_MIMETYPE","lastUpdatedColumn":"UPDATED"}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&EMAIL. - &COUNTRY!HTML.',
    '{if GROUP_MEMBERSHIP/}<br>Groups: &GROUP_MEMBERSHIP.{endif/}',
    '{if SCREEN_NAME/}<br>Screen Name: &SCREEN_NAME.{endif/}',
    '{if TAGS/}<br>Tags: &TAGS.{endif/}')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    'Contribution Count: <strong>&TOTAL.</strong><br>',
    'Current Activity Count: <strong>&ACTIVITIES.</strong><br>',
    'Open Reviews: <strong>&REVIEWS.</strong>')),
  'REMOVE_PADDING', 'N',
  'TITLE', '&NAME!HTML.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(38280684194740691711)
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
 p_id=>wwv_flow_imp.id(41271234565761114171)
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
 p_id=>wwv_flow_imp.id(41271234685166114172)
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
 p_id=>wwv_flow_imp.id(41271234814006114173)
,p_name=>'EMAIL_DOMAIN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMAIL_DOMAIN'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271234938398114174)
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
 p_id=>wwv_flow_imp.id(41271235059824114175)
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
 p_id=>wwv_flow_imp.id(41271235210313114177)
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
 p_id=>wwv_flow_imp.id(41271235819978114183)
,p_name=>'ACTIVITIES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVITIES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>130
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271235959005114184)
,p_name=>'TOTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_format_mask=>'999G999G999G999G999G999G990'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271235998781114185)
,p_name=>'PROJECT_LEAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_LEAD'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271236098994114186)
,p_name=>'COMMENT_MENTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENT_MENTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271236263506114187)
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
 p_id=>wwv_flow_imp.id(41271236350573114188)
,p_name=>'COUNTRY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNTRY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271236377498114189)
,p_name=>'REGION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REGION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271236604008114191)
,p_name=>'REVIEWS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REVIEWS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271236739213114192)
,p_name=>'HAS_ACTIVITIES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_ACTIVITIES'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271237176261114197)
,p_name=>'HAS_PROFILE_PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_PROFILE_PHOTO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>270
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271237291122114198)
,p_name=>'PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41271237416983114199)
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
 p_id=>wwv_flow_imp.id(41702543347671774106)
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
 p_id=>wwv_flow_imp.id(43550799271397064018)
,p_name=>'HAS_SCREEN_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_SCREEN_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>350
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45628237188196527511)
,p_name=>'GROUP_MEMBERSHIP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'GROUP_MEMBERSHIP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>320
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46709711955329593071)
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
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47393924912165158994)
,p_name=>'COMPETENCIES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPETENCIES'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>330
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(50382006948705366471)
,p_name=>'HAS_OPEN_REVIEWS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HAS_OPEN_REVIEWS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>340
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48031059055579943495)
,p_plug_name=>'Faceted Search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'current_facets_selector', '#active_facets',
  'display_chart_for_top_n_values', '20',
  'show_charts', 'Y',
  'show_current_facets', 'E',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41271540491806147700)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(45917384960298204390)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40996714824437283997)
,p_name=>'P74_ORDER_BY'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44192547144049567909)
,p_item_display_point=>'NEXT'
,p_item_default=>'NAME'
,p_prompt=>'Order By'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Name;NAME,Email;EMAIL,Current Activities;ACTIVITIES,Country;COUNTRY,&NOMENCLATURE_PROJECT. Lead;PROJECT_LEAD,Created;CREATED,Updated;UPDATED,Open Reviews;REVIEWS'
,p_cHeight=>1
,p_tag_css_classes=>'w200 no-item-ui'
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-asc'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43550799445447064019)
,p_name=>'P74_HAS_SCREEN_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Has Screen Name'
,p_source=>'HAS_SCREEN_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(46804096636430955252)
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44192559802493568009)
,p_name=>'P74_HAS_ACTIVITIES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Current or Future Activities'
,p_source=>'HAS_ACTIVITIES'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45360349303382146432)
,p_name=>'P74_HAS_PROFILE_PHOTO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Has Profile Photo'
,p_source=>'HAS_PROFILE_PHOTO'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_display_as=>'FILTER_DIALOG'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45628237331972527512)
,p_name=>'P74_GROUP_MEMBERSHIP'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Groups'
,p_source=>'GROUP_MEMBERSHIP'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47393924990145158995)
,p_name=>'P74_COMPETENCIES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Competencies'
,p_source=>'COMPETENCIES'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48031071645777943594)
,p_name=>'P74_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48031071777826943595)
,p_name=>'P74_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Tags'
,p_source=>'TAGS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>','
,p_multi_value_trim_space=>true
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48031072099594943599)
,p_name=>'P74_EMAIL_DOMAIN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Email Domain'
,p_source=>'EMAIL_DOMAIN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48031073496569943613)
,p_name=>'P74_PROJECT_LEAD'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'&NOMENCLATURE_PROJECT. Owner'
,p_source=>'PROJECT_LEAD'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_display_as=>'FILTER_DIALOG'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50382006988173366472)
,p_name=>'P74_HAS_OPEN_REVIEWS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Open Reviews'
,p_source=>'HAS_OPEN_REVIEWS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50481177672199962016)
,p_name=>'P74_APP_ROLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'App Role'
,p_source=>'APP_ROLE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51601107021882430416)
,p_name=>'P74_COUNTRY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Country'
,p_source=>'COUNTRY'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51601108828164430434)
,p_name=>'P74_REGION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(48031059055579943495)
,p_prompt=>'Region'
,p_source=>'REGION'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_display_as=>'FILTER_DIALOG'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41271545128888147733)
,p_name=>'DC'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41271546074344147738)
,p_event_id=>wwv_flow_imp.id(41271545128888147733)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41271545581614147738)
,p_event_id=>wwv_flow_imp.id(41271545128888147733)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48031059055579943495)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41271546484989147739)
,p_name=>'refresh on dialog closed'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(45917384960298204390)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41271547002017147739)
,p_event_id=>wwv_flow_imp.id(41271546484989147739)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41271547509669147740)
,p_event_id=>wwv_flow_imp.id(41271546484989147739)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(48031059055579943495)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41271544684431147730)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'sync roles'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_util.sync_team_members_app_role (',
'    p_app_id => :APP_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>4372186819029179961
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40996713283791283982)
,p_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40996714572884283995)
,p_region_id=>wwv_flow_imp.id(47235315433794283725)
,p_position_id=>348722977165395441
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:&ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(42893256138128961832)
,p_region_id=>wwv_flow_imp.id(46781728315331219208)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Add &NOMENCLATURE_USER.'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:RP,20::'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-plus'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(46781728615910219211)
,p_region_id=>wwv_flow_imp.id(46781728315331219208)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40996713265046283981)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_USERS. Details'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40996713554491283984)
,p_component_action_id=>wwv_flow_imp.id(40996713283791283982)
,p_menu_entry_type=>'ENTRY'
,p_label=>'User Details'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_ID:&ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40996713606971283985)
,p_component_action_id=>wwv_flow_imp.id(40996713283791283982)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit (Admin)'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:RP,20:P20_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40996713706704283986)
,p_component_action_id=>wwv_flow_imp.id(40996713283791283982)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Quick Look'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:&ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40996714951770283998)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>60
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42608500927309324939)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Add Multiple &NOMENCLATURE_USERS. (admin)'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:54:&SESSION.::&DEBUG.:RP,54::'
,p_icon_css_classes=>'fa-users'
,p_authorization_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(44013049344937316477)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:RP,74::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(44013049536089316478)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'About &NOMENCLATURE_USERS.'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-info'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45628234511881527484)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Manage Groups'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:103:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-users'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(46781729321817219218)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52711838093688073300)
,p_component_action_id=>wwv_flow_imp.id(46781728615910219211)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>30
);
wwv_flow_imp.component_end;
end;
/
