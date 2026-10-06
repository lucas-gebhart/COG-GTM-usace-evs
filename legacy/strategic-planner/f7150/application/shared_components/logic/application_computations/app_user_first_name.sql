prompt --application/shared_components/logic/application_computations/app_user_first_name
begin
--   Manifest
--     APPLICATION COMPUTATION: APP_USER_FIRST_NAME
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_computation(
 p_id=>wwv_flow_imp.id(53852011433055371321)
,p_computation_sequence=>10
,p_computation_item=>'APP_USER_FIRST_NAME'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'    select first_name',
'      from sp_team_members ',
'     where id = :APP_USER_ID',
'       and first_name is not null',
') loop',
'    return c1.first_name;',
'end loop;',
'-- in case user is not in team_members (or first name is null)',
'return lower(:APP_USER);'))
,p_compute_when=>':APP_USER_ID is not null and :APP_USER_FIRST_NAME is null'
,p_compute_when_text=>'PLSQL'
,p_compute_when_type=>'EXPRESSION'
,p_version_scn=>46642687347737
);
wwv_flow_imp.component_end;
end;
/
