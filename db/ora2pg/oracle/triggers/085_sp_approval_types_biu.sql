-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_approval_types_biu
    before insert or update
    on sp_approval_types
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_approval_types_biu;
/
