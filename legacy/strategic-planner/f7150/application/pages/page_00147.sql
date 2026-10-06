prompt --application/pages/page_00147
begin
--   Manifest
--     PAGE: 00147
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
 p_id=>147
,p_name=>'My Approval Configuration'
,p_alias=>'MY-APPROVAL-CONFIGURATION'
,p_page_mode=>'MODAL'
,p_step_title=>'My Approval Configuration'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_required_patch=>wwv_flow_imp.id(46255070709862811051)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37396617336380952859)
,p_name=>'Configuration'
,p_template=>3371237801798025892
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.initiative ||'' - ''|| t.approval_type approval_type,',
'       nvl((select listagg(case when c.active_yn = ''N'' then ''(Inactive - '' end ||',
'                           case when c.alternate_team_member_id is not null and   ',
'                                    (c.alternate_start_date <= sysdate or c.alternate_start_date is null) and ',
'                                    (c.alternate_end_date+1 > sysdate or c.alternate_end_date is null)',
'                                then (select first_name||'' ''||last_name',
'                                        from sp_team_members',
'                                       where id = c.alternate_team_member_id)||',
'                                       '' as alternate for ''||tm.first_name||'' ''||tm.last_name',
'                                else tm.first_name||'' ''||tm.last_name',
'                                end ||',
'                            case when c.active_yn = ''N'' then '')'' end,'', '')',
'                   within group (order by approval_seq)',
'              from sp_initiative_approval_chain c,',
'                   sp_team_members tm',
'             where c.initiative_approval_id = a.id',
'               and c.team_member_id = tm.id',
'              group by c.initiative_approval_id),''None Yet'') approvers,',
'       (select id',
'          from sp_initiative_approval_chain',
'         where initiative_approval_id = a.id   ',
'           and team_member_id = :APP_USER_ID) initiative_approval_chain_id',
'  from sp_initiative_approvals a,',
'       sp_approval_types t,',
'       sp_initiatives i',
' where a.active_yn =''Y''',
'   and a.approval_type_id = t.id',
'   and a.initiative_id = i.id',
'   and a.id in (select initiative_approval_id',
'                  from sp_initiative_approval_chain',
'                 where team_member_id = :APP_USER_ID)',
'order by 1'))
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
 p_id=>wwv_flow_imp.id(18842602559968570850)
,p_query_column_id=>1
,p_column_alias=>'APPROVAL_TYPE'
,p_column_display_sequence=>10
,p_column_heading=>'Approval Type'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(18842602161570570850)
,p_query_column_id=>2
,p_column_alias=>'APPROVERS'
,p_column_display_sequence=>20
,p_column_heading=>'Approvers'
,p_column_link=>'f?p=&APP_ID.:4015:&SESSION.::&DEBUG.:4015:P4015_ID:#INITIATIVE_APPROVAL_CHAIN_ID##INITIATIVE_APPROVAL_ID#'
,p_column_linktext=>'#APPROVERS#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(18842601736926570849)
,p_query_column_id=>3
,p_column_alias=>'INITIATIVE_APPROVAL_CHAIN_ID'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(18555556437383440151)
,p_name=>'when close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37396617336380952859)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18555556519579440152)
,p_event_id=>wwv_flow_imp.id(18555556437383440151)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37396617336380952859)
,p_attribute_01=>'N'
);
wwv_flow_imp.component_end;
end;
/
