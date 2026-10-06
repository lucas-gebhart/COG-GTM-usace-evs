-- source: install_projects_triggers.sql (p_sequence 520, projects triggers)
create or replace trigger sp_projects_bd
    before delete
    on sp_projects
    for each row
begin
    insert into sp_project_history
        (project_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.id, 'PROJECT', 'DELETE', :old.PROJECT, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_projects_bd;
/
