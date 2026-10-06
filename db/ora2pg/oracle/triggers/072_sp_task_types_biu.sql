-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_task_types_biu
    before insert or update
    on sp_task_types
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    --
    --
    :new.static_id := upper(:new.static_id);
end sp_task_types_biu;
/
