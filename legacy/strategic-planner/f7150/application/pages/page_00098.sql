prompt --application/pages/page_00098
begin
--   Manifest
--     PAGE: 00098
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
 p_id=>98
,p_name=>'Task Quick Look'
,p_alias=>'TASK-QUICK-LOOK'
,p_page_mode=>'MODAL'
,p_step_title=>'Quick Look'
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
 p_id=>wwv_flow_imp.id(48857345938502853095)
,p_name=>'Documents'
,p_template=>4072358936313175081
,p_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.ID,',
'       d.DOCUMENT_FILENAME || case when important_yn = ''Y'' then '' (Important)'' end document_filename,',
'       ''added by ''||lower(created_by) ||'' ''||apex_util.get_since(created) created_details',
'  from SP_TASK_DOCUMENTS d',
' where task_id = :P98_TASK_ID',
'order by created desc'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_TASK_DOCUMENTS',
' where task_id = :P98_TASK_ID'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P98_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No documents found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857346004256853096)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857346555310853101)
,p_query_column_id=>2
,p_column_alias=>'DOCUMENT_FILENAME'
,p_column_display_sequence=>50
,p_column_heading=>'Document'
,p_column_link=>'f?p=&APP_ID.:505:&SESSION.::&DEBUG.:505:P505_ID,P502_TASK_ID,P505_PREV_PAGE:#ID#,&P98_ID.,502'
,p_column_linktext=>'#DOCUMENT_FILENAME#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857347713325853113)
,p_query_column_id=>3
,p_column_alias=>'CREATED_DETAILS'
,p_column_display_sequence=>70
,p_column_heading=>'Created Details'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(50132248126843842916)
,p_name=>'Tags'
,p_template=>4072358936313175081
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select lower(replace(TAGS,'','','', '')) tags',
'  from SP_tasks',
' where id = :P98_TASK_ID',
'   and tags is not null'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks',
' where id = :P98_TASK_ID',
'   and tags is not null'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No tags found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959223292289489396)
,p_query_column_id=>1
,p_column_alias=>'TAGS'
,p_column_display_sequence=>20
,p_column_heading=>'Tags'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(50454203300477039195)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>80
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(55810211719203497963)
,p_name=>'&P98_TASK_TYPE.'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with today as (select trunc(sysdate) day from dual)',
'select r.ID,',
'       (select project from sp_projects where id = r.project_id) project,',
'       r.project_id,',
'       (select task_type from sp_task_types rt where rt.id = r.task_sub_type_id) task_type,',
'       r.task task,',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) the_owner,',
'       r.impact,',
'       s.status,',
'       r.start_date,',
'       r.target_complete,',
'       case when s.indicates_complete_yn = ''N'' and',
'                 r.target_complete is not null',
'            then least(5, trunc(r.target_complete) - trunc(r.target_complete, ''iw'') + 1)',
'                 - least(5, today.day - trunc(today.day, ''iw'') + 1)',
'                 + (trunc(r.target_complete, ''iw'') - trunc(today.day, ''iw'')) * 5 / 7',
'       end weekdays_left,',
'       r.updated,',
'       r.description,',
'       p.friendly_identifier fi,',
'       p.project_url_name pn',
'  from sp_tasks r,',
'       sp_task_statuses s,',
'       today,',
'       SP_PROJECTS p',
' where r.id = :P98_TASK_ID',
'   and r.status_id = s.id',
'   and r.project_id = p.id'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P98_TASK_ID,APP_USER_ID'
,p_lazy_loading=>false
,p_query_row_template=>2100515439059797523
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959241352066489422)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959246468630489430)
,p_query_column_id=>2
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>50
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FI#,#PN#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345200501853088)
,p_query_column_id=>3
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48999803175861585384)
,p_query_column_id=>4
,p_column_alias=>'TASK_TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Type'
,p_column_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID,P502_PREV_PAGE,P502_PROJECT_ID:#ID#,3,#PROJECT_ID#'
,p_column_linktext=>'#TASK_TYPE#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks',
' where id = :P98_TASK_ID',
'   and task_sub_type_id is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857347404317853110)
,p_query_column_id=>5
,p_column_alias=>'TASK'
,p_column_display_sequence=>30
,p_column_heading=>'Task'
,p_column_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID,P502_PREV_PAGE,P502_PROJECT_ID:#ID#,3,#PROJECT_ID#'
,p_column_linktext=>'#TASK#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks',
' where id = :P98_TASK_ID',
'   and task is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959241781779489423)
,p_query_column_id=>6
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>60
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857347521922853111)
,p_query_column_id=>7
,p_column_alias=>'IMPACT'
,p_column_display_sequence=>70
,p_column_heading=>'Impact'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks',
' where id = :P98_ID',
'   and impact is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345339208853089)
,p_query_column_id=>8
,p_column_alias=>'STATUS'
,p_column_display_sequence=>110
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345383644853090)
,p_query_column_id=>9
,p_column_alias=>'START_DATE'
,p_column_display_sequence=>120
,p_column_heading=>'Start Date'
,p_column_format=>'fmDD fmMonth, YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959242599456489424)
,p_query_column_id=>10
,p_column_alias=>'TARGET_COMPLETE'
,p_column_display_sequence=>130
,p_column_heading=>'Target Complete'
,p_column_format=>'DD-Mon-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345542214853091)
,p_query_column_id=>11
,p_column_alias=>'WEEKDAYS_LEFT'
,p_column_display_sequence=>140
,p_column_heading=>'Weekdays Remaining'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959244298879489427)
,p_query_column_id=>12
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345864053853094)
,p_query_column_id=>13
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>170
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345601115853092)
,p_query_column_id=>14
,p_column_alias=>'FI'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48857345682627853093)
,p_query_column_id=>15
,p_column_alias=>'PN'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(165826503329196122613)
,p_name=>'Links'
,p_template=>4072358936313175081
,p_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.id, ',
'       case when lower(l.link_url) not like ''http%'' then ''http://'' end || l.link_url link_url,',
'       l.created, ',
'       l.updated, ',
'       decode(',
'           greatest(length(l.link_url),80),',
'           length(l.link_url),',
'           substr(l.link_url,1,37)||''...''||substr(l.link_url,length(l.link_url)-40),',
'           l.link_url',
'           ) link_url_display',
'from SP_task_LINKS l ',
'where task_id = :P98_TASK_ID',
'order by created desc'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_task_LINKS',
' where task_id = :P98_TASK_ID'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P98_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No links found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959227319299489404)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959227735240489405)
,p_query_column_id=>2
,p_column_alias=>'LINK_URL'
,p_column_display_sequence=>30
,p_column_heading=>'URL'
,p_column_html_expression=>'<a href="#LINK_URL#" target="_blank">#LINK_URL_DISPLAY#</a>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959228151064489405)
,p_query_column_id=>3
,p_column_alias=>'CREATED'
,p_column_display_sequence=>50
,p_column_heading=>'Created'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959228473738489406)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(48959226880218489404)
,p_query_column_id=>5
,p_column_alias=>'LINK_URL_DISPLAY'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(186026587461405775221)
,p_name=>'Comments'
,p_region_name=>'COMMENTS'
,p_template=>4072358936313175081
,p_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ic.ID,',
'       -- Display Columns',
'       tm.initials user_icon,',
'       apex_util.get_since(ic.created) comment_date,',
'       tm.first_name || '' '' || tm.last_name user_name,',
'       --',
'       ic.body_html comment_text,',
'       null actions,',
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
'  from sp_task_comments ic, ',
'       sp_team_members tm',
'where ic.author_id = tm.id and',
'      ic.task_id = :P98_TASK_ID and  ',
'      (nvl(ic.private_yn,''N'') = ''N'' or lower(ic.created_by) = lower(:APP_USER) )',
'order by created desc'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_task_comments',
' where task_id = :P98_TASK_ID ',
'   and (nvl(private_yn,''N'') = ''N'' or lower(created_by) = lower(:APP_USER))'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P98_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2613168815517880001
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No comments'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150165590813673502)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150166055197673503)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>150
,p_column_heading=>'User Icon'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150166428079673504)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'Comment Date'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150166787817673504)
,p_query_column_id=>4
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>170
,p_column_heading=>'User Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150167187170673505)
,p_query_column_id=>5
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
 p_id=>wwv_flow_imp.id(49150167596115673506)
,p_query_column_id=>6
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>190
,p_column_heading=>'Actions'
,p_report_column_required_role=>wwv_flow_imp.id(176222234113670897793)
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150168047523673506)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>200
,p_column_heading=>'Attribute 1'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150168402841673507)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>210
,p_column_heading=>'Attribute 2'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150168777323673507)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>220
,p_column_heading=>'Attribute 3'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150169173491673508)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>230
,p_column_heading=>'Attribute 4'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150169640165673508)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>240
,p_column_heading=>'Icon Modifier'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150170044608673509)
,p_query_column_id=>12
,p_column_alias=>'PRIVATE_COMMENT_LABEL'
,p_column_display_sequence=>260
,p_column_heading=>'Private Comment Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150170371512673509)
,p_query_column_id=>13
,p_column_alias=>'BODY'
,p_column_display_sequence=>40
,p_column_heading=>'Body'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150170819946673509)
,p_query_column_id=>14
,p_column_alias=>'BODY_HTML'
,p_column_display_sequence=>50
,p_column_heading=>'Body Html'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150171263907673510)
,p_query_column_id=>15
,p_column_alias=>'AUTHOR_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Author Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150171585465673510)
,p_query_column_id=>16
,p_column_alias=>'CREATED'
,p_column_display_sequence=>110
,p_column_heading=>'Created'
,p_column_format=>'SINCE'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150172010628673510)
,p_query_column_id=>17
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>120
,p_column_heading=>'Created By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150172391118673511)
,p_query_column_id=>18
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150172863639673511)
,p_query_column_id=>19
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>140
,p_column_heading=>'Updated By'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(49150173245877673512)
,p_query_column_id=>20
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>250
,p_column_heading=>'User ID'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48959230946657489409)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(50454203300477039195)
,p_button_name=>'Close'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48959248531777489433)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_button_name=>'task_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'History'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:507:&SESSION.::&DEBUG.:507:P507_TASK_ID:&P98_TASK_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48959248932305489433)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_button_name=>'Edit'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:RP,501:P501_ID:&P98_TASK_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P98_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID not in (''MILESTONE'',''REVIEW'')'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48857347221738853108)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_button_name=>'Edit-review'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:509:&SESSION.::&DEBUG.:RP,509:P509_ID:&P98_TASK_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P98_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID = ''REVIEW'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48857347363368853109)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_button_name=>'Edit-milestone'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:508:&SESSION.::&DEBUG.:RP,508:P508_ID:&P98_TASK_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_tasks t, sp_task_types tt',
' where t.id = :P98_TASK_ID',
'   and t.task_type_id = tt.id',
'   and tt.STATIC_ID = ''MILESTONE'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48959230124971489408)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(50454203300477039195)
,p_button_name=>'Details'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'View Details'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:RP,502:P502_TASK_ID,P502_PROJECT_ID,P502_PREV_PAGE:&P98_TASK_ID.,&P98_PROJECT_ID.,3'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48999802395876585376)
,p_name=>'P98_PROJECT_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48999802659058585378)
,p_name=>'P98_TASK_TYPE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(50132272551942842942)
,p_name=>'P98_TASK_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55810211719203497963)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48999802481469585377)
,p_computation_sequence=>10
,p_computation_item=>'P98_PROJECT_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project_id',
'  from sp_tasks',
' where id = :P98_TASK_ID'))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(48999803158172585383)
,p_computation_sequence=>10
,p_computation_item=>'P98_TASK_TYPE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tt.task_type ',
'  from sp_tasks t,',
'       sp_task_types tt',
' where t.id = :P98_TASK_ID',
'   and t.task_type_id = tt.id'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48959259081306489456)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(48959230946657489409)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48959259575929489457)
,p_event_id=>wwv_flow_imp.id(48959259081306489456)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25423962281418543477)
,p_name=>'links in comments in new tab'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25423962366364543478)
,p_event_id=>wwv_flow_imp.id(25423962281418543477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#COMMENTS a'').attr(''target'',''_blank'');'
);
wwv_flow_imp.component_end;
end;
/
