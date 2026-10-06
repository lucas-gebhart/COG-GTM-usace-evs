prompt --application/shared_components/user_interface/lovs/workflow_console_lov_workflow_state
begin
--   Manifest
--     WORKFLOW_CONSOLE.LOV.WORKFLOW_STATE
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(46255771491820639769)
,p_lov_name=>'WORKFLOW_CONSOLE.LOV.WORKFLOW_STATE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_workflow.get_lov_workflow_state )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'VAL'
,p_display_column_name=>'DISP'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>44427828483332
);
wwv_flow_imp.component_end;
end;
/
