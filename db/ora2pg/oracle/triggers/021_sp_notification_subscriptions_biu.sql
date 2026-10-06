-- source: install_sp_notification_subscriptions.sql (p_sequence 370, sp_notification_subscriptions)
create or replace trigger sp_notification_subscriptions_biu
    before insert or update
    on sp_notification_subscriptions
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_notification_subscriptions_biu;
/
