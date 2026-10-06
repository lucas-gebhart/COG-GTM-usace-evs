prompt --application/pages/page_00140
begin
--   Manifest
--     PAGE: 00140
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
 p_id=>140
,p_name=>'Activity Quick Look'
,p_alias=>'ACTIVITY-QUICK-LOOK1'
,p_page_mode=>'MODAL'
,p_step_title=>'Activity Quick Look'
,p_autocomplete_on_off=>'OFF'
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
'}'))
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(40970596320088936040)
,p_name=>'Activity'
,p_template=>4501440665235496320
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ap.ID,',
'       ap.ACTIVITY_TYPE_ID,',
'       (select activity_type from SP_ACTIVITY_TYPES at where at.id = ap.ACTIVITY_TYPE_ID) activity_type,',
'       ap.PROJECT_ID,',
'       nvl((select project from sp_projects p where p.id = ap.project_id),''Non Specified'') project,',
'       ap.TEAM_MEMBER_ID,',
'       decode(tm.first_name,null,tm.email,tm.first_Name||'' ''||tm.last_name||'' (''||tm.email||'')'') name,',
'       trunc(ap.END_DATE) - trunc(ap.START_DATE) activity_length,',
'       to_char(ap.START_DATE,''FMDay DD-MON-YYYY'')|| '' - ''||to_char(ap.END_DATE,''FMDay DD-MON-YYYY'') dates,',
'       decode(',
'           greatest(trunc(sysdate),trunc(ap.end_date)),',
'           trunc(sysdate),',
'           ''Past'',',
'           decode(',
'               greatest(trunc(sysdate),trunc(ap.start_date)),',
'               trunc(sysdate),',
'               ''Current'',',
'               ''Future'')',
'           ) timeframe,',
'       ap.COMMENTS,',
'       ap.COMMENTS comments2,',
'       apex_util.get_since(ap.CREATED) created,',
'       lower(ap.CREATED_BY) CREATED_BY,',
'       apex_util.get_since(ap.UPDATED) updated,',
'       lower(ap.UPDATED_BY) UPDATED_BY,',
'       sp_date_range_pct_comp(ap.start_date, ap.end_date)||''%'' time_elapesed,',
'       ap.URL',
'  from sp_activities ap, ',
'       sp_team_Members tm',
' where ap.id = :P140_ID and',
'       ap.team_member_id = tm.id(+)'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P140_ID'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844734278517994861)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>0
,p_column_heading=>'ID'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_hidden_column=>'Y'
,p_include_in_export=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844734699587994861)
,p_query_column_id=>2
,p_column_alias=>'ACTIVITY_TYPE_ID'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844733553937994860)
,p_query_column_id=>3
,p_column_alias=>'ACTIVITY_TYPE'
,p_column_display_sequence=>42
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844735143675994862)
,p_query_column_id=>4
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>92
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844737878263994865)
,p_query_column_id=>5
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>112
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844735509454994862)
,p_query_column_id=>6
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>102
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844733879252994860)
,p_query_column_id=>7
,p_column_alias=>'NAME'
,p_column_display_sequence=>32
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844738719952994865)
,p_query_column_id=>8
,p_column_alias=>'ACTIVITY_LENGTH'
,p_column_display_sequence=>72
,p_column_heading=>'Activity Length'
,p_column_html_expression=>'#ACTIVITY_LENGTH# Days, #TIME_ELAPESED# elapsed'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844739160815994866)
,p_query_column_id=>9
,p_column_alias=>'DATES'
,p_column_display_sequence=>52
,p_column_heading=>'Dates'
,p_column_html_expression=>'<strong>#TIMEFRAME#</strong>: #DATES#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39820380243429388078)
,p_query_column_id=>10
,p_column_alias=>'TIMEFRAME'
,p_column_display_sequence=>62
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844735913600994862)
,p_query_column_id=>11
,p_column_alias=>'COMMENTS'
,p_column_display_sequence=>12
,p_column_heading=>'Activity'
,p_column_link=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:101:P101_ID:#ID#'
,p_column_linktext=>'#COMMENTS#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_report_column_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(31844052382939784945)
,p_query_column_id=>12
,p_column_alias=>'COMMENTS2'
,p_column_display_sequence=>22
,p_column_heading=>'Comments'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_report_column_required_role=>'!'||wwv_flow_imp.id(176222234113670897793)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844736361111994863)
,p_query_column_id=>13
,p_column_alias=>'CREATED'
,p_column_display_sequence=>132
,p_column_heading=>'Created'
,p_column_html_expression=>'#CREATED# by #CREATED_BY#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844736667736994863)
,p_query_column_id=>14
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>142
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844737157297994864)
,p_query_column_id=>15
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>152
,p_column_heading=>'Updated'
,p_column_html_expression=>'#UPDATED# by #UPDATED_BY#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844737486619994864)
,p_query_column_id=>16
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>162
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844738350044994865)
,p_query_column_id=>17
,p_column_alias=>'TIME_ELAPESED'
,p_column_display_sequence=>82
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39820381141676388087)
,p_query_column_id=>18
,p_column_alias=>'URL'
,p_column_display_sequence=>122
,p_column_heading=>'URL'
,p_column_link=>'#URL#'
,p_column_linktext=>'#URL#'
,p_column_link_attr=>'target="_blank" title="open link in new browser tab"'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'from SP_ACTIVITIES',
'where id = :P140_ID and URL is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(42368149600574953877)
,p_name=>'Associated &NOMENCLATURE_INITIATIVE.'
,p_template=>2664334895415463485
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.ID initiative_id,',
'       f.area,',
'       i.initiative initiative,',
'       nvl((select t.first_name||'' ''||t.last_name from sp_team_members t where t.id = i.SPONSOR_ID),''No Owner'') initiative_owner,',
'       i.OBJECTIVE description',
'from ',
'       SP_INITIATIVES i,',
'       SP_AREAS f,',
'       sp_activities a',
'where ',
'      a.id = :P140_ID and',
'      i.area_id = f.id and',
'      i.id = a.initiative_id and ',
'      a.initiative_id is not null'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from SP_ACTIVITIES a',
'where a.id = :P140_ID and a.initiative_id is not null'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P140_ID'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No &NOMENCLATURE_PROJECT. found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368152170673953903)
,p_query_column_id=>1
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368149882862953880)
,p_query_column_id=>2
,p_column_alias=>'AREA'
,p_column_display_sequence=>20
,p_column_heading=>'&NOMENCLATURE_INITIATIVE. &NOMENCLATURE_AREA.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368149992241953881)
,p_query_column_id=>3
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>10
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_column_link=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP,94:P94_INITIATIVE_ID:#INITIATIVE_ID#'
,p_column_linktext=>'#INITIATIVE#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368152361529953904)
,p_query_column_id=>4
,p_column_alias=>'INITIATIVE_OWNER'
,p_column_display_sequence=>50
,p_column_heading=>' &NOMENCLATURE_INITIATIVE. Owner'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368152378504953905)
,p_query_column_id=>5
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>60
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(46695543732700663218)
,p_name=>'Associated &NOMENCLATURE_PROJECT.'
,p_template=>2664334895415463485
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       f.area,',
'       i.initiative initiative,',
'       nvl((select t.first_name||'' ''||t.last_name from sp_team_members t where t.id = p.OWNER_ID),''No Owner'') the_owner,',
'       p.owner_id,',
'       p.project,',
'       --',
'       nvl((select ''<span class="fa fa-heart u-danger-text" aria-hidden="true"></span>'' ',
'            from sp_favorites fav',
'            where fav.project_id = p.id and ',
'                  fav.team_member_id = :APP_USER_ID),',
'            ''<span class="fa fa-heart-o" aria-hidden="true"></span>'') favorite_icon,',
'       --',
'       p.PCT_COMPLETE||''%'' PCT_COMPLETE,',
'       nvl((select ''P''||priority from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'') priority,',
'       null attributes,',
'       --',
'       -- optional release association',
'       --',
'       (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id) release,',
'       --',
'       -- optional project targeted date',
'       --',
'       nvl(to_char(p.target_complete,''DD-Mon-YYYY''),''No Target'') targeted_date,',
'       --',
'       --',
'       --',
'       lower(p.TAGS) tags,',
'       lower(p.CREATED_BY)||'' ''||apex_util.get_since(p.CREATED) created,',
'       lower(p.UPDATED_BY)||'' ''||apex_util.get_since(p.updated) updated,',
'       --',
'       p.PROJECT_SIZE,',
'       p.project_url_name,',
'       p.friendly_identifier friendly_identifier1',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f,',
'       SP_PROJECT_SIZES s',
'where ',
'      p.archived_yn = ''N'' and',
'      p.initiative_id = i.id and',
'      i.area_id = f.id and',
'      p.PROJECT_SIZE = s.project_size and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.id = (select project_id from sp_activities ap where ap.id = :P140_ID)'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from SP_ACTIVITIES a',
'where a.id = :P140_ID and a.project_id is not null'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P140_ID'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No &NOMENCLATURE_PROJECT. found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844555514013654659)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42281281474076438519)
,p_query_column_id=>2
,p_column_alias=>'AREA'
,p_column_display_sequence=>50
,p_column_heading=>'&NOMENCLATURE_AREA.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368148880353953870)
,p_query_column_id=>3
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>60
,p_column_heading=>'&NOMENCLATURE_INITIATIVE.'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844555922139654660)
,p_query_column_id=>4
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>70
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844556280649654661)
,p_query_column_id=>5
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844563143921654676)
,p_query_column_id=>6
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>40
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FRIENDLY_IDENTIFIER1#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_link_attr=>'title="navigate to detail view"'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844562705602654675)
,p_query_column_id=>7
,p_column_alias=>'FAVORITE_ICON'
,p_column_display_sequence=>270
,p_column_heading=>'My Favorite'
,p_column_link=>'f?p=&APP_ID.:128:&SESSION.::&DEBUG.:RP,128:P128_PROJECT_ID:#ID#'
,p_column_linktext=>'#FAVORITE_ICON#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844563550099654677)
,p_query_column_id=>8
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>260
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844557938961654666)
,p_query_column_id=>9
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844555155821654658)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>110
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844558291422654667)
,p_query_column_id=>11
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>160
,p_column_heading=>'Release'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from sp_projects P  ',
'where p.release_id is not null ',
'  and p.id = (select project_id from SP_ACTIVITIES a where a.id = :P140_ID)',
''))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42368149057849953871)
,p_query_column_id=>12
,p_column_alias=>'TARGETED_DATE'
,p_column_display_sequence=>170
,p_column_heading=>'Target Completion'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42281281355554438517)
,p_query_column_id=>13
,p_column_alias=>'TAGS'
,p_column_display_sequence=>230
,p_column_heading=>'Tags'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844558711131654667)
,p_query_column_id=>14
,p_column_alias=>'CREATED'
,p_column_display_sequence=>240
,p_column_heading=>'Created'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844559120156654668)
,p_query_column_id=>15
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>250
,p_column_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844559560516654669)
,p_query_column_id=>16
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844559951851654669)
,p_query_column_id=>17
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39844560287047654670)
,p_query_column_id=>18
,p_column_alias=>'FRIENDLY_IDENTIFIER1'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40907009597060028104)
,p_name=>'P140_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40970596320088936040)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp.component_end;
end;
/
