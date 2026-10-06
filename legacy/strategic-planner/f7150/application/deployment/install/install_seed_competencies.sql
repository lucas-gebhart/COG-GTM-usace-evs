prompt --application/deployment/install/install_seed_competencies
begin
--   Manifest
--     INSTALL: INSTALL-seed competencies
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
 p_id=>wwv_flow_imp.id(52442800158483251814)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'seed competencies'
,p_sequence=>880
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (1, ''JavaScript (Advanced)'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (2, ''JavaScript (Intermediate)'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (3, ''CSS (Advanced)'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (4, ''PL/SQL (Advanced)'', ''Demonstrated expertise in writing and optimizing advanced PL/SQL code, including complex stored procedures, functions, packages, and triggers. Strong performance tuning. Strong debugging skills.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (5, ''PL/SQL (Intermediate)'', ''Ability to write efficient, complex queries and stored procedures. Demonstrates a solid understanding of PL/SQL programming constructs. Someone who is a profesional PL/SQL programmer whose code is used by others.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (6, ''APEX App Development (Advanced)'', ''Comfortable building and deploying applications used by hundreds or thousands of people.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (7, ''Graphics Design'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (8, ''Accessibility'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (9, ''UI Design'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (10, ''CSS (Intermediate)'', ''A high level of proficiency and experience in front-end development. Ability to create responsive and adaptive designs that work across various devices and screen sizes.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (11, ''Database Design'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (12, ''DevOps'', ''Build tools, automations, etc.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (13, ''Performance Tuning'', ''Comfortable performance tuning SQL and PL/SQL. Can get to the root of a performance problem.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (14, ''APEX App Development (Intermediate)'', ''Comfortable building APEX applications with moderate complexity and quality UI and usability.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (15, ''Multimedia Production'', ''Video, motion, and other multimedia production'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (16, ''Product Management'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (17, ''Testing'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (18, ''Security'', '''');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (19, ''SQL (Advanced)'', ''Advanced SQL skills including strong understanding of performance and syntax. Goto person for SQL.'');',
'insert into SP_COMPETENCIES',
'    (ID, COMPETENCY, DESCRIPTION) ',
'    values ',
'    (20, ''Program Management'', '''');'))
);
wwv_flow_imp.component_end;
end;
/
