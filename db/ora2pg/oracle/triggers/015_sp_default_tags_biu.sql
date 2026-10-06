-- source: install_triggers.sql (p_sequence 350, triggers)
create or replace trigger SP_DEFAULT_TAGS_biu
    before insert or update
    on SP_DEFAULT_TAGS
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.tag := upper(:new.tag);
end SP_DEFAULT_TAGS_biu;
/
