prompt --application/shared_components/logic/application_settings
begin
--   Manifest
--     APPLICATION SETTINGS: 7150
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(41356667730959819495)
,p_name=>'EXTERNAL_PERSON_LINK'
,p_value=>'http://people.oracle.com/@#EMAIL#'
,p_is_required=>'N'
,p_comments=>'link with #EMAIL# substitution to provide a link to more details - only if the email domain matches that within EXTERNAL_PERSON_LINK_DOMAIN'
,p_version_scn=>41537612306125
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(41356689192712824180)
,p_name=>'EXTERNAL_PERSON_LINK_DOMAIN'
,p_value=>'oracle.com'
,p_is_required=>'N'
,p_comments=>'if the email of a "person" uses this domain, the EXTERNAL_PERSON_LINK will be used to show a link to more details'
,p_version_scn=>41537612306171
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(45083515120794703612)
,p_name=>'FEEDBACK_ATTACHMENTS_YN'
,p_value=>'Y'
,p_is_required=>'N'
,p_valid_values=>'Y, N'
,p_on_upgrade_keep_value=>true
,p_required_patch=>wwv_flow_imp.id(45083514827823703609)
,p_version_scn=>1
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(46335905611333503729)
,p_name=>'ACCESS_CONTROL_SCOPE'
,p_value=>'ACL_ONLY'
,p_is_required=>'N'
,p_valid_values=>'ACL_ONLY, ALL_USERS'
,p_on_upgrade_keep_value=>true
,p_required_patch=>wwv_flow_imp.id(176222232227855897789)
,p_comments=>'The default access level given to authenticated users who are not in the access control list'
,p_version_scn=>44517093686629
);
wwv_flow_imp.component_end;
end;
/
