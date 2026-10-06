-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_tasks_bd
    before delete
    on sp_tasks
    for each row
declare
    l_type  varchar2(5000) := null;
begin
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
    --
    for c1 in (
        select TASK_TYPE || case when :old.TASK_SUB_TYPE_ID is not null
                                 then ': '||(select task_type from sp_task_types
                                              where id = :old.task_sub_type_id)
                                 end ||
                            case when :old.task is not null 
                                 then ' - '||:new.task
                                 end r
          from SP_TASK_TYPES x 
         where x.id = :old.TASK_TYPE_ID
    ) loop l_type := substr(c1.r,1,4000); end loop;
    insert into sp_task_history
        (task_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.id, 'TASK', 'DELETE', l_type, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_tasks_bd;
/
