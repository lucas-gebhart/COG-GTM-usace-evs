-- APEX supporting object install script: seed project priorities
-- sequence 830, source application/deployment/install/install_seed_project_priorities.sql
-- kind: dml

insert into sp_project_priorities (id, priority, description, IS_DEFAULT_YN) values (1,1, 'P1 - Highest','N');
insert into sp_project_priorities (id, priority, description, IS_DEFAULT_YN) values (2,2, 'P2 - High (Critical)','N');
insert into sp_project_priorities (id, priority, description, IS_DEFAULT_YN) values (3,3, 'P3 - Medium','N');
insert into sp_project_priorities (id, priority, description, IS_DEFAULT_YN) values (4,4, 'P4 - Low','N');
insert into sp_project_priorities (id, priority, description, IS_DEFAULT_YN) values (5,5, 'P5 - Not Prioritized','Y');
