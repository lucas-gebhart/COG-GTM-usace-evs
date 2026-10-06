-- source: install_sp_release_milestone_types_table_and_trigger.sql (p_sequence 295, sp_release_milestone_types table and trigger)
create or replace trigger sp_release_milestone_types_biu
    before insert or update
    on sp_release_milestone_types
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_release_milestone_types_biu;
/
