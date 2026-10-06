-- source: install_projects_triggers.sql (p_sequence 520, projects triggers)
create or replace trigger sp_projects_ai
    after insert
    on sp_projects
    for each row
begin
    insert into sp_project_history
        (project_id, attribute_column, change_type, new_value, changed_on, changed_by)
    values
        (:new.id, 'PROJECT', 'CREATE', :new.PROJECT, sysdate, lower(:new.created_by));
end sp_projects_ai;
/
