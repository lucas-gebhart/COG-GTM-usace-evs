prompt --application/pages/page_00123
begin
--   Manifest
--     PAGE: 00123
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
 p_id=>123
,p_name=>'Screen Names'
,p_alias=>'SCREEN-NAMES1'
,p_page_mode=>'MODAL'
,p_step_title=>'Screen Names'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-ContextualInfo .t-Button--link {',
'  --a-button-line-height: 1rem;',
'  --a-button-border-radius: 0;',
'  --a-button-font-weight: normal;',
'}',
'',
'.t-ContextualInfo .t-Button--link:hover {',
'  text-decoration: none;',
'}'))
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46709712195930593074)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>2
,p_location=>null
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(57264940085705313617)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57264940085705313617)
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
'    t.country_id,',
'    lower(t.TAGS) tags,',
'    t.app_role,',
'    t.UPDATED,',
'    t.created,',
'    t.email,',
'    t.competencies,',
'    t.email_domain,',
'    t.photo,',
'    t.photo_mimetype,',
'    t.screen_name,',
'    case when t.screen_name is not null ',
'         then ''@''||t.screen_name||',
'              '' <button type="button" title="Copy Screen Name" aria-label="Copy Screen Name" data-clipboard-source="''||',
'              t.screen_name||',
'              ''" class="t-Button t-Button--noLabel t-Button--icon t-Button--link padding-none">''||',
'              ''<span class="fa fa-copy" aria-hidden="true"></span>''||''</button>''',
'         end screen_name_disp',
'from SP_TEAM_MEMBERS t',
'where nvl(t.IS_CURRENT_YN,''Y'') = ''Y'' and',
'      (nvl(:P123_require_screen_Name,''Y'') = ''N'' or t.screen_name is not null)',
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
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"PHOTO","filenameColumn":"NAME","mimeTypeColumn":"PHOTO_MIMETYPE","lastUpdatedColumn":"UPDATED"}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&EMAIL. {if COUNTRY/}<br />-  &COUNTRY.{endif/}&COUNTRY!HTML.',
    '{if TAGS/}<br />Tags: &TAGS.{endif/}',
    '{if GROUP_MEMBERSHIP/}<br />Groups: &GROUP_MEMBERSHIP.{endif/}',
    '{if SCREEN_NAME/}<br />Screen Name: @&SCREEN_NAME.{endif/}')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N',
  'TITLE', '&NAME!HTML.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46709712410440593076)
,p_name=>'COUNTRY_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNTRY_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>370
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48139344156269521293)
,p_name=>'SCREEN_NAME_DISP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCREEN_NAME_DISP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>380
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48310308846651721603)
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
 p_id=>wwv_flow_imp.id(51300859217672144063)
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
 p_id=>wwv_flow_imp.id(51300859337077144064)
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
 p_id=>wwv_flow_imp.id(51300859465917144065)
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
 p_id=>wwv_flow_imp.id(51300859590309144066)
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
 p_id=>wwv_flow_imp.id(51300859711735144067)
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
 p_id=>wwv_flow_imp.id(51300859862224144069)
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
 p_id=>wwv_flow_imp.id(51300860915417144079)
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
 p_id=>wwv_flow_imp.id(51300861943033144090)
,p_name=>'PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51300862068894144091)
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
 p_id=>wwv_flow_imp.id(51732167999582803998)
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
 p_id=>wwv_flow_imp.id(56739336607240622963)
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
 p_id=>wwv_flow_imp.id(57423549564076188886)
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46709712270437593075)
,p_name=>'P123_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(46709712195930593074)
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
 p_id=>wwv_flow_imp.id(46709713228447593084)
,p_name=>'P123_REQUIRE_SCREEN_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(57264940085705313617)
,p_item_default=>'Y'
,p_prompt=>'Has Screen Name'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(46709713324760593085)
,p_computation_sequence=>10
,p_computation_item=>'P123_REQUIRE_SCREEN_NAME'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46709713450884593086)
,p_name=>'on change of screen name'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P123_REQUIRE_SCREEN_NAME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46709713478163593087)
,p_event_id=>wwv_flow_imp.id(46709713450884593086)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P123_REQUIRE_SCREEN_NAME'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46709713612064593088)
,p_event_id=>wwv_flow_imp.id(46709713450884593086)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(57264940085705313617)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
