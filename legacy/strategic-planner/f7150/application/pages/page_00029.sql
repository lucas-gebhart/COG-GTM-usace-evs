prompt --application/pages/page_00029
begin
--   Manifest
--     PAGE: 00029
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
 p_id=>29
,p_name=>'Project Images'
,p_alias=>'PROJECT-IMAGES'
,p_step_title=>'&P29_PROJECT_NAME. - Images'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38145431302666166575)
,p_plug_name=>'Images'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select :NOMENCLATURE_PROJECT belongs_to,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':30:''||:APP_SESSION||''::NO:30:P30_PREV_PAGE,P30_ID:29,''||d.id) details_link,',
'       null task,',
'       d.ID,',
'       d.DOCUMENT_FILENAME,',
'       d.document_mimetype,',
'       d.document_lastupd,',
'       UPDATED,',
'       d.created,',
'       d.tags,',
'       case when length(d.doc_description) > 200',
'            then substr(d.doc_description,1,200)||''...''',
'            else d.doc_description',
'            end doc_description,',
'       d.DOCUMENT_BLOB,',
'       lower(created_by) author,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) doc_size,',
'       apex_util.get_since(created) created_since,',
'       d.created date_created,',
'       lower(substr(DOCUMENT_FILENAME,instr(DOCUMENT_FILENAME,''.'',-1)+1,length(DOCUMENT_FILENAME)-instr(DOCUMENT_FILENAME,''.'',-1))) file_extension,',
'       to_char(d.created,''YYYY.MM'') month_created',
'  from SP_PROJECT_DOCUMENTS d',
' where project_id = :P29_PROJECT_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.avif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )',
'union all',
'select ''Task'' belongs_to,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':505:''||:APP_SESSION||''::NO:505:P505_PREV_PAGE,P505_ID:29,''||d.id) details_link,',
'       (select task_type from sp_task_types rt where rt.id = t.task_type_id)||',
'           case when t.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = t.task_sub_type_id) ||',
'           case when t.task is not null then '' - ''||t.task end task,',
'       d.ID,',
'       d.DOCUMENT_FILENAME,',
'       d.document_mimetype,',
'       d.document_lastupd,',
'       d.UPDATED,',
'       d.created,',
'       d.tags,',
'       case when length(d.doc_description) > 200',
'            then substr(d.doc_description,1,200)||''...''',
'            else d.doc_description',
'            end doc_description,',
'       d.DOCUMENT_BLOB,',
'       lower(d.created_by) author,',
'       dbms_lob.getlength(d.DOCUMENT_BLOB) doc_size,',
'       apex_util.get_since(d.created) created_since,',
'       d.created date_created,',
'       lower(substr(d.DOCUMENT_FILENAME,instr(d.DOCUMENT_FILENAME,''.'',-1)+1,length(d.DOCUMENT_FILENAME)-instr(d.DOCUMENT_FILENAME,''.'',-1))) file_extension,',
'       to_char(d.created,''YYYY.MM'') month_created',
'  from SP_task_DOCUMENTS d,',
'       sp_tasks t',
' where d.task_id = t.id',
'   and t.project_id = :P29_PROJECT_ID and ',
'       (',
'           lower(d.DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(d.DOCUMENT_FILENAME) like ''%.ai'' ',
'       )',
'order by created desc',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_ajax_items_to_submit=>'P29_PROJECT_ID'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(38145431564862166577)
,p_region_id=>wwv_flow_imp.id(38145431302666166575)
,p_layout_type=>'GRID'
,p_title_adv_formatting=>false
,p_title_column_name=>'DOCUMENT_FILENAME'
,p_sub_title_adv_formatting=>true
,p_sub_title_html_expr=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if TASK/}&TASK.<br/>{endif/}',
'&AUTHOR. - &CREATED_SINCE.',
''))
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>true
,p_second_body_html_expr=>'&DOC_DESCRIPTION.'
,p_media_adv_formatting=>false
,p_media_source_type=>'BLOB'
,p_media_blob_column_name=>'DOCUMENT_BLOB'
,p_media_display_position=>'BODY'
,p_media_sizing=>'FIT'
,p_pk1_column_name=>'ID'
,p_mime_type_column_name=>'DOCUMENT_MIMETYPE'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(38145435652451166618)
,p_card_id=>wwv_flow_imp.id(38145431564862166577)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&DETAILS_LINK.'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38145431944355166581)
,p_plug_name=>'Facets'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(38145431302666166575)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39012383630935607340)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(70493427237479186933)
,p_name=>'Project'
,p_template=>4501440665235496320
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:margin-left-md:margin-right-md'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'REGION_POSITION_01'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.ID,',
'       p.INITIATIVE_ID,',
'       f.area focus_area,',
'       f.id focus_area_id,',
'       i.initiative,',
'       p.PROJECT,',
'       (select t.first_name||'' ''||t.last_name',
'          from SP_TEAM_MEMBERS t ',
'         where t.id = p.OWNER_ID) project_owner,',
'       p.owner_id,',
'       p.TARGET_COMPLETE target_complete,',
'       case p.pct_complete when 0 then s.pc0_label ',
'                           when 10 then s.pc10_label',
'                           when 20 then s.pc20_label',
'                           when 30 then s.pc30_label',
'                           when 40 then s.pc40_label',
'                           when 50 then s.pc50_label',
'                           when 60 then s.pc60_label',
'                           when 70 then s.pc70_label',
'                           when 80 then s.pc80_label',
'                           when 90 then s.pc90_label',
'                           when 100 then s.pc100_label',
'                           end||'' - ''||p.pct_complete||''%'' as status,',
'       p.PRIORITY_ID,',
'       nvl((select description from sp_project_priorities pp where pp.id = p.priority_id),''Not Prioritized'') priority,',
'       (select RELEASE_TRAIN||'' ''||release from SP_RELEASE_TRAINS r where r.id = p.release_id) release,',
'       p.TAGS,',
'       p.CREATED,',
'       p.CREATED_BY,',
'       p.UPDATED,',
'       p.UPDATED_BY,',
'       p.project_size',
'  from SP_PROJECTS p, ',
'       SP_INITIATIVES i,',
'       SP_AREAS f,',
'       sp_project_scales s',
'where ',
'      p.initiative_id = i.id and',
'      i.area_id = f.id and',
'      p.id = :P29_PROJECT_ID and',
'      p.status_scale = s.scale_letter'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P29_PROJECT_ID'
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
 p_id=>wwv_flow_imp.id(39015525709279268995)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015526095710268995)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015526526762268995)
,p_query_column_id=>3
,p_column_alias=>'FOCUS_AREA'
,p_column_display_sequence=>30
,p_column_heading=>'Area'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_FOCUS_AREA:#FOCUS_AREA#'
,p_column_linktext=>'#FOCUS_AREA#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015526936760268996)
,p_query_column_id=>4
,p_column_alias=>'FOCUS_AREA_ID'
,p_column_display_sequence=>210
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015527324346268996)
,p_query_column_id=>5
,p_column_alias=>'INITIATIVE'
,p_column_display_sequence=>40
,p_column_heading=>'Initiative'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.::P23_INITIATIVE,P23_FOCUS_AREA:#INITIATIVE#,#FOCUS_AREA#'
,p_column_linktext=>'#INITIATIVE#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015527757557268996)
,p_query_column_id=>6
,p_column_alias=>'PROJECT'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015532937542269001)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_OWNER'
,p_column_display_sequence=>50
,p_column_heading=>'Project Owner'
,p_column_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RR,5:P5_ID:#OWNER_ID#'
,p_column_linktext=>'#PROJECT_OWNER#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015525314314268994)
,p_query_column_id=>8
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>220
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015528117655268997)
,p_query_column_id=>9
,p_column_alias=>'TARGET_COMPLETE'
,p_column_display_sequence=>150
,p_column_heading=>'Target'
,p_column_format=>'DD-Mon-YYYY'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41725546421674004288)
,p_query_column_id=>10
,p_column_alias=>'STATUS'
,p_column_display_sequence=>100
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015529291652268997)
,p_query_column_id=>11
,p_column_alias=>'PRIORITY_ID'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015529735308268998)
,p_query_column_id=>12
,p_column_alias=>'PRIORITY'
,p_column_display_sequence=>110
,p_column_heading=>'Priority'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015530511065268999)
,p_query_column_id=>13
,p_column_alias=>'RELEASE'
,p_column_display_sequence=>140
,p_column_heading=>'Release'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_projects',
' where id = :P29_PROJECT_ID',
'   and release_id is not null'))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015530871706268999)
,p_query_column_id=>14
,p_column_alias=>'TAGS'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015531320324269000)
,p_query_column_id=>15
,p_column_alias=>'CREATED'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015531681071269000)
,p_query_column_id=>16
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015532078613269000)
,p_query_column_id=>17
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>190
,p_column_heading=>'Updated'
,p_column_format=>'SINCE'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015532565387269001)
,p_query_column_id=>18
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>200
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39015524871966268993)
,p_query_column_id=>19
,p_column_alias=>'PROJECT_SIZE'
,p_column_display_sequence=>130
,p_column_heading=>'Size'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41413709958237908991)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39012383630935607340)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Document'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RR,12:P12_PROJECT_ID:&P3_PROJECT_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39012663009879050930)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39012383630935607340)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:&P29_FI.,&P29_PN.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38145431383487166576)
,p_name=>'P29_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38145431302666166575)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38145431582966166578)
,p_name=>'P29_PROJECT_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38145431302666166575)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38145431967246166582)
,p_name=>'P29_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
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
 p_id=>wwv_flow_imp.id(38145432114250166583)
,p_name=>'P29_FILE_EXTENSION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
,p_prompt=>'File Extension'
,p_source=>'FILE_EXTENSION'
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
 p_id=>wwv_flow_imp.id(38145432189653166584)
,p_name=>'P29_AUTHOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
,p_prompt=>'Contributor'
,p_source=>'AUTHOR'
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
 p_id=>wwv_flow_imp.id(38145432333725166585)
,p_name=>'P29_MONTH_CREATED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
,p_prompt=>'Month Created'
,p_source=>'MONTH_CREATED'
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
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40990340237623247813)
,p_name=>'P29_FI'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39012383630935607340)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40990340399844247815)
,p_name=>'P29_PN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39012383630935607340)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'WEB_SAFE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48805115670090715385)
,p_name=>'P29_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
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
 p_id=>wwv_flow_imp.id(53933058862277387101)
,p_name=>'P29_BELONGS_TO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38145431944355166581)
,p_prompt=>'Belongs To'
,p_source=>'BELONGS_TO'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'D'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38145431755580166579)
,p_computation_sequence=>10
,p_computation_item=>'P29_PROJECT_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select project from sp_projects where id = :P29_PROJECT_ID'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40990340509074247816)
,p_computation_sequence=>20
,p_computation_item=>'P29_FI'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select FRIENDLY_IDENTIFIER from sp_projects where id = :P29_PROJECT_ID'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(40990340589745247817)
,p_computation_sequence=>30
,p_computation_item=>'P29_PN'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select PROJECT_URL_NAME from sp_projects where id = :P29_PROJECT_ID'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41501763103959119080)
,p_name=>'DC'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39012383630935607340)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501763234663119081)
,p_event_id=>wwv_flow_imp.id(41501763103959119080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(38145431302666166575)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
