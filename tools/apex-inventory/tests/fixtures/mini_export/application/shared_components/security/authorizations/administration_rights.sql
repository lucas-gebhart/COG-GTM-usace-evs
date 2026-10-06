prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(500)
,p_name=>'Administration Rights'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'Administrator'
,p_error_message=>'You aren''t an admin.'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
