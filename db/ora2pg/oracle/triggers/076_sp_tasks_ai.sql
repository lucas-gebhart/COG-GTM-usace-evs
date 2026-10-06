-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_tasks_ai
    after insert
    on sp_tasks
    for each row
declare
    l_type  varchar2(5000) := null;
begin
    for c1 in (
        select TASK_TYPE || case when :new.TASK_SUB_TYPE_ID is not null
                                 then ': '||(select task_type from sp_task_types
                                              where id = :new.task_sub_type_id)
                                 end ||
                            case when :new.task is not null 
                                 then ' - '||:new.task
                                 end  r
          from SP_TASK_TYPES x 
         where x.id = :new.TASK_TYPE_ID
    ) loop l_type := substr(c1.r,1,4000); end loop;
    insert into sp_task_history
        (task_id, attribute_column, change_type, new_value, changed_on, changed_by)
    values
        (:new.id, 'TASK', 'CREATE', l_type, sysdate, lower(:new.created_by));
end sp_tasks_ai;
/
