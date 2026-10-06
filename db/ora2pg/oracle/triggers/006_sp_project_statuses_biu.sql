-- source: install_sp_project_statuses_table.sql (p_sequence 215, sp_project_statuses table)
create or replace trigger sp_project_statuses_biu
    before insert or update
    on sp_project_statuses
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    :new.static_id := upper(:new.static_id);
end sp_project_statuses_biu;
/
