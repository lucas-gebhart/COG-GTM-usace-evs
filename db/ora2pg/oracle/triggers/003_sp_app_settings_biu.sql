-- source: install_sp_app_settings.sql (p_sequence 70, sp_app_settings)
create or replace trigger sp_app_settings_biu
    before insert or update 
    on sp_app_settings
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated    := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.static_id  := upper(:new.static_id);
end sp_app_settings_biu;
/
