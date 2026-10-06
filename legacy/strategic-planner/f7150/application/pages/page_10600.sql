prompt --application/pages/page_10600
begin
--   Manifest
--     PAGE: 10600
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
 p_id=>10600
,p_name=>'Contributor Roles'
,p_alias=>'CONTRIBUTOR-ROLES-ADMIN'
,p_step_title=>'Contributor Roles'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37119473752626553089)
,p_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (''||',
'        id||'', ''''''||',
'        RESOURCE_TYPE||'''''', ''''''||',
'        replace(RESOURCE_DESCRIPTION,'''''''','''''''''''')||'''''', ''''''||',
'        IS_DEFAULT_YN||'''''');'' SQL',
'from SP_RESOURCE_TYPES rt'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>150
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37119473809600553090)
,p_query_column_id=>1
,p_column_alias=>'SQL'
,p_column_display_sequence=>10
,p_column_heading=>'SQL'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176240960841322124004)
,p_plug_name=>'Resource Types'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       RESOURCE_TYPE,',
'       RESOURCE_DESCRIPTION,',
'       CREATED,',
'       lower(created_by) CREATED_BY,',
'       UPDATED,',
'       lower(updated_by) UPDATED_BY,',
'       decode(IS_DEFAULT_YN,''Y'',''Yes'',''No'') IS_DEFAULT_YN,',
'       (select count(*) ',
'        from SP_PROJECT_CONTRIBUTORS pc, ',
'             sp_projects p ',
'        where pc.RESPONSIBILITY_ID = rt.id and',
'              pc.project_id = p.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.DUPLICATE_OF_PROJECT_ID is null',
'        ) project_contributions,',
'        (select count(*) ',
'        from SP_PROJECT_CONTRIBUTORS pc, ',
'             sp_projects p ',
'        where pc.RESPONSIBILITY_ID = rt.id and',
'              pc.project_id = p.id and',
'              p.ARCHIVED_YN = ''N'' and',
'              p.DUPLICATE_OF_PROJECT_ID is null and',
'              p.pct_complete = 100',
'        ) completed_projects',
'  from SP_RESOURCE_TYPES rt'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Resource Types'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(176240960966330124004)
,p_name=>'Resource Types'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10610:&SESSION.::&DEBUG.:RP:P10610_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>27446493998897261436
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240961757747124006)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_column_identifier=>'B'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240962162334124006)
,p_db_column_name=>'RESOURCE_TYPE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Role'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240962540802124006)
,p_db_column_name=>'RESOURCE_DESCRIPTION'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240962965098124006)
,p_db_column_name=>'CREATED'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240963355396124007)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240963739876124007)
,p_db_column_name=>'UPDATED'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(176240964104184124008)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(69544560164697096274)
,p_db_column_name=>'IS_DEFAULT_YN'
,p_display_order=>18
,p_column_identifier=>'I'
,p_column_label=>'Is Default'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44360477942907793073)
,p_db_column_name=>'PROJECT_CONTRIBUTIONS'
,p_display_order=>28
,p_column_identifier=>'J'
,p_column_label=>'&NOMENCLATURE_PROJECTS.'
,p_column_link=>'f?p=&APP_ID.:10601:&SESSION.::&DEBUG.:RP,10601:P10601_ID:#ID#'
,p_column_linktext=>'#PROJECT_CONTRIBUTIONS#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43162214120967749772)
,p_db_column_name=>'COMPLETED_PROJECTS'
,p_display_order=>38
,p_column_identifier=>'K'
,p_column_label=>'Completed &NOMENCLATURE_PROJECTS.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(176240988701057125167)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'274465218'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'RESOURCE_TYPE:IS_DEFAULT_YN:RESOURCE_DESCRIPTION:PROJECT_CONTRIBUTIONS:COMPLETED_PROJECTS:UPDATED:'
,p_sort_column_1=>'RESOURCE_TYPE'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'UPDATED'
,p_sort_direction_2=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(176240966284742124010)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(176240964597502124009)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176240966284742124010)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Role'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10610:&SESSION.::&DEBUG.:10610'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41215591462642990780)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(176240966284742124010)
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
 p_id=>wwv_flow_imp.id(176240964905370124009)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(176240960841322124004)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(176240965457599124009)
,p_event_id=>wwv_flow_imp.id(176240964905370124009)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(176240960841322124004)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41501762878724119078)
,p_name=>'DC'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(176240966284742124010)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41501762971210119079)
,p_event_id=>wwv_flow_imp.id(41501762878724119078)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(176240960841322124004)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
