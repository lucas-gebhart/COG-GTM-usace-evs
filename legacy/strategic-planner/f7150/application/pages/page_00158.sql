prompt --application/pages/page_00158
begin
--   Manifest
--     PAGE: 00158
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
 p_id=>158
,p_name=>'Comments Interactive Report'
,p_alias=>'COMMENTS-IR'
,p_step_title=>'Comments'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45066659146316698292)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.no-item-ui {',
'  --a-field-input-border-width: 0px;',
'  --a-field-input-background-color: transparent;',
'}',
'',
'.overline {',
'  color: var(--ut-region-text-color, var(--ut-component-text-default-color));',
'}'))
,p_step_template=>4072355960268175073
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'All Comments with this application along with what object they are associated with (e.g. &NOMENCLATURE_INITIATIVE., &NOMENCLATURE_PROJECT.) and by whom and when they were added.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66299305813763102332)
,p_plug_name=>'&NOMENCLATURE_PROJECT. Comments'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'       created comment_date,',
'       created created_full,',
'       comment_type,',
'       area,',
'       initiative,',
'       release,',
'       project,',
'       author,',
'       private_yn private,',
'       context,',
'       body comment_text,',
'       body_html,',
'       view_link',
'from (',
'select :NOMENCLATURE_PROJECT comment_type,',
'       a.area,',
'       i.initiative,',
'       '''' Release,',
'       p.project,',
'       p.project context,',
'       substr(c.body_no_images,1,4000) body,',
'       c.body_html,',
'       nvl((select first_name||'' ''||last_name from sp_team_members tm where tm.id = c.author_id),''system'') author,',
'       c.CREATED,',
'       decode(nvl(c.private_yn,''N''),''N'',''No'',''Y'',''Yes'',''Unknown'') private_yn,',
'       apex_util.prepare_URL(',
'           p_url => ''f?p=''||:APP_ID||'':3:''||:APP_SESSION||''::NO:3:P3_PROJECT_ID:''||p.id,',
'           p_checksum_type => ''3'') view_link',
'  from SP_PROJECT_COMMENTS_V c,',
'       sp_projects p,',
'       sp_initiatives i,',
'       sp_areas a ',
' where c.author_id is not null and',
'       p.id = c.project_id and',
'       p.initiative_id = i.id and',
'       i.area_id = a.id and',
'       p.DUPLICATE_OF_PROJECT_ID is null and',
'       p.ARCHIVED_YN = ''N'' and ',
'       (nvl(c.private_yn,''N'') = ''N'' or lower(c.created_by) = lower(:app_user) )',
' union all',
'select :NOMENCLATURE_INITIATIVE comment_type,',
'       a.area,',
'       i.initiative,',
'       '''' Release,',
'       '''' project,',
'       i.initiative context,',
'       substr(c.body_no_images,1,4000) body,',
'       c.body_html,',
'       (select first_name||'' ''||last_name from sp_team_members tm where tm.id = c.author_id) author,',
'       c.CREATED,',
'       decode(nvl(c.private_yn,''N''),''N'',''No'',''Y'',''Yes'',''Unknown'') private_yn,',
'       apex_util.prepare_URL(',
'           p_url => ''f?p=''||:APP_ID||'':94:''||:APP_SESSION||''::NO:94:P94_INITIATIVE_ID:''||i.id,',
'           p_checksum_type => ''3'')view_link',
'from SP_INITIATIVE_COMMENTS_V c,',
'     sp_initiatives i,',
'     sp_areas a ',
' where c.author_id is not null and',
'       c.initiative_id = i.id and',
'       i.area_id = a.id and',
'       (nvl(c.private_yn,''N'') = ''N'' or lower(c.created_by) = lower(:app_user) )',
'union all',
'select ''Release'' comment_type,',
'       '''' area,',
'       '''' initiative,',
'       r.release_train||'' ''||release release,',
'       '''' project,',
'       r.release_train||'' ''||release context,',
'       substr(c.body_no_images,1,4000) body,',
'       c.body_html,',
'       (select first_name||'' ''||last_name from sp_team_members tm where tm.id = c.author_id) author,',
'       c.CREATED,',
'       decode(nvl(c.private_yn,''N''),''N'',''No'',''Y'',''Yes'',''Unknown'') private_yn,',
'       apex_util.prepare_URL(',
'           p_url => ''f?p=''||:APP_ID||'':117:''||:APP_SESSION||''::NO:117:P117_RELEASE_ID:''||r.id,',
'           p_checksum_type => ''3'') view_link',
'from SP_RELEASE_COMMENTS_V c,',
'     sp_release_trains r',
' where c.release_id = r.id and',
'       c.author_id is not null and',
'       (nvl(c.private_yn,''N'') = ''N'' or lower(c.created_by) = lower(:app_user) )',
'union all',
'select ''Task'' comment_type,',
'       a.area,',
'       i.initiative,',
'       '''' Release,',
'       p.project,',
'       (select task_type from sp_task_types rt where rt.id = t.task_type_id)||',
'           case when t.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = t.task_sub_type_id) ||',
'           case when t.task is not null then '' - ''||t.task end context,',
'       substr(c.body_no_images,1,4000) body,',
'       c.body_html,',
'       (select first_name||'' ''||last_name from sp_team_members tm where tm.id = c.author_id) author,',
'       c.CREATED,',
'       decode(nvl(c.private_yn,''N''),''N'',''No'',''Y'',''Yes'',''Unknown'') private_yn,',
'      apex_util.prepare_URL(',
'          p_url => ''f?p=''||:APP_ID||'':502:''||:APP_SESSION||''::NO:502:P502_PREV_PAGE,P502_PROJECT_ID,P502_TASK_ID:3,''||p.id||'',''||t.id,',
'          p_checksum_type => ''3'') view_link',
'  from SP_TASK_COMMENTS_V c,',
'       sp_tasks t,',
'       sp_projects p,',
'       sp_initiatives i,',
'       sp_areas a ',
' where c.author_id is not null and',
'       t.id = c.task_id and',
'       t.project_id = p.id and',
'       p.initiative_id = i.id and',
'       i.area_id = a.id and',
'       p.DUPLICATE_OF_PROJECT_ID is null and',
'       p.ARCHIVED_YN = ''N'' and ',
'       (nvl(c.private_yn,''N'') = ''N'' or lower(c.created_by) = lower(:app_user) )',
') '))
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
 p_id=>wwv_flow_imp.id(24160501601625089334)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'#VIEW_LINK#'
,p_detail_link_text=>'<img src="#APEX_FILES#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="View in Context">'
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>24158962019757031206
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160502776170089345)
,p_db_column_name=>'COMMENT_TYPE'
,p_display_order=>10
,p_column_identifier=>'G'
,p_column_label=>'Associated With'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503467950089352)
,p_db_column_name=>'CONTEXT'
,p_display_order=>20
,p_column_identifier=>'M'
,p_column_label=>'Comment On'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160502826424089346)
,p_db_column_name=>'AREA'
,p_display_order=>30
,p_column_identifier=>'H'
,p_column_label=>'Area'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160502965446089347)
,p_db_column_name=>'INITIATIVE'
,p_display_order=>40
,p_column_identifier=>'I'
,p_column_label=>'Initiative'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160502474759089342)
,p_db_column_name=>'COMMENT_TEXT'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Comment'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503033257089348)
,p_db_column_name=>'RELEASE'
,p_display_order=>60
,p_column_identifier=>'J'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503082386089349)
,p_db_column_name=>'AUTHOR'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Author'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503644769089354)
,p_db_column_name=>'PRIVATE'
,p_display_order=>90
,p_column_identifier=>'O'
,p_column_label=>'Private'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160501868425089336)
,p_db_column_name=>'COMMENT_DATE'
,p_display_order=>100
,p_column_identifier=>'B'
,p_column_label=>'Comment Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503686585089355)
,p_db_column_name=>'PROJECT'
,p_display_order=>110
,p_column_identifier=>'P'
,p_column_label=>'Project'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24160503872780089356)
,p_db_column_name=>'VIEW_LINK'
,p_display_order=>120
,p_column_identifier=>'Q'
,p_column_label=>'View Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178318342202483250)
,p_db_column_name=>'BODY_HTML'
,p_display_order=>130
,p_column_identifier=>'R'
,p_column_label=>'Body Html'
,p_column_type=>'CLOB'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178319353784483260)
,p_db_column_name=>'CREATED_FULL'
,p_display_order=>140
,p_column_identifier=>'S'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-Mon-YYYY HH:MIPM'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(24164274238736286674)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'241627347'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COMMENT_TYPE:CONTEXT:COMMENT_TEXT:AUTHOR:COMMENT_DATE'
,p_sort_column_1=>'COMMENT_DATE'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(185936984701645108310)
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
 p_id=>wwv_flow_imp.id(24160501539385089333)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(185936984701645108310)
,p_button_name=>'Filter-Report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Filter Report'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24160501432471089332)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(185936984701645108310)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:158:&SESSION.::&DEBUG.:158,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24163914826477909307)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(185936984701645108310)
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
