prompt --application/deployment/install/install_seed_resource_types
begin
--   Manifest
--     INSTALL: INSTALL-seed resource types
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(152260168862836009331)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed resource types'
,p_sequence=>800
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (1, ''Main Developer'', ''Developer most responsible for the implementation, actual coding, of the project. The main developer typically contributes the most c'
||'ode and coordinates other developer contributions.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (3, ''Project Manager'', ''Develops, maintains, and revises proposals for assigned projects including project objectives, technologies, systems, information sp'
||'ecifications, timelines, funding, and staffing. Sets and tracks project milestones; manages and accounts for unforeseen delays, then realigns schedules and expectations as needed.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (4, ''Requestor'', ''The customer or the person who is asking for the feature or capability. The project is being performed at the request of this person.'', ''N'
||''');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (2, ''Architect'', ''A software architect is a computer programmer who makes project-specific software design choices, coordinates technical teams and selects '
||'and enforces technical coding standards when creating new programs or software to fulfill business goals.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (5, ''Functional Tester'', ''A functional tester is someone who measures and monitors progress during each test to ensure that the application is tested, valid'
||'ated, and piloted on time and within budget, and that it meets or exceeds expectations. Review test, validation, and pilot results to ensure that they meet the entry and exit criteria.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (6, ''Contributing Developer'', ''A developer who is not the main developer but is contributing to the development process for a specific project.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (7, ''Researcher'', ''The Research Software Engineer works with researchers to gain an understanding of the problems they face, and then develops, maintains an'
||'d extends software to provide the answers.'', ''N'');',
'insert into SP_RESOURCE_TYPES (ID, RESOURCE_TYPE, RESOURCE_DESCRIPTION, IS_DEFAULT_YN) values (8, ''UI Designer'', ''A user interface designer, UI designer, is someone who designs the graphical user interface of an app, website, or device that a human i'
||'nteracts with. For example, when you access a website or an app on your phone, there''''s usually a graphical interface that allows you to navigate and achieve your goal.'', ''N'');',
''))
);
wwv_flow_imp.component_end;
end;
/
