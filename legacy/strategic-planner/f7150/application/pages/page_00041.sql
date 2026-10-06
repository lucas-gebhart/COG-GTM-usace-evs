prompt --application/pages/page_00041
begin
--   Manifest
--     PAGE: 00041
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
 p_id=>41
,p_name=>'Reports'
,p_alias=>'REPORTS'
,p_step_title=>'Reports'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(47769086658539422762)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'06'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47013757957611934280)
,p_plug_name=>'Reports from List'
,p_region_template_options=>'#DEFAULT#:margin-top-md'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--displaySubtitle:t-Cards--basic:t-Cards--displayIcons:t-Cards--3cols:t-Cards--iconsRounded:t-Cards--animColorFill'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_location=>null
,p_list_id=>wwv_flow_imp.id(47163355497317693718)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2886769488667748277
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47015349125202045874)
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
 p_id=>wwv_flow_imp.id(47015133184581627810)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(47015349125202045874)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(38991626229329857794)
,p_computation_sequence=>10
,p_computation_item=>'LAST_PROJ_JUMP_PG'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'41'
);
wwv_flow_imp.component_end;
end;
/
