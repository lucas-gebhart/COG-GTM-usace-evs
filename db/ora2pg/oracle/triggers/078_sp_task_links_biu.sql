-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_task_links_biu
    before insert or update
    on sp_task_links
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- touch parent table
    --
    update sp_tasks set updated = sysdate, updated_by = :new.updated_by where id = :new.task_id;
    --
    -- history
    --
    if inserting then
       if :new.task_id is not null then
           insert into sp_task_history
               (task_id, attribute_column, change_type, new_value, changed_on, changed_by)
           values
               (:new.task_id, 'LINK', 'CREATE', :new.link_url, sysdate, lower(:new.created_by));
       elsif updating then
          if not sp_value_compare.is_equal(:old.link_url,:new.link_url) then
              insert into sp_task_history
                  (task_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
              values
                  (:new.task_id, 'LINK', 'UPDATE', :old.link_url, :new.link_url, sysdate, lower(:new.updated_by));
          end if;
       end if;
    end if;
end sp_task_links_biu;
/
