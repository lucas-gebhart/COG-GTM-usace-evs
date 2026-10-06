prompt --application/pages/page_00222
begin
--   Manifest
--     PAGE: 00222
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
 p_id=>222
,p_name=>'Status Scale'
,p_alias=>'STATUS-SCALE'
,p_page_mode=>'MODAL'
,p_step_title=>'Status Scale'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(41363076894551330374)
,p_name=>'&P222_LABEL_E.'
,p_template=>4072358936313175081
,p_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 0 pct_complete, pc0_label project_status, pc0_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 10 pct_complete, pc10_label project_status, pc10_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 20 pct_complete, pc20_label project_status, pc20_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 30 pct_complete, pc30_label project_status, pc30_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 40 pct_complete, pc40_label project_status, pc40_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 50 pct_complete, pc50_label project_status, pc50_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 60 pct_complete, pc60_label project_status, pc60_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 70 pct_complete, pc70_label project_status, pc70_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 80 pct_complete, pc80_label project_status, pc80_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 90 pct_complete, pc90_label project_status, pc90_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'union all',
'select 100 pct_complete, pc100_label project_status, pc100_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''E''',
'order by pct_complete'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_scales ',
' where is_active_yn = ''Y''',
'   and scale_letter = ''E'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(41363077158683330376)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41363077230194330377)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41363077349801330378)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41363077720245330382)
,p_plug_name=>'RDS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_region_icons', 'N',
  'include_show_all', 'Y',
  'rds_mode', 'STANDARD',
  'remember_selection', 'USER')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(154751881955711534942)
,p_name=>'&P222_LABEL_D.'
,p_template=>4072358936313175081
,p_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 0 pct_complete, pc0_label project_status, pc0_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 10 pct_complete, pc10_label project_status, pc10_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 20 pct_complete, pc20_label project_status, pc20_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 30 pct_complete, pc30_label project_status, pc30_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 40 pct_complete, pc40_label project_status, pc40_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 50 pct_complete, pc50_label project_status, pc50_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 60 pct_complete, pc60_label project_status, pc60_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 70 pct_complete, pc70_label project_status, pc70_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 80 pct_complete, pc80_label project_status, pc80_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 90 pct_complete, pc90_label project_status, pc90_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'union all',
'select 100 pct_complete, pc100_label project_status, pc100_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''D''',
'order by pct_complete'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_scales ',
' where is_active_yn = ''Y''',
'   and scale_letter = ''D'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(41459781787167300451)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459783027582300453)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459783432012300453)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(154751883955812534962)
,p_name=>'&P222_LABEL_C.'
,p_template=>4072358936313175081
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 0 pct_complete, pc0_label project_status, pc0_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 10 pct_complete, pc10_label project_status, pc10_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 20 pct_complete, pc20_label project_status, pc20_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 30 pct_complete, pc30_label project_status, pc30_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 40 pct_complete, pc40_label project_status, pc40_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 50 pct_complete, pc50_label project_status, pc50_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 60 pct_complete, pc60_label project_status, pc60_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 70 pct_complete, pc70_label project_status, pc70_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 80 pct_complete, pc80_label project_status, pc80_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 90 pct_complete, pc90_label project_status, pc90_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'union all',
'select 100 pct_complete, pc100_label project_status, pc100_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''C''',
'order by pct_complete'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_scales ',
' where is_active_yn = ''Y''',
'   and scale_letter = ''C'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(41459778662163300448)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459779829178300449)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459780241070300449)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(154768829914839439020)
,p_name=>'&P222_LABEL_B.'
,p_template=>4072358936313175081
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 0 pct_complete, pc0_label project_status, pc0_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 10 pct_complete, pc10_label project_status, pc10_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 20 pct_complete, pc20_label project_status, pc20_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 30 pct_complete, pc30_label project_status, pc30_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 40 pct_complete, pc40_label project_status, pc40_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 50 pct_complete, pc50_label project_status, pc50_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 60 pct_complete, pc60_label project_status, pc60_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 70 pct_complete, pc70_label project_status, pc70_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 80 pct_complete, pc80_label project_status, pc80_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 90 pct_complete, pc90_label project_status, pc90_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'union all',
'select 100 pct_complete, pc100_label project_status, pc100_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''B''',
'order by pct_complete'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_scales ',
' where is_active_yn = ''Y''',
'   and scale_letter = ''B'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(41459775463161300444)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459776641778300445)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>30
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459777052042300445)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(154768830699237439028)
,p_name=>'&P222_LABEL_A.'
,p_template=>4072358936313175081
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 0 pct_complete, pc0_label project_status, pc0_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 10 pct_complete, pc10_label project_status, pc10_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 20 pct_complete, pc20_label project_status, pc20_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 30 pct_complete, pc30_label project_status, pc30_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 40 pct_complete, pc40_label project_status, pc40_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 50 pct_complete, pc50_label project_status, pc50_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 60 pct_complete, pc60_label project_status, pc60_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 70 pct_complete, pc70_label project_status, pc70_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 80 pct_complete, pc80_label project_status, pc80_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 90 pct_complete, pc90_label project_status, pc90_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'union all',
'select 100 pct_complete, pc100_label project_status, pc100_desc description',
'  from SP_PROJECT_SCALES s',
' where scale_letter = ''A''',
'order by pct_complete'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from sp_project_scales ',
' where is_active_yn = ''Y''',
'   and scale_letter = ''A'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_imp.id(41459772214452300431)
,p_query_column_id=>1
,p_column_alias=>'PCT_COMPLETE'
,p_column_display_sequence=>20
,p_column_heading=>'Complete'
,p_column_html_expression=>'#PCT_COMPLETE#%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459773400298300433)
,p_query_column_id=>2
,p_column_alias=>'PROJECT_STATUS'
,p_column_display_sequence=>50
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(41459773787318300433)
,p_query_column_id=>3
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>60
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(154751895073160534986)
,p_name=>'P222_LABEL_E'
,p_item_sequence=>110
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(154751895218529534987)
,p_name=>'P222_LABEL_D'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(154751895301085534988)
,p_name=>'P222_LABEL_C'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(154751895392520534989)
,p_name=>'P222_LABEL_B'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(154751895519672534990)
,p_name=>'P222_LABEL_A'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41459785957414300466)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'load labels'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select scale_letter, scale_name',
'    from sp_project_scales ',
'    where is_active_yn = ''Y''',
'    order by scale_letter) loop',
'    if    c1.scale_letter = ''A'' then :P222_LABEL_A := c1.scale_name;',
'    elsif c1.scale_letter = ''B'' then :P222_LABEL_B := c1.scale_name;',
'    elsif c1.scale_letter = ''C'' then :P222_LABEL_C := c1.scale_name;',
'    elsif c1.scale_letter = ''D'' then :P222_LABEL_D := c1.scale_name;',
'    elsif c1.scale_letter = ''E'' then :P222_LABEL_E := c1.scale_name;',
'    end if;',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>4560428092012332697
);
wwv_flow_imp.component_end;
end;
/
