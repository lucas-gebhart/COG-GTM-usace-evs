-- APEX supporting object install script: seed release_milestone_types
-- sequence 855, source application/deployment/install/install_seed_release_milestone_types.sql
-- kind: dml

insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (1, 'Build', 1);
insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (2, 'Doc', 2);
insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (3, 'Merge', 3);
insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (4, 'Milestone', 4);
insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (6, 'Translation Drop', 6);
insert into sp_release_milestone_types (id, milestone_type, display_seq)
    values (7, 'Upgrade', 7);
