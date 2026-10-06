-- source: install_team_member_notifications.sql (p_sequence 730, team_member_notifications)
create or replace trigger sp_team_member_notifications_biu
    before insert or update
    on sp_team_member_notifications
    for each row
declare 
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_team_member_notifications_biu;
/
