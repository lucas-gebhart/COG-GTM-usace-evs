prompt --application/pages/page_00146
begin
--   Manifest
--     PAGE: 00146
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
 p_id=>146
,p_name=>'Links'
,p_alias=>'LINKS-IR'
,p_step_title=>'Links'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(45067720961302709863)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'All Links with this application along with what object they are associated with (e.g. &NOMENCLATURE_INITIATIVE., &NOMENCLATURE_PROJECT.) and by whom and when they were added.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53550869083245945887)
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(53550869836809945890)
,p_plug_name=>'Links Interactive Report'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select name,',
'       link_name,',
'       link_url,',
'       created,',
'       added_by,',
'       important,',
'       release,',
'       tags,',
'       action',
'  from (',
'select p.project name,',
'       d.link_name,',
'       case when lower(d.link_url) not like ''http%'' then ''http://'' end || d.link_url link_url,',
'       d.created,',
'       lower(d.created_by) added_by,',
'       decode(d.important_yn,''Y'',''Yes'',''No'') important,',
'       case when p.release_id is not null',
'            then (select release_train||'' ''||release from sp_release_trains where id = p.release_id)',
'            else ''Not Targeted''',
'            end release,',
'       p.tags,',
'       ''<a href="''||apex_util.prepare_URL(',
'                            p_url => ''f?p=''||:APP_ID||'':3:''||:APP_SESSION||''::NO:3:P3_PROJECT_ID:''||p.id,',
'                            p_checksum_type => ''3'')||''">''||:NOMENCLATURE_PROJECT||'': ''||apex_escape.html(p.project)||''</a>'' action',
'  from SP_PROJECT_LINKS d,',
'       sp_projects p',
' where project_id = p.id and',
'       p.ARCHIVED_YN = ''N'' and ',
'       p.DUPLICATE_OF_PROJECT_ID is null',
'union all',
'select r.release_train ||'' '' ||r.release name,',
'       d.link_name,',
'       case when lower(d.link_url) not like ''http%'' then ''http://'' end || d.link_url link_url,',
'       d.created,',
'       lower(d.created_by) added_by,',
'       decode(d.important_yn,''Y'',''Yes'',''No'') important,',
'       release_train||'' ''||release release,',
'       null tags,',
'       ''<a href="''||apex_util.prepare_URL(',
'                            p_url => ''f?p=''||:APP_ID||'':117:''||:APP_SESSION||''::NO:117:P117_RELEASE_ID:''||r.id,',
'                            p_checksum_type => ''3'')||''">''||''Release: ''||apex_escape.html(r.release_train||'' ''||release)||''</a>'' action',
'  from SP_RELEASE_LINKS d,',
'       sp_release_trains r',
' where r.id = d.release_id',
'union all',
'select a.area || '' / '' ||initiative name,',
'       d.link_name,',
'       case when lower(d.link_url) not like ''http%'' then ''http://'' end || d.link_url link_url,',
'       d.created,',
'       lower(d.created_by) added_by,',
'       decode(d.important_yn,''Y'',''Yes'',''No'') important,',
'       null release,',
'       i.tags,',
'       ''<a href="''||apex_util.prepare_URL(',
'                            p_url => ''f?p=''||:APP_ID||'':94:''||:APP_SESSION||''::NO:94:P94_INITIATIVE_ID:''||i.id,',
'                            p_checksum_type => ''3'')||''">''||:NOMENCLATURE_INITIATIVE||'': ''||apex_escape.html(i.initiative)||''</a>'' action',
'  from SP_INITIATIVE_LINKS d,',
'       sp_initiatives i,',
'       sp_areas a',
' where d.initiative_id = i.id',
'   and i.area_id = a.id',
'union all',
'select p.project || '' / '' ||',
'         (select task_type from sp_task_types rt where rt.id = t.task_type_id)||',
'           case when t.task_sub_type_id is not null then '': '' end ||',
'           (select task_type from sp_task_types rt where rt.id = t.task_sub_type_id) name,',
'       d.link_name,',
'       case when lower(d.link_url) not like ''http%'' then ''http://'' end || d.link_url link_url,',
'       d.created,',
'       lower(d.created_by) added_by,',
'       decode(d.important_yn,''Y'',''Yes'',''No'') important,',
'       case when p.release_id is not null',
'            then (select release_train||'' ''||release from sp_release_trains where id = p.release_id)',
'            else ''Not Targeted''',
'            end release,',
'       t.tags,',
'       ''<a href="''||apex_util.prepare_URL(',
'                            p_url => ''f?p=''||:APP_ID||'':502:''||:APP_SESSION||''::NO:502:P502_PREV_PAGE,P502_PROJECT_ID,P502_TASK_ID:3,''||p.id||'',''||t.id,',
'                            p_checksum_type => ''3'')||''">''||',
'           (select apex_escape.html(task_type) from sp_task_types rt where rt.id = t.task_type_id)||',
'           case when t.task_sub_type_id is not null then '': '' end ||',
'           (select apex_escape.html(task_type) from sp_task_types rt where rt.id = t.task_sub_type_id) ||',
'           case when t.task is not null then '' - ''||apex_escape.html(t.task) end ||''</a>'' action',
'  from sp_task_links d,',
'       sp_tasks t,',
'       sp_projects p',
' where p.id = t.project_id',
'   and t.id = d.task_id',
'  )'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Links Interactive Report'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(53550869913239945890)
,p_name=>'Links Interactive Report'
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
,p_owner=>'SHARON.KENNEDY@ORACLE.COM'
,p_internal_uid=>16651512047837978121
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53088315128398006982)
,p_db_column_name=>'ACTION'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Associated With'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550870973658945896)
,p_db_column_name=>'NAME'
,p_display_order=>21
,p_column_identifier=>'B'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550871437773945897)
,p_db_column_name=>'LINK_NAME'
,p_display_order=>31
,p_column_identifier=>'C'
,p_column_label=>'Link'
,p_column_link=>'#LINK_URL#'
,p_column_linktext=>'#LINK_NAME#'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550871830719945898)
,p_db_column_name=>'LINK_URL'
,p_display_order=>41
,p_column_identifier=>'D'
,p_column_label=>'Link URL'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550873802883945902)
,p_db_column_name=>'IMPORTANT'
,p_display_order=>51
,p_column_identifier=>'I'
,p_column_label=>'Important'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550874225251945902)
,p_db_column_name=>'RELEASE'
,p_display_order=>61
,p_column_identifier=>'J'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53088315194560006983)
,p_db_column_name=>'TAGS'
,p_display_order=>81
,p_column_identifier=>'L'
,p_column_label=>'Tags'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550873411908945901)
,p_db_column_name=>'ADDED_BY'
,p_display_order=>91
,p_column_identifier=>'H'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(53550872600947945899)
,p_db_column_name=>'CREATED'
,p_display_order=>101
,p_column_identifier=>'F'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(53550973645846977043)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'166516158'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ACTION:NAME:LINK_NAME:IMPORTANT:ADDED_BY:CREATED'
,p_sort_column_1=>'CREATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53551612942073288002)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(53550869083245945887)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:146:&SESSION.::&DEBUG.:RR,146,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(53551883317758044155)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(53550869083245945887)
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
