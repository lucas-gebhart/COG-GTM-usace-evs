prompt --application/pages/page_00051
begin
--   Manifest
--     PAGE: 00051
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
 p_id=>51
,p_name=>'Duplicate Projects'
,p_alias=>'DUPLICATE-PROJECTS'
,p_step_title=>'Duplicate Projects'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(47769086658539422762)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'All &NOMENCLATURE_PROJECTS. that have been marked as duplicates and which they are a duplicate of.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60238911417503727799)
,p_plug_name=>'Duplidate &NOMENCLATURE_PROJECTS.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       (select initiative from sp_initiatives i where i.id = p.INITIATIVE_ID) initiative,',
'       (select area from sp_areas f where id = (select area_id from sp_initiatives i where i.id = p.INITIATIVE_ID)) area,',
'       PROJECT,',
'       (select FIRST_NAME ||'' ''||last_name from SP_TEAM_MEMBERS x where x.ID = p.OWNER_ID) owner,',
'       TARGET_COMPLETE,',
'       pct_complete,',
'       (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id) release,',
'       PROJECT_SIZE,',
'       DESCRIPTION,',
'       TAGS,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       DUPLICATE_OF_PROJECT_ID,',
'       (select project from sp_projects p2 where p2.id = p.DUPLICATE_OF_PROJECT_ID) duplicate_of,',
'       --',
'       -- initiative focus area',
'       --',
'       nvl((select focus_area from sp_initiative_focus_areas where id = p.focus_area_id),''Not Identified'') Init_focus_area',
'  from SP_PROJECTS p',
' where p.DUPLICATE_OF_PROJECT_ID is not null',
'   and p.ARCHIVED_YN = ''N'''))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Duplidate &NOMENCLATURE_PROJECTS.'
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
 p_id=>wwv_flow_imp.id(60238911510140727799)
,p_name=>'Archived &NOMENCLATURE_PROJECTS.'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'MIKE'
,p_internal_uid=>23339553644738760030
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574094710412474924)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574095073057474924)
,p_db_column_name=>'PROJECT'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'&NOMENCLATURE_PROJECT.'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_PROJECT_ID:#ID#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574095506052474924)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Target Complete'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD-Mon-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574096305931474925)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Project Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574096713221474925)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Description'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574099113007474927)
,p_db_column_name=>'TAGS'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574100338834474928)
,p_db_column_name=>'CREATED'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574100702927474928)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574101123749474929)
,p_db_column_name=>'UPDATED'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE_SHORT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574101474481474929)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574103482423474930)
,p_db_column_name=>'DUPLICATE_OF_PROJECT_ID'
,p_display_order=>28
,p_column_identifier=>'AB'
,p_column_label=>'Duplicate of Project ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574093465773474923)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>88
,p_column_identifier=>'AH'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574093946596474923)
,p_db_column_name=>'AREA'
,p_display_order=>98
,p_column_identifier=>'AI'
,p_column_label=>'Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(48574094323137474923)
,p_db_column_name=>'DUPLICATE_OF'
,p_display_order=>108
,p_column_identifier=>'AJ'
,p_column_label=>'Duplicate of'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_PROJECT_ID:#DUPLICATE_OF_PROJECT_ID#'
,p_column_linktext=>'#DUPLICATE_OF#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(42363574218596683511)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>118
,p_column_identifier=>'AK'
,p_column_label=>'Pct Complete'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(46240432432413837619)
,p_db_column_name=>'INIT_FOCUS_AREA'
,p_display_order=>128
,p_column_identifier=>'AL'
,p_column_label=>'Focus Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178317797926483245)
,p_db_column_name=>'RELEASE'
,p_display_order=>138
,p_column_identifier=>'AM'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178318095651483248)
,p_db_column_name=>'OWNER'
,p_display_order=>148
,p_column_identifier=>'AO'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(60238994800475731834)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'116649051'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:AREA:INITIATIVE:INIT_FOCUS_AREA:OWNER:UPDATED:DUPLICATE_OF:'
,p_sort_column_1=>'PROJECT'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(60239468300056746026)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48574090384213474918)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(60239468300056746026)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP,51,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48574090860467474918)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(60239468300056746026)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
