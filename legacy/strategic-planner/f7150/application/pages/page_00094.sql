prompt --application/pages/page_00094
begin
--   Manifest
--     PAGE: 00094
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
 p_id=>94
,p_name=>'Initiative'
,p_alias=>'INITIATIVE'
,p_step_title=>'&NOMENCLATURE_INITIATIVE.: &P94_INITIATIVE.'
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
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41376456070343866302)
,p_plug_name=>'Associated Releases'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rt.id,',
'       release_train||'' ''||release release,',
'       RELEASE_TARGET_DATE,',
'       RELEASE_OPEN_DATE,',
'       decode(nvl(rt.RELEASE_COMPLETED,''N''),''Y'',''Yes'',''N'',''No'',RELEASE_COMPLETED) COMPLETED,',
'       (select count(*) from sp_projects p where nvl(p.ARCHIVED_YN,''N'') = ''N'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.initiative_id = :P94_INITIATIVE_ID and',
'      p.release_id is not null and ',
'      p.release_id = rt.id) project_count',
'from   sp_release_trains rt',
'where rt.id in (',
'select distinct p.release_id',
'from  SP_PROJECTS p',
'where nvl(p.ARCHIVED_YN,''N'') = ''N'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.initiative_id = :P94_INITIATIVE_ID and',
'      p.release_id is not null)',
'',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Associated Releases'
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
,p_plug_footer=>'<p>This reports lists releases that have one or more associated &NOMENCLATURE_PROJECTS. that corresponds to the selected &NOMENCLATURE_INITIATIVE..</p>'
,p_required_patch=>wwv_flow_imp.id(41243768626038066363)
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(41565408085421002094)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>4666050220019034325
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408231058002095)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408299770002096)
,p_db_column_name=>'RELEASE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Release'
,p_column_link=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.::P117_RELEASE_ID:#ID#'
,p_column_linktext=>'#RELEASE#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408420249002097)
,p_db_column_name=>'RELEASE_TARGET_DATE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Release Target Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FMDD Month YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408467393002098)
,p_db_column_name=>'RELEASE_OPEN_DATE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Release Open Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FMDD Month YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408621159002099)
,p_db_column_name=>'COMPLETED'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Completed'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565408759606002100)
,p_db_column_name=>'PROJECT_COUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Project Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(41597135889671370386)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'46977781'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RELEASE:RELEASE_TARGET_DATE:RELEASE_OPEN_DATE:COMPLETED:PROJECT_COUNT'
,p_sort_column_1=>'RELEASE_OPEN_DATE'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41565405759516002070)
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
 p_id=>wwv_flow_imp.id(41565408815667002101)
,p_plug_name=>'&NOMENCLATURE_PROJECTS. '
,p_icon_css_classes=>' '
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.PROJECT,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = p.PRIORITY_ID) priority,',
'       p.PCT_COMPLETE pct_complete,',
'       case when p.pct_complete >= s.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            else ''NA''',
'            end status,',
'       (select decode(greatest(length(initiative),15),15,initiative,substr(initiative,1,12)||''...'') initiative ',
'        from sp_initiatives i ',
'        where i.id = p.initiative_id) initiative,',
'       --',
'       -- release',
'       --',
'       case when p.release_id is not null',
'            then (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.RELEASE_ID) ',
'            else ''Not Targeted''',
'            end release,',
'       to_char(p.target_complete,''DD-Mon-YYYY'') target_complete,',
'       --',
'       p.PROJECT_SIZE,',
'       p.UPDATED,',
'       p.owner_id,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       nvl((select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.email = lower(p.updated_by)),lower(p.updated_by)) updated_by,',
'       null actions,',
'       p.tags',
' from  SP_PROJECTS p,',
'       sp_initiatives i,',
'       sp_project_scales s',
'where p.initiative_id = i.id and',
'      i.status_scale = s.scale_letter and',
'      nvl(p.ARCHIVED_YN,''N'') = ''N'' and ',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.initiative_id = :P94_INITIATIVE_ID',
'order by p.updated desc nulls last',
'',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'&NOMENCLATURE_PROJECTS. '
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
,p_plug_footer=>'Click the &NOMENCLATURE_PROJECT. name to view details.'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(41565410459692002117)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>4666052594290034348
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565410469099002118)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41565410638771002119)
,p_db_column_name=>'PROJECT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'&NOMENCLATURE_PROJECT. Name'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597145887289379770)
,p_db_column_name=>'THE_OWNER'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Owner'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#OWNER_ID#'
,p_column_linktext=>'#THE_OWNER#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146007266379771)
,p_db_column_name=>'PRIORITY'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146087809379772)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Completeness'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146214908379773)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(30944276397569136837)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>70
,p_column_identifier=>'AA'
,p_column_label=>'Target Complete'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146321482379774)
,p_db_column_name=>'RELEASE'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146402037379775)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146542667379776)
,p_db_column_name=>'UPDATED'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146671312379778)
,p_db_column_name=>'OWNER_ID'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Owner Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146858527379779)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597146952529379780)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41597147120406379782)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41628126490864336401)
,p_db_column_name=>'ACTIONS'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Quick Look'
,p_column_link=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_ID:#ID#'
,p_column_linktext=>'<span class="fa fa-align-justify" aria-hidden="true"></span>'
,p_column_link_attr=>'View &NOMENCLATURE_PROJECTS. Details'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53264577572458686306)
,p_db_column_name=>'TAGS'
,p_display_order=>160
,p_column_identifier=>'Y'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52590898942658963415)
,p_db_column_name=>'STATUS'
,p_display_order=>170
,p_column_identifier=>'Z'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(41596987926643024176)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'46976301'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:THE_OWNER:PRIORITY:PCT_COMPLETE:STATUS:RELEASE:TARGET_COMPLETE:PROJECT_SIZE:UPDATED:ACTIONS:'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'PCT_COMPLETE'
,p_sort_direction_2=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(31031249762311756718)
,p_report_id=>wwv_flow_imp.id(41596987926643024176)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'PCT_COMPLETE'
,p_operator=>'!='
,p_expr=>'100'
,p_condition_sql=>'"PCT_COMPLETE" != to_number(#APXWS_EXPR#)'
,p_condition_display=>'#APXWS_COL_NAME# != #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41621602072957453097)
,p_plug_name=>'Activities'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ap.id, ',
'       at.activity_type,',
'       ap.comments,',
'       ap.start_date,',
'       ap.end_date,',
'       to_char(ap.end_date,''Day DD-MON-YYYY'') end_date_formatted,',
'       to_char(ap.start_date,''Day DD-MON-YYYY'')||'' to ''||to_char(ap.end_date,''Day DD-MON-YYYY'') TIMELINE,',
'       ap.end_date - ap.start_date days,',
'       round(ap.end_date - sysdate) days_remaining,',
'       ap.url,',
'       --',
'       i.initiative,',
'       i.id initiative_id,',
'       --',
'       tm.first_name||'' ''||tm.last_name owner,',
'       --',
'       -- timeframe',
'       --',
'        decode(',
'           greatest(trunc(sysdate),trunc(ap.end_date)),',
'           trunc(sysdate),',
'           ''Past'',',
'           decode(',
'               greatest(trunc(sysdate),trunc(ap.start_date)),',
'               trunc(sysdate),',
'               ''Current'',',
'               ''Future'')',
'           ) timeframe,',
'       --',
'       -- pie chart icon in 10% chunks that show time percent complete',
'       --',
'       ''fa-pie-chart-''||sp_date_range_pct_comp(ap.start_date, ap.end_date) icon',
'from sp_activities ap,',
'     sp_initiatives i,',
'     sp_activity_types at,',
'     sp_team_members tm',
'where ap.initiative_id = i.id and',
'      i.id = :P94_INITIATIVE_ID and',
'      ap.activity_type_id = at.id and',
'      ap.team_member_id = tm.id ',
'order by ap.updated desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Activities'
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
 p_id=>wwv_flow_imp.id(41621602253838453098)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>4722244388436485329
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621602302944453099)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621602711403453103)
,p_db_column_name=>'COMMENTS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Details'
,p_column_link=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:RP,140:P140_ID:#ID#'
,p_column_linktext=>'#COMMENTS#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621602830669453104)
,p_db_column_name=>'START_DATE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Start'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FMDD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621602946485453105)
,p_db_column_name=>'END_DATE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'End'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FMDD-MON-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41621603653727453112)
,p_db_column_name=>'URL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Url'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41625763931839177280)
,p_db_column_name=>'INITIATIVE_ID'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>'Initiative Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41625764846731177289)
,p_db_column_name=>'OWNER'
,p_display_order=>370
,p_column_identifier=>'AK'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41625764910277177290)
,p_db_column_name=>'ACTIVITY_TYPE'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>'Activity Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41625765241486177293)
,p_db_column_name=>'TIMEFRAME'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Timeframe'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153063166953911)
,p_db_column_name=>'END_DATE_FORMATTED'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'End Date Formatted'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153081402953912)
,p_db_column_name=>'TIMELINE'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'Timeline'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153197778953913)
,p_db_column_name=>'DAYS'
,p_display_order=>420
,p_column_identifier=>'AP'
,p_column_label=>'Days'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153273476953914)
,p_db_column_name=>'DAYS_REMAINING'
,p_display_order=>430
,p_column_identifier=>'AQ'
,p_column_label=>'Days Remaining'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153422297953915)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>440
,p_column_identifier=>'AR'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42368153467585953916)
,p_db_column_name=>'ICON'
,p_display_order=>450
,p_column_identifier=>'AS'
,p_column_label=>'Icon'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(41625619374690541764)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'47262616'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TIMEFRAME:OWNER:ACTIVITY_TYPE:COMMENTS:START_DATE:END_DATE'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(41703582219135816994)
,p_report_id=>wwv_flow_imp.id(41625619374690541764)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'TIMEFRAME'
,p_operator=>'='
,p_expr=>'Current'
,p_condition_sql=>'"TIMEFRAME" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''Current''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44252253978621161489)
,p_plug_name=>'Initiative Details'
,p_region_css_classes=>'u-flex'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-left-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41806955407192483899)
,p_plug_name=>'Initiative Icon'
,p_parent_plug_id=>wwv_flow_imp.id(44252253978621161489)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.id, ',
'       case when i.image is not null then i.image else f.image end image,',
'       case when i.image is not null then i.image_name else f.image_name end alt_text, ',
'       case when i.image is not null then i.image_name else f.image_name end image_name, ',
'       case when i.image is not null then i.image_mimetype else f.image_mimetype end image_mimetype ',
'  from SP_INITIATIVES i,',
'       sp_areas f',
' where i.id = :P94_INITIATIVE_ID',
'   and i.area_id = f.id'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$AVATAR'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_INITIATIVES i,',
'       sp_areas f',
' where i.id = :P94_INITIATIVE_ID',
'   and i.area_id = f.id',
'   and (i.image is not null or f.image is not null)'))
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"IMAGE","filenameColumn":"IMAGE_NAME","mimeTypeColumn":"IMAGE_MIMETYPE","lastUpdatedColumn":""}',
  'SIZE', 't-Avatar--xs',
  'TYPE', 'IMAGE')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806955519426483900)
,p_name=>'IMAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806955590098483901)
,p_name=>'ALT_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ALT_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806955758965483902)
,p_name=>'IMAGE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806955785094483903)
,p_name=>'IMAGE_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IMAGE_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41806955895766483904)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(73043048861304498649)
,p_name=>'&NOMENCLATURE_INITIATIVE.'
,p_parent_plug_id=>wwv_flow_imp.id(44252253978621161489)
,p_template=>4501440665235496320
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.area focus_area, ',
'       i.initiative, ',
'       ''<button type="button" title="Copy Permalink" aria-label="Copy Permalink" data-clipboard-source="''||:P94_PERMALINK_PREFIX||apex_escape.html(i.friendly_identifier)||''&pn=''||apex_escape.html(i.initiative_url_name)||''" class="t-Button t-Button--n'
||'oLabel t-Button--icon t-Button--link padding-none">''||i.friendly_identifier||''</button>'' perma_link,',
'       --',
'       -- projects',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.initiative_id = i.id and ',
'              p.ARCHIVED_YN = ''N'' and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects,',
'       --',
'       -- projects',
'       --',
'       (select count(*) ',
'        from sp_projects p ',
'        where p.initiative_id = i.id and ',
'              p.ARCHIVED_YN = ''N'' and',
'              p.pct_complete = 100 and',
'              p.DUPLICATE_OF_PROJECT_ID is null) projects_resolved,',
'       --',
'       -- owner',
'       --',
'       (select first_name||'' ''||last_name ',
'        from sp_team_members tm ',
'        where tm.id = i.SPONSOR_ID) the_owner,',
'       --',
'       i.sponsor_id owner_id,',
'       --',
'       i.updated,',
'       --',
'       i.id',
'  from SP_INITIATIVES i,',
'       SP_AREAS f',
'where i.area_id = f.id and',
'      i.id = :P94_INITIATIVE_ID',
'',
'     '))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(41565147337641580716)
,p_query_column_id=>1
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>20
,p_column_heading=>'&NOMENCLATURE_AREA.'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FOCUS_AREA:#FOCUS_AREA#'
,p_column_linktext=>'#FOCUS_AREA#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41565148534687580718)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>30
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083679756891389383)
,p_query_column_id=>3
,p_column_alias=>'PERMA_LINK'
,p_column_display_sequence=>40
,p_column_heading=>'Permalink'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41376456033495866301)
,p_query_column_id=>4
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_PROJECTS.'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42497662041303646687)
,p_query_column_id=>5
,p_column_alias=>'PROJECTS_RESOLVED'
,p_column_display_sequence=>60
,p_column_heading=>'Projects Resolved'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41628125774537336394)
,p_query_column_id=>6
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>100
,p_column_heading=>'Owner'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#OWNER_ID#'
,p_column_linktext=>'#THE_OWNER#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41628125924087336395)
,p_query_column_id=>7
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41702541121725774084)
,p_query_column_id=>8
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(44252253844084161487)
,p_query_column_id=>9
,p_column_alias=>'ID'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(46347225677624712493)
,p_plug_name=>'Links'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>165
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.ID,',
'       77 edit_page,',
'       :NOMENCLATURE_INITIATIVE belongs_to,',
'       LINK_NAME,',
'       LINK_URL,',
'       case when lower(link_url) not like ''http%''',
'            then ''http://''||link_url',
'            else link_url',
'            end for_link,',
'       decode(IMPORTANT_YN,''Y'',''Yes'',''N'',''No'',IMPORTANT_YN) IMPORTANT,',
'       CREATED,',
'       lower(CREATED_BY) created_by,',
'       UPDATED,',
'       UPDATED_BY',
'from SP_INITIATIVE_LINKS l',
'where  initiative_id = :P94_INITIATIVE_ID',
'union all',
'select l.ID,',
'       40 edit_page,',
'       ''Focus Area: ''||a.focus_area belongs_to,',
'       l.LINK_NAME,',
'       l.LINK_URL,',
'       case when lower(link_url) not like ''http%''',
'            then ''http://''||link_url',
'            else link_url',
'            end for_link,',
'       decode(l.IMPORTANT_YN,''Y'',''Yes'',''N'',''No'',l.IMPORTANT_YN) IMPORTANT,',
'       l.CREATED,',
'       lower(l.CREATED_BY) created_by,',
'       l.UPDATED,',
'       l.UPDATED_BY',
'from SP_INIT_FOCUS_AREA_LINKS l,',
'     SP_INITIATIVE_FOCUS_AREAS a',
'where a.initiative_id = :P94_INITIATIVE_ID',
'  and a.id = l.init_focus_area_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(46347225753475712494)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:RP,#EDIT_PAGE#:P#EDIT_PAGE#_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>9447867888073744725
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46347225867525712495)
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
 p_id=>wwv_flow_imp.id(53933058031342387093)
,p_db_column_name=>'BELONGS_TO'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Belongs To'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46347226132580712497)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_html_expression=>'<a href="#FOR_LINK#" target="_blank">#LINK_NAME#</a>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46347226160171712498)
,p_db_column_name=>'LINK_URL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'URL'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46347226391037712500)
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
 p_id=>wwv_flow_imp.id(46347226483195712501)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>60
,p_column_identifier=>'G'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46347226619854712502)
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
 p_id=>wwv_flow_imp.id(46347226738620712503)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51594542420419377595)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>90
,p_column_identifier=>'K'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933058145284387094)
,p_db_column_name=>'EDIT_PAGE'
,p_display_order=>100
,p_column_identifier=>'M'
,p_column_label=>'Edit Page'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933058207074387095)
,p_db_column_name=>'FOR_LINK'
,p_display_order=>110
,p_column_identifier=>'N'
,p_column_label=>'For Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(46349610039698759002)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'47246263'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BELONGS_TO:LINK_NAME:LINK_URL:IMPORTANT:UPDATED:CREATED_BY:'
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
 p_id=>wwv_flow_imp.id(48982607614208821638)
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
 p_id=>wwv_flow_imp.id(49846950969241836456)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(48982607614208821638)
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
 p_id=>wwv_flow_imp.id(49846952202747836468)
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
 p_id=>wwv_flow_imp.id(49762297745600785594)
,p_plug_name=>'Configuration'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>185
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40293448261128691779)
,p_plug_name=>'Focus Areas [&P94_FOCUS_AREA_CNT.]'
,p_parent_plug_id=>wwv_flow_imp.id(49762297745600785594)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>70
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40293448405768691781)
,p_plug_name=>'focus area content'
,p_title=>'Focus Areas'
,p_parent_plug_id=>wwv_flow_imp.id(40293448261128691779)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id,',
'       focus_area,',
'       focus_area focus_area_for_link,',
'       decode(active_yn,''Y'',''Yes'',''No'') active,',
'       updated last_update,',
'       display_sequence,',
'       (select count(*) from sp_projects',
'         where initiative_id = a.initiative_id',
'           and focus_area_id = a.id',
'           and duplicate_of_project_id is null',
'           and archived_yn = ''N'') projects,',
'       (select count(*) from sp_projects',
'         where initiative_id = a.initiative_id',
'           and focus_area_id = a.id',
'           and duplicate_of_project_id is null',
'           and archived_yn = ''N''',
'           and pct_complete >= 20 and pct_complete <= 90) in_process_projects,',
'       (select count(*) from sp_projects',
'         where initiative_id = a.initiative_id',
'           and focus_area_id = a.id',
'           and duplicate_of_project_id is null',
'           and archived_yn = ''N''',
'           and pct_complete = 100) complete_projects',
'  from sp_initiative_focus_areas a',
' where initiative_id = :P94_INITIATIVE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Focus Areas'
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
,p_plug_header=>'Only these focus areas will be available to be associated with the &NOMENCLATURE_PROJECTS. added to this &NOMENCLATURE_INITIATIVE..'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(49954354049666454097)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'No Focus Areas'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>13054996184264486328
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354079699454098)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354166616454099)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Focus Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>'!'||wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354565120454102)
,p_db_column_name=>'FOCUS_AREA_FOR_LINK'
,p_display_order=>30
,p_column_identifier=>'E'
,p_column_label=>'Focus Area'
,p_column_link=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:10151:P10151_ID:#ID#'
,p_column_linktext=>'#FOCUS_AREA_FOR_LINK#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354317850454100)
,p_db_column_name=>'ACTIVE'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Active'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354465107454101)
,p_db_column_name=>'LAST_UPDATE'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Last Update'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354908222454106)
,p_db_column_name=>'DISPLAY_SEQUENCE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50799540252606804201)
,p_db_column_name=>'PROJECTS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Total Projects'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52590897111087963397)
,p_db_column_name=>'IN_PROCESS_PROJECTS'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'In Process Projects (20-90% complete)'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52590897263623963398)
,p_db_column_name=>'COMPLETE_PROJECTS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Complete Projects'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(50023275421914037163)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'131239176'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FOCUS_AREA_FOR_LINK:ACTIVE:PROJECTS:LAST_UPDATE:'
,p_sort_column_1=>'DISPLAY_SEQUENCE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(51480013485360943725)
,p_report_id=>wwv_flow_imp.id(50023275421914037163)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'ACTIVE'
,p_operator=>'='
,p_expr=>'Yes'
,p_condition_sql=>'"ACTIVE" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''Yes''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50047297030760743682)
,p_plug_name=>'Approval Workflow [&P94_APPROVAL_TYPE_CNT.]'
,p_parent_plug_id=>wwv_flow_imp.id(49762297745600785594)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>40
,p_location=>null
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49762297901753785596)
,p_plug_name=>'approval type content'
,p_parent_plug_id=>wwv_flow_imp.id(50047297030760743682)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>50
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id,',
'       approval_type,',
'       status,',
'       approval_type_for_link,',
'       created_by,',
'       updated,',
'       approvers,',
'       approvers approvers_for_link,',
'       display_seq',
'  from (',
'select a.ID,',
'       t.approval_type,',
'       case when a.active_yn = ''Y'' then ''Active'' else ''Inactive'' end status,',
'       t.approval_type approval_type_for_link,',
'       lower(a.CREATED_BY) created_by,',
'       a.UPDATED,',
'       nvl((select listagg(case when c.alternate_team_member_id is not null and   ',
'                                    (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                                    (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'                                then ''Alternate - ''||',
'                                     (select first_name||'' ''||last_name',
'                                        from sp_team_members',
'                                       where id = c.alternate_team_member_id)',
'                                else t.first_name||'' ''||t.last_name',
'                                end ,'', '')',
'                   within group (order by approval_seq)',
'              from sp_initiative_approval_chain c,',
'                   sp_team_members t',
'             where c.initiative_approval_id = a.id',
'               and c.team_member_id = t.id',
'               and c.active_yn = ''Y''',
'              group by c.initiative_approval_id),''None Yet'') approvers,',
'       t.display_seq',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id',
'   and t.active_yn = ''Y''',
'   and a.initiative_id = :P94_INITIATIVE_ID',
')',
' order by approval_type'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
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
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(50047295782067743670)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'No Approval Types'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>13147937916665775901
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047295877306743671)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047296043388743672)
,p_db_column_name=>'APPROVAL_TYPE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Approval Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>'!'||wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50133922823175657100)
,p_db_column_name=>'APPROVAL_TYPE_FOR_LINK'
,p_display_order=>30
,p_column_identifier=>'I'
,p_column_label=>'Approval Type'
,p_column_link=>'f?p=&APP_ID.:4013:&SESSION.::&DEBUG.:4013:P4013_ID:#ID#'
,p_column_linktext=>'#APPROVAL_TYPE_FOR_LINK#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047296554772743677)
,p_db_column_name=>'STATUS'
,p_display_order=>40
,p_column_identifier=>'G'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047296390515743676)
,p_db_column_name=>'APPROVERS'
,p_display_order=>50
,p_column_identifier=>'F'
,p_column_label=>'Approvers'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>'!'||wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50133922670213657099)
,p_db_column_name=>'APPROVERS_FOR_LINK'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'Approvers'
,p_column_link=>'f?p=&APP_ID.:4016:&SESSION.::&DEBUG.:4016:P4016_INITIATIVE_APPROVAL_ID:#ID#'
,p_column_linktext=>'#APPROVERS_FOR_LINK#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047296217820743674)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>70
,p_column_identifier=>'D'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50047296288546743675)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'E'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53088317993852007011)
,p_db_column_name=>'DISPLAY_SEQ'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(50047330323957747808)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'131479725'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'APPROVAL_TYPE_FOR_LINK:APPROVAL_TYPE:STATUS:APPROVERS_FOR_LINK:APPROVERS:CREATED_BY:UPDATED:'
,p_sort_column_1=>'DISPLAY_SEQ'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
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
 p_id=>wwv_flow_imp.id(54742468767242190933)
,p_plug_name=>'Default Completeness Scale [&P94_STATUS_SCALE.]'
,p_parent_plug_id=>wwv_flow_imp.id(49762297745600785594)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>20
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(53086728100251817239)
,p_name=>'Status Scale content'
,p_parent_plug_id=>wwv_flow_imp.id(54742468767242190933)
,p_template=>4072358936313175081
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''0%'' pct_complete, pc0_label project_status, pc0_desc description, :P94_STATUS_SCALE selected_scale,',
'       0 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''10%'' pct_complete, pc10_label, pc10_desc, :P94_STATUS_SCALE selected_scale,',
'       10 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''20%'' pct_complete, pc20_label, pc20_desc, :P94_STATUS_SCALE selected_scale,',
'       20 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''30%'' pct_complete, pc30_label, pc30_desc, :P94_STATUS_SCALE selected_scale,',
'       30 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''40%'' pct_complete, pc40_label, pc40_desc, :P94_STATUS_SCALE selected_scale,',
'       40 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''50%'' pct_complete, pc50_label, pc50_desc, :P94_STATUS_SCALE selected_scale,',
'       50 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''60%'' pct_complete, pc60_label, pc60_desc, :P94_STATUS_SCALE selected_scale,',
'       60 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''70%'' pct_complete, pc70_label, pc70_desc, :P94_STATUS_SCALE selected_scale,',
'       70 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''80%'' pct_complete, pc80_label, pc80_desc, :P94_STATUS_SCALE selected_scale,',
'       80 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''90%'' pct_complete, pc90_label, pc90_desc, :P94_STATUS_SCALE selected_scale,',
'       90 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'union all',
'select ''100%'' pct_complete, pc100_label, pc100_desc, :P94_STATUS_SCALE selected_scale,',
'       100 r',
'  from SP_PROJECT_SCALES s',
' where scale_letter = nvl(:P94_STATUS_SCALE_LETTER,''A'')',
'order by r'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P94_STATUS_SCALE_LETTER,P94_STATUS_SCALE'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49939288155617384636)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Completeness'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49939288516504384637)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49939288928577384637)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>60
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49939289295438384638)
,p_query_column_id=>4
,p_column_alias=>'SELECTED_SCALE'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49939289702262384638)
,p_query_column_id=>5
,p_column_alias=>'R'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55059015799205694807)
,p_plug_name=>'Default Tasks [&P94_DEFAULT_TASK_CNT.]'
,p_parent_plug_id=>wwv_flow_imp.id(49762297745600785594)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>30
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55177378708922247805)
,p_name=>'task content'
,p_title=>'Default Tasks'
,p_parent_plug_id=>wwv_flow_imp.id(55059015799205694807)
,p_template=>4501440665235496320
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case when t.parent_type_id is not null',
'            then t2.task_type||'': ''',
'            end ||',
'           t.task_type task',
'  from sp_task_types t,',
'       sp_task_types t2,',
'       sp_initiative_default_tasks i',
' where t.parent_type_id = t2.id (+)',
'   and t.id = i.type_id',
'   and t.include_yn = ''Y''',
'   and i.initiative_id = :P94_INITIATIVE_ID',
' order by nvl(t2.display_seq,t.display_seq), t.display_seq nulls first'))
,p_header=>'These tasks will be pre-created for all &NOMENCLATURE_PROJECTS. added to this &NOMENCLATURE_INITIATIVE..'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>1000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'ROWS_X_TO_Y'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177378831988247806)
,p_query_column_id=>1
,p_column_alias=>'TASK'
,p_column_display_sequence=>10
,p_column_heading=>'Task'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(49954352924695454086)
,p_plug_name=>'Focus Areas'
,p_title=>'Focus Areas'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>135
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id,',
'       focus_area,',
'       description,',
'       (select first_name||'' ''||last_name',
'          from sp_team_members',
'         where a.development_owner_id = id) owner,',
'       display_sequence,',
'       (select count(*) from sp_projects where focus_area_id = a.id) cnt,',
'       greatest(a.updated,nvl((select max(updated) from sp_projects where focus_area_id = a.id),a.updated)) last_update',
'  from sp_initiative_focus_areas a',
' where initiative_id = :P94_INITIATIVE_ID',
'   and active_yn = ''Y'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Focus Areas'
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
 p_id=>wwv_flow_imp.id(49954352969527454087)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Focus Areas not set for this &NOMENCLATURE_INITIATIVE..  These are set by an Administrator of this application.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>13054995104125486318
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954353103999454088)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Focus Area'
,p_column_link=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:33:P33_INIT_FOCUS_AREA_ID:#ID#'
,p_column_linktext=>'#FOCUS_AREA#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954353264149454089)
,p_db_column_name=>'CNT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'&NOMENCLATURE_PROJECT. Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954353326348454090)
,p_db_column_name=>'LAST_UPDATE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954353395899454091)
,p_db_column_name=>'ID'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354575532454103)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354746729454104)
,p_db_column_name=>'OWNER'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(49954354843643454105)
,p_db_column_name=>'DISPLAY_SEQUENCE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(50023274399710037136)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'131239166'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FOCUS_AREA:OWNER:CNT:LAST_UPDATE:'
,p_sort_column_1=>'DISPLAY_SEQUENCE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
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
 p_id=>wwv_flow_imp.id(52590895824095963384)
,p_plug_name=>'This Week'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>155
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51905692825789848905)
,p_plug_name=>'This Week Content'
,p_title=>'This Week'
,p_parent_plug_id=>wwv_flow_imp.id(52590895824095963384)
,p_icon_css_classes=>'fa-check-circle-o'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>145
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with d as (select trunc(sysdate,''IW'') monday, trunc(sysdate) today, to_char(sysdate,''YYYY'') year from dual)',
'select p.id project_id, ',
'       p.project, ',
'       t.id task_id,',
'       tt.task_type||'': ''||tt2.task_type task_type, ',
'       tm.first_name||'' ''||tm.last_name task_owner,',
'       tm.photo, tm.photo_filename, tm.photo_mimetype, tm.photo_lastupd,',
'       s.status,',
'       case when to_char(t.target_complete,''YYYY'') != d.year ',
'            then to_char(t.target_complete,''Mon DDfm, YYYY'')',
'            else to_char(t.target_complete, ''Mon DDfm'')',
'            end target_complete,',
'       case when s.indicates_complete_yn = ''N'' and t.target_complete < d.today then ''Overdue''',
'            when s.indicates_complete_yn = ''N'' and trunc(t.target_complete) >= d.today then ''Pending''',
'            else ''Complete''',
'            end icon,',
'       case when s.indicates_complete_yn = ''N'' and t.target_complete < d.today then ''danger''',
'            when s.indicates_complete_yn = ''N'' and trunc(t.target_complete) >= d.today then ''warning''',
'            else ''success''',
'            end icon_class,',
'       case when s.indicates_complete_yn = ''N'' then ''notdone'' else null end notdone_ind',
'  from sp_projects p,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_task_types tt2,',
'       sp_team_members tm,',
'       sp_task_statuses s,',
'       d',
' where p.id = t.project_id',
'   and p.archived_yn != ''Y''',
'   and p.duplicate_of_project_id is null',
'   and t.task_type_id = tt.id',
'   and tt.static_id in (''MILESTONE'', ''REVIEW'')',
'   and (:P94_THIS_WEEK_type = ''ALL'' or :P94_THIS_WEEK_type = tt.static_id)',
'   and t.task_sub_type_id = tt2.id',
'   and t.owner_id = tm.id (+)',
'   and (trunc(t.target_complete) between d.monday and d.monday+6 or',
'         (t.target_complete < d.monday and s.indicates_complete_yn = ''N'')) -- to get overdue',
'   and p.initiative_id = :P94_INITIATIVE_ID',
'   and t.status_id = s.id',
'   and (:P94_THIS_WEEK_EXCLUDE is null or ',
'        (((instr(:P94_THIS_WEEK_EXCLUDE,''COMPLETE'') > 0 and s.indicates_complete_yn = ''N'') or instr(:P94_THIS_WEEK_EXCLUDE,''COMPLETE'') = 0) and',
'         ((instr(:P94_THIS_WEEK_EXCLUDE,''PREVIOUS'') > 0 and t.target_complete > d.monday) or instr(:P94_THIS_WEEK_EXCLUDE,''PREVIOUS'') = 0)) )'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'target_complete'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID,P94_THIS_WEEK_TYPE,P94_THIS_WEEK_EXCLUDE'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'AVATAR_IMAGE', '{"source":"BLOB_COLUMN","blobColumn":"PHOTO","filenameColumn":"PHOTO_FILENAME","mimeTypeColumn":"PHOTO_MIMETYPE","lastUpdatedColumn":"PHOTO_LASTUPD"}',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'image',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', '&ICON.',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_SHAPE', 't-Badge--rounded',
  'BADGE_STATE', 'ICON_CLASS',
  'BADGE_VALUE', 'ICON',
  'DESCRIPTION', '&TASK_OWNER.',
  'DISPLAY_AVATAR', 'Y',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    '&STATUS.<br/>',
    '{if NOTDONE_IND/}due {endif/}&TARGET_COMPLETE.')),
  'OVERLINE', '&PROJECT.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&TASK_TYPE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590894500099963371)
,p_name=>'PROJECT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590894578416963372)
,p_name=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590894670150963373)
,p_name=>'TASK_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590894821703963374)
,p_name=>'TASK_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590894926082963375)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590895036322963376)
,p_name=>'TARGET_COMPLETE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TARGET_COMPLETE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590895124529963377)
,p_name=>'ICON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896124039963387)
,p_name=>'PHOTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO'
,p_data_type=>'BLOB'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896215281963388)
,p_name=>'PHOTO_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896342931963389)
,p_name=>'TASK_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896481996963391)
,p_name=>'PHOTO_FILENAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO_FILENAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896582941963392)
,p_name=>'PHOTO_LASTUPD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PHOTO_LASTUPD'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896752419963393)
,p_name=>'NOTDONE_IND'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOTDONE_IND'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>130
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52590896855278963394)
,p_name=>'ICON_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ICON_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(58034539737288833304)
,p_name=>'Additional Attriubtes'
,p_template=>4501440665235496320
,p_display_sequence=>180
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'REGION_POSITION_05'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select lower(i.created_by) created_by,',
'       i.created,',
'       lower(i.updated_by) last_updated_by,',
'       i.updated',
'  from SP_INITIATIVES i',
'where i.id = :P94_INITIATIVE_ID',
'',
'     '))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
,p_lazy_loading=>false
,p_query_row_template=>2115772683903439354
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46689376312846387767)
,p_query_column_id=>1
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>10
,p_column_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46689376746696387768)
,p_query_column_id=>2
,p_column_alias=>'CREATED'
,p_column_display_sequence=>20
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46689375950764387766)
,p_query_column_id=>3
,p_column_alias=>'LAST_UPDATED_BY'
,p_column_display_sequence=>30
,p_column_heading=>'Last Updated By'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46689377141953387768)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>40
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(155646708834508872042)
,p_name=>'Comments'
,p_region_name=>'COMMENTS'
,p_template=>4501440665235496320
,p_display_sequence=>110
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
'                 p_url => ''f?p=''||:APP_ID||'':87:''||:APP_SESSION||''::NO:87:P87_ID:''||ic.id,',
'                 p_checksum_type => ''3''',
'                 )||''">edit</a>'' ',
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
'  from sp_initiative_comments_v ic, ',
'       sp_team_members tm',
'where ic.author_id = tm.id and',
'      ic.initiative_id = :P94_INITIATIVE_ID and  ',
'      (nvl(ic.private_yn,''N'') = ''N'' or lower(ic.created_by) = lower(:app_user) )',
'order by ic.created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(41596697566087181248)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596490396822181241)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178318895726483256)
,p_query_column_id=>3
,p_column_alias=>'DATE_FULL'
,p_column_display_sequence=>270
,p_column_heading=>'Date Full'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596490786279181242)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_column_html_expression=>'<span title="added #DATE_FULL#">#CREATED#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596491228511181243)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596491637468181243)
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
 p_id=>wwv_flow_imp.id(41596491986053181244)
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
 p_id=>wwv_flow_imp.id(41596692415204181244)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596692812479181245)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596693246704181245)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596693604616181245)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596694009162181246)
,p_query_column_id=>12
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41702542952065774102)
,p_query_column_id=>13
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>260
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596694367884181246)
,p_query_column_id=>14
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596694844944181246)
,p_query_column_id=>15
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596695211246181247)
,p_query_column_id=>16
,p_column_alias=>'AUTHOR_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Author Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596695612275181247)
,p_query_column_id=>17
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596696021499181247)
,p_query_column_id=>18
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596696456331181247)
,p_query_column_id=>19
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596696803425181248)
,p_query_column_id=>20
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41596697173132181248)
,p_query_column_id=>21
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(167433884371348323955)
,p_plug_name=>'Documents'
,p_region_name=>'DOCUMENTS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>175
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case doc_type ',
'            when ''Initiative''',
'            then :NOMENCLATURE_INITIATIVE ',
'            when ''Initiative Focus Area''',
'            then :NOMENCLATURE_INITIATIVE||'' Focus Area''',
'            end type,',
'       case doc_type',
'            when ''Initiative''',
'            then ''13'' ',
'            else ''56''',
'            end edit_page, ',
'       case doc_type',
'            when ''Initiative''',
'            then ''53''',
'            else ''59''',
'            end display_page,',
'       document_id ID,',
'       DOCUMENT_FILENAME,',
'       UPDATED,',
'       created,',
'       doc_description,',
'       tags,',
'       added_by created_by,',
'       filesize doc_size,',
'       created date_created,',
'       file_extension,',
'       important,',
'       filesize document,',
'       document_id',
'  from SP_DOCUMENTS_V',
' where initiative_id = :P94_INITIATIVE_ID',
'   and doc_type in (''Initiative'', ''Initiative Focus Area'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P94_INITIATIVE_ID'
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
 p_id=>wwv_flow_imp.id(53742498183013619279)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:#EDIT_PAGE#:P#EDIT_PAGE#_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_detail_link_auth_scheme=>wwv_flow_imp.id(176222234113670897793)
,p_owner=>'MIKE'
,p_internal_uid=>16843140317611651510
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53742498284177619280)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933057543858387088)
,p_db_column_name=>'TYPE'
,p_display_order=>20
,p_column_identifier=>'O'
,p_column_label=>'Belongs to'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'EXISTS'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_INIT_FOCUS_AREA_DOCUMENTS d,',
'       SP_INITIATIVE_FOCUS_AREAS fa',
' where fa.initiative_id = :P94_INITIATIVE_ID',
'   and fa.id = d.init_focus_area_id'))
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53742498416568619281)
,p_db_column_name=>'DOCUMENT_FILENAME'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Filename'
,p_column_link=>'f?p=&APP_ID.:#DISPLAY_PAGE#:&SESSION.::&DEBUG.:#DISPLAY_PAGE#:P#DISPLAY_PAGE#_ID,P#DISPLAY_PAGE#_PREV_PAGE:#ID#,94'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53742498841369619285)
,p_db_column_name=>'DOC_DESCRIPTION'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53742499046898619287)
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
 p_id=>wwv_flow_imp.id(53742498593532619283)
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
 p_id=>wwv_flow_imp.id(53742498669375619284)
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
 p_id=>wwv_flow_imp.id(53742499063936619288)
,p_db_column_name=>'DATE_CREATED'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Created On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(54179353254682468067)
,p_db_column_name=>'FILE_EXTENSION'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'File Extension'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(64839036958623016870)
,p_db_column_name=>'TAGS'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(51825532970882349314)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(52935080810292546774)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Added By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933057607929387089)
,p_db_column_name=>'EDIT_PAGE'
,p_display_order=>140
,p_column_identifier=>'P'
,p_column_label=>'Edit Page'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53933057747617387090)
,p_db_column_name=>'DISPLAY_PAGE'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Display Page'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014891386900880777)
,p_db_column_name=>'DOCUMENT'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Document'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DOWNLOAD:SP_DOCUMENTS_V:DOCUMENT_BLOB:DOCUMENT_ID::DOCUMENT_MIMETYPE:DOCUMENT_FILENAME:DOCUMENT_LASTUPD:DOCUMENT_LASTUPD:attachment::'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014891578543880778)
,p_db_column_name=>'DOCUMENT_ID'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Document Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(53744234417817212050)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8109551'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE:DOCUMENT_FILENAME:DOC_DESCRIPTION:CREATED_BY:IMPORTANT:DOCUMENT:DOC_SIZE:UPDATED:'
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
 p_id=>wwv_flow_imp.id(41596697987835181249)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(155646708834508872042)
,p_button_name=>'POST_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Post Comment'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'u-flex u-align-items-center margin-bottom-md'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41624987021823227220)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(46347225677624712493)
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
 p_id=>wwv_flow_imp.id(40293451630847691813)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40293448261128691779)
,p_button_name=>'add_focus_area'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Add Focus Area'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:10151:P10151_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49762298828434785605)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(50047297030760743682)
,p_button_name=>'ADD_APPROVAL_TYPE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Associated New Type'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:4013:&SESSION.::&DEBUG.:4013:P4013_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1  ',
'  from sp_approval_types',
' where id not in (select approval_type_id',
'                    from sp_initiative_approvals',
'                   where initiative_id = :P94_INITIATIVE_ID)',
'   and active_yn = ''Y'''))
,p_button_condition_type=>'EXISTS'
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55177375645509247774)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(55059015799205694807)
,p_button_name=>'edit_tasks'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Edit Default Tasks'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:95:&SESSION.::&DEBUG.:RR,95:P95_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(49762298884972785606)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(54742468767242190933)
,p_button_name=>'edit_default_project_type'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Select Different Completeness Scale'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:127:&SESSION.::&DEBUG.:RR,127:P127_ID:&P94_INITIATIVE_ID.'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41625764404870177285)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(41621602072957453097)
,p_button_name=>'add_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Activity'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_INITIATIVE_ID,P101_TEAM_MEMBER_ID:&P94_INITIATIVE_ID.,&APP_USER_ID.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52933283254648269264)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(167433884371348323955)
,p_button_name=>'view_images'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Image Gallery'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:62:&SESSION.::&DEBUG.:62:P62_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'  from SP_INITIATIVE_DOCUMENTS d',
' where initiative_id = :P94_INITIATIVE_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )',
'union all',
'select 1 ',
'  from SP_INIT_focus_area_DOCUMENTS d,',
'       SP_INITIATIVE_FOCUS_AREAS f',
'   where f.initiative_id = :P94_INITIATIVE_ID and ',
'         f.id = d.init_focus_area_id and',
'       (',
'           lower(d.DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.ai'' ',
'       )'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41702541940542774092)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(41565408815667002101)
,p_button_name=>'Add_project'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Project'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52933283641514269265)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(167433884371348323955)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Document'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RR,13:P13_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41564221218508815870)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(48982607614208821638)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:66:&SESSION.::&DEBUG.:RP,:P66_AREA_ID:&P94_AREA_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18555558707128440174)
,p_name=>'P94_MIN_PC_FOR_STATUS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(54742468767242190933)
,p_prompt=>'Minimum % Complete for Status'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21722865365635623551)
,p_name=>'P94_IMAGE_REF_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(155646708834508872042)
,p_item_default=>'to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41376455070247866292)
,p_name=>'P94_INITIATIVE_ID'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41376455244792866293)
,p_name=>'P94_AREA_ID'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41376455289349866294)
,p_name=>'P94_INITIATIVE'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41376455826415866299)
,p_name=>'P94_AREA'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41702542826152774101)
,p_name=>'P94_PRIVATE_YN'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(155646708834508872042)
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
 p_id=>wwv_flow_imp.id(46347230618836712539)
,p_name=>'P94_LINK'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(46347225677624712493)
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
 p_id=>wwv_flow_imp.id(46347231019967712543)
,p_name=>'P94_LINK_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(46347225677624712493)
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49762300109571785618)
,p_name=>'P94_FOCUS_AREA_CNT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(44252253978621161489)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49954351344044454070)
,p_name=>'P94_DEFAULT_TASK_CNT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(44252253978621161489)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49954351464604454071)
,p_name=>'P94_APPROVAL_TYPE_CNT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(44252253978621161489)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(49954352319788454080)
,p_name=>'P94_STATUS_SCALE_LETTER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(54742468767242190933)
,p_item_default=>'A'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52590895168838963378)
,p_name=>'P94_THIS_WEEK_TYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(52590895824095963384)
,p_item_default=>'ALL'
,p_prompt=>'Type'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:All;ALL,Milestones;MILESTONE,Reviews;REVIEW'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '3',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52590895495917963381)
,p_name=>'P94_THIS_WEEK_EXCLUDE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(52590895824095963384)
,p_prompt=>'Exclude'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC2:Complete;COMPLETE,Prior Weeks Overdue;PREVIOUS'
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(53086729998889817259)
,p_name=>'P94_STATUS_SCALE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(54742468767242190933)
,p_item_default=>'A'
,p_prompt=>'Default Completeness Scale'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083679294152389379)
,p_name=>'IFI'
,p_item_sequence=>50
,p_display_as=>'NATIVE_HIDDEN'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083679437729389380)
,p_name=>'INN'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55083679511517389381)
,p_name=>'P94_PERMALINK_PREFIX'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(164217827182291129269)
,p_name=>'P94_COMMENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(155646708834508872042)
,p_prompt=>' '
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
'                imageRefId: apex.item(''P94_IMAGE_REF_ID'').getValue()',
'            }',
'        }',
'    });',
'}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'Y',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49954351489302454072)
,p_computation_sequence=>10
,p_computation_item=>'P94_FOCUS_AREA_CNT'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_initiative_focus_areas a',
' where initiative_id = :P94_INITIATIVE_ID',
'   and active_yn = ''Y'''))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49954351853949454075)
,p_computation_sequence=>20
,p_computation_item=>'P94_DEFAULT_TASK_CNT'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_task_types t,',
'       sp_task_types t2,',
'       sp_initiative_default_tasks i',
' where t.parent_type_id = t2.id (+)',
'   and t.id = i.type_id',
'   and t.include_yn = ''Y''',
'   and i.initiative_id = :P94_INITIATIVE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49954352126366454078)
,p_computation_sequence=>30
,p_computation_item=>'P94_APPROVAL_TYPE_CNT'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id',
'   and a.initiative_id = :P94_INITIATIVE_ID',
'   and a.active_yn = ''Y'''))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49762297785474785595)
,p_computation_sequence=>40
,p_computation_item=>'P94_STATUS_SCALE'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.scale_name',
'  from sp_initiatives i,',
'       sp_project_scales s',
' where i.id = :P94_INITIATIVE_ID',
'   and i.status_scale = s.scale_letter'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(18555558871902440175)
,p_computation_sequence=>50
,p_computation_item=>'P94_MIN_PC_FOR_STATUS'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.min_pc_for_status||''%''',
'  from sp_initiatives i,',
'       sp_project_scales s',
' where i.id = :P94_INITIATIVE_ID',
'   and i.status_scale = s.scale_letter'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(49954352388857454081)
,p_computation_sequence=>60
,p_computation_item=>'P94_STATUS_SCALE_LETTER'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select status_scale',
'  from sp_initiatives',
' where id = :P94_INITIATIVE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38144216041097090861)
,p_computation_sequence=>10
,p_computation_item=>'P94_INITIATIVE_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return sp_util.get_initiative_id (',
'    p_friendly_identifier => :IFI,',
'    p_initiative_url_name => :INN);'))
,p_compute_when=>'P94_INITIATIVE_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41376455366087866295)
,p_computation_sequence=>20
,p_computation_item=>'P94_INITIATIVE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select INITIATIVE',
'from   sp_initiatives i',
'where  id = :P94_INITIATIVE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41376455493410866296)
,p_computation_sequence=>30
,p_computation_item=>'P94_AREA_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select area_id',
'from   sp_initiatives i',
'where  id = :P94_INITIATIVE_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41376455964149866300)
,p_computation_sequence=>40
,p_computation_item=>'P94_AREA'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select area ',
'from sp_areas a  ',
'where a.id = (',
'    select area_id',
'    from   sp_initiatives i',
'    where  id = :P94_INITIATIVE_ID)'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(55083679636802389382)
,p_computation_sequence=>50
,p_computation_item=>'P94_PERMALINK_PREFIX'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>'return APEX_UTIL.HOST_URL(''SCRIPT'') || ''initiative?ifi='';'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(41597147258200379783)
,p_computation_sequence=>60
,p_computation_item=>'LAST_PROJECT_VIEW'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'94'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41565406837847002081)
,p_name=>'post comment'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41596697987835181249)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722865601112623554)
,p_event_id=>wwv_flow_imp.id(41565406837847002081)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(41596697987835181249)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41565406930765002082)
,p_event_id=>wwv_flow_imp.id(41565406837847002081)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sp_comment_util.add_initiative_comment (',
'    p_app_user_id   => :APP_USER_ID,',
'    p_comment       => :P94_COMMENT,',
'    p_private_yn    => nvl(:P94_PRIVATE_YN,''N''),',
'    p_initiative_id => :P94_INITIATIVE_ID,',
'    p_image_ref_id  => :P94_IMAGE_REF_ID );',
':P94_COMMENT := null;',
':P94_PRIVATE_YN := null;',
':P94_IMAGE_REF_ID := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');'))
,p_attribute_02=>'P94_INITIATIVE_ID,P94_COMMENT,APP_USER_ID,P94_PRIVATE_YN,P94_IMAGE_REF_ID'
,p_attribute_03=>'P94_COMMENT,P94_IMAGE_REF_ID'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41565407060582002083)
,p_event_id=>wwv_flow_imp.id(41565406837847002081)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155646708834508872042)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722865869111623556)
,p_event_id=>wwv_flow_imp.id(41565406837847002081)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.ariaAlertMessage("Comment Added Successfully");'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21722865756766623555)
,p_event_id=>wwv_flow_imp.id(41565406837847002081)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(41596697987835181249)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41565407870288002092)
,p_name=>'on comments dialog closed'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(155646708834508872042)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41565408020207002093)
,p_event_id=>wwv_flow_imp.id(41565407870288002092)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(155646708834508872042)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41702540284221774076)
,p_event_id=>wwv_flow_imp.id(41565407870288002092)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(73043048861304498649)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41621601766620453094)
,p_name=>'add initiative link'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41624987021823227220)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51825529482339349279)
,p_event_id=>wwv_flow_imp.id(41621601766620453094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Please supply a Link URL and a Link Name.'
,p_attribute_02=>'Missing Link Details'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v(''P94_LINK'') === '''' || $v(''P94_LINK_NAME'') === '''''
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41621601937321453095)
,p_event_id=>wwv_flow_imp.id(41621601766620453094)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P94_LINK_NAME is not null and :P94_LINK is not null then',
'insert into SP_INITIATIVE_LINKS (',
'    initiative_id, link_name, link_url)',
'values (',
'    :P94_INITIATIVE_ID, :P94_LINK_NAME, :P94_LINK);',
':P94_LINK_NAME := null;',
':P94_LINK := null;',
'end if;'))
,p_attribute_02=>'P94_INITIATIVE_ID,P94_LINK_NAME,P94_LINK'
,p_attribute_03=>'P94_LINK_NAME,P94_LINK'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41621601972295453096)
,p_event_id=>wwv_flow_imp.id(41621601766620453094)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46347225677624712493)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41702540522347774078)
,p_event_id=>wwv_flow_imp.id(41621601766620453094)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(73043048861304498649)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41625764662717177287)
,p_name=>'refresh on activity dc'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(41621602072957453097)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41625764729541177288)
,p_event_id=>wwv_flow_imp.id(41625764662717177287)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(41621602072957453097)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(51825532702412349311)
,p_name=>'refresh on documents'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(167433884371348323955)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(51825532786451349312)
,p_event_id=>wwv_flow_imp.id(51825532702412349311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(167433884371348323955)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41628126160139336397)
,p_name=>'contextual info dialog close refresh'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(48982607614208821638)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41628126187913336398)
,p_event_id=>wwv_flow_imp.id(41628126160139336397)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(73043048861304498649)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41702540590365774079)
,p_name=>'on links region dc'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(46347225677624712493)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41702540690722774080)
,p_event_id=>wwv_flow_imp.id(41702540590365774079)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(73043048861304498649)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41702540787800774081)
,p_event_id=>wwv_flow_imp.id(41702540590365774079)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(46347225677624712493)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41702541968673774093)
,p_name=>'projects tab refresh on dialog closed'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(41565408815667002101)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41702542094795774094)
,p_event_id=>wwv_flow_imp.id(41702541968673774093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(41565408815667002101)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40293451683878691814)
,p_name=>'refresh on focus areas'
,p_event_sequence=>200
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40293448261128691779)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954351681800454074)
,p_event_id=>wwv_flow_imp.id(40293451683878691814)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_FOCUS_AREA_CNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_initiative_focus_areas a',
' where initiative_id = :P94_INITIATIVE_ID',
'   and active_yn = ''Y''',
''))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40293451825861691815)
,p_event_id=>wwv_flow_imp.id(40293451683878691814)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40293448261128691779)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954351585579454073)
,p_event_id=>wwv_flow_imp.id(40293451683878691814)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40293448405768691781)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50047296568669743678)
,p_name=>'refresh on focus area content'
,p_event_sequence=>210
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40293448405768691781)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
,p_security_scheme=>wwv_flow_imp.id(176222233957385897793)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047296726378743679)
,p_event_id=>wwv_flow_imp.id(50047296568669743678)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_FOCUS_AREA_CNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_initiative_focus_areas a',
' where initiative_id = :P94_INITIATIVE_ID',
'   and active_yn = ''Y''',
''))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047296856631743680)
,p_event_id=>wwv_flow_imp.id(50047296568669743678)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40293448261128691779)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047296896149743681)
,p_event_id=>wwv_flow_imp.id(50047296568669743678)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40293448405768691781)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49762299341587785610)
,p_name=>'After Approval Type action'
,p_event_sequence=>220
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(50047297030760743682)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954352200842454079)
,p_event_id=>wwv_flow_imp.id(49762299341587785610)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_APPROVAL_TYPE_CNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id',
'   and a.initiative_id = :P94_INITIATIVE_ID',
'   and a.active_yn = ''Y'''))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762299435202785611)
,p_event_id=>wwv_flow_imp.id(49762299341587785610)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(50047297030760743682)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047297391860743686)
,p_event_id=>wwv_flow_imp.id(49762299341587785610)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(49762297901753785596)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50047297135661743683)
,p_name=>'After Approval Type content change'
,p_event_sequence=>230
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(49762297901753785596)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047297178208743684)
,p_event_id=>wwv_flow_imp.id(50047297135661743683)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_APPROVAL_TYPE_CNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from SP_INITIATIVE_APPROVALS a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.initiative_id = i.id',
'   and a.approval_type_id = t.id',
'   and a.initiative_id = :P94_INITIATIVE_ID',
'   and a.active_yn = ''Y'''))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047297326612743685)
,p_event_id=>wwv_flow_imp.id(50047297135661743683)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(50047297030760743682)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50047297523646743687)
,p_event_id=>wwv_flow_imp.id(50047297135661743683)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(49762297901753785596)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49762299488198785612)
,p_name=>'After Default Task action'
,p_event_sequence=>240
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(55059015799205694807)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954352028261454077)
,p_event_id=>wwv_flow_imp.id(49762299488198785612)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_DEFAULT_TASK_CNT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from sp_task_types t,',
'       sp_task_types t2,',
'       sp_initiative_default_tasks i',
' where t.parent_type_id = t2.id (+)',
'   and t.id = i.type_id',
'   and t.include_yn = ''Y''',
'   and i.initiative_id = :P94_INITIATIVE_ID',
''))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762299602719785613)
,p_event_id=>wwv_flow_imp.id(49762299488198785612)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55059015799205694807)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954351944652454076)
,p_event_id=>wwv_flow_imp.id(49762299488198785612)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55177378708922247805)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(49762299893687785616)
,p_name=>'after Status Scale change'
,p_event_sequence=>250
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(49762298884972785606)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954352655712454083)
,p_event_id=>wwv_flow_imp.id(49762299893687785616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_STATUS_SCALE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.scale_name',
'  from sp_initiatives i,',
'       sp_project_scales s',
' where i.id = :P94_INITIATIVE_ID',
'   and i.status_scale = s.scale_letter'))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954352553727454082)
,p_event_id=>wwv_flow_imp.id(49762299893687785616)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P94_STATUS_SCALE_LETTER'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select status_scale',
'  from sp_initiatives',
' where id = :P94_INITIATIVE_ID'))
,p_attribute_07=>'P94_INITIATIVE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49762300028802785617)
,p_event_id=>wwv_flow_imp.id(49762299893687785616)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(54742468767242190933)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(49954352679262454084)
,p_event_id=>wwv_flow_imp.id(49762299893687785616)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(53086728100251817239)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(52590895361149963379)
,p_name=>'when change P94_THIS_WEEK_type'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P94_THIS_WEEK_TYPE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(52590895432084963380)
,p_event_id=>wwv_flow_imp.id(52590895361149963379)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51905692825789848905)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(52590895654584963382)
,p_name=>'when change P94_THIS_WEEK_EXCLUDE'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P94_THIS_WEEK_EXCLUDE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(52590895696924963383)
,p_event_id=>wwv_flow_imp.id(52590895654584963382)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(51905692825789848905)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27117239645963764629)
,p_name=>'links in comments in new tab'
,p_event_sequence=>280
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27117239757489764630)
,p_event_id=>wwv_flow_imp.id(27117239645963764629)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(43185952602390630100)
,p_region_id=>wwv_flow_imp.id(49846950969241836456)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:RP,22:P22_ID:&P94_INITIATIVE_ID.'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-edit'
,p_is_hot=>true
,p_show_as_disabled=>false
,p_authorization_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(49846951269820836459)
,p_region_id=>wwv_flow_imp.id(49846950969241836456)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(52590896875241963395)
,p_region_id=>wwv_flow_imp.id(51905692825789848905)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:98:&SESSION.::&DEBUG.:98:P98_TASK_ID,P98_PROJECT_ID:&TASK_ID.,&PROJECT_ID.'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(38033424834073290434)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Kanban'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:4:P4_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-columns'
,p_build_option_id=>wwv_flow_imp.id(48520462122696828334)
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41376455585421866297)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECTS.'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,23:P23_FOCUS_AREA,P23_INITIATIVE,P23_INITIATIVE_ID,P23_FOCUS_AREA_ID:&P94_AREA.,&P94_INITIATIVE.,&P94_INITIATIVE_ID.,&P94_AREA_ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(41376455762379866298)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>80
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(44303603192873324976)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'About &NOMENCLATURE_INITIATIVES.'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:106:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-info'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45704846289032876524)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45704846457649876525)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>40
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(49846951975727836466)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>100
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51065624867245282190)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Milestones Report'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:112:&SESSION.::&DEBUG.:RP,:P112_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-file-text-o'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53811143294993576670)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>60
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(53811143431436576671)
,p_component_action_id=>wwv_flow_imp.id(49846951269820836459)
,p_menu_entry_type=>'ENTRY'
,p_label=>'View History'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:11:P11_INITIATIVE_ID:&P94_INITIATIVE_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp.component_end;
end;
/
