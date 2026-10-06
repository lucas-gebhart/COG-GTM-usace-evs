prompt --application/pages/page_00060
begin
--   Manifest
--     PAGE: 00060
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
 p_id=>60
,p_name=>'Task Images'
,p_alias=>'TASK-IMAGES'
,p_step_title=>'&P60_TASK_NAME. - Images'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066647556686697793)
,p_step_template=>2526643373347724467
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55640363637069741594)
,p_plug_name=>'Images'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.ID,',
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
'  from SP_TASK_DOCUMENTS d',
' where task_id = :P60_TASK_ID and ',
'       (',
'           lower(DOCUMENT_FILENAME) like ''%.png'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.jpeg'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.gif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.tiff'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.avif'' or ',
'           lower(DOCUMENT_FILENAME) like ''%.ai'' ',
'       )',
'order by created desc',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_ajax_items_to_submit=>'P60_TASK_ID'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(54394293066300542807)
,p_region_id=>wwv_flow_imp.id(55640363637069741594)
,p_layout_type=>'GRID'
,p_title_adv_formatting=>false
,p_title_column_name=>'DOCUMENT_FILENAME'
,p_sub_title_adv_formatting=>true
,p_sub_title_html_expr=>'&AUTHOR. - &CREATED_SINCE.'
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
 p_id=>wwv_flow_imp.id(54394293599878542808)
,p_card_id=>wwv_flow_imp.id(54394293066300542807)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:505:&SESSION.::&DEBUG.:505:P505_ID,P505_PREV_PAGE:&ID.,60'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55640364278758741600)
,p_plug_name=>'Facets'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(55640363637069741594)
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56507315965339182359)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(108678465036737076378)
,p_name=>'Task'
,p_template=>4501440665235496320
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-ContextualInfo-label--stacked:t-Report--hideNoPagination'
,p_display_point=>'REGION_POSITION_01'
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
' where r.id = :P60_TASK_ID',
'   and r.status_id = s.id',
'   and r.project_id = p.id',
'   and p.initiative_id = i.id',
'   and i.area_id = f.id'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P60_TASK_ID'
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
 p_id=>wwv_flow_imp.id(54405704649297348054)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933059976147387113)
,p_query_column_id=>2
,p_column_alias=>'INITIATIVE_ID'
,p_column_display_sequence=>260
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(53933060112452387114)
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
 p_id=>wwv_flow_imp.id(53933060180430387115)
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
 p_id=>wwv_flow_imp.id(53933060312606387116)
,p_query_column_id=>5
,p_column_alias=>'FOCUS_AREA_ID'
,p_column_display_sequence=>280
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(54405703375255348052)
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
 p_id=>wwv_flow_imp.id(54405706612423348056)
,p_query_column_id=>7
,p_column_alias=>'PROJECT_ID'
,p_column_display_sequence=>250
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(54405703864856348053)
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
 p_id=>wwv_flow_imp.id(54405706173315348055)
,p_query_column_id=>9
,p_column_alias=>'OWNER_ID'
,p_column_display_sequence=>240
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(54405704981085348054)
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
 p_id=>wwv_flow_imp.id(54405705381420348055)
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
 p_id=>wwv_flow_imp.id(54405705790935348055)
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
 p_id=>wwv_flow_imp.id(54405707056922348056)
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
 p_id=>wwv_flow_imp.id(54405704251944348053)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54394291520335542802)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56507315965339182359)
,p_button_name=>'add_document'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Document'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:504:&SESSION.::&DEBUG.:RR,504:P504_TASK_ID:&P60_TASK_ID.'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_imp.id(176222234113670897793)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54394291104149542801)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56507315965339182359)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:502:P502_TASK_ID:&P60_TASK_ID.'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640367738936741618)
,p_name=>'P60_TASK_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55640363637069741594)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640367938415741620)
,p_name=>'P60_TASK_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55640363637069741594)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640369267619741626)
,p_name=>'P60_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55640364278758741600)
,p_prompt=>'Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640369414623741627)
,p_name=>'P60_FILE_EXTENSION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55640364278758741600)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640369490026741628)
,p_name=>'P60_AUTHOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55640364278758741600)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55640369634098741629)
,p_name=>'P60_MONTH_CREATED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55640364278758741600)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(66300052970464290429)
,p_name=>'P60_TAGS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(55640364278758741600)
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(54394305759399542831)
,p_computation_sequence=>10
,p_computation_item=>'P60_TASK_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select (select task_type from sp_task_types rt where rt.id = task_type_id)||',
'           case when task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = task_sub_type_id) ||',
'       case when task is not null then '' - ''||task end type',
'  from sp_tasks',
' where id = :P60_TASK_ID'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(54394306784236542832)
,p_name=>'DC'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56507315965339182359)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(54394307320679542835)
,p_event_id=>wwv_flow_imp.id(54394306784236542832)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55640363637069741594)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(53933058756471387100)
,p_event_id=>wwv_flow_imp.id(54394306784236542832)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(55640364278758741600)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
