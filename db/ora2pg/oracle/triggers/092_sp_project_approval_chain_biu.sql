-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_project_approval_chain_biu
    before insert or update
    on sp_project_approval_chain
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- no need to update project table nor history
    --
end sp_project_approval_chain_biu;
/
