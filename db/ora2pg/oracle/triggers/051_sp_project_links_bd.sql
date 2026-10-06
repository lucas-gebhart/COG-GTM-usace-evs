-- source: install_project_links_triggers.sql (p_sequence 500, project links triggers)
create or replace trigger sp_project_links_bd
    before delete
    on sp_project_links
    for each row
begin
    if :old.project_id is not null then
        --
        -- touch parent table
        --
        update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
        --
        insert into sp_project_history
            (project_id, attribute_column, change_type, old_value, changed_on, changed_by)
        values
            (:old.project_id, 'LINK', 'DELETE', :old.link_url, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_project_links_bd;
/
