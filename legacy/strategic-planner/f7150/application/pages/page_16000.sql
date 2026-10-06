prompt --application/pages/page_16000
begin
--   Manifest
--     PAGE: 16000
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
 p_id=>16000
,p_name=>'Error Log'
,p_alias=>'ERROR-LOG'
,p_step_title=>'Error Log'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_help_text=>'<p>This report shows all email queued to be sent and those already sent.</p>'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(76976941347384041599)
,p_plug_name=>'Error Log'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       PACKAGE_NAME,',
'       PROCEDURE_NAME,',
'       ERROR,',
'       ARG1_NAME,',
'       ARG1_VAL,',
'       ARG2_NAME,',
'       ARG2_VAL,',
'       ARG3_NAME,',
'       ARG3_VAL,',
'       ARG4_NAME,',
'       ARG4_VAL,',
'       ARG5_NAME,',
'       ARG5_VAL,',
'       CREATED,',
'       CREATED_TRUNC,',
'       lower(CREATED_BY) created_by',
'  from SP_ERROR_LOG'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Email Reporting'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(76976941961503041600)
,p_name=>'Email Reporting'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_base_pk1=>'ID'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link_text=>'<img src="#APEX_FILES#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_allow_exclude_null_values=>'N'
,p_allow_hide_extra_columns=>'N'
,p_owner=>'SBKENNED'
,p_internal_uid=>76975402379634983472
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(76976942854796041612)
,p_db_column_name=>'ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131764503548695145)
,p_db_column_name=>'PACKAGE_NAME'
,p_display_order=>12
,p_column_identifier=>'V'
,p_column_label=>'Package Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131764586281695146)
,p_db_column_name=>'PROCEDURE_NAME'
,p_display_order=>22
,p_column_identifier=>'W'
,p_column_label=>'Procedure Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131764707238695147)
,p_db_column_name=>'ERROR'
,p_display_order=>32
,p_column_identifier=>'X'
,p_column_label=>'Error'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131764831275695148)
,p_db_column_name=>'ARG1_NAME'
,p_display_order=>42
,p_column_identifier=>'Y'
,p_column_label=>'Arg1 Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131764943633695149)
,p_db_column_name=>'ARG1_VAL'
,p_display_order=>52
,p_column_identifier=>'Z'
,p_column_label=>'Arg1 Val'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765020288695150)
,p_db_column_name=>'ARG2_NAME'
,p_display_order=>62
,p_column_identifier=>'AA'
,p_column_label=>'Arg2 Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765127845695151)
,p_db_column_name=>'ARG2_VAL'
,p_display_order=>72
,p_column_identifier=>'AB'
,p_column_label=>'Arg2 Val'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765257059695152)
,p_db_column_name=>'ARG3_NAME'
,p_display_order=>82
,p_column_identifier=>'AC'
,p_column_label=>'Arg3 Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765299685695153)
,p_db_column_name=>'ARG3_VAL'
,p_display_order=>92
,p_column_identifier=>'AD'
,p_column_label=>'Arg3 Val'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765413423695154)
,p_db_column_name=>'ARG4_NAME'
,p_display_order=>102
,p_column_identifier=>'AE'
,p_column_label=>'Arg4 Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765550067695155)
,p_db_column_name=>'ARG4_VAL'
,p_display_order=>112
,p_column_identifier=>'AF'
,p_column_label=>'Arg4 Val'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765588026695156)
,p_db_column_name=>'ARG5_NAME'
,p_display_order=>122
,p_column_identifier=>'AG'
,p_column_label=>'Arg5 Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765691622695157)
,p_db_column_name=>'ARG5_VAL'
,p_display_order=>132
,p_column_identifier=>'AH'
,p_column_label=>'Arg5 Val'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765782328695158)
,p_db_column_name=>'CREATED'
,p_display_order=>142
,p_column_identifier=>'AI'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765935733695159)
,p_db_column_name=>'CREATED_TRUNC'
,p_display_order=>152
,p_column_identifier=>'AJ'
,p_column_label=>'Created Trunc'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(28131765988550695160)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>162
,p_column_identifier=>'AK'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(76976957665729041631)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'118737241'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_report_columns=>'PACKAGE_NAME:PROCEDURE_NAME:ERROR:ARG1_NAME:ARG1_VAL:CREATED_BY:CREATED:'
,p_sort_column_1=>'CREATED'
,p_sort_direction_1=>'DESC'
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
 p_id=>wwv_flow_imp.id(106081014210125469699)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28205423221872881079)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(106081014210125469699)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:16000:&SESSION.::&DEBUG.:RR,16000::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28205423617517881079)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(106081014210125469699)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
