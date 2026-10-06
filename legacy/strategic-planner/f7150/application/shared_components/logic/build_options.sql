prompt --application/shared_components/logic/build_options
begin
--   Manifest
--     BUILD OPTIONS: 7150
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(27803842998100767814)
,p_build_option_name=>'AI Project Summaries'
,p_build_option_status=>'EXCLUDE'
,p_version_scn=>46038024627617
,p_default_on_export=>'EXCLUDE'
,p_build_option_comment=>'If included, and an AI Service is identified (under Settings), summaries will be generated for &NOMENCLATURE_PROJECTS..'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(30769244999117825609)
,p_build_option_name=>'AI Release Summaries'
,p_build_option_status=>'EXCLUDE'
,p_version_scn=>46038024627664
,p_build_option_comment=>'If included, and an AI Service is identified (under Settings), summaries can be generated for Releases.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(39029755398907879859)
,p_build_option_name=>'About Page'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>40760826019912
,p_feature_identifier=>'APPLICATION_ABOUT_PAGE'
,p_build_option_comment=>'This feature displays an "About this application" link and exposes a partially configurable about this application page.  If you don''t want to have a link to about this application disable this setting.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(40074095762229259811)
,p_build_option_name=>'Reviews'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44449905286858
,p_build_option_comment=>'If disabled, Reviews will not be included within NOMENCLATURE_PROJECTS.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(41243768626038066363)
,p_build_option_name=>'Releases'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44677695879980
,p_build_option_comment=>'Used to exclude the use of Releases.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(42654456934873218939)
,p_build_option_name=>'Show friendly identifier'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>40760828906055
,p_build_option_comment=>'Each project gets a friendly identifier by default.  Friendly identifiers are alternative primary keys that are human readable. For example "AA01" is a friendly identifier.  This setting controls if the identifiers are displayed in the UI of the appl'
||'ication.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(45083514827823703609)
,p_build_option_name=>'Feedback'
,p_build_option_status=>'EXCLUDE'
,p_version_scn=>44674988377216
,p_feature_identifier=>'APPLICATION_FEEDBACK'
,p_build_option_comment=>'Provide a mechanism for end users to post general comments back to the application administrators and developers.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(45129951509728196750)
,p_build_option_name=>'Configure Application Features'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>41300082518941
,p_feature_identifier=>'APPLICATION_CONFIGURATION'
,p_build_option_comment=>'Allow application administrators to enable or disable specific application features.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(46255070709862811051)
,p_build_option_name=>'Approvals'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44792133584199
,p_default_on_export=>'INCLUDE'
,p_build_option_comment=>'Encapsulates all the workflow for NOMENCLATURE_PROJECT approvals.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(46804096636430955252)
,p_build_option_name=>'Comment Tagging'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44449904548259
,p_build_option_comment=>'If included, Screen Name will be available under NOMENCLATURE_USERS and NOMENCLATURE_PROJECT comments will be searched for screen names and if someone is ''tagged'', they will receive an alert (if they have Comment Alerts enabled).'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(47107697553662333659)
,p_build_option_name=>'Groups'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44449904974681
,p_build_option_comment=>'Groups allow you to organize contributors.  You define a group, then add NOMENCLATURE_USERS to the group.  When viewing  NOMENCLATURE_USERS, you can filter by groups.  This reduces a large list to a smaller, more targeted, list.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(48021503892065797891)
,p_build_option_name=>'Subscriptions'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>41329529515893
,p_build_option_comment=>'Allows enable/disable of Notification Subscriptions, sent via email.  This should be disabled if email is not configured on this instance.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(48520462122696828334)
,p_build_option_name=>'Kanban'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>42092809933464
,p_build_option_comment=>'Kanban Board, Cumulative Flow, Control Chart and Planning Board.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(51182682188183937291)
,p_build_option_name=>'Activity Planning'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44449904025996
,p_build_option_comment=>'Allows a team member to plan activities; For example I am working on these activities (aka NOMENCLATURE_PROJECTS) for these dates.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(51655467048481750655)
,p_build_option_name=>'Project Groups'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44677692749795
,p_build_option_comment=>'Allows grouping of NOMENCLATURE_PROJECTS across NOMENCLATURE_INITIATIVES.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(53728659243476523541)
,p_build_option_name=>'Email Configured'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>41331431166856
,p_build_option_comment=>'If email is not configured on your instance, use this to turn off the features that would send emails.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(54991132434390587116)
,p_build_option_name=>'Include Project Active Toggle'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>44449905825992
,p_build_option_comment=>'Identifies a NOMENCLATURE_PROJECT as being actively worked or not.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(176222232227855897789)
,p_build_option_name=>'Access Control'
,p_build_option_status=>'INCLUDE'
,p_version_scn=>40760827840139
,p_feature_identifier=>'APPLICATION_ACCESS_CONTROL'
,p_build_option_comment=>'Incorporate role based user authentication within your application and manage username mappings to application roles.'
);
wwv_flow_imp.component_end;
end;
/
