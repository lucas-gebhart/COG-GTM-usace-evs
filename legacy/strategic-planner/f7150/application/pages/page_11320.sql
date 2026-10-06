prompt --application/pages/page_11320
begin
--   Manifest
--     PAGE: 11320
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
 p_id=>11320
,p_name=>'Manage Duplicate Projects'
,p_alias=>'MANAGE-DUPLICATE-PROJECTS'
,p_step_title=>'Manage Duplicate &NOMENCLATURE_PROJECTS.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(48256067099300626783)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61812106926039424869)
,p_plug_name=>'Duplicate &NOMENCLATURE_PROJECTS.'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.ID,',
'       a.PROJECT,',
'       (select project from sp_projects b where b.id = a.DUPLICATE_OF_PROJECT_ID) duplicate_of_primary_project,',
'       a.friendly_identifier,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = a.OWNER_ID) the_owner,',
'       (select ''P''||PRIORITY from SP_PROJECT_PRIORITIES x where x.ID = a.PRIORITY_ID) priority,',
'       a.PROJECT_SIZE,',
'       a.UPDATED,',
'       a.created,',
'       null attributes,',
'       a.owner_id,',
'       ARCHIVED_YN,',
'       ARCHIVED_DATE,',
'       ARCHIVED_BY,',
'       (select project from sp_projects b where b.id = a.DUPLICATE_OF_PROJECT_ID) duplicate_of,',
'       a.DUPLICATE_OF_PROJECT_ID,',
'       (select count(*) from sp_project_comments c where c.project_id = a.id) comments,',
'       (select count(*) from sp_project_contributors c2 where c2.project_id = a.id) contributors,',
'       (select count(*) from SP_PROJECT_DOCUMENTS d where d.project_id = a.id) documents',
'from SP_PROJECTS a',
'where a.DUPLICATE_OF_PROJECT_ID is not null',
'',
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
,p_prn_page_header=>'Duplicate &NOMENCLATURE_PROJECTS.'
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
 p_id=>wwv_flow_imp.id(62798785966519872520)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11310:&SESSION.::&DEBUG.:RP,11310:P11310_ID:#ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>25899428101117904751
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786094557872521)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786228728872522)
,p_db_column_name=>'PROJECT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:FI:#FRIENDLY_IDENTIFIER#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786244462872523)
,p_db_column_name=>'THE_OWNER'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786495499872525)
,p_db_column_name=>'PRIORITY'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786600966872526)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786679991872527)
,p_db_column_name=>'UPDATED'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786766332872528)
,p_db_column_name=>'ATTRIBUTES'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Attributes'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798786861144872529)
,p_db_column_name=>'OWNER_ID'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Owner ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787028438872530)
,p_db_column_name=>'ARCHIVED_YN'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Archived'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787086644872531)
,p_db_column_name=>'ARCHIVED_DATE'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Archived'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD-MON-YYYY HH24:MI'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787218608872532)
,p_db_column_name=>'ARCHIVED_BY'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Archived By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787252422872533)
,p_db_column_name=>'DUPLICATE_OF'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Duplicate Of'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787384340872534)
,p_db_column_name=>'DUPLICATE_OF_PROJECT_ID'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Duplicate of Project ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787514160872535)
,p_db_column_name=>'COMMENTS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Comments'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787576614872536)
,p_db_column_name=>'CONTRIBUTORS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Contributors'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62798787687944872537)
,p_db_column_name=>'DOCUMENTS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Documents'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62889003353942250224)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'ID'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(62889004613050250236)
,p_db_column_name=>'CREATED'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_column_alignment=>'CENTER'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50493823948819761107)
,p_db_column_name=>'DUPLICATE_OF_PRIMARY_PROJECT'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Duplicate Of Primary Project'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(62798969967427310344)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'118157234'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:THE_OWNER:ARCHIVED_DATE:PRIORITY:COMMENTS:CONTRIBUTORS:DOCUMENTS:CREATED:UPDATED'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(50983253089162502638)
,p_report_id=>wwv_flow_imp.id(62798969967427310344)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'ARCHIVED_YN'
,p_operator=>'='
,p_expr=>'Y'
,p_condition_sql=>'"ARCHIVED_YN" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''Y''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62605706331809277668)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50983254723017502642)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(62605706331809277668)
,p_button_name=>'reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:11320:&SESSION.::&DEBUG.:RR,11320::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(50983254318697502641)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(62605706331809277668)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(50983256176390502648)
,p_name=>'refresh on close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(61812106926039424869)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(50983256737117502651)
,p_event_id=>wwv_flow_imp.id(50983256176390502648)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(61812106926039424869)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
