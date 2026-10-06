-- source: install_create_sp_application_notifications.sql (p_sequence 660, create SP_APPLICATION_NOTIFICATIONS)
create or replace trigger SP_APPLICATION_NOTIFICATIONS_biu
    before insert or update
    on SP_APPLICATION_NOTIFICATIONS
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end SP_APPLICATION_NOTIFICATIONS_biu;
/
