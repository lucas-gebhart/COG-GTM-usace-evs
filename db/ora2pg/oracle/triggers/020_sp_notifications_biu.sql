-- source: install_sp_notifications_table.sql (p_sequence 360, sp_notifications table)
create or replace trigger sp_notifications_biu
    before insert or update
    on sp_notifications
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.static_id := upper(:new.static_id);
end sp_notifications_biu;
/
