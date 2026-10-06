prompt --application/pages/page_10150
begin
--   Manifest
--     PAGE: 10150
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
 p_id=>10150
,p_name=>'Initiative Focus Areas'
,p_alias=>'INITIATIVE-FOCUS-AREAS'
,p_step_title=>'Initiative Focus Areas'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(44378471622612773304)
,p_name=>'SQL'
,p_region_name=>'SQL'
,p_template=>2664334895415463485
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''insert into sp_initiatvie_focus_areas (ID, INITIATIVE_ID, FOCUS_AREA, description, ACTIVE_YN) values (''||',
'       id||'', ''||',
'       INITIATIVE_ID||'', ''''''||',
'       FOCUS_AREA||'''''', ''''''||',
'       description||'''''', ''''''||',
'       ACTIVE_YN||'''''');'' SQL',
'  from sp_initiative_focus_areas '))
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
 p_id=>wwv_flow_imp.id(40292481889312944215)
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
 p_id=>wwv_flow_imp.id(45957197882959623648)
,p_plug_name=>'Initiative Focus Areas'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.ID,',
'       a.area,',
'       i.initiative,',
'       f.focus_area,',
'       f.CREATED,',
'       f.CREATED_BY,',
'       f.UPDATED,',
'       f.UPDATED_BY,',
'       f.description,',
'       nvl(f.display_sequence,10) display_sequence,',
'       decode(f.active_yn,''Y'',''Yes'',''N'',''No'',f.active_yn) active,',
'       --',
'       -- usage',
'       --',
'       (select count(*) from sp_projects p where p.focus_area_id = f.id and  p.archived_yn = ''N'' and p.DUPLICATE_OF_PROJECT_ID is null) usage_count,',
'       --',
'       -- owners',
'       --',
'       (select first_name||'' ''||last_name from SP_TEAM_MEMBERS tm where tm.id = f.development_owner_id) dev_focus_area_lead',
'  from SP_INITIATIVE_FOCUS_AREAS f,',
'       SP_INITIATIVES i,',
'       sp_areas a',
' where f.initiative_id = i.id',
'   and i.area_id = a.id'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Project Size'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(45957197998559623648)
,p_name=>'Project Size'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:RP,10151:P10151_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_owner=>'MIKE'
,p_internal_uid=>9057840133157655879
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45957198362598623651)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252341358118094216)
,p_db_column_name=>'AREA'
,p_display_order=>10
,p_column_identifier=>'K'
,p_column_label=>'&NOMENCLATURE_AREA.'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252341391706094217)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'&NOMENCLATURE_INITIATIVE.'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252341506985094218)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Focus Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38252341627501094219)
,p_db_column_name=>'ACTIVE'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Active'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(43790504065391179449)
,p_db_column_name=>'USAGE_COUNT'
,p_display_order=>50
,p_column_identifier=>'J'
,p_column_label=>'Usage'
,p_column_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,23:P23_FOCUS_AREA,P23_INITIATIVE,P23_INIT_FOCUS_AREA:#AREA#,#INITIATIVE#,#FOCUS_AREA#'
,p_column_linktext=>'#USAGE_COUNT#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45957199975849623654)
,p_db_column_name=>'CREATED'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45957200366520623654)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45957200770414623655)
,p_db_column_name=>'UPDATED'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(45957201186185623656)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46240430969873837605)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>100
,p_column_identifier=>'O'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46240431137446837606)
,p_db_column_name=>'DEV_FOCUS_AREA_LEAD'
,p_display_order=>110
,p_column_identifier=>'P'
,p_column_label=>'Lead'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37803137832214686471)
,p_db_column_name=>'DISPLAY_SEQUENCE'
,p_display_order=>120
,p_column_identifier=>'Q'
,p_column_label=>'Display Sequence'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(45957608133974307079)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'56651268'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'AREA:INITIATIVE:FOCUS_AREA:DEV_FOCUS_AREA_LEAD:DISPLAY_SEQUENCE:DESCRIPTION:USAGE_COUNT:UPDATED:'
,p_sort_column_1=>'AREA'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'INITIATIVE'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'DISPLAY_SEQUENCE'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'FOCUS_AREA'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(37803357858206008708)
,p_report_id=>wwv_flow_imp.id(45957608133974307079)
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
 p_id=>wwv_flow_imp.id(45957203317589623662)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40292483093999944216)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(45957203317589623662)
,p_button_name=>'add_focus_area'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconRight'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Add Focus Area'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10151:&SESSION.::&DEBUG.:RP,10151::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40292482755508944216)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(45957203317589623662)
,p_button_name=>'Up'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40292488156069944237)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(45957197882959623648)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40292488631145944238)
,p_event_id=>wwv_flow_imp.id(40292488156069944237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(45957197882959623648)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40292489004395944238)
,p_name=>'refresh on dialog close'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(45957203317589623662)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40292489530729944238)
,p_event_id=>wwv_flow_imp.id(40292489004395944238)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(45957197882959623648)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40292490013587944239)
,p_event_id=>wwv_flow_imp.id(40292489004395944238)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(44378471622612773304)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
