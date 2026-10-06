prompt --application/pages/page_00079
begin
--   Manifest
--     PAGE: 00079
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
 p_id=>79
,p_name=>'Change History'
,p_alias=>'CHANGE-HISTORY-IR'
,p_step_title=>'Change History'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(47769086658539422762)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'Changes made across &NOMENCLATURE_INITIATIVES., &NOMENCLATURE_PROJECTS., &NOMENCLATURE_PROJECT. Milestones, Reviews, Tasks and Releases.  Includes old and new values and who made the change and when the change was made.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57793211501476928785)
,p_plug_name=>'Change History'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select change_to,',
'       parent_type,',
'       object,',
'       owner,',
'       view_link,                   ',
'       favorite,',
'       ATTRIBUTE_CHANGE_DATE,',
'       change_type,',
'       ATTRIBUTE_COLUMN,',
'       OLD_VALUE,',
'       NEW_VALUE,',
'       changed_by,',
'       release',
'  from (',
'select :NOMENCLATURE_PROJECT               change_to,',
'       :NOMENCLATURE_PROJECT               parent_type,',
'       p.project                           object,',
'       (select tm.first_name||'' ''||tm.last_name',
'        from   sp_team_members TM  ',
'        where  tm.id = p.OWNER_ID)         owner,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':3:''||:APP_SESSION||''::NO:3:FI,PN:''||apex_escape.html(p.FRIENDLY_IDENTIFIER)||'',''||apex_escape.html(p.PROJECT_URL_NAME)) view_link,',
'       --',
'       case when f.project_id is not null then ''Yes'' else ''No'' end favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       case pc.change_type when ''CREATE'' then ''Addition''',
'                           when ''UPDATE'' then ''Update''',
'                           when ''DELETE'' then ''Delete''',
'                           else pc.change_type',
'            end change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id) release',
'  from SP_PROJECT_HISTORY pc,',
'       sp_projects p,',
'       sp_favorites f',
' where p.id = pc.project_id',
'   and p.ARCHIVED_YN = ''N''',
'   and p.duplicate_of_project_id is null',
'   and p.id = f.project_id (+)',
'   and (f.team_member_id = :APP_USER_ID or f.team_member_id is null)',
'union all',
'select :NOMENCLATURE_PROJECT ||'' ''|| tt.task_type ||',
'       case when t.task_sub_type_id is not null',
'            then (select '': ''||task_type from sp_task_types where t.task_sub_type_id = id)',
'            end change_to,',
'       :NOMENCLATURE_PROJECT ||'' ''|| case when tt.task_type in (''Review'',''Milestone'') then tt.task_type',
'                                          else ''Task'' end parent_type,',
'       p.project                           object,',
'       (select tm.first_name||'' ''||tm.last_name',
'        from   sp_team_members TM  ',
'        where  tm.id = p.OWNER_ID)         owner,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':502:''||:APP_SESSION||''::NO:502:P502_PREV_PAGE,P502_TASK_ID,P502_PROJECT_ID:3,''||t.id||'',''||p.id) view_link,',
'       --',
'       case when f.project_id is not null then ''Yes'' else ''No'' end favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       case pc.change_type when ''CREATE'' then ''Addition''',
'                           when ''UPDATE'' then ''Update''',
'                           when ''DELETE'' then ''Delete''',
'                           else pc.change_type',
'            end change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       (select t.release_train||'' ''||t.release from SP_RELEASE_TRAINS t where t.id = p.release_id) release',
'  from sp_task_history pc,',
'       sp_tasks t,',
'       sp_task_types tt,',
'       sp_projects p,',
'       sp_favorites f',
' where pc.task_id = t.id',
'   and t.task_type_id = tt.id',
'   and t.project_id = p.id',
'   and p.ARCHIVED_YN = ''N''',
'   and p.duplicate_of_project_id is null',
'   and p.id = f.project_id (+)',
'   and (f.team_member_id = :APP_USER_ID or f.team_member_id is null)',
'union all',
'select ''Release''               change_to,',
'       ''Release''               parent_type,',
'       p.release_train||'' ''||p.release object,',
'       (select tm.first_name||'' ''||tm.last_name',
'        from   sp_team_members TM  ',
'        where  tm.id = p.RELEASE_OWNER_ID) owner,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':117:''||:APP_SESSION||''::NO:117:P117_RELEASE_ID:''||p.id) view_link,                    ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       case pc.change_type when ''CREATE'' then ''Addition''',
'                           when ''UPDATE'' then ''Update''',
'                           when ''DELETE'' then ''Delete''',
'                           else pc.change_type',
'            end change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       p.release_train||'' ''||p.release release',
'  from SP_RELEASE_HISTORY pc,',
'       sp_release_trains p',
' where p.id = pc.release_id',
'union all',
'select :NOMENCLATURE_INITIATIVE  change_to,',
'       :NOMENCLATURE_INITIATIVE  parent_type,',
'       p.initiative              object,',
'       (select tm.first_name||'' ''||tm.last_name',
'        from   sp_team_members TM  ',
'        where  tm.id = p.sponsor_id) owner,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':94:''||:APP_SESSION||''::NO:94:P94_INITIATIVE_ID:''||p.id) view_link,                  ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       case pc.change_type when ''CREATE'' then ''Addition''',
'                           when ''UPDATE'' then ''Update''',
'                           when ''DELETE'' then ''Delete''',
'                           else pc.change_type',
'            end change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       null release',
'  from SP_INITIATIVE_HISTORY pc,',
'       sp_initiatives p',
' where p.id = pc.initiative_id',
'union all',
'select :NOMENCLATURE_INITIATIVE  change_to,',
'       :NOMENCLATURE_INITIATIVE||'' Focus Area''  parent_type,',
'       p.initiative||'' - ''||a.focus_area  object,',
'       (select tm.first_name||'' ''||tm.last_name',
'        from   sp_team_members TM  ',
'        where  tm.id = a.development_owner_id) owner,',
'       apex_util.prepare_url(''f?p=''||:APP_ID||'':33:''||:APP_SESSION||''::NO:33:P33_INIT_FOCUS_AREA_ID:''||a.id) view_link,                    ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       case pc.change_type when ''CREATE'' then ''Addition''',
'                           when ''UPDATE'' then ''Update''',
'                           when ''DELETE'' then ''Delete''',
'                           else pc.change_type',
'            end change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       null release',
'  from SP_INIT_FOCUS_AREA_HISTORY pc,',
'       sp_initiative_focus_areas a,',
'       sp_initiatives p',
' where pc.init_focus_area_id = a.id',
'   and p.id = a.initiative_id',
'union all',
'select :NOMENCLATURE_PROJECT       change_to,',
'       :NOMENCLATURE_PROJECT       parent_type,',
'       old_value                   object,',
'       null owner,',
'       ''#'' view_link,                  ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       ''Delete'' change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       null release',
'  from SP_PROJECT_HISTORY pc',
' where change_type = ''DELETE''',
'   and attribute_column = ''PROJECT''',
'union all',
'select :NOMENCLATURE_INITIATIVE  change_to,',
'       :NOMENCLATURE_INITIATIVE  parent_type,',
'       old_value                 object,',
'       null owner,',
'       ''#'' view_link,                  ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       ''Delete'' change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       null release',
'  from SP_INITIATIVE_HISTORY pc',
' where change_type = ''DELETE''',
'   and attribute_column = ''INITIATIVE''',
'union all',
'select ''Release''               change_to,',
'       ''Release''               parent_type,',
'       old_value                 object,',
'       null owner,',
'       ''#'' view_link,                  ',
'       --',
'       null favorite,',
'       pc.changed_on ATTRIBUTE_CHANGE_DATE,',
'       ''Delete'' change_type,',
'       --',
'       initcap(replace(pc.attribute_column,''_'','' '')) ATTRIBUTE_COLUMN,',
'       decode(pc.old_value,''Y'',''Yes'',''N'',''No'',old_value) OLD_VALUE,',
'       decode(pc.new_value,''Y'',''Yes'',''N'',''No'',new_value) NEW_VALUE,',
'       pc.changed_by,',
'       --',
'       -- release',
'       --',
'       null release',
'  from SP_RELEASE_HISTORY pc',
' where change_type = ''DELETE''',
'   and attribute_column = ''RELEASE''',
')'))
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
 p_id=>wwv_flow_imp.id(44073261590920604784)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SBKENNED'
,p_internal_uid=>7173903725518637015
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073262772065604796)
,p_db_column_name=>'ATTRIBUTE_CHANGE_DATE'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Attribute Change Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-MON-YYYY HH:MIPM'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178317042397483237)
,p_db_column_name=>'PARENT_TYPE'
,p_display_order=>30
,p_column_identifier=>'W'
,p_column_label=>'Parent Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178317119306483238)
,p_db_column_name=>'OBJECT'
,p_display_order=>40
,p_column_identifier=>'X'
,p_column_label=>'Object Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_help_text=>'Name of object changed.'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073261731014604785)
,p_db_column_name=>'CHANGE_TO'
,p_display_order=>50
,p_column_identifier=>'A'
,p_column_label=>'Change To'
,p_column_link=>'#VIEW_LINK#'
,p_column_linktext=>'#CHANGE_TO#'
,p_column_link_attr=>'alt="View Object"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073262249982604790)
,p_db_column_name=>'OWNER'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073262733191604795)
,p_db_column_name=>'FAVORITE'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Favorite'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073262992203604798)
,p_db_column_name=>'CHANGE_TYPE'
,p_display_order=>80
,p_column_identifier=>'N'
,p_column_label=>'Change Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073263098018604799)
,p_db_column_name=>'ATTRIBUTE_COLUMN'
,p_display_order=>90
,p_column_identifier=>'O'
,p_column_label=>'Column Changed'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073263165815604800)
,p_db_column_name=>'OLD_VALUE'
,p_display_order=>100
,p_column_identifier=>'P'
,p_column_label=>'Old Value'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073263317372604801)
,p_db_column_name=>'NEW_VALUE'
,p_display_order=>110
,p_column_identifier=>'Q'
,p_column_label=>'New Value'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073263455158604802)
,p_db_column_name=>'CHANGED_BY'
,p_display_order=>120
,p_column_identifier=>'R'
,p_column_label=>'Changed By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(44073263662141604804)
,p_db_column_name=>'RELEASE'
,p_display_order=>130
,p_column_identifier=>'T'
,p_column_label=>'Release'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(24178317242087483239)
,p_db_column_name=>'VIEW_LINK'
,p_display_order=>150
,p_column_identifier=>'Y'
,p_column_label=>'View Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(46235620403610248181)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'93362626'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ATTRIBUTE_CHANGE_DATE:CHANGE_TO:OBJECT:ATTRIBUTE_COLUMN:CHANGE_TYPE:OLD_VALUE:NEW_VALUE:CHANGED_BY'
,p_sort_column_1=>'ATTRIBUTE_CHANGE_DATE'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(58151891356499922719)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24160501322567089331)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(58151891356499922719)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:79:&SESSION.::&DEBUG.:RR,79,CIR,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46235560863799238192)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(58151891356499922719)
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
