-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_task_comments_bd
    before delete
    on sp_task_comments
    for each row
begin
    if :old.private_yn = 'N' then
        --
        -- touch parent table
        --
        update sp_tasks set updated = sysdate, updated_by = :old.updated_by where id = :old.task_id;
        --
        insert into sp_task_history
            (task_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)
        values
            (:old.task_id, 'COMMENT', 'DELETE', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_task_comments_bd;
/
