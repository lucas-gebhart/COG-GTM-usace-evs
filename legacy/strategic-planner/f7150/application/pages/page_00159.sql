prompt --application/pages/page_00159
begin
--   Manifest
--     PAGE: 00159
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
 p_id=>159
,p_name=>'Project Contributors'
,p_alias=>'PROJECT-CONTRIBUTORS-IR'
,p_step_title=>'&NOMENCLATURE_PROJECT. Contributors'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45067720961302709863)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.no-item-ui {',
'    --a-field-input-border-width: 0;',
'    --a-field-input-background-color: transparent;',
'}',
'.overline {',
'  color: var(--ut-region-text-color,var(--ut-component-text-default-color));',
'}',
'',
'.a-FS-facetsDashboard {--a-fs-chart-grid-gap: 0;',
'       --a-fs-chart-border-width: 0;',
'       --a-fs-chart-shadow: none;',
'}',
''))
,p_step_template=>4072355960268175073
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'Each &NOMENCLATURE_USER. contributing to a &NOMENCLATURE_PROJECT. along with the role they are assigned.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62294131381251688174)
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62294132015256688176)
,p_plug_name=>'Search Results'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.*, case when release_link is not null',
'                 then ''<a href="''||release_link||''">''||apex_escape.html(release)||''</a>''',
'                 else apex_escape.html(release)',
'                 end release_display',
'  from',
' (',
'select tm.first_name||'' ''||tm.last_name name, ',
'       tm.id team_member_id,',
'       r.resource_type, ',
'       p.project, ',
'       i.INITIATIVE,',
'       (select f.area from sp_areas f where f.id = i.area_id) area,',
'       (select focus_area from sp_initiative_focus_areas where id = p.focus_area_id) focus_area,',
'       p.tags,',
'       p.updated,',
'       p.friendly_identifier,',
'       p.project_url_name,',
'       case when p.release_id is not null',
'            then (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id)',
'            else ''Not Targeted''',
'            end release,',
'       case when p.release_id is not null',
'            then APEX_PAGE.GET_URL (',
'                     p_page   => 117,',
'                     p_items  => ''P117_RELEASE_ID'',',
'                     p_values => p.release_id ) ',
'            end release_link,',
'       p.target_complete,',
'       p.PROJECT_SIZE,',
'       ''P''||nvl(to_char(pp.PRIORITY),''X'') PRIORITY,',
'       to_char(p.PCT_COMPLETE)||''%'' PCT_COMPLETE',
'from SP_PROJECT_CONTRIBUTORS pc,',
'     SP_TEAM_MEMBERS tm,',
'     SP_PROJECTS p,',
'     SP_RESOURCE_TYPES r,',
'     SP_INITIATIVES i,',
'     SP_PROJECT_PRIORITIES pp',
'where pc.TEAM_MEMBER_ID = tm.id and',
'      pc.PROJECT_ID = p.id and',
'      p.INITIATIVE_ID = i.id and',
'      pc.RESPONSIBILITY_ID  = r.id and',
'      p.PRIORITY_ID = pp.id(+)',
' ) x'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
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
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(24160504145054089359)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>24158964563186031231
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160504264650089360)
,p_db_column_name=>'NAME'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Contributor'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:73:P73_TEAM_MEMBER_ID:#TEAM_MEMBER_ID#'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160504323077089361)
,p_db_column_name=>'RESOURCE_TYPE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Resource Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160504464240089362)
,p_db_column_name=>'PROJECT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Project'
,p_column_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3:FI,PN:#FRIENDLY_IDENTIFIER#,#PROJECT_URL_NAME#'
,p_column_linktext=>'#PROJECT#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160504661850089364)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160504760723089365)
,p_db_column_name=>'AREA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505921195089377)
,p_db_column_name=>'PROJECT_SIZE'
,p_display_order=>70
,p_column_identifier=>'R'
,p_column_label=>'Project Size'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160506047069089378)
,p_db_column_name=>'PRIORITY'
,p_display_order=>80
,p_column_identifier=>'S'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178316442257483231)
,p_db_column_name=>'PCT_COMPLETE'
,p_display_order=>90
,p_column_identifier=>'V'
,p_column_label=>'Pct Complete'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178316534019483232)
,p_db_column_name=>'RELEASE_DISPLAY'
,p_display_order=>100
,p_column_identifier=>'W'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(30944277343771136846)
,p_db_column_name=>'TARGET_COMPLETE'
,p_display_order=>110
,p_column_identifier=>'AB'
,p_column_label=>'Target Complete'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-Mon-YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505059281089368)
,p_db_column_name=>'TAGS'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Project Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505310588089371)
,p_db_column_name=>'UPDATED'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505630446089374)
,p_db_column_name=>'PROJECT_URL_NAME'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Project Url Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505733262089375)
,p_db_column_name=>'RELEASE'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160505840426089376)
,p_db_column_name=>'RELEASE_LINK'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Release Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178316606324483233)
,p_db_column_name=>'FRIENDLY_IDENTIFIER'
,p_display_order=>170
,p_column_identifier=>'X'
,p_column_label=>'Friendly Identifier'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178316817774483235)
,p_db_column_name=>'TEAM_MEMBER_ID'
,p_display_order=>180
,p_column_identifier=>'Z'
,p_column_label=>'Team Member Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178318214240483249)
,p_db_column_name=>'FOCUS_AREA'
,p_display_order=>190
,p_column_identifier=>'AA'
,p_column_label=>'Focus Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(24182023233360495075)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'241804837'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:RESOURCE_TYPE:PROJECT:INITIATIVE:AREA:FOCUS_AREA:UPDATED:'
,p_sort_column_1=>'NAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24178054532014463953)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(62294131381251688174)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:159:&SESSION.::&DEBUG.:RR,159,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24178054943835463953)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(62294131381251688174)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
