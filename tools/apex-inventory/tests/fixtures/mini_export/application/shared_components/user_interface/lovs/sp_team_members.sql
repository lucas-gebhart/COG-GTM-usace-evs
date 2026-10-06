prompt --application/shared_components/user_interface/lovs/sp_team_members
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(600)
,p_lov_name=>'SP_TEAM_MEMBERS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select full_name d, id r',
'from SP_TEAM_MEMBERS',
'order by 1'))
,p_source_type=>'SQL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(601)
,p_lov_id=>wwv_flow_imp.id(600)
,p_query_column_name=>'D'
,p_display_sequence=>1
);
end;
/
