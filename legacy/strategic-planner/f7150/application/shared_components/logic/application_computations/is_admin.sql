prompt --application/shared_components/logic/application_computations/is_admin
begin
--   Manifest
--     APPLICATION COMPUTATION: IS_ADMIN
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
 p_id=>wwv_flow_imp.id(55083298746978348890)
,p_computation_sequence=>10
,p_computation_item=>'IS_ADMIN'
,p_computation_point=>'AFTER_LOGIN'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if APEX_AUTHORIZATION.IS_AUTHORIZED (p_authorization_name => ''Administration Rights'') then',
'   return ''Y'';',
'else return ''N'';',
'end if;'))
,p_version_scn=>42076116550825
);
wwv_flow_imp.component_end;
end;
/
