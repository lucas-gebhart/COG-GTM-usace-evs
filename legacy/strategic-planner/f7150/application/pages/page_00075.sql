prompt --application/pages/page_00075
begin
--   Manifest
--     PAGE: 00075
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
 p_id=>75
,p_name=>'Current Activity'
,p_alias=>'CURRENT-ACTIVITY'
,p_step_title=>'Current Activity'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39784980351666284990)
,p_name=>'Current Activity'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--inline:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       tm.first_name||'' ''||tm.last_name person,',
'       tm.id team_member_id,',
'       count(distinct p.id) projects,',
'       sum(decode(instr(p.tags,''-COMMITTED''),0,0,1)) tagged_committed,',
'       sum(decode(instr(p.tags,''-TARGETED''),0,0,1)) tagged_tareted,',
'       sum(decode(instr(p.tags,''-QUICK-WIN''),0,0,1)) tagged_quick_win,',
'       sum(decode(instr(p.tags,''-BACKLOG''),0,0,1)) tagged_backlog,',
'       sum(decode(instr(p.tags,''-CANDIDATE''),0,0,1)) tagged_candidate,',
'       --',
'       -- priorities',
'       --',
'       sum(decode(pp.PRIORITY,1,1,0)) p1,',
'       sum(decode(pp.PRIORITY,2,1,0)) p2,',
'       sum(decode(pp.PRIORITY,3,1,0)) p3,',
'       sum(decode(pp.PRIORITY,4,1,0)) p4,',
'       sum(decode(pp.PRIORITY,5,1,0)) p5,',
'       --',
'       -- percent complete',
'       --',
'       sum(decode(p.PCT_COMPLETE,10,1,0)) s10_pct,',
'       sum(decode(p.PCT_COMPLETE,20,1,0)) s20_pct,',
'       sum(decode(p.PCT_COMPLETE,30,1,0)) s30_pct,',
'       sum(decode(p.PCT_COMPLETE,40,1,0)) s40_pct,',
'       sum(decode(p.PCT_COMPLETE,50,1,0)) s50_pct,',
'       sum(decode(p.PCT_COMPLETE,60,1,0)) s60_pct,',
'       sum(decode(p.PCT_COMPLETE,70,1,0)) s70_pct,',
'       sum(decode(p.PCT_COMPLETE,80,1,0)) s80_pct,',
'       sum(decode(p.PCT_COMPLETE,90,1,0)) s90_pct,',
'       sum(decode(p.PCT_COMPLETE,100,1,0)) s100_pct,',
'       --',
'       --',
'       --',
'       LISTAGG(DISTINCT (select release_train||'' ''||release ',
'                         from SP_RELEASE_TRAINS rt',
'                         where rt.id = p.release_id), '', '' ',
'            ON OVERFLOW TRUNCATE WITH COUNT) WITHIN GROUP ',
'            (ORDER BY (select release_train||'' ''||release ',
'                         from SP_RELEASE_TRAINS rt',
'                         where rt.id = p.release_id)) releases',
'from sp_activities ap,',
'     sp_projects p,',
'     sp_activity_types at,',
'     sp_team_members tm,',
'     SP_PROJECT_PRIORITIES pp',
'where ap.project_id = p.id and',
'      p.priority_id = pp.id and',
'      ap.activity_type_id = at.id and',
'      ap.team_member_id = tm.id and',
'      p.DUPLICATE_OF_PROJECT_ID is null and',
'      p.ARCHIVED_YN = ''N'' and',
'      trunc(sysdate) between ap.start_date and ap.end_date and',
'      (:P75_RELEASE = 0 or p.release_id = :P75_RELEASE)',
'group by tm.first_name, tm.last_name, tm.id'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P75_RELEASE'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_report_total_text_format=>'&nbsp;'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39784980757947284995)
,p_query_column_id=>1
,p_column_alias=>'PERSON'
,p_column_display_sequence=>1
,p_column_heading=>'Person'
,p_column_link=>'f?p=&APP_ID.:73:&SESSION.::&DEBUG.:RP,73:P73_TEAM_MEMBER_ID:#TEAM_MEMBER_ID#'
,p_column_linktext=>'#PERSON#'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39784981107789284996)
,p_query_column_id=>2
,p_column_alias=>'TEAM_MEMBER_ID'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39784981489246284997)
,p_query_column_id=>3
,p_column_alias=>'PROJECTS'
,p_column_display_sequence=>3
,p_column_heading=>'Projects'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785075142788312072)
,p_query_column_id=>4
,p_column_alias=>'TAGGED_COMMITTED'
,p_column_display_sequence=>23
,p_column_heading=>'Tagged Committed'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785075227394312073)
,p_query_column_id=>5
,p_column_alias=>'TAGGED_TARETED'
,p_column_display_sequence=>33
,p_column_heading=>'Tagged Tareted'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785075363027312074)
,p_query_column_id=>6
,p_column_alias=>'TAGGED_QUICK_WIN'
,p_column_display_sequence=>43
,p_column_heading=>'Tagged Quick Win'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785075442254312075)
,p_query_column_id=>7
,p_column_alias=>'TAGGED_BACKLOG'
,p_column_display_sequence=>53
,p_column_heading=>'Tagged Backlog'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785075483535312076)
,p_query_column_id=>8
,p_column_alias=>'TAGGED_CANDIDATE'
,p_column_display_sequence=>63
,p_column_heading=>'Tagged Candidate'
,p_column_format=>'999G999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076147531312082)
,p_query_column_id=>9
,p_column_alias=>'P1'
,p_column_display_sequence=>73
,p_column_heading=>'P1'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076220649312083)
,p_query_column_id=>10
,p_column_alias=>'P2'
,p_column_display_sequence=>83
,p_column_heading=>'P2'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076288353312084)
,p_query_column_id=>11
,p_column_alias=>'P3'
,p_column_display_sequence=>93
,p_column_heading=>'P3'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076412613312085)
,p_query_column_id=>12
,p_column_alias=>'P4'
,p_column_display_sequence=>103
,p_column_heading=>'P4'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076494294312086)
,p_query_column_id=>13
,p_column_alias=>'P5'
,p_column_display_sequence=>113
,p_column_heading=>'P5'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076627731312087)
,p_query_column_id=>14
,p_column_alias=>'S10_PCT'
,p_column_display_sequence=>123
,p_column_heading=>'10%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076745026312088)
,p_query_column_id=>15
,p_column_alias=>'S20_PCT'
,p_column_display_sequence=>133
,p_column_heading=>'20%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076821735312089)
,p_query_column_id=>16
,p_column_alias=>'S30_PCT'
,p_column_display_sequence=>143
,p_column_heading=>'30%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785076924847312090)
,p_query_column_id=>17
,p_column_alias=>'S40_PCT'
,p_column_display_sequence=>153
,p_column_heading=>'40%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077058819312091)
,p_query_column_id=>18
,p_column_alias=>'S50_PCT'
,p_column_display_sequence=>163
,p_column_heading=>'50%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077154607312092)
,p_query_column_id=>19
,p_column_alias=>'S60_PCT'
,p_column_display_sequence=>164
,p_column_heading=>'60%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077231005312093)
,p_query_column_id=>20
,p_column_alias=>'S70_PCT'
,p_column_display_sequence=>183
,p_column_heading=>'70%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077326177312094)
,p_query_column_id=>21
,p_column_alias=>'S80_PCT'
,p_column_display_sequence=>193
,p_column_heading=>'80%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077366239312095)
,p_query_column_id=>22
,p_column_alias=>'S90_PCT'
,p_column_display_sequence=>203
,p_column_heading=>'90%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785077490494312096)
,p_query_column_id=>23
,p_column_alias=>'S100_PCT'
,p_column_display_sequence=>213
,p_column_heading=>'100%'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39785074985636312071)
,p_query_column_id=>24
,p_column_alias=>'RELEASES'
,p_column_display_sequence=>13
,p_column_heading=>'Releases'
,p_column_format=>'999G999G999G999G999G999G990'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39785075570250312077)
,p_plug_name=>'Filter'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>2
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44431020854764998215)
,p_plug_name=>'Breadcrumb'
,p_region_sub_css_classes=>'has-header-actions'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45295364209798013033)
,p_plug_name=>'Menubar'
,p_parent_plug_id=>wwv_flow_imp.id(44431020854764998215)
,p_region_sub_css_classes=>'header-actions'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select 1 as actions from dual'
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'AVATAR_ICON', 'fa-user',
  'AVATAR_SHAPE', 't-Avatar--rounded',
  'AVATAR_TYPE', 'icon',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL_DISPLAY', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(45295365443304013045)
,p_name=>'ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIONS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39785159872215941429)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(44431020854764998215)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39785075703710312078)
,p_name=>'P75_RELEASE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39785075570250312077)
,p_item_default=>'0'
,p_prompt=>'Release'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select release_train||'' ''||release release_train, id ',
'  from SP_RELEASE_TRAINS',
' where id in (select release_id ',
'                from sp_projects p, sp_activities ap',
'               where ap.project_id = p.id ',
'                 and p.ARCHIVED_YN = ''N'' ',
'                 and p.DUPLICATE_OF_PROJECT_ID is null)'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- All Releases -'
,p_lov_null_value=>'0'
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '8',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39785075795436312079)
,p_name=>'release change'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P75_RELEASE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39785075930597312080)
,p_event_id=>wwv_flow_imp.id(39785075795436312079)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P75_RELEASE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39785076046738312081)
,p_event_id=>wwv_flow_imp.id(39785075795436312079)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39784980351666284990)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(45295364510377013036)
,p_region_id=>wwv_flow_imp.id(45295364209798013033)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(39781251561765585519)
,p_component_action_id=>wwv_flow_imp.id(45295364510377013036)
,p_menu_entry_type=>'ENTRY'
,p_label=>'&NOMENCLATURE_PROJECTS.'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-package'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(42526685239404110302)
,p_component_action_id=>wwv_flow_imp.id(45295364510377013036)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Reset'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:RP,75::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(45295365216284013043)
,p_component_action_id=>wwv_flow_imp.id(45295364510377013036)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Refresh'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:RP,::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(51225473988154867125)
,p_component_action_id=>wwv_flow_imp.id(45295364510377013036)
,p_menu_entry_type=>'SEPARATOR'
,p_display_sequence=>20
);
wwv_flow_imp.component_end;
end;
/
