prompt --application/pages/page_00036
begin
--   Manifest
--     PAGE: 00036
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
 p_id=>36
,p_name=>'Project Detail'
,p_alias=>'PROJECT-DETAIL'
,p_page_mode=>'MODAL'
,p_step_title=>'&NOMENCLATURE_PROJECT.'
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
 p_id=>wwv_flow_imp.id(37614968010974937413)
,p_name=>'Milestones'
,p_template=>4072358936313175081
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       t.task_type type,',
'       r.description,',
'       (select status from sp_task_statuses where id = r.status_id) status,',
'       to_char(r.start_date,''DD-MON'') || case when r.start_date is not null then '' - '' end ||',
'       nvl(to_char(r.target_complete,''DD-MON''),''?'') dates,',
'       t.display_seq ob',
'  from sp_tasks r,',
'       sp_task_types t',
' where project_id = :P36_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and t.static_id like ''MILESTONE%''',
' order by t.display_seq'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>30
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968096572937414)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968550148937418)
,p_query_column_id=>2
,p_column_alias=>'OWNER'
,p_column_display_sequence=>50
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968263034937415)
,p_query_column_id=>3
,p_column_alias=>'TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968346118937416)
,p_query_column_id=>4
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968445680937417)
,p_query_column_id=>5
,p_column_alias=>'STATUS'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090001471704244770)
,p_query_column_id=>6
,p_column_alias=>'DATES'
,p_column_display_sequence=>70
,p_column_heading=>'Dates'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37614968618381937419)
,p_query_column_id=>7
,p_column_alias=>'OB'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38072381438468321281)
,p_name=>'Activity'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ap.id, ',
'       at.activity_type,',
'       ap.comments,',
'       to_char(ap.start_date,''DD-MON-YYYY'')||'' to ''||to_char(ap.end_date,''DD-MON'') TIMELINE,',
'       tm.first_name||'' ''||tm.last_name name,',
'       ap.updated',
'from sp_activities ap,',
'     sp_projects p,',
'     sp_activity_types at,',
'     sp_team_members tm',
'where ap.project_id = p.id and',
'      p.id = :P36_ID and',
'      ap.activity_type_id = at.id and',
'      ap.team_member_id = tm.id and',
'      --',
'      --',
'      --',
'      (  ',
'         sysdate between ap.start_date and ap.end_date ',
'      )',
'order by ap.start_date, ap.updated desc',
'',
''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No Open Activity Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072381509491321282)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072383329219321299)
,p_query_column_id=>2
,p_column_alias=>'ACTIVITY_TYPE'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072383443038321300)
,p_query_column_id=>3
,p_column_alias=>'COMMENTS'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072383525041321301)
,p_query_column_id=>4
,p_column_alias=>'TIMELINE'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072382486066321291)
,p_query_column_id=>5
,p_column_alias=>'NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Name'
,p_column_html_expression=>'#NAME#: #ACTIVITY_TYPE#: #COMMENTS# - #TIMELINE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38419378818509282786)
,p_query_column_id=>6
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_column_heading=>'Updated'
,p_column_format=>'since_short'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38072381963183321286)
,p_name=>'Related'
,p_template=>4072358936313175081
,p_display_sequence=>90
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.project related_project,',
'       p.FRIENDLY_IDENTIFIER related_fi,',
'       p.PROJECT_URL_NAME related_pn,',
'       p.updated',
'  from SP_PROJECT_RELATED r,',
'       sp_projects p',
'where  r.PROJECT_ID = :P36_ID and ',
'       r.RELATED_PROJECT_ID = p.id and ',
'       p.DUPLICATE_OF_PROJECT_ID is null and',
'       p.ARCHIVED_YN = ''N''',
'union',
'select rp.project related_project,',
'       rp.FRIENDLY_IDENTIFIER related_fi,',
'       rp.PROJECT_URL_NAME related_pn, ',
'       rp.updated',
'  from SP_PROJECT_RELATED r,',
'       sp_projects rp',
'where  r.RELATED_PROJECT_ID = :P36_ID and',
'       r.project_id = rp.id and',
'       rp.DUPLICATE_OF_PROJECT_ID is null and',
'       rp.ARCHIVED_YN = ''N''',
' order by updated desc'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072382202587321288)
,p_query_column_id=>1
,p_column_alias=>'RELATED_PROJECT'
,p_column_display_sequence=>20
,p_column_heading=>'Related Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI,PN:#RELATED_FI#,#RELATED_PN#'
,p_column_linktext=>'#RELATED_PROJECT#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072382326182321289)
,p_query_column_id=>2
,p_column_alias=>'RELATED_FI'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38072382403481321290)
,p_query_column_id=>3
,p_column_alias=>'RELATED_PN'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24178318607772483253)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>50
,p_column_heading=>'Updated'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38072383614256321302)
,p_name=>'Tags'
,p_template=>4072358936313175081
,p_display_sequence=>80
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(lower(replace(p.TAGS,'','','', '')),''None Found'') tags',
'  from SP_PROJECTS p',
'where ',
'      p.archived_yn = ''N'' and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.id = :P36_ID'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38394340793528517601)
,p_query_column_id=>1
,p_column_alias=>'TAGS'
,p_column_display_sequence=>20
,p_column_heading=>'Tags'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(38090001632519244771)
,p_name=>'Reviews'
,p_template=>4072358936313175081
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       t.task_type type,',
'       r.description,',
'       (select status from sp_task_statuses where id = r.status_id) status,',
'       to_char(r.start_date,''DD-MON'') || case when r.start_date is not null then '' - '' end ||',
'       nvl(to_char(r.target_complete,''DD-MON''),''?'') dates,',
'       t.display_seq ob',
'  from sp_tasks r,',
'       sp_task_types t',
' where project_id = :P36_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and t.static_id like ''REVIEW%''',
' order by r.target_complete nulls first, t.display_seq'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090001764358244772)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090002110342244776)
,p_query_column_id=>2
,p_column_alias=>'OWNER'
,p_column_display_sequence=>50
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090001811179244773)
,p_query_column_id=>3
,p_column_alias=>'TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090001924080244774)
,p_query_column_id=>4
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090002036604244775)
,p_query_column_id=>5
,p_column_alias=>'STATUS'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090002300306244778)
,p_query_column_id=>6
,p_column_alias=>'DATES'
,p_column_display_sequence=>70
,p_column_heading=>'Dates'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38090002196565244777)
,p_query_column_id=>7
,p_column_alias=>'OB'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38394338787889517581)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>80
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(43750347206615976349)
,p_name=>'Attributes'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       f.area ||'' / ''|| i.initiative area_initiative,',
'       nvl((select t.first_name||'' ''||t.last_name from sp_team_members t where t.id = p.OWNER_ID),''No Owner'') the_owner,',
'       p.owner_id,',
'       p.project,',
'       --',
'       -- project group',
'       --',
'       (select group_name from sp_project_groups pg where pg.id = p.project_group_id) project_group,',
'       p.project_group_id,',
'       --',
'       -- fav icon',
'       --',
'       nvl((select ''<span class="fa fa-heart u-danger-text" aria-hidden="true"></span>'' ',
'            from sp_favorites fav',
'            where fav.project_id = p.id and ',
'                  fav.team_member_id = :APP_USER_ID),',
'            ''<span class="fa fa-heart-o" aria-hidden="true"></span>'') favorite_icon,',
'       --',
'       -- attributes',
'       --',
'       p.PCT_COMPLETE||''%'' PCT_COMPLETE,',
'       case when p.pct_complete >= sc.min_pc_for_status ',
'             and p.pct_complete != 100',
'            then nvl((select status from sp_project_statuses',
'                       where id = p.status_id),''Not Set'')',
'            end status,',
'       nvl((select ''P''||priority from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'') priority,',
'       null attributes,',
'       (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id) release,',
'       case when p.target_complete is not null',
'            then to_char(p.target_complete,''DD-Mon-YYYY'')',
'            else ''Not Targeted''',
'            end target_complete,',
'       --',
'       lower(p.CREATED_BY)||'' ''||apex_util.get_since(p.CREATED) created,',
'       lower(p.UPDATED_BY)||'' ''||apex_util.get_since(p.updated) updated,',
'       --',
'       p.PROJECT_SIZE,',
'       p.project_url_name,',
'       p.friendly_identifier friendly_identifier1,',
'       --',
'       -- external link:',
'       --',
'       p.external_system_link external_link,',
'       ''<button type="button" title="Copy Permalink" aria-label="Copy Permalink" data-clipboard-source="''||:P36_PERMALINK||''" class="t-Button t-Button--noLabel t-Button--icon t-Button--link padding-none">''||apex_escape.html(p.friendly_identifier)||''<'
||'/button>'' perma_link,',
'       :P36_PERMALINK permalink,',
'       --',
'       -- focus area',
'       --',
'       nvl((select focus_area from SP_INITIATIVE_FOCUS_AREAS fa where fa.id = p.FOCUS_AREA_ID),''Unallocated'') Focus_area',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f,',
'       SP_PROJECT_SIZES s,',
'       sp_project_scales sc',
'where ',
'      p.archived_yn = ''N'' and',
'      p.initiative_id = i.id and',
'      i.status_scale = sc.scale_letter and',
'      i.area_id = f.id and',
'      p.PROJECT_SIZE = s.project_size and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.id = :P36_ID'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_PERMALINK,P36_ID,APP_USER_ID'
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
 p_id=>wwv_flow_imp.id(38028687888841872690)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23383228563632838745)
,p_query_column_id=>2
,p_column_alias=>'AREA_INITIATIVE'
,p_column_display_sequence=>40
,p_column_heading=>'Area/Initiative'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028688557554872696)
,p_query_column_id=>3
,p_column_alias=>'THE_OWNER'
,p_column_display_sequence=>60
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028688642695872697)
,p_query_column_id=>4
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39223155692986110274)
,p_query_column_id=>5
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>30
,p_column_heading=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FRIENDLY_IDENTIFIER1#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550797204735063997)
,p_query_column_id=>6
,p_column_alias=>'PROJECT_GROUP'
,p_column_display_sequence=>100
,p_column_heading=>'Group'
,p_column_link=>'f?p=&APP_ID.:119:&SESSION.::&DEBUG.:RP,119:P119_PROJECT_GROUP_ID:#PROJECT_GROUP_ID#'
,p_column_linktext=>'#PROJECT_GROUP#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_projects',
' where id = :P36_ID',
'   and project_group_id is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_required_patch=>wwv_flow_imp.id(51655467048481750655)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(43550797288920063998)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_GROUP_ID'
,p_column_display_sequence=>230
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39223156006361110277)
,p_query_column_id=>8
,p_column_alias=>'FAVORITE_ICON'
,p_column_display_sequence=>220
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
 p_id=>wwv_flow_imp.id(38623442617328817675)
,p_query_column_id=>9
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(52590898421559963410)
,p_query_column_id=>10
,p_column_alias=>'STATUS'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028689218681872703)
,p_query_column_id=>11
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38623442526848817674)
,p_query_column_id=>12
,p_column_alias=>'ATTRIBUTES'
,p_column_display_sequence=>110
,p_column_heading=>'Attributes'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="sp-tags-container">',
'    <span class="sp-tag">#PRIORITY#</span>',
'    <span class="sp-tag">#PROJECT_SIZE#</span>',
'    <span class="sp-tag">#PCT_COMPLETE#</span>',
'{if STATUS/}    <span class="sp-tag">#STATUS#</span>{endif/}',
'    <span class="sp-tag">#RELEASE#</span>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028689443779872705)
,p_query_column_id=>13
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>90
,p_column_heading=>'Release'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from sp_projects',
'where id = :P36_ID ',
'  and RELEASE_ID is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028688690872872698)
,p_query_column_id=>14
,p_column_alias=>'TARGET_COMPLETE'
,p_column_display_sequence=>80
,p_column_heading=>'Target Complete'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028689593919872707)
,p_query_column_id=>15
,p_column_alias=>'CREATED'
,p_column_display_sequence=>190
,p_column_heading=>'Created'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028689852356872709)
,p_query_column_id=>16
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028689998888872711)
,p_query_column_id=>17
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028690258303872713)
,p_query_column_id=>18
,p_column_alias=>'PROJECT_URL_NAME'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38028690360699872714)
,p_query_column_id=>19
,p_column_alias=>'FRIENDLY_IDENTIFIER1'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42497661227108646679)
,p_query_column_id=>20
,p_column_alias=>'EXTERNAL_LINK'
,p_column_display_sequence=>180
,p_column_heading=>'External Link'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from sp_projects',
' where id = :P36_ID',
'   and external_system_link is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55083679187320389378)
,p_query_column_id=>21
,p_column_alias=>'PERMA_LINK'
,p_column_display_sequence=>160
,p_column_heading=>'Permalink'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(42497661541589646682)
,p_query_column_id=>22
,p_column_alias=>'PERMALINK'
,p_column_display_sequence=>170
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'NEVER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(46240430840409837603)
,p_query_column_id=>23
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>50
,p_column_heading=>'Focus Area'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(60082690306053517610)
,p_name=>'Approvals'
,p_template=>4072358936313175081
,p_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_new_grid_row=>false
,p_new_grid_column=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.approval_type,',
'       m.first_name||'' ''||m.last_name submitted_by,',
'       a.submitted,',
'       initcap(replace(a.status,''-'','' '')) status,',
'       (select max(nvl(last_status_on,updated)) from sp_project_approval_chain',
'         where project_approval_id = a.id) last_action',
'  from sp_project_approvals a,',
'       sp_approval_types t,',
'       sp_team_members m',
' where a.project_id = :P36_ID',
'   and a.approval_type_id = t.id    ',
'   and a.submitted_by_team_member_id = m.id'))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'last_action desc'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_approvals',
' where project_id = :P36_ID',
'union',
'select 1',
'  from sp_initiative_approvals a,',
'       sp_projects p',
' where p.id = :P36_ID',
'   and p.initiative_id = a.initiative_id'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489757530722794603)
,p_query_column_id=>1
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489757642344794604)
,p_query_column_id=>2
,p_column_alias=>'SUBMITTED_BY'
,p_column_display_sequence=>30
,p_column_heading=>'Submitted By'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489757721341794605)
,p_query_column_id=>3
,p_column_alias=>'SUBMITTED'
,p_column_display_sequence=>40
,p_column_heading=>'Submitted'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489757848281794606)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(50489757993023794608)
,p_query_column_id=>5
,p_column_alias=>'LAST_ACTION'
,p_column_display_sequence=>70
,p_column_heading=>'Last Action'
,p_column_format=>'SINCE_SHORT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(72349515475432024248)
,p_name=>'Tasks'
,p_template=>4072358936313175081
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ID,',
'       (select case when first_name is not null or last_name is not null',
'                    then first_name||'' ''||last_name',
'                    else email',
'                    end',
'               from sp_team_members t where t.id = r.owner_id) owner,',
'       (select task_type from sp_task_types rt where rt.id = task_type_id)||',
'           case when task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = r.task_sub_type_id) type,',
'       r.description,',
'       (select status from sp_task_statuses where id = r.status_id) status,',
'       to_char(r.start_date,''DD-MON'') || case when r.start_date is not null then '' - '' end ||',
'       nvl(to_char(r.target_complete,''DD-MON''),''?'') dates,',
'       t.display_seq ob',
'  from sp_tasks r,',
'       sp_task_types t',
' where project_id = :P36_ID',
'   and nvl(r.task_sub_type_id,r.task_type_id) = t.id',
'   and t.static_id not like ''MILESTONE%''',
'   and t.static_id not like ''REVIEW%''',
' order by r.target_complete nulls first, t.display_seq'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177379106034247809)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177379215563247810)
,p_query_column_id=>2
,p_column_alias=>'OWNER'
,p_column_display_sequence=>60
,p_column_heading=>'Owner'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177379365373247811)
,p_query_column_id=>3
,p_column_alias=>'TYPE'
,p_column_display_sequence=>30
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177379404714247812)
,p_query_column_id=>4
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55177379515739247813)
,p_query_column_id=>5
,p_column_alias=>'STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451867985868187671)
,p_query_column_id=>6
,p_column_alias=>'DATES'
,p_column_display_sequence=>140
,p_column_heading=>'Dates'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(55451867912556187670)
,p_query_column_id=>7
,p_column_alias=>'OB'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(153766638816608600999)
,p_name=>'Links'
,p_template=>4072358936313175081
,p_display_sequence=>100
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
'from SP_PROJECT_LINKS l ',
'where project_id = :P36_ID',
'order by created desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P36_ID'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'None Found'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39223160195795110319)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39266083992467556671)
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
 p_id=>wwv_flow_imp.id(39266084230525556673)
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
 p_id=>wwv_flow_imp.id(39266084307066556674)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39266084573743556677)
,p_query_column_id=>5
,p_column_alias=>'LINK_URL_DISPLAY'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38394339081075517584)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38394338787889517581)
,p_button_name=>'Close'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38090002458391244779)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38090001632519244771)
,p_button_name=>'add_review'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Review'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:509:&SESSION.::&DEBUG.:509:P509_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38090002470064244780)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37614968010974937413)
,p_button_name=>'add_milestone'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Milestone'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:508:&SESSION.::&DEBUG.:508:P508_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38419377851134282776)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38072383614256321302)
,p_button_name=>'view_change_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View Change History'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:82:&SESSION.::&DEBUG.:RP,82:P82_ID:&P36_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38623443346209817682)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_button_name=>'project_history'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View History'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:124:&SESSION.::&DEBUG.::P124_ID:&P36_ID.'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39266084857684556679)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(153766638816608600999)
,p_button_name=>'add_link'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Link'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55451840717374177031)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(72349515475432024248)
,p_button_name=>'add_task'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Task'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:501:P501_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28131767378825695173)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_button_name=>'view_details'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'View Details'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:P3_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38419378753079282785)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38072381438468321281)
,p_button_name=>'add_activity'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Add Activity'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38419381505888282813)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38072383614256321302)
,p_button_name=>'edit_tags'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:88:&SESSION.::&DEBUG.:RP,88:P88_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38394339019873517583)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_button_name=>'Edit'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:&P36_ID.'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38394339758058517590)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38394338787889517581)
,p_button_name=>'Description'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Description'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:136:&SESSION.::&DEBUG.:RP,136:P136_ID:&P36_ID.'
,p_icon_css_classes=>'fa-file-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39223156223536110279)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38394338787889517581)
,p_button_name=>'Documents'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Documents'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:141:&SESSION.::&DEBUG.:RP,141:P141_ID:&P36_ID.'
,p_icon_css_classes=>'fa-image'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38429381709276341675)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(38394338787889517581)
,p_button_name=>'Comments'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Comments'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.:RP,100:P100_PROJECT_ID:&P36_ID.'
,p_icon_css_classes=>'fa-comment-o'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38072381124498321278)
,p_name=>'P36_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38136735915833233716)
,p_name=>'P36_LOG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38394340210644517595)
,p_name=>'P36_PROJECT_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42497661380928646681)
,p_name=>'P36_PERMALINK'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(43750347206615976349)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38136735828056233715)
,p_computation_sequence=>10
,p_computation_item=>'P36_LOG'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation=>'return sp_log.log_and_summarize(:P36_ID);'
,p_computation_error_message=>'Unable to log view #SQLERRM#'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38394340305229517596)
,p_computation_sequence=>20
,p_computation_item=>'P36_PROJECT_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select project',
'from SP_PROJECTS p',
'where p.id = :P36_ID'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38394339177181517585)
,p_name=>'close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38394339081075517584)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38394339356874517586)
,p_event_id=>wwv_flow_imp.id(38394339177181517585)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(42497661274151646680)
,p_process_sequence=>2
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Determine Permalink'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select friendly_identifier, project_url_name',
'      from sp_projects',
'     where id = :P36_ID',
') loop',
'    :P36_PERMALINK := APEX_UTIL.HOST_URL(''SCRIPT'') || ',
'                      ''project-details?fi=''||apex_escape.html(c1.friendly_identifier)||''&pn=''||apex_escape.html(c1.project_url_name);',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>5598303408749678911
);
wwv_flow_imp.component_end;
end;
/
