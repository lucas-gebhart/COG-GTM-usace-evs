prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
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
 p_id=>1
,p_name=>'home'
,p_alias=>'HOME'
,p_step_title=>'&NOMENCLATURE_STRATEGIC_PLANNER. home'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066978815243276896)
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(() => { ',
'    apex.actions.add({',
'        name: ''favoriteProject'',',
'        action: function(event, focusElement, args) {',
'            $(event.currentTarget).addClass(''js-project-to-favorite'');',
'            apex.item(''P1_PROJECT_TO_FAVORITE'').setValue(args.id);',
'            return true;',
'            }',
'    });',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.sp-tag {',
'    padding: 2px 4px;',
'    display: inline-block;',
'    vertical-align: text-bottom;',
'    border-radius: 3px;',
'    background-color: rgba(0,0,0,.1);',
'    text-overflow: ellipsis;',
'    white-space: nowrap;',
'}',
'.sp-tags-container {',
'    display: flex;',
'    align-items: center;',
'    flex-wrap: wrap;',
'    gap: 4px;',
'    justify-content: flex-start;',
'}',
'',
'.resize-region {',
'  resize: vertical;',
'  overflow: auto;',
'}',
'',
'.a-CardView-iconWrap,',
'.a-CardView-badge { align-self: flex-start; }'))
,p_step_template=>4072355960268175073
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_comment=>'home'
,p_page_component_map=>'13'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40124747147497543025)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>75
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40989090502530557843)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(40124747147497543025)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_template_component_type=>'PARTIAL'
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(40506778417903286983)
,p_name=>'Recently Changed &NOMENCLATURE_PROJECTS.'
,p_template=>4072358936313175081
,p_display_sequence=>71
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>' '
,p_region_sub_css_classes=>'h380 resize-region'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--horizontalBorders:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.PROJECT,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       (select decode(greatest(length(initiative),15),15,initiative,substr(initiative,1,12)||''...'') initiative ',
'        from sp_initiatives i ',
'        where i.id = p.initiative_id) initiative,',
'       decode(p.release_id,',
'          null, decode(p.TARGET_COMPLETE,null,''No Target'',to_char(p.TARGET_COMPLETE,''DD-MON-YYYY'')),',
'          (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID)) release,',
'       p.PROJECT_SIZE,',
'       p.UPDATED,',
'       null attributes,',
'       p.owner_id,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       p.ARCHIVED_YN,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(p.updated_by)),lower(p.updated_by)) updated_by',
'from  SP_PROJECTS p',
'where nvl(p.ARCHIVED_YN,''N'') != ''Y'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null',
'order by p.updated desc nulls last',
'fetch first 30 rows only',
'',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506778469836286984)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506778671783286986)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>30
,p_column_heading=>'&NOMENCLATURE_PROJECT.'
,p_use_as_row_header=>'Y'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506780878092287008)
,p_query_column_id=>3
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506781117395287010)
,p_query_column_id=>4
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(44339696977350052700)
,p_query_column_id=>5
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(36966112896368502602)
,p_query_column_id=>6
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>120
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(45477756699934646179)
,p_query_column_id=>7
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506779441981286993)
,p_query_column_id=>8
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506780506465287004)
,p_query_column_id=>9
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_column_html_expression=>'#UPDATED# - #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40506781277374287012)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>110
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#%</span>',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42863148937644103899)
,p_query_column_id=>11
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48805114720684715375)
,p_query_column_id=>12
,p_column_alias=>'FRIENDLY_IDENTIFIER'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48805115065122715378)
,p_query_column_id=>13
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40288904628930420808)
,p_query_column_id=>14
,p_column_alias=>'ARCHIVED_YN'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50493823754778761105)
,p_query_column_id=>15
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41376453076139866272)
,p_plug_name=>'Notifications'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--info:t-Alert--accessibleHeading'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>1
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_return clob;',
'   l_count  int := 0;',
'   l_user_tags varchar2(4000) := null;',
'begin',
'   for c1 in (select upper(tags) tags from sp_team_members where id = :APP_USER_ID and tags is not null) loop',
'       l_user_tags := c1.tags;',
'   end loop;',
'   for c1 in (',
'      select notification_description ',
'      from SP_APPLICATION_NOTIFICATIONS ',
'      where (from_date is null or sysdate >= from_date) and',
'            (to_date   is null or sysdate <= to_date) and ',
'            (required_user_tag is null or instr(l_user_tags,required_user_tag) > 0) and',
'            is_active_yn = ''Y'') loop',
'      --',
'      --',
'      --',
'      l_count := l_count + 1;',
'      if l_count = 2 then ',
'          l_return := ''<ul><li>''||l_return||''</li>'';',
'      end if;',
'      if l_count >= 2 then',
'         l_return := l_return||''<li>'';',
'      end if;',
'      l_return := l_return||apex_escape.html(c1.notification_description);',
'      if l_count >= 2 then',
'         l_return := l_return||''</li>'';',
'      end if;',
'   end loop;',
'   --',
'   --',
'   --',
'   if l_count >= 2 then',
'      l_return := l_return||''</ul>'';',
'   end if;',
'   --',
'   --',
'   --',
'   return l_return;',
'end;',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'from SP_APPLICATION_NOTIFICATIONS n',
'where (from_date is null or sysdate >= from_date) and',
'      (to_date   is null or sysdate <= to_date) and ',
'      is_active_yn = ''Y'' and',
'      (n.required_user_tag is null or exists (',
'          select 1',
'          from sp_team_members tm',
'          where tm.id = :APP_USER_ID and ',
'                tm.tags is not null and',
'                instr(upper(tm.tags),upper(n.required_user_tag)) > 0',
'      )',
'      )'))
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41579293761725943861)
,p_plug_name=>'My &NOMENCLATURE_PROJECTS.'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>51
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       --',
'       -- project name',
'       --',
'       --decode(greatest(length(p.project),80),80,p.PROJECT,substr(p.project,1,80)||''...'') project,',
'       p.project,',
'       --',
'       -- project owner',
'       --',
'       nvl(decode(t.first_name,null,t.email,t.first_name||'' ''||t.last_name),''No Owner'') the_owner,',
'       p.owner_id,',
'       p.TARGET_COMPLETE,',
'       --',
'       -- percent complete',
'       --',
'       p.PCT_COMPLETE||''%'' status,',
'       ''fa-pie-chart-''||p.PCT_COMPLETE as icon,',
'       --',
'       -- priority',
'       --',
'       nvl((select ''P''||priority from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'') priority,',
'       --',
'       -- Target',
'       --',
'       case when p.release_id is not null',
'            then (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id)',
'            when p.target_complete is not null',
'            then to_char(p.target_complete,''Mon-RR'')',
'            else ''No Target''',
'            end target,',
'       case when p.release_id is not null then ''success'' else ''info'' end target_badge_class,',
'       --',
'       -- Project favorites',
'       --',
'       nvl((select ''Yes'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''No'') favorite,',
'       nvl((select ''fa-heart u-danger-text'' from sp_favorites f where f.project_id = p.id and f.team_member_id = :APP_USER_ID),''fa-heart-o'') favorite_icon,',
'       --',
'       -- project fields',
'       --',
'       lower(p.TAGS) tags,',
'       p.CREATED,',
'       apex_util.get_since(p.UPDATED) updated_since,',
'       p.updated,',
'       p.PROJECT_SIZE,',
'       p.project_url_name,',
'       p.friendly_identifier friendly_identifier1,',
'       --',
'       -- activity',
'       --',
'       (select ''<span class="fa fa-badge-check" aria-hidden="true" title="Active Activity"></span> '' from dual where exists (',
'           select 1 ',
'           from SP_ACTIVITIES ap ',
'           where ap.project_id = p.id and trunc(sysdate) between trunc(ap.start_date) and trunc(ap.end_date))) active_activity_icon',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       sp_team_members t  ',
'where ',
'      p.archived_yn = ''N'' and',
'      p.initiative_id = i.id and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      t.id = lower(:APP_USER_ID) and',
'      --',
'      --',
'      --',
'      p.PCT_COMPLETE < 100 and',
'      --',
'      -- conditions to constrain list of project to current user',
'      --',
'      (',
'          -- app user is owner of project',
'          p.owner_id = t.id or',
'          -- app user has incomplete tasks',
'          p.id in (select ta.project_id ',
'                     from sp_tasks ta',
'                    where ta.PROJECT_ID = p.id',
'                      and ta.owner_id = :APP_USER_ID',
'                      and instr(:COMPLETE_TASK_STATUS_IDS,'':''||ta.status_id||'':'') = 0)',
'      )'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'updated desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>5
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'You have no &NOMENCLATURE_PROJECT. Associations.'
,p_show_total_row_count=>false
,p_plug_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'AVATAR_DESCRIPTION', '&STATUS. Complete',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--noShape',
  'AVATAR_SIZE', 't-Avatar--sm',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'Target',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'TARGET_BADGE_CLASS',
  'BADGE_VALUE', 'TARGET',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&ACTIVE_ACTIVITY_ICON!RAW. &PRIORITY. - &STATUS. - &PROJECT_SIZE.  ',
    '')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', '&UPDATED_SINCE.',
  'REMOVE_PADDING', 'N',
  'TITLE', '<div class="u-lineclamp-1">&PROJECT.</div>')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(30944276132114136834)
,p_name=>'TARGET'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TARGET'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>390
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(30944276239919136835)
,p_name=>'TARGET_BADGE_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TARGET_BADGE_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>400
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39785079024258312111)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>380
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41579293884577943862)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41724733197346254154)
,p_name=>'FAVORITE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAVORITE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>340
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41724733299354254155)
,p_name=>'FAVORITE_ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAVORITE_ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>350
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831223559707866218)
,p_name=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831223617014866219)
,p_name=>'THE_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'THE_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831223760955866220)
,p_name=>'OWNER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OWNER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831223875509866221)
,p_name=>'TARGET_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TARGET_COMPLETE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831224349380866226)
,p_name=>'PRIORITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRIORITY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831224636891866229)
,p_name=>'TAGS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TAGS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831224695320866230)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831224931849866232)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831225278341866235)
,p_name=>'PROJECT_SIZE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_SIZE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>240
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831225421288866237)
,p_name=>'PROJECT_URL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_URL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831225572749866238)
,p_name=>'FRIENDLY_IDENTIFIER1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FRIENDLY_IDENTIFIER1'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>270
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41831226558264866248)
,p_name=>'UPDATED_SINCE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED_SINCE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>310
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41912143346751395343)
,p_name=>'ACTIVE_ACTIVITY_ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVE_ACTIVITY_ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>370
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(44168205860583398645)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>320
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49001115179777388994)
,p_plug_name=>'&NOMENCLATURE_PROJECT. Search'
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>21
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(52861349035501637675)
,p_plug_name=>'My Open Releases'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>61
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, ',
'       release_train, ',
'       release_owner_id,',
'       nvl(release_owner,''(No Owner)'') release_owner,',
'       release,',
'       timeline,',
'       days_remaining,',
'       badge_state,',
'       RELEASE_OPEN_DATE,',
'       RELEASE_TARGET_DATE,',
'       to_char(RELEASE_TARGET_DATE,''YYYY'') RELEASE_TARGET_YEAR,',
'       UPDATED,',
'       duration_in_days,',
'       AVG_PCT_COMPLETE,',
'       completed,',
'       not_completed,',
'       last_updated,',
'       projects,',
'       initcap(nvl(release_type,''FULL'')) release_type,',
'       --',
'       -- percent of projects fully completed',
'       --',
'       round(',
'           100 *',
'           decode(nvl(not_completed,0),',
'                  0,0,',
'                  completed / (nvl(completed,0) + nvl(not_completed,0))',
'                  )',
'            ) pct_complete,',
'       ''fa-pie-chart-''||round(.1 * ',
'           AVG_PCT_COMPLETE)*10 icon,',
'      window,',
'      --',
'      -- release milestone counts',
'      --',
'      milestones,',
'      completed_milestones',
'from (',
'select ',
'       r.ID,',
'       --',
'       -- release attributes',
'       --',
'       r.RELEASE_OPEN_DATE,',
'       r.RELEASE_TARGET_DATE,',
'       r.UPDATED,',
'       r.RELEASE_TARGET_DATE - r.RELEASE_OPEN_DATE duration_in_days,',
'       r.RELEASE_TRAIN,',
'       r.RELEASE_OWNER_ID,',
'       --',
'       -- release owner',
'       --',
'       (select first_Name||'' ''||last_name from sp_team_members tm where tm.id =  r.RELEASE_OWNER_ID) release_owner,',
'       --',
'       -- release',
'       --',
'       r.RELEASE_TRAIN||'' ''||r.RELEASE RELEASE, ',
'       --',
'       -- release date timeline (from open to targeted complete) for display in UI',
'       --',
'       to_char(r.RELEASE_OPEN_DATE,''Day DD-MON-YYYY'')||'' to ''||to_char(r.RELEASE_TARGET_DATE,''Day DD-MON-YYYY'') timeline,',
'       --',
'       -- Days remaining for release',
'       --',
'       decode(',
'           greatest( trunc(sysdate),r.RELEASE_TARGET_DATE),',
'           trunc(sysdate),',
'           ''Completed'',',
'           trunc(r.RELEASE_TARGET_DATE) - trunc(sysdate) || '' Days Remaining'') as days_remaining,',
'       --',
'       -- State of release "danger", "warning", or "success"',
'       --',
'       case ',
'           when trunc(r.RELEASE_TARGET_DATE) < trunc(sysdate) then ''success''',
'           when trunc(r.RELEASE_TARGET_DATE) - trunc(sysdate) < 15 then ''danger'' ',
'           when trunc(r.RELEASE_TARGET_DATE) - trunc(sysdate)< 30 then ''warning''',
'           else ''success''',
'        end as badge_state,',
'       --',
'       -- Count of projects targeted for release',
'       --',
'       (select count(*) ',
'          from sp_projects p ',
'         where p.release_id = r.id  ',
'           and p.ARCHIVED_YN = ''N''',
'           and p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       -- average percent complete of projects for a release',
'       --',
'       round(nvl((select avg(nvl(p.PCT_COMPLETE,0)) a',
'                    from sp_projects p ',
'                   where p.release_id = r.id',
'                     and p.ARCHIVED_YN = ''N''',
'                     and p.DUPLICATE_OF_PROJECT_ID is null),0)) AVG_PCT_COMPLETE,',
'       --',
'       -- fully completed projects for a given release',
'       --',
'       (select count(*) c ',
'          from sp_projects p ',
'         where p.release_id = r.id ',
'           and p.ARCHIVED_YN = ''N''',
'           and p.DUPLICATE_OF_PROJECT_ID is null',
'           and p.pct_complete = 100 ) completed,',
'       --',
'       -- Open (not completed) projects for a given release',
'       --',
'       (select count(*) c ',
'          from sp_projects p ',
'         where p.release_id = r.id',
'           and p.ARCHIVED_YN = ''N''',
'           and p.DUPLICATE_OF_PROJECT_ID is null',
'           and p.pct_complete != 100) not_completed,',
'       --',
'       -- Most recent update to release project or release train',
'       --',
'       greatest(nvl((select max(updated) ',
'                       from sp_projects p ',
'                      where p.release_id = r.id',
'                        and p.ARCHIVED_YN = ''N''',
'                        and p.DUPLICATE_OF_PROJECT_ID is null),r.updated),r.updated) last_updated,',
'       case when release_open_completed = ''Y'' and nvl(release_completed,''N'') = ''N''',
'            then ''Open''',
'            when nvl(release_open_completed,''N'') = ''N''',
'            then ''Future''',
'            else ''Closed'' ',
'            end window,',
'       --',
'       -- milestone counts',
'       --',
'       (select count(*) from SP_RELEASE_MILESTONES m where m.RELEASE_ID = r.id) milestones,',
'       (select count(*) from SP_RELEASE_MILESTONES m where m.RELEASE_ID = r.id and m.MILESTONE_COMPLETED_YN = ''Y'') completed_milestones,',
'       --',
'       (select count(p.id) ',
'          from SP_TASKS t, ',
'               sp_projects p ',
'         where t.PROJECT_ID = p.id ',
'           and t.OWNER_ID = :APP_USER_ID ',
'           and p.release_id = r.id',
'           and p.ARCHIVED_YN = ''N''  ',
'           and p.DUPLICATE_OF_PROJECT_ID is null) identified_as_task_owner,',
'       (select count(p.id)',
'          from SP_ACTIVITIES dap, ',
'               sp_projects p ',
'         where dap.project_id = p.id',
'           and dap.TEAM_MEMBER_ID = :APP_USER_ID',
'           and p.release_id = r.id',
'           and p.ARCHIVED_YN = ''N''  ',
'           and p.DUPLICATE_OF_PROJECT_ID is null) project_activivity_contributor,',
'       --',
'       -- project owner',
'       --',
'       (select count(*) ',
'          from sp_projects p ',
'         where p.owner_id = :APP_USER_ID',
'           and p.release_id = r.id',
'           and p.ARCHIVED_YN = ''N''  ',
'           and p.DUPLICATE_OF_PROJECT_ID is null) project_owner_count,',
'       r.release_type',
'  from SP_RELEASE_TRAINS r',
'  where nvl(RELEASE_OPEN_COMPLETED,''Y'') = ''Y'' and nvl(RELEASE_COMPLETED,''N'') = ''N''',
')',
' where (identified_as_task_owner > 0 or ',
'        project_activivity_contributor > 0 or ',
'        project_owner_count > 0)'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'last_updated desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--noShape',
  'AVATAR_SIZE', 't-Avatar--md',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--lg',
  'BADGE_LABEL', '&NOMENCLATURE_PROJECTS.',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'DAYS_REMAINING',
  'DESCRIPTION', '&COMPLETED./&PROJECTS. Completed (&AVG_PCT_COMPLETE.% Progress based on status, &PCT_COMPLETE.% Fully Complete)',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    'Updated: &LAST_UPDATED.<br />',
    '&MILESTONES. Milestones, &COMPLETED_MILESTONES. completed')),
  'OVERLINE', '&TIMELINE.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&RELEASE. - &RELEASE_TYPE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(50603636219164524600)
,p_name=>'RELEASE_TARGET_YEAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TARGET_YEAR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51432452997259117292)
,p_name=>'WINDOW'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WINDOW'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905145167635122)
,p_name=>'RELEASE_TRAIN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TRAIN'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905184160635123)
,p_name=>'RELEASE_OWNER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OWNER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905336071635124)
,p_name=>'RELEASE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905394460635125)
,p_name=>'RELEASE_OPEN_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OPEN_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905541142635126)
,p_name=>'RELEASE_TARGET_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TARGET_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905623911635127)
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
 p_id=>wwv_flow_imp.id(52511905741735635128)
,p_name=>'DURATION_IN_DAYS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DURATION_IN_DAYS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905875421635130)
,p_name=>'AVG_PCT_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AVG_PCT_COMPLETE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511905986236635131)
,p_name=>'COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLETED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511906075445635132)
,p_name=>'NOT_COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOT_COMPLETED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52511906349260635134)
,p_name=>'TIMELINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMELINE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52861349548636637681)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_is_required=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52862741176712572144)
,p_name=>'LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374848962421181)
,p_name=>'RELEASE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53286473003974956206)
,p_name=>'DAYS_REMAINING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS_REMAINING'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53286473146101956207)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53553527769416891627)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53553527910405891628)
,p_name=>'PCT_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PCT_COMPLETE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(57405046473211101424)
,p_name=>'PROJECTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECTS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(57837530994231534494)
,p_name=>'RELEASE_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RELEASE_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>230
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(57837531230421534496)
,p_name=>'MILESTONES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MILESTONES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>240
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(57837531379814534497)
,p_name=>'COMPLETED_MILESTONES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLETED_MILESTONES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>250
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53205373870373421172)
,p_plug_name=>'My Initiatives'
,p_title=>'My &NOMENCLATURE_INITIATIVES.'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>41
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.id,',
'       i.INITIATIVE,',
'       decode(greatest(length(i.OBJECTIVE),110),110,i.OBJECTIVE, substr(i.OBJECTIVE,1,108)||''...'') objective,',
'       f.area area,',
'       --',
'       -- project count',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.initiative_id = i.id and',
'              p.archived_yn = ''N'' and ',
'              p.DUPLICATE_OF_PROJECT_ID is null and ',
'              nvl(PCT_COMPLETE,0) != 0 and ',
'              nvl(PCT_COMPLETE,0) != 100) active_projects,',
'       --',
'       -- last updated',
'       --',
'       greatest(i.updated,nvl((',
'           select max(updated) ',
'           from sp_projects p ',
'           where p.initiative_id = i.id and ',
'                 p.archived_yn = ''N'' and ',
'                 p.DUPLICATE_OF_PROJECT_ID is null',
'                 ),',
'           i.updated)) last_updated,',
'',
'       case when i.image is not null then i.image else f.image end image,',
'       case when i.image is not null then i.image_mimetype else f.image_mimetype end image_mimetype,',
'       case when i.image is not null then i.image_name else f.image_name end image_name, ',
'       case when i.image is not null then i.image_last_updated else f.image_last_updated end image_last_updated',
'',
'  from SP_INITIATIVES i, ',
'       sp_areas f',
'',
'  where i.area_id = f.id and',
'        --',
'        -- exclude archived initiatives',
'        --',
'        nvl(i.ARCHIVED_YN,''N'') = ''N'' and',
'        (',
'        --',
'        -- logged in user owns a project in the initiative',
'        --',
'        i.id in (',
'            select p.initiative_id ',
'            from sp_projects p ',
'            where p.OWNER_ID = (',
'                select id ',
'                from sp_team_members tm ',
'                where tm.email = lower(:APP_USER)',
'                )  and ',
'                p.archived_yn = ''N'' and ',
'                p.DUPLICATE_OF_PROJECT_ID is null and',
'                nvl(p.PCT_COMPLETE,0) != 0 and ',
'                nvl(p.PCT_COMPLETE,0) != 100',
'                )',
'        --',
'        -- logged in user owns the initiative',
'        --',
'        or',
'        i.SPONSOR_ID = (',
'            select tm.id ',
'            from sp_team_members tm ',
'            where tm.email = lower(:APP_USER))',
'        --',
'        -- logged in user is a project contributor',
'        --',
'        or ',
'        i.id in (',
'            select p.initiative_id',
'            from SP_PROJECT_CONTRIBUTORS c,',
'                 SP_PROJECTS p',
'            where p.id = c.project_id and',
'                  p.archived_yn = ''N'' and ',
'                  p.DUPLICATE_OF_PROJECT_ID is null and',
'                  c.TEAM_MEMBER_ID = (',
'                     select id ',
'                     from sp_team_members tm ',
'                     where tm.email = lower(:APP_USER)) and',
'                  nvl(p.PCT_COMPLETE,0) != 0 and ',
'                  nvl(p.PCT_COMPLETE,0) != 100',
'        )',
'        )',
'-- order by 6 desc nulls last'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'active_projects desc, last_updated desc'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>5
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"IMAGE","filenameColumn":"IMAGE_NAME","mimeTypeColumn":"IMAGE_MIMETYPE","lastUpdatedColumn":"IMAGE_LAST_UPDATED"}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'DESCRIPTION', '&OBJECTIVE.',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&ACTIVE_PROJECTS. &NOMENCLATURE_PROJECTS.<br />',
    '&LAST_UPDATED.')),
  'OVERLINE', '&AREA.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&INITIATIVE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806956241883483907)
,p_name=>'IMAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806956339757483908)
,p_name=>'IMAGE_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806956399450483909)
,p_name=>'IMAGE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806956494517483910)
,p_name=>'IMAGE_LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE_LAST_UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374063191421173)
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
 p_id=>wwv_flow_imp.id(53205374099435421174)
,p_name=>'INITIATIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374260800421175)
,p_name=>'OBJECTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBJECTIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374352642421176)
,p_name=>'ACTIVE_PROJECTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVE_PROJECTS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_format_mask=>'999G999G999G999G999G999G990'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374410243421177)
,p_name=>'LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53205374485013421178)
,p_name=>'AREA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AREA'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55491903744582352510)
,p_plug_name=>'My Activities'
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>31
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ap.id, ',
'       ap.project_id,',
'       --',
'       -- activity core information',
'       --',
'       at.activity_type,',
'       decode(greatest(length(ap.comments),80),80,ap.comments,substr(ap.comments,1,80)||''...'') comments,',
'       ap.url,',
'       apex_util.get_since(ap.updated) last_updated,',
'       ap.created,',
'       ap.tags,',
'       ap.updated,',
'       --',
'       -- activity date fields',
'       --',
'       ap.start_date,',
'       ap.end_date,',
'       to_char(start_date,''YYYY.MM'') start_month,',
'       to_char(end_date,''YYYY.MM'') end_month,',
'       to_char(ap.start_date,''DD-MON-YYYY'')||'' to ''||to_char(ap.end_date,''DD-MON-YYYY'') TIMELINE,',
'       ap.end_date - ap.start_date days,',
'       round(ap.end_date - sysdate) days_remaining,',
'       --',
'       -- team member info',
'       --',
'       tm.first_name||'' ''||tm.last_name name,',
'       --',
'       -- optional initiative',
'       --',
'       decode(ap.initiative_id,null,null,(',
'           select initiative from sp_initiatives where id = ap.initiative_id',
'       )) initiative,',
'       ap.initiative_id,',
'       --',
'       -- optional project ',
'       --',
'       decode(ap.project_id,null,null,(',
'           select decode(greatest(length(p.project),80),80,p.PROJECT,substr(p.project,1,80)||''...'') project ',
'           from sp_projects p ',
'           where p.id = ap.project_id and ',
'                 p.DUPLICATE_OF_PROJECT_ID is null and',
'                 p.ARCHIVED_YN = ''N'')',
'           ) project,',
'       decode(ap.project_id,null,null,(',
'           select friendly_identifier ',
'           from sp_projects p ',
'           where p.id = ap.project_id and ',
'                 p.DUPLICATE_OF_PROJECT_ID is null and',
'                 p.ARCHIVED_YN = ''N'')',
'           ) friendly_identifier,',
'       decode(ap.project_id,null,null,(',
'           select PROJECT_URL_NAME ',
'           from sp_projects p ',
'           where p.id = ap.project_id and ',
'                 p.DUPLICATE_OF_PROJECT_ID is null and',
'                 p.ARCHIVED_YN = ''N'')',
'           ) PROJECT_URL_NAME,',
'       --',
'       -- badge status is red if past due and green if within begin and and dates',
'       --',
'       decode (trunc(sysdate),trunc(ap.end_date),''success'',',
'       decode (trunc(sysdate),trunc(ap.start_date),''success'',',
'       decode(',
'           greatest(to_char(ap.end_date,''YYYY.MM.DD''),to_char(sysdate,''YYYY.MM.DD'')),',
'           to_char(sysdate,''YYYY.MM.DD''),',
'           ''danger'',',
'           decode(',
'               greatest(to_char(ap.start_date,''YYYY.MM.DD''),to_char(sysdate,''YYYY.MM.DD'')),',
'               to_char(sysdate,''YYYY.MM.DD''),',
'               ''success'',''info'')))) as badge_class,       ',
'       --',
'       -- pie chart icon in 10% chunks that show time percent complete',
'       --',
'       ''fa-pie-chart-''||sp_date_range_pct_comp(ap.start_date, ap.end_date) icon,',
'       --',
'       -- current or future',
'       --',
'       --case when trunc(sysdate) <= trunc(ap.end_date) and trunk',
'       decode (trunc(sysdate),trunc(ap.end_date),''Current'',',
'       decode (trunc(sysdate),trunc(ap.start_date),''Current'',',
'       decode(',
'           greatest(trunc(sysdate),trunc(ap.end_date)),',
'           trunc(sysdate),',
'           ''Past'',',
'           decode(',
'               greatest(trunc(sysdate),trunc(ap.start_date)),',
'               trunc(sysdate),',
'               ''Current'',',
'               ''Future'')',
'           ))) timeframe',
'           ',
'from sp_activities ap,',
'     sp_activity_types at,',
'     sp_team_members tm',
'where ',
'      --',
'      -- activity to activity type join',
'      --',
'      ap.activity_type_id = at.id and',
'      --',
'      -- show only current logged in user',
'      --',
'      tm.id = (select id from sp_team_members where email = lower(:APP_USER)) and',
'      --',
'      -- join team member detail',
'      --',
'      ap.team_member_id = tm.id and',
'      --',
'      --',
'      --',
'      trunc(sysdate) <= trunc(ap.end_date)'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'end_date'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows=>5
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'You have no current of future activities identified.'
,p_show_total_row_count=>false
,p_plug_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_required_patch=>wwv_flow_imp.id(51182682188183937291)
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_DESCRIPTION', 'Percentage of time elapsed',
  'AVATAR_ICON', '&ICON.',
  'AVATAR_SHAPE', 't-Avatar--noShape',
  'AVATAR_SIZE', 't-Avatar--sm',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', '&NOMENCLATURE_PROJECTS.',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_CLASS',
  'BADGE_VALUE', 'TIMEFRAME',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&ACTIVITY_TYPE.</strong>: &TIMELINE.<br>',
    '{if PROJECT/}<strong>&NOMENCLATURE_PROJECT.</strong>: &PROJECT.<br>{endif/}',
    '{if INITIATIVE/}<strong>&NOMENCLATURE_INITIATIVE.</strong>: &INITIATIVE.<br>{endif/}')),
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', '&LAST_UPDATED.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&COMMENTS.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41237943419018315642)
,p_name=>'PROJECT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>350
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41339791239119729154)
,p_name=>'TIMEFRAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMEFRAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>360
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41394179831295240789)
,p_name=>'START_MONTH'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_MONTH'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>370
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41394179879230240790)
,p_name=>'END_MONTH'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_MONTH'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>380
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41726045998623785052)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>410
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41726046874392785060)
,p_name=>'TAGS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TAGS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>420
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41726047023750785062)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>430
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41827790305589879531)
,p_name=>'BADGE_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>330
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(42368149189805953873)
,p_name=>'INITIATIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>440
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(42368149352716953874)
,p_name=>'INITIATIVE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATIVE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>450
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491903919888352511)
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
 p_id=>wwv_flow_imp.id(55491905312507352525)
,p_name=>'DAYS_REMAINING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS_REMAINING'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491905464246352527)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491907408606352546)
,p_name=>'ACTIVITY_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVITY_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491907523883352547)
,p_name=>'COMMENTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENTS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491907624694352548)
,p_name=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55491907716434352549)
,p_name=>'END_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140408465904000)
,p_name=>'DAYS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DAYS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>230
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140445701904001)
,p_name=>'URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'URL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>240
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140599520904002)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>250
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140722050904003)
,p_name=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>260
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140770775904004)
,p_name=>'FRIENDLY_IDENTIFIER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FRIENDLY_IDENTIFIER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>270
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140832588904005)
,p_name=>'TIMELINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIMELINE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>280
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513140979949904006)
,p_name=>'PROJECT_URL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_URL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>290
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(55513141109854904007)
,p_name=>'LAST_UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>300
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56740433561052006211)
,p_plug_name=>'Reviews Needed'
,p_icon_css_classes=>'fa-workflow'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--customIcons:t-Alert--warning:t-Alert--removeHeading js-removeLandmark'
,p_plug_template=>2040683448887306517
,p_plug_display_sequence=>11
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_return  varchar2(4000) := null;',
'begin',
'',
'if :APPROVALS_PENDING_CNT > 0 and :APPROVALS_MORE_INFO_CNT > 0 then',
'    if :APPROVALS_PENDING_CNT = 1 then',
'        l_return := ''You have 1 pending ''|| :NOMENCLATURE_PROJECT ||'' approval request.'';',
'    else',
'        l_return := ''You have ''|| :APPROVALS_PENDING_CNT ||'' pending ''|| :NOMENCLATURE_PROJECT ||'' approval requests.'';',
'    end if;',
'    if :APPROVALS_MORE_INFO_CNT = 1 then',
'        l_return := l_return || ''<br/>You have 1 request for more information regarding your ''|| :NOMENCLATURE_PROJECT ||'' approval request.'';',
'    else',
'        l_return := l_return || ''<br/>You have ''|| :APPROVALS_MORE_INFO_CNT ||'' requests for more information regarding your ''|| :NOMENCLATURE_PROJECT ||'' approval requests.'';',
'    end if;',
'elsif :APPROVALS_PENDING_CNT > 0 then',
'    if :APPROVALS_PENDING_CNT = 1 then',
'        l_return := ''You have 1 pending ''|| :NOMENCLATURE_PROJECT ||'' approval request.'';',
'    else',
'        l_return := ''You have ''|| :APPROVALS_PENDING_CNT ||'' pending ''|| :NOMENCLATURE_PROJECT ||'' approval requests.'';',
'    end if;',
'elsif :APPROVALS_MORE_INFO_CNT > 0 then',
'    if :APPROVALS_MORE_INFO_CNT = 1 then',
'        l_return := ''You have 1 request for more information regarding your ''|| :NOMENCLATURE_PROJECT ||'' approval request.'';',
'    else',
'        l_return := ''You have ''|| :APPROVALS_MORE_INFO_CNT ||'' requests for more information regarding your ''|| :NOMENCLATURE_PROJECT ||'' approval requests.'';',
'    end if;',
'end if;',
'',
'return l_return;',
'',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':APPROVALS_PENDING_CNT > 0 or',
':APPROVALS_MORE_INFO_CNT > 0'))
,p_plug_display_when_cond2=>'PLSQL'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40965295355451321280)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40506778417903286983)
,p_button_name=>'view_project_details'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View &NOMENCLATURE_PROJECTS.'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23::'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49015131142709361182)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(52861349035501637675)
,p_button_name=>'view_open_releases'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View Open Releases'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:8:P8_WINDOW:Open'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39785078526376312106)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(55491903744582352510)
,p_button_name=>'about_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'About Activity'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:131:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-question-circle-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39820379887461388075)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(41579293761725943861)
,p_button_name=>'about_my_projects'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'About my &NOMENCLATURE_PROJECTS.'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:138:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-question-circle-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39785078462023312105)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55491903744582352510)
,p_button_name=>'add_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Activity'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40988171510055966519)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(41579293761725943861)
,p_button_name=>'add_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add &NOMENCLATURE_PROJECT.'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:104:&SESSION.::&DEBUG.:RP,104::'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39785078640616312107)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(55491903744582352510)
,p_button_name=>'view_my_activities'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View My Activities'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:RP,102:P102_PERSON:&APP_USER_FIRST_LAST_NAME.'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39785078918992312110)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(41579293761725943861)
,p_button_name=>'view_my_projects'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View My &NOMENCLATURE_PROJECTS.'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:113:&SESSION.::&DEBUG.:RP,113::'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50873807431724825200)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(56740433561052006211)
,p_button_name=>'VIEW-REQUESTS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'View Requests'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:132:&SESSION.::&DEBUG.:132::'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(49001115743270388999)
,p_branch_name=>'search projects'
,p_branch_action=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,23:P23_SEARCH:&P1_SEARCH.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39785079439240312115)
,p_name=>'P1_PROJECT_TO_FAVORITE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(41579293761725943861)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(43550796773324063993)
,p_name=>'P1_PROJECT_GROUPS'
,p_item_sequence=>161
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49001115342778388995)
,p_name=>'P1_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(49001115179777388994)
,p_placeholder=>'Search &NOMENCLATURE_PROJECTS.'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'Y',
  'subtype', 'SEARCH',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248166982915784001)
,p_name=>'P1_AREAS'
,p_item_sequence=>81
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248167159311784002)
,p_name=>'P1_INITIATIVES'
,p_item_sequence=>91
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248167258246784003)
,p_name=>'P1_ACTIVITIES'
,p_item_sequence=>111
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248167288330784004)
,p_name=>'P1_PROJECTS'
,p_item_sequence=>121
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248167394132784005)
,p_name=>'P1_RELEASES'
,p_item_sequence=>131
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49248167559901784006)
,p_name=>'P1_PEOPLE'
,p_item_sequence=>141
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50330184164330852572)
,p_name=>'P1_GROUPS'
,p_item_sequence=>151
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49279405989316562691)
,p_computation_sequence=>10
,p_computation_item=>'LAST_PROJECT_VIEW'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'1'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38991625823082857790)
,p_computation_sequence=>30
,p_computation_item=>'LAST_PROJ_JUMP_PG'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'1'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38317532468794869289)
,p_name=>'refresh on dialog close'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40124747147497543025)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38317532690502869291)
,p_event_id=>wwv_flow_imp.id(38317532468794869289)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40506778417903286983)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39785079164370312112)
,p_name=>'on my proj dc refresh'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(41579293761725943861)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39785079175838312113)
,p_event_id=>wwv_flow_imp.id(39785079164370312112)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(41579293761725943861)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39785079292644312114)
,p_event_id=>wwv_flow_imp.id(39785079164370312112)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55491903744582352510)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49015131172483361183)
,p_name=>'on Releases after edit'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(52861349035501637675)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49015131270853361184)
,p_event_id=>wwv_flow_imp.id(49015131172483361183)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(52861349035501637675)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39785079739755312118)
,p_name=>'toggle favorite'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1_PROJECT_TO_FAVORITE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39785079831792312119)
,p_event_id=>wwv_flow_imp.id(39785079739755312118)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_favorite_toggle(',
'    p_project_id => :P1_PROJECT_TO_FAVORITE, ',
'    p_app_user_id => :APP_USER_ID',
'    );'))
,p_attribute_02=>'P1_PROJECT_TO_FAVORITE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39820379430813388070)
,p_event_id=>wwv_flow_imp.id(39785079739755312118)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var favButton$ = $(".js-project-to-favorite");',
'var favButtonIcon$ = favButton$.find(".t-Icon");',
'',
'// we use the class to get the active element, can be cleared now',
'favButton$.removeClass("js-project-to-favorite"); ',
'',
'if ( favButtonIcon$.hasClass("fa-heart") ) {',
'    favButtonIcon$.removeClass("fa-heart u-danger-text").addClass("fa-heart-o");',
'    // hide success message, no API to do this so done with classes',
'    $( "#APEX_SUCCESS_MESSAGE" ).removeClass("u-visible").addClass("u-hidden"); ',
'} else if ( favButtonIcon$.hasClass("fa-heart-o") ) {',
'    favButtonIcon$.removeClass("fa-heart-o").addClass("fa-heart u-danger-text");',
'    apex.message.showPageSuccess(''Project favorited!'');',
'}',
'apex.items.P1_PROJECT_TO_FAVORITE.setValue('''',undefined,true); //third parameter used to suppress change event'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40690388547922052904)
,p_name=>'dismiss notif'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1_NOTIF_TO_DISMISS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40690388639123052905)
,p_event_id=>wwv_flow_imp.id(40690388547922052904)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update sp_team_member_notifications',
'   set dismissed_yn = ''Y''',
' where id = :P1_NOTIF_TO_DISMISS',
'   and team_member_id =  :APP_USER_ID;'))
,p_attribute_02=>'P1_NOTIF_TO_DISMISS'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40690388754412052906)
,p_event_id=>wwv_flow_imp.id(40690388547922052904)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.items.P1_NOTIF_TO_DISMISS.setValue('''',undefined,true);'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39820379566334388072)
,p_name=>'refresh my curr activity on dc'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(55491903744582352510)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39820379753121388073)
,p_event_id=>wwv_flow_imp.id(39820379566334388072)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55491903744582352510)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(53205375392192421187)
,p_name=>'initiative refresh on dialog close'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(53205373870373421172)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53205375468499421188)
,p_event_id=>wwv_flow_imp.id(53205375392192421187)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(53205373870373421172)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(40989090803109557846)
,p_region_id=>wwv_flow_imp.id(40989090502530557843)
,p_position_id=>362316004162771045
,p_display_sequence=>40
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(41831225974708866242)
,p_region_id=>wwv_flow_imp.id(41579293761725943861)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(41831226301638866246)
,p_region_id=>wwv_flow_imp.id(41579293761725943861)
,p_position_id=>348722977165395441
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&FRIENDLY_IDENTIFIER1.,&PROJECT_URL_NAME.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(41912143965311395350)
,p_region_id=>wwv_flow_imp.id(41579293761725943861)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Favorite'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$favoriteProject?id=&ID.'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'&FAVORITE_ICON.'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(46240430306779837598)
,p_region_id=>wwv_flow_imp.id(40989090502530557843)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'My Favorites'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,:P23_FAVORITE:Yes'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-heart'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(49247648521817194495)
,p_region_id=>wwv_flow_imp.id(40989090502530557843)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362316605839802174
,p_label=>'View &NOMENCLATURE_PROJECTS.'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,::'
,p_button_display_type=>'TEXT'
,p_is_hot=>true
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(52511906666365635138)
,p_region_id=>wwv_flow_imp.id(52861349035501637675)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,117:P117_RELEASE_ID:&ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(52862740786846572140)
,p_region_id=>wwv_flow_imp.id(52861349035501637675)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(53205374648341421179)
,p_region_id=>wwv_flow_imp.id(53205373870373421172)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:&ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(53205374728105421180)
,p_region_id=>wwv_flow_imp.id(53205373870373421172)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362316605839802174
,p_label=>'Kanban'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RP,4:P4_INITIATIVE_ID:&ID.'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-layout-3col'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(53205374881998421182)
,p_region_id=>wwv_flow_imp.id(53205373870373421172)
,p_position_id=>362316004162771045
,p_display_sequence=>30
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(55491905739329352530)
,p_region_id=>wwv_flow_imp.id(55491903744582352510)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:RP,140:P140_ID:&ID.#ACTIVITY'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(55491905903024352531)
,p_region_id=>wwv_flow_imp.id(55491903744582352510)
,p_position_id=>362316004162771045
,p_display_sequence=>30
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_action_css_classes=>'t-Button--noUI'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(29014889136496880754)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'AI Summaries'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:26:&SESSION.::&DEBUG.:RP,26:P26_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-ai-sparkle-generate-text'
,p_build_option_id=>wwv_flow_imp.id(27803842998100767814)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(40989091509016557853)
,p_component_action_id=>wwv_flow_imp.id(40989090803109557846)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>150
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,1::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41237943327809315641)
,p_component_action_id=>wwv_flow_imp.id(55491905903024352531)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Quick Look'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:&PROJECT_ID.'
,p_icon_css_classes=>'fa-package'
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'FRIENDLY_IDENTIFIER'
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234009685897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41543963547260355262)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Change History'
,p_display_sequence=>110
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:124:&SESSION.::&DEBUG.:RP,124:P124_ID:&ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41831226043466866243)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit '
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41831226126085866244)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Owner Quick Look'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:&OWNER_ID.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41831226209518866245)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Details'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:&FRIENDLY_IDENTIFIER1.,&PROJECT_URL_NAME.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41927853573122718565)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Activity Quick Look'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:130:&SESSION.::&DEBUG.:RP,130:P130_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-badge-check'
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'ACTIVE_ACTIVITY_ICON'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41927854115411718570)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Add Activity'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-plus'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42267928001643037049)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Add Comment'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.:100:P100_PROJECT_ID:&ID.'
,p_icon_css_classes=>'fa-comment-o'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42292196225669002444)
,p_component_action_id=>wwv_flow_imp.id(55491905903024352531)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Activity Quick Look'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:RP,140:P140_ID:&ID.'
,p_icon_css_classes=>'fa-badge-check'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42404826439011352726)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Quick Look'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:&ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42404826562842352727)
,p_component_action_id=>wwv_flow_imp.id(41831225974708866242)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>30
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42521102797086844262)
,p_component_action_id=>wwv_flow_imp.id(55491905903024352531)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>30
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51065626441141282205)
,p_component_action_id=>wwv_flow_imp.id(53205374881998421182)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Milestones'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:112:&SESSION.::&DEBUG.:RP,:P112_INITIATIVE_ID:&ID.'
,p_icon_css_classes=>'fa-calendar-month'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52862740961115572142)
,p_component_action_id=>wwv_flow_imp.id(52862740786846572140)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Release'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:RP,27:P27_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(52862741139355572143)
,p_component_action_id=>wwv_flow_imp.id(52862740786846572140)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release &NOMENCLATURE_PROJECTS. '
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:RP,:P300_RELEASE_ID:&ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53205375036990421183)
,p_component_action_id=>wwv_flow_imp.id(53205374881998421182)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit &NOMENCLATURE_INITIATIVE.'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:RP,22:P22_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53205375083945421184)
,p_component_action_id=>wwv_flow_imp.id(53205374881998421182)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View &NOMENCLATURE_INITIATIVE.'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:&ID.'
,p_icon_css_classes=>'fa-binoculars'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53205375182415421185)
,p_component_action_id=>wwv_flow_imp.id(53205374881998421182)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View Kanban'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RP,4:P4_INITIATIVE_ID:&ID.'
,p_icon_css_classes=>'fa-layout-3col'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53205375270496421186)
,p_component_action_id=>wwv_flow_imp.id(53205374881998421182)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View &NOMENCLATURE_PROJECTS.'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,23:P23_FOCUS_AREA,P23_INITIATIVE:&AREA.,&INITIATIVE.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53830896908140460090)
,p_component_action_id=>wwv_flow_imp.id(52862740786846572140)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release Details'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:RP,117:P117_RELEASE_ID:&ID.'
,p_icon_css_classes=>'fa-ship'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55491905965509352532)
,p_component_action_id=>wwv_flow_imp.id(55491905903024352531)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Edit Activity'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_ID:&ID.'
,p_icon_css_classes=>'fa-edit'
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55574018464363849601)
,p_component_action_id=>wwv_flow_imp.id(55491905903024352531)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECT. Detail'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:&FRIENDLY_IDENTIFIER.,&PROJECT_URL_NAME.'
,p_icon_css_classes=>'fa-package'
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'FRIENDLY_IDENTIFIER'
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234009685897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(64211590232276285527)
,p_component_action_id=>wwv_flow_imp.id(52862740786846572140)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>30
);
wwv_flow_imp.component_end;
end;
/
