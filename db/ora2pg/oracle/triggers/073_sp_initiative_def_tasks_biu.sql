-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_initiative_def_tasks_biu
    before insert or update
    on sp_initiative_default_tasks
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
    update sp_initiatives set updated = sysdate, updated_by = :new.updated_by where id = :new.initiative_id;
end sp_initiative_def_tasks_biu;
/
