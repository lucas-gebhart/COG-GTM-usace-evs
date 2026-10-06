prompt --application/pages/page_04001
begin
--   Manifest
--     PAGE: 04001
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
 p_id=>4001
,p_name=>'Workflow Details'
,p_page_mode=>'MODAL'
,p_step_title=>'Workflow Details'
,p_allow_duplicate_submissions=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255786333506639792)
,p_plug_name=>'Subject'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>60
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select title,',
'       workflow_def_name,',
'       initiator,',
'       created_ago,',
'       badge_text,',
'       badge_state',
'  from table ( apex_workflow.get_workflows (',
'                   p_context     => ''SINGLE_WORKFLOW'',',
'                   p_workflow_id => :P4001_WORKFLOW_ID ) );'))
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'BADGE_COL_WIDTH', 't-ContentRow-badge--auto',
  'BADGE_LABEL', 'State',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_SIZE', 't-Badge--md',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&WORKFLOW_DEF_NAME!HTML.</strong>',
    '{if INITIATOR/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.WORKFLOW.INITIATED_BY_USER_SINCE 0=&INITIATOR!HTML. 1=&CREATED_AGO.}.',
    '{endif/}')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'TITLE', '&TITLE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255786702008639794)
,p_name=>'TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255787205868639794)
,p_name=>'WORKFLOW_DEF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKFLOW_DEF_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255787722740639795)
,p_name=>'INITIATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255788205298639796)
,p_name=>'CREATED_AGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255788677540639796)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255789171619639797)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255789760256639797)
,p_plug_name=>'Activities'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>70
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select activity_id,',
'       type,',
'       name,',
'       state,',
'       error_message,',
'       due_on,',
'       retry_count,',
'       start_time,',
'       end_time,',
'       initcap(state) as badge_text,',
'       case state',
'           when ''WAITING''    then ''danger''',
'           when ''COMPLETED''  then ''success''',
'           when ''TERMINATED'' then ''warning''',
'           when ''FAULTED''    then ''danger''',
'       end as badge_state,',
'       ( select max(workflow_id)',
'           from apex_workflows w',
'          where w.parent_workflow_id = :P4001_WORKFLOW_ID',
'            and w.parent_activity_id = a.activity_id ) as invoked_workflow_id',
'  from apex_workflow_activities a',
' where workflow_id = :P4001_WORKFLOW_ID',
' order by start_time'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P4001_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'Status',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_STYLE', 't-Badge--outline',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', '&ERROR_MESSAGE.',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    '{case STATE/}',
    '    {when COMPLETED/}',
    '        &{APEX.WORKFLOW.COMPLETED_SINCE 0=&END_TIME.}.',
    '    {otherwise/}',
    '        &{APEX.WORKFLOW.STARTED_SINCE 0=&START_TIME.}.',
    '{endcase/}',
    '{if DUE_ON/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.WORKFLOW.DUE_SINCE 0=&DUE_ON.}.',
    '{endif/}',
    '{if RETRY_COUNT/}',
    '    {case RETRY_COUNT/}',
    '        {when 0/}',
    '        {when 1/}',
    '        <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            &{APEX.WORKFLOW.RETRY_COUNT.EQUALS_ONE 0=&RETRY_COUNT.}.',
    '        {otherwise/}',
    '        <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            &{APEX.WORKFLOW.RETRY_COUNT.NOT_EQUALS_ONE 0=&RETRY_COUNT.}.',
    '    {endcase/}',
    '{endif/}')),
  'TITLE', '&NAME.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255790104449639798)
,p_name=>'ACTIVITY_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVITY_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255790617772639799)
,p_name=>'TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255791142864639800)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255791661912639800)
,p_name=>'STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255792107355639802)
,p_name=>'ERROR_MESSAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ERROR_MESSAGE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255792613344639802)
,p_name=>'DUE_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255793148301639803)
,p_name=>'RETRY_COUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RETRY_COUNT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255793676510639804)
,p_name=>'START_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_TIME'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255794224110639804)
,p_name=>'END_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_TIME'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255794667084639805)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255795219851639806)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255795711722639806)
,p_name=>'INVOKED_WORKFLOW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INVOKED_WORKFLOW_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255797202458639808)
,p_plug_name=>'Activity Audit'
,p_parent_plug_id=>wwv_flow_imp.id(46255789760256639797)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>80
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select created_by,',
'       created_on,',
'       action,',
'       display_msg',
'  from apex_workflow_audit',
' where workflow_id         = :P4001_WORKFLOW_ID',
'   and current_activity_id = :P4001_ACTIVITY_ID',
' order by audit_id'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P4001_WORKFLOW_ID,P4001_ACTIVITY_ID'
,p_plug_query_num_rows=>5
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'COMMENT_DATE', 'CREATED_ON',
  'COMMENT_TEXT', 'DISPLAY_MSG',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--basic',
  'USER_NAME', 'CREATED_BY')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255797649870639808)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255798104047639809)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255798626106639809)
,p_name=>'ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255799145166639810)
,p_name=>'DISPLAY_MSG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_MSG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255799975469639812)
,p_plug_name=>'Variables'
,p_region_name=>'VARIABLES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>90
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select static_id,',
'       label,',
'       display_value',
'  from apex_workflow_variables',
' where workflow_id = :P4001_WORKFLOW_ID',
'   and variable_type = ''VARIABLE''',
' order by label'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P4001_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'OVERLINE', '&LABEL.',
  'TITLE', '&DISPLAY_VALUE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255800384430639812)
,p_name=>'STATIC_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATIC_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255800886433639813)
,p_name=>'LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255801419693639813)
,p_name=>'DISPLAY_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255805241975639818)
,p_plug_name=>'Parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>110
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select label,',
'       display_value',
'  from apex_workflow_variables',
' where workflow_id = :P4001_WORKFLOW_ID',
'   and variable_type = ''PARAMETER''',
' order by label'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P4001_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'OVERLINE', '&LABEL.',
  'TITLE', '&DISPLAY_VALUE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255805644887639819)
,p_name=>'LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255806130784639820)
,p_name=>'DISPLAY_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255806595656639820)
,p_plug_name=>'History'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>120
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display_msg,',
'       created_by,',
'       created_on',
'  from apex_workflow_audit',
' where workflow_id = :P4001_WORKFLOW_ID',
'   and current_activity_id is null',
' order by audit_id desc'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P4001_WORKFLOW_ID'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'COMMENT_DATE', 'CREATED_ON',
  'COMMENT_TEXT', 'DISPLAY_MSG',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--basic',
  'USER_NAME', 'CREATED_BY')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255806981839639821)
,p_name=>'DISPLAY_MSG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_MSG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255807538023639822)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(46255808001171639822)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_format_mask=>'SINCE'
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255808474751639823)
,p_plug_name=>'Workflow Diagram'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>130
,p_plug_source_type=>'NATIVE_WORKFLOW_DIAGRAM'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_navigator', 'Y',
  'initial_zoom', '0',
  'workflow_id', 'P4001_WORKFLOW_ID')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46255808932507639824)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--stickToBottom:t-ButtonRegion--slimPadding:margin-bottom-none'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46255785947626639791)
,p_button_sequence=>50
,p_button_name=>'TO_PARENT_WORKFLOW'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'To Parent Workflow'
,p_button_redirect_url=>'f?p=&APP_ID.:4001:&SESSION.::&DEBUG.:RP,4001:P4001_WORKFLOW_ID:&P4001_PARENT_WORKFLOW_ID.'
,p_button_condition=>'P4001_PARENT_WORKFLOW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-left-alt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46255799600617639811)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46255797202458639808)
,p_button_name=>'CANCEL_ACTIVITY_AUDIT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46255809277505639824)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46255808932507639824)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53088316318490006994)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(46255808932507639824)
,p_button_name=>'TERMINATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Terminate'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P4001_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_terminate )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-times u-danger-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53088315949842006990)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(46255808932507639824)
,p_button_name=>'SUSPEND'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Suspend'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P4001_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_suspend )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-pause-circle u-warning-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53088315722270006988)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(46255808932507639824)
,p_button_name=>'RESUME'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Resume'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P4001_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_resume )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-play-circle u-success-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53088316563456006996)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(46255808932507639824)
,p_button_name=>'RETRY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Retry'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P4001_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_retry )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-redo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46255784677677639790)
,p_name=>'P4001_WORKFLOW_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46255785159822639790)
,p_name=>'P4001_ACTIVITY_ID'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(46255785546802639791)
,p_name=>'P4001_PARENT_WORKFLOW_ID'
,p_item_sequence=>30
,p_source=>'select parent_workflow_id from apex_workflows where workflow_id = :P4001_WORKFLOW_ID'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46255811408904639826)
,p_name=>'Activity Audit'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.audit'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255811864146639826)
,p_event_id=>wwv_flow_imp.id(46255811408904639826)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46255797202458639808)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255812348458639827)
,p_event_id=>wwv_flow_imp.id(46255811408904639826)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4001_ACTIVITY_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-id")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255812846802639827)
,p_event_id=>wwv_flow_imp.id(46255811408904639826)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46255797202458639808)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46255813303258639828)
,p_name=>'Cancel Activity Audit'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(46255799600617639811)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255813693166639828)
,p_event_id=>wwv_flow_imp.id(46255813303258639828)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46255797202458639808)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46255814219869639829)
,p_name=>'Edit Variable'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.variable'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#VARIABLES'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255815620840639831)
,p_event_id=>wwv_flow_imp.id(46255814219869639829)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4001_VARIABLE_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-id")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255816089020639831)
,p_event_id=>wwv_flow_imp.id(46255814219869639829)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4001_VARIABLE_LABEL'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-label")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255816651195639832)
,p_event_id=>wwv_flow_imp.id(46255814219869639829)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4001_CURRENT_VALUE,P4001_NEW_VALUE'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-value")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255817124025639832)
,p_event_id=>wwv_flow_imp.id(46255814219869639829)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P4001_NEW_VALUE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46255819006847639834)
,p_name=>'Cancel Dialog'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(46255809277505639824)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46255819394214639835)
,p_event_id=>wwv_flow_imp.id(46255819006847639834)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46255819904277639836)
,p_name=>'Disable/Enable Update Button'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P4001_NEW_VALUE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.items.P4001_NEW_VALUE.value != apex.items.P4001_CURRENT_VALUE.value'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keyup'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53088315993020006991)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Suspend'
,p_attribute_01=>'SUSPEND'
,p_attribute_04=>'P4001_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53088315949842006990)
,p_process_success_message=>'Workflow suspended'
,p_internal_uid=>16188958127618039222
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53088315799711006989)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Resume'
,p_attribute_01=>'RESUME'
,p_attribute_04=>'P4001_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53088315722270006988)
,p_process_success_message=>'Workflow resumed'
,p_internal_uid=>16188957934309039220
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53088316433202006995)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Terminate'
,p_attribute_01=>'TERMINATE'
,p_attribute_04=>'P4001_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53088316318490006994)
,p_process_success_message=>'Workflow terminated'
,p_internal_uid=>16188958567800039226
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(53088316653772006997)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Retry'
,p_attribute_01=>'RETRY'
,p_attribute_04=>'P4001_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(53088316563456006996)
,p_process_success_message=>'Workflow retried'
,p_internal_uid=>16188958788370039228
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(46255823425037639840)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>9356465559635672071
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(46255796231439639807)
,p_region_id=>wwv_flow_imp.id(46255789760256639797)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#'
,p_link_attributes=>'class="audit" data-id="&ACTIVITY_ID." aria-haspopup="dialog"'
,p_condition_type=>'ITEM_IS_NULL'
,p_condition_expr1=>'INVOKED_WORKFLOW_ID'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(46255796737504639807)
,p_region_id=>wwv_flow_imp.id(46255789760256639797)
,p_position_id=>348722977165395441
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:4001:&SESSION.::&DEBUG.:RP,4001:P4001_WORKFLOW_ID:&INVOKED_WORKFLOW_ID.'
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'INVOKED_WORKFLOW_ID'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp.component_end;
end;
/
