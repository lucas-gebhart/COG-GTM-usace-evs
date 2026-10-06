prompt --application/pages/page_00502
begin
--   Manifest
--     PAGE: 00502
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
 p_id=>502
,p_name=>'Task Details'
,p_alias=>'TASK-DETAILS'
,p_step_title=>'Details'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_FILES#js/spCommentImageSupport#MIN#.js'
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
'.a-CardView-badge { align-self: flex-start; }',
'',
'.project-rds-region {',
'    background-color: rgb(219 204 175 / 20%);',
'}',
'.t-Body-title {',
'    --ut-palette-warning-shade: rgba(var(--oj-palette-neutral-rgb-160));',
'    --ut-component-background-color: rgba(var(--oj-palette-neutral-rgb-170)); ',
'    --ut-alert-horizontal-border-radius: 0;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59694476925605199521)
,p_plug_name=>'RDS'
,p_region_css_classes=>'u-padding-inline-dynamic project-rds-region'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_region_icons', 'N',
  'include_show_all', 'N',
  'rds_mode', 'STANDARD',
  'remember_selection', 'USER')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62381325144710358940)
,p_plug_name=>'Details'
,p_region_css_classes=>'u-flex'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(91172120027393696100)
,p_name=>'Task'
,p_parent_plug_id=>wwv_flow_imp.id(62381325144710358940)
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with today as (select trunc(sysdate) day from dual)',
'select r.ID,',
'       p.INITIATIVE_ID,',
'       i.initiative,',
'       f.area focus_area,',
'       f.id focus_area_id,',
'       (select project from sp_projects where id = r.project_id) project,',
'       r.project_id,',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) the_owner,',
'       r.owner_id,',
'       s.status,',
'       r.start_date,',
'       r.target_complete,',
'       case when s.indicates_complete_yn = ''N'' and',
'                 r.target_complete is not null',
'            then least(5, trunc(r.target_complete) - trunc(r.target_complete, ''iw'') + 1)',
'                 - least(5, today.day - trunc(today.day, ''iw'') + 1)',
'                 + (trunc(r.target_complete, ''iw'') - trunc(today.day, ''iw'')) * 5 / 7',
'       end weekdays_left,',
'       r.updated',
'  from sp_tasks r,',
'       sp_task_statuses s,',
'       today,',
'       SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f',
' where r.id = :P502_TASK_ID',
'   and r.status_id = s.id',
'   and r.project_id = p.id',
'   and p.initiative_id = i.id',
'   and i.area_id = f.id'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P502_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028445010638165251)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059608468387109)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>260
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059728962387110)
,p_query_column_id=>3
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>160
,p_column_heading=>'Initiative'
,p_column_link=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:94:P94_INITIATIVE_ID:#INITIATIVE_ID#'
,p_column_linktext=>'#INITIATIVE#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059779383387111)
,p_query_column_id=>4
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>150
,p_column_heading=>'Focus Area'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FOCUS_AREA:#FOCUS_AREA#'
,p_column_linktext=>'#FOCUS_AREA#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059905453387112)
,p_query_column_id=>5
,p_column_alias=>'FOCUS_AREA_ID'
,p_column_display_sequence=>280
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010685912552779687)
,p_query_column_id=>6
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>170
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:#PROJECT_ID#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55059012923095694778)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>250
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010688385251779712)
,p_query_column_id=>8
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>180
,p_column_heading=>'Owner'
,p_column_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:5:P5_ID:#OWNER_ID#'
,p_column_linktext=>'#THE_OWNER#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010688313354779711)
,p_query_column_id=>9
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010685463276779682)
,p_query_column_id=>10
,p_column_alias=>'STATUS'
,p_column_display_sequence=>190
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010685528744779683)
,p_query_column_id=>11
,p_column_alias=>'START_DATE'
,p_column_display_sequence=>200
,p_column_heading=>'Start Date'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55010685628909779684)
,p_query_column_id=>12
,p_column_alias=>'TARGET_COMPLETE'
,p_column_display_sequence=>210
,p_column_heading=>'Target Complete'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46901092373457793918)
,p_query_column_id=>13
,p_column_alias=>'WEEKDAYS_LEFT'
,p_column_display_sequence=>220
,p_column_heading=>'Weekdays Left'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028444586451165251)
,p_query_column_id=>14
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>230
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(64476296843713909944)
,p_plug_name=>'Links'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       TASK_ID,',
'       LINK_NAME,',
'       case when lower(link_url) not like ''http%'' then ''http://'' end || link_url link_url_link,',
'       decode(greatest(length(link_url),80),80,',
'           link_url,',
'           substr(link_url,1,39)||''...''||substr(link_url,length(link_url)-39)',
'           ) link_url_disp,',
'       decode(IMPORTANT_YN,''Y'',''Yes'',''N'',''No'',IMPORTANT_YN) IMPORTANT,',
'       CREATED,',
'       lower(CREATED_BY) created_by,',
'       UPDATED,',
'       UPDATED_BY',
'  from SP_TASK_LINKS',
' where task_id = :P502_TASK_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P502_TASK_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Links'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(64476296919564909945)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:506:&SESSION.::&DEBUG.:RP,506:P506_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>27576939054162942176
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297033614909946)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297298669909948)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_html_expression=>'<a href="#LINK_URL_LINK#" target="_blank">#LINK_NAME#</a>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55059013128684694780)
,p_db_column_name=>'LINK_URL_DISP'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Link URL'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297557126909951)
,p_db_column_name=>'CREATED'
,p_display_order=>50
,p_column_identifier=>'F'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297649284909952)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>60
,p_column_identifier=>'G'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297785943909953)
,p_db_column_name=>'UPDATED'
,p_display_order=>70
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64476297904709909954)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69723613586508575046)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>90
,p_column_identifier=>'K'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55010684990714779678)
,p_db_column_name=>'TASK_ID'
,p_display_order=>100
,p_column_identifier=>'L'
,p_column_label=>'Task Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55059013017728694779)
,p_db_column_name=>'LINK_URL_LINK'
,p_display_order=>110
,p_column_identifier=>'M'
,p_column_label=>'Link Url Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(64478681205787956453)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'47246263'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK_NAME:LINK_URL_DISP:IMPORTANT:UPDATED:CREATED_BY:'
,p_sort_column_1=>'IMPORTANT'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66969322098564766632)
,p_plug_name=>'Details'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(86179321961620184757)
,p_plug_name=>'Details'
,p_parent_plug_id=>wwv_flow_imp.id(66969322098564766632)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>120
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    x clob;',
'begin',
'x := ''No details provided.'';',
'for c1 in (select description from sp_tasks d where d.id = :P502_TASK_ID and description is not null) loop',
'    x := apex_markdown.to_html(c1.description);',
'end loop;',
'return x;',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P502_TASK_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67111678780298019089)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67976022135331033907)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(67111678780298019089)
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
 p_id=>wwv_flow_imp.id(67976023368837033919)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(173775780000598069493)
,p_name=>'Comments'
,p_region_name=>'COMMENTS'
,p_template=>4501440665235496320
,p_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ic.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       to_char(ic.created,''fmDay, fmDD fmMonth, YYYY'') date_full,',
'       null comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       ic.body_html comment_text,',
'       case when lower(ic.created_by) = lower(:app_user)',
'            then ''<a href="''||apex_util.prepare_URL(',
'                              p_url => ''f?p=''||:APP_ID||'':503:''||:APP_SESSION||''::NO:503:P503_ID:''||ic.id,',
'                              p_checksum_type => ''3'')||''">edit</a>'' ',
'            end actions,',
'       '' '' attribute_1,',
'       '' '' attribute_2,',
'       '' '' attribute_3,',
'       '' '' attribute_4,',
'       ''u-color-''||ora_hash(ic.created_by,45) icon_modifier,',
'       --',
'       --',
'       --',
'       decode(ic.private_yn,null,null,''N'',null,''Y'','' Private Comment'') private_comment_label,',
'       --',
'       -- Data Columns',
'       --',
'       ic.BODY,',
'       ic.BODY_HTML,',
'       ic.AUTHOR_ID,',
'       --',
'       ic.CREATED,',
'       ic.CREATED_BY,',
'       ic.UPDATED,',
'       ic.UPDATED_BY,',
'       tm.id team_member_id',
'  from sp_task_comments_v ic, ',
'       sp_team_members tm',
'where ic.author_id = tm.id and',
'      ic.task_id = :P502_TASK_ID and  ',
'      (nvl(ic.private_yn,''N'') = ''N'' or lower(ic.created_by) = lower(:app_user) )',
'order by ic.created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P502_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No Comments'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028457060797165271)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028457370139165272)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178319029486483257)
,p_query_column_id=>3
,p_column_alias=>'DATE_FULL'
,p_column_display_sequence=>270
,p_column_heading=>'Date Full'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028457800164165272)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_column_html_expression=>'<span title="added #DATE_FULL#">#CREATED#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028458237400165272)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028458598030165273)
,p_query_column_id=>6
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>180
,p_column_heading=>'Comment Text'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if PRIVATE_COMMENT_LABEL/}<strong class="u-danger-text">#PRIVATE_COMMENT_LABEL#</strong><br />{endif/}',
'#COMMENT_TEXT#'))
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028458993126165273)
,p_query_column_id=>7
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>190
,p_column_heading=>'Actions'
,p_report_column_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028459404640165273)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028459857778165274)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028460191548165274)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028460598703165275)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028460977209165275)
,p_query_column_id=>12
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028461450459165275)
,p_query_column_id=>13
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>260
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028461817582165276)
,p_query_column_id=>14
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028462211132165276)
,p_query_column_id=>15
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028462660067165276)
,p_query_column_id=>16
,p_column_alias=>'AUTHOR_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Author Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028463028713165276)
,p_query_column_id=>17
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028463365777165277)
,p_query_column_id=>18
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028463815825165277)
,p_query_column_id=>19
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028464200578165278)
,p_query_column_id=>20
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55028464597404165278)
,p_query_column_id=>21
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(185562955537437521406)
,p_plug_name=>'Documents'
,p_region_name=>'DOCUMENTS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.ID,',
'       d.DOCUMENT_FILENAME,',
'       d.UPDATED,',
'       d.created,',
'       case when length(d.doc_description) > 200',
'            then substr(d.doc_description,1,200)||''...''',
'            else d.doc_description',
'            end doc_description,',
'       d.tags,',
'       lower(created_by) created_by,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) doc_size,',
'       created date_created,',
'       substr(DOCUMENT_FILENAME,instr(DOCUMENT_FILENAME,''.'',-1)+1,length(DOCUMENT_FILENAME)-instr(DOCUMENT_FILENAME,''.'',-1)) file_extension,',
'       decode(important_yn,''Y'',''Yes'',''No'') important,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) document',
'  from SP_TASK_DOCUMENTS d',
' where task_id = :P502_TASK_ID',
'order by created desc',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P502_TASK_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Documents'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(71871569349102816730)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:504:&SESSION.::&DEBUG.:504:P504_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>34972211483700848961
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871569450266816731)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871569582657816732)
,p_db_column_name=>'DOCUMENT_FILENAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Filename'
,p_column_link=>'f?p=&APP_ID.:505:&SESSION.::&DEBUG.:505:P505_ID,P505_PREV_PAGE:#ID#,502'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871570007458816736)
,p_db_column_name=>'DOC_DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871570212987816738)
,p_db_column_name=>'DOC_SIZE'
,p_display_order=>50
,p_column_identifier=>'H'
,p_column_label=>'Size'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FILESIZE'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871569759621816734)
,p_db_column_name=>'UPDATED'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871569835464816735)
,p_db_column_name=>'CREATED'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71871570230025816739)
,p_db_column_name=>'DATE_CREATED'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Created On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(72308424420771665518)
,p_db_column_name=>'FILE_EXTENSION'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'File Extension'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(82968108124712214321)
,p_db_column_name=>'TAGS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69954604136971546765)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(71064151976381744225)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014891233891880775)
,p_db_column_name=>'DOCUMENT'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Document'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DOWNLOAD:SP_TASK_DOCUMENTS:DOCUMENT_BLOB:ID::DOCUMENT_MIMETYPE:DOCUMENT_FILENAME:DOCUMENT_LASTUPD:DOCUMENT_CHARSET:attachment:Download:'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(71873305583906409501)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8109551'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DOCUMENT_FILENAME:DOC_DESCRIPTION:CREATED_BY:IMPORTANT:DOCUMENT:DOC_SIZE:UPDATED:'
,p_sort_column_1=>'IMPORTANT'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_sum_columns_on_break=>'DOC_SIZE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55028465036919165278)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(173775780000598069493)
,p_button_name=>'POST_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Post Comment'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'u-flex u-align-items-center margin-bottom-md'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55028450422587165258)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(64476296843713909944)
,p_button_name=>'add_link'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Link'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55028433537781165232)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(185562955537437521406)
,p_button_name=>'view_images'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Image Gallery'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.:60:P60_TASK_ID:&P502_TASK_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from SP_TASK_DOCUMENTS d',
' where task_id = :P502_TASK_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55028433938791165234)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(185562955537437521406)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Document'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:504:&SESSION.::&DEBUG.:RR,504:P504_TASK_ID:&P502_TASK_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55028451861553165260)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(67111678780298019089)
,p_button_name=>'UP_for_3'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,:P3_PROJECT_ID:&P502_PROJECT_ID.'
,p_button_condition=>'P502_PREV_PAGE'
,p_button_condition2=>'3'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55451870039771187691)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(67111678780298019089)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:&P502_PREV_PAGE.:&SESSION.::&DEBUG.:RP,::'
,p_button_condition=>'P502_PREV_PAGE'
,p_button_condition2=>'3'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5124358161538787003)
,p_name=>'P502_PTID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722865166592623549)
,p_name=>'P502_IMAGE_REF_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(173775780000598069493)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48050551489554060982)
,p_name=>'P502_COMMENT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(173775780000598069493)
,p_prompt=>' Comment'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(options) {',
'    return spCommentImageSupport.markdown.configEditor(options, {',
'        apexUpload: {',
'            // Application process name that that will handle the POST request when an image is dropped into',
'            // text box',
'            uploadApplicationProcess: ''POST_COMMENT_IMAGE'',',
'            // Pass in any data that you want in the POST process ',
'            // Will be passed in as a JSON object and available in apex_application.g_x01',
'            data: {',
'                imageRefId: apex.item(''P502_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}',
''))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48139343434692521286)
,p_name=>'P502_TASK_LINK'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48139343955212521291)
,p_name=>'P502_PARENT_TASK_TYPE'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55010685697541779685)
,p_name=>'P502_PROJECT_ID'
,p_item_sequence=>50
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55451869875144187690)
,p_name=>'P502_PREV_PAGE'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59505572894242063818)
,p_name=>'P502_TASK_ID'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59505573113344063820)
,p_name=>'P502_TASK'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59831650329361971611)
,p_name=>'P502_PRIVATE_YN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(173775780000598069493)
,p_item_default=>'N'
,p_prompt=>'This is a private comment'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#:margin-left-md'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64476323602398910028)
,p_name=>'P502_LINK'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(64476296843713909944)
,p_prompt=>'Link URL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'URL',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64476324003529910032)
,p_name=>'P502_LINK_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(64476296843713909944)
,p_prompt=>'Link Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(5124358380642787005)
,p_computation_sequence=>10
,p_computation_item=>'P502_TASK_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
'  from sp_tasks',
' where id = :P502_PTID'))
,p_compute_when=>'P502_PTID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(55028477113089165297)
,p_computation_sequence=>20
,p_computation_item=>'P502_TASK'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select (select task_type from sp_task_types rt where rt.id = task_type_id)||',
'           case when task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = task_sub_type_id) ||',
'       case when task is not null then '' - ''||task end type',
'  from sp_tasks',
' where id = :P502_TASK_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48139343857365521290)
,p_computation_sequence=>40
,p_computation_item=>'P502_PARENT_TASK_TYPE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rt.task_type',
'  from sp_tasks t,',
'       sp_task_types rt',
' where t.id = :P502_TASK_ID',
'   and rt.id = t.task_type_id'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48139343521563521287)
,p_computation_sequence=>50
,p_computation_item=>'P502_TASK_LINK'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_util.get_setting(p_static_id => ''APP_PREFIX_URL'')||',
'                      apex_page.get_url (',
'                          p_application    => :APP_ID,',
'                          p_page           => ''task-details'',',
'                          p_session        => null,',
'                          p_items          => ''P502_PTID'',',
'                          p_values         => :P502_TASK_ID,',
'                          p_plain_url      => TRUE );'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(5124358503204787006)
,p_computation_sequence=>60
,p_computation_item=>'P502_PROJECT_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_id',
'  from sp_tasks',
' where id = :P502_TASK_ID'))
,p_compute_when=>'P502_PROJECT_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(5124358258571787004)
,p_computation_sequence=>70
,p_computation_item=>'P502_PREV_PAGE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'3'
,p_compute_when=>'P502_PREV_PAGE'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028479554660165299)
,p_name=>'post comment and do alerts'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(55028465036919165278)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(17885008133537678865)
,p_event_id=>wwv_flow_imp.id(55028479554660165299)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(55028465036919165278)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028480020712165300)
,p_event_id=>wwv_flow_imp.id(55028479554660165299)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'Add Comment and send alerts'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_task_comment (',
'    p_app_user_id  => :APP_USER_ID, ',
'    p_app_user     => :APP_USER,',
'    p_comment      => :P502_COMMENT,',
'    p_private_yn   => nvl(:P502_PRIVATE_YN,''N''),',
'    p_project_id   => :P502_PROJECT_ID,',
'    p_task_id      => :P502_TASK_ID,',
'    p_app_id       => :APP_ID,',
'    p_link         => :P502_TASK_LINK,',
'    p_nomen_sp     => :NOMENCLATURE_STRATEGIC_PLANNER,',
'    p_image_ref_id => :P502_IMAGE_REF_ID );',
'',
':P502_COMMENT      := null;',
':P502_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P502_TASK_ID,P502_COMMENT,P502_PRIVATE_YN,P502_PROJECT_ID,P502_TASK_LINK,P502_IMAGE_REF_ID'
,p_attribute_03=>'P502_COMMENT,P502_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028480529109165300)
,p_event_id=>wwv_flow_imp.id(55028479554660165299)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(173775780000598069493)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48139343211354521284)
,p_event_id=>wwv_flow_imp.id(55028479554660165299)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(17885008232548678866)
,p_event_id=>wwv_flow_imp.id(55028479554660165299)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(55028465036919165278)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028481371047165301)
,p_name=>'on comments dialog closed'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(173775780000598069493)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028481923343165301)
,p_event_id=>wwv_flow_imp.id(55028481371047165301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(173775780000598069493)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028482415705165301)
,p_event_id=>wwv_flow_imp.id(55028481371047165301)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(91172120027393696100)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028482778165165302)
,p_name=>'add link'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(55028450422587165258)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028483350722165302)
,p_event_id=>wwv_flow_imp.id(55028482778165165302)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please supply a Link URL and a Link Name.'
,p_attribute_02=>'Missing Link Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P502_LINK'') === '''' || $v(''P502_LINK_NAME'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028483808788165302)
,p_event_id=>wwv_flow_imp.id(55028482778165165302)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P502_LINK_NAME is not null and :P502_LINK is not null then',
'insert into SP_TASK_LINKS (',
'    task_id, link_name, link_url)',
'values (',
'    :P502_TASK_ID, :P502_LINK_NAME, :P502_LINK);',
':P502_LINK_NAME := null;',
':P502_LINK := null;',
'end if;'))
,p_attribute_02=>'P502_LINK_NAME,P502_LINK,P502_TASK_ID'
,p_attribute_03=>'P502_LINK_NAME,P502_LINK'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028484279934165303)
,p_event_id=>wwv_flow_imp.id(55028482778165165302)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(64476296843713909944)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028484828500165303)
,p_event_id=>wwv_flow_imp.id(55028482778165165302)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(91172120027393696100)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028478578487165298)
,p_name=>'refresh on documents'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(185562955537437521406)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028479076022165299)
,p_event_id=>wwv_flow_imp.id(55028478578487165298)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(185562955537437521406)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028486659166165304)
,p_name=>'contextual info dialog close refresh'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(67111678780298019089)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028487133429165305)
,p_event_id=>wwv_flow_imp.id(55028486659166165304)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(91172120027393696100)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55028487553326165305)
,p_name=>'on links region dc'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(64476296843713909944)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028488016333165305)
,p_event_id=>wwv_flow_imp.id(55028487553326165305)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(91172120027393696100)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55028488479518165306)
,p_event_id=>wwv_flow_imp.id(55028487553326165305)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(64476296843713909944)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25423962058239543475)
,p_name=>'links in comments in new tab'
,p_event_sequence=>80
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25423962134687543476)
,p_event_id=>wwv_flow_imp.id(25423962058239543475)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38252337117898094174)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'log'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_log.log_interaction(',
'    p_project_id => :P502_PROJECT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>1352979252496126405
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(38090003267206244788)
,p_region_id=>wwv_flow_imp.id(67976022135331033907)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:RP,501:P501_ID:&P502_TASK_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXISTS'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P502_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID not in (''MILESTONE'',''REVIEW'')'))
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(38090003442026244789)
,p_region_id=>wwv_flow_imp.id(67976022135331033907)
,p_position_id=>362316004162771045
,p_display_sequence=>30
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:509:&SESSION.::&DEBUG.:RP,509:P509_ID:&P502_TASK_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXISTS'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P502_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID = ''REVIEW'''))
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(55059013854438694787)
,p_region_id=>wwv_flow_imp.id(67976022135331033907)
,p_position_id=>362316004162771045
,p_display_sequence=>40
,p_template_id=>362317865359806322
,p_label=>'menu'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(61315023768479827551)
,p_region_id=>wwv_flow_imp.id(67976022135331033907)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:508:&SESSION.::&DEBUG.:RP,508:P508_ID:&P502_TASK_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_condition_type=>'EXISTS'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P502_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID = ''MILESTONE'''))
,p_exec_cond_for_each_row=>true
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(48139344315641521295)
,p_component_action_id=>wwv_flow_imp.id(55059013854438694787)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Show Involved People'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:96:&SESSION.::&DEBUG.:96:P96_ID:&P502_PROJECT_ID.'
,p_icon_css_classes=>'fa-users-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(48139344385666521296)
,p_component_action_id=>wwv_flow_imp.id(55059013854438694787)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>30
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(48139344531478521297)
,p_component_action_id=>wwv_flow_imp.id(55059013854438694787)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Find Screen Names'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:123:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-at'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(55059013905881694788)
,p_component_action_id=>wwv_flow_imp.id(55059013854438694787)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:507:&SESSION.::&DEBUG.:507:P507_TASK_ID:&P502_TASK_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp.component_end;
end;
/
