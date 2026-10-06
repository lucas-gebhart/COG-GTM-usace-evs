prompt --application/pages/page_14010
begin
--   Manifest
--     PAGE: 14010
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
 p_id=>14010
,p_name=>'Delete Sample Data'
,p_alias=>'DELETE-SAMPLE-DATA'
,p_step_title=>'Delete Sample Data'
,p_autocomplete_on_off=>'OFF'
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(79791402343828995643)
,p_name=>'Delete Sample Data'
,p_template=>4501440665235496320
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--staticRowColors:t-Report--rowHighlightOff:t-Report--noBorders'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select label, cnt, details',
'  from ',
'(',
'select 1 ob, :NOMENCLATURE_AREAS label, count(*) cnt,',
'       listagg(area,'', '') within group (order by id) details',
'  from SP_AREAS',
' where id in (1,2)',
'union all',
'select 2 ob, :NOMENCLATURE_INITIATIVES label, count(*) cnt,',
'       listagg(initiative,'', '') within group (order by id) details',
'  from SP_INITIATIVES',
' where id in (1,2,3)',
'union all',
'select 3 ob, :NOMENCLATURE_PROJECTS label, count(*) cnt,',
'       listagg(project,'', '') within group (order by id) details',
'  from SP_PROJECTS',
' where id in (1,2,3,4,5,6)',
'union all',
'select 4 ob, ''Activities'' label, count(*) cnt,',
'       listagg(comments,'', '') within group (order by id) details',
'  from sp_activities',
' where id in (1,2,3)',
'union all',
'select 5 ob, ''Releases'' label, count(*) cnt,',
'       listagg(release_train||'' '' ||release,'', '') within group (order by id) details',
'  from sp_release_trains',
' where id in (1,2)',
'union all',
'select 7 ob, :NOMENCLATURE_USERS label, count(*) cnt,',
'       listagg(first_name||'' ''||last_name,'', '') within group (order by id) details',
'  from SP_TEAM_MEMBERS',
' where id in (1,2,3)',
')',
'where cnt > 0',
'order by ob'))
,p_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This application installed with some sample data to help illustrate it''s use.  ',
'    Once deleted, this data cannot be installed again.',
'    Only the main attributes listed below will be deleted, not any of the Look Up Values.</p>',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'Sample data has all been removed.'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51825530385167349288)
,p_query_column_id=>1
,p_column_alias=>'LABEL'
,p_column_display_sequence=>20
,p_column_heading=>'Label'
,p_column_html_expression=>'#CNT# #LABEL# (#DETAILS#)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51825530554390349289)
,p_query_column_id=>2
,p_column_alias=>'CNT'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(51825530655194349290)
,p_query_column_id=>3
,p_column_alias=>'DETAILS'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(185442657922400486853)
,p_plug_name=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52409745870477225713)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(185442657922400486853)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delete'
,p_button_position=>'NEXT'
,p_confirm_message=>'Do you really want to remove the sample data?'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from SP_AREAS',
' where id in (1,2)',
'union all',
'select 1',
'  from SP_INITIATIVES',
' where id in (1,2,3)',
'union all',
'select 1',
'  from SP_PROJECTS',
' where id in (1,2,3,4,5,6)',
'union all',
'select 1',
'  from sp_activities',
' where id in (1,2,3)',
'union all',
'select 1',
'  from sp_release_trains',
' where id in (1,2)',
'union all',
'select 1',
'  from SP_TEAM_MEMBERS',
' where id in (1,2,3)'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(52409746361923225713)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(185442657922400486853)
,p_button_name=>'Up'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Up'
,p_button_position=>'UP'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(52409747568870225715)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete sample data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from SP_PROJ_INTERACTIONS_LOG ',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_activities',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_comments',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_documents',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_tasks',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_contributors',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_links',
' where project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_related',
' where project_id in (1,2,3,4,5,6)',
'    or related_project_id in (1,2,3,4,5,6);',
'',
'delete from sp_project_history',
' where id in (1,2,3,4,5,6);',
'',
'delete from SP_PROJECTS',
' where id in (1,2,3,4,5,6);',
'',
'delete from sp_release_comments',
' where release_id in (1,2);',
'',
'delete from sp_release_documents',
' where release_id in (1,2);',
'',
'delete from sp_release_links',
' where release_id in (1,2);',
'',
'delete from sp_release_milestones',
' where release_id in (1,2);',
'',
'delete from sp_release_history',
' where release_id in (1,2);',
'',
'delete from sp_release_trains',
' where id in (1,2);',
'',
'delete from sp_initiative_links',
' where initiative_id in (1,2,3);',
'',
'delete from sp_initiative_comments',
' where initiative_id in (1,2,3);',
'',
'delete from sp_initiative_documents',
' where initiative_id in (1,2,3);',
' ',
'delete from SP_INITIATIVES',
' where id in (1,2,3);',
'',
'delete from SP_AREAS',
' where id in (1,2);',
'',
'delete from SP_TEAM_MEMBERS',
' where id in (1,2,3);',
'',
'sp_util.add_app_log(',
'    p_activity => ''Sample Data Deleted'', ',
'    p_details  => null );'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Sample data failed to be deleted.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(52409745870477225713)
,p_process_success_message=>'Sample data deleted.'
,p_internal_uid=>15510389703468257946
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51825530928494349293)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'recalculate counts'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (select count(*) c from sp_areas) loop',
'    :P1_AREAS := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*) c from sp_initiatives)  loop',
'    :P1_INITIATIVES := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*)  c',
'             from sp_projects p',
'            where p.ARCHIVED_YN = ''N'' and ',
'                  p.DUPLICATE_OF_PROJECT_ID is null',
') loop',
'    :P1_PROJECTS := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*) c ',
'             from sp_activities ap, sp_projects p',
'            where ap.project_id = p.id(+) and',
'                  p.DUPLICATE_OF_PROJECT_ID is null and',
'                  (p.ARCHIVED_YN = ''N'' or p.archived_yn is null) -- need the is null to accomodate the outer join',
') loop',
'    :P1_ACTIVITIES := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*) c from SP_RELEASE_TRAINS) loop',
'    :P1_RELEASES := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*) c from SP_TEAM_MEMBERS) loop',
'    :P1_PEOPLE := to_char(c1.c,''FM999G999G990''); ',
'end loop;',
'',
'for c1 in (select count(*) c from SP_GROUPS) loop',
'    :P1_GROUPS := to_char(c1.c,''FM999G999G990''); ',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(52409745870477225713)
,p_internal_uid=>14926173063092381524
);
wwv_flow_imp.component_end;
end;
/
