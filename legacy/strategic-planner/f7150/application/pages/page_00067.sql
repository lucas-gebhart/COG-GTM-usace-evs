prompt --application/pages/page_00067
begin
--   Manifest
--     PAGE: 00067
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
 p_id=>67
,p_name=>'Contributor_roles'
,p_alias=>'CONTRIBUTOR-ROLES'
,p_page_mode=>'MODAL'
,p_step_title=>'Contributor Roles'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39600692918890397919)
,p_name=>'Contributor Roles'
,p_template=>4501440665235496320
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       RESOURCE_TYPE,',
'       nvl(RESOURCE_DESCRIPTION,''No description available'') RESOURCE_DESCRIPTION,',
'       decode(IS_DEFAULT_YN,''Y'',''Yes'',''N'',''No'',IS_DEFAULT_YN) as IS_DEFAULT_YN',
'  from SP_RESOURCE_TYPES',
'order by upper(RESOURCE_TYPE)'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39768018707793113470)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39768018816672113471)
,p_query_column_id=>2
,p_column_alias=>'RESOURCE_TYPE'
,p_column_display_sequence=>20
,p_column_heading=>'Role'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39768018871831113472)
,p_query_column_id=>3
,p_column_alias=>'RESOURCE_DESCRIPTION'
,p_column_display_sequence=>30
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39768018970403113473)
,p_query_column_id=>4
,p_column_alias=>'IS_DEFAULT_YN'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp.component_end;
end;
/
