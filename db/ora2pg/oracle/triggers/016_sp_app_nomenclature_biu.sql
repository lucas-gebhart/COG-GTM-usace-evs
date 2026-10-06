-- source: install_triggers.sql (p_sequence 350, triggers)
create or replace trigger SP_APP_NOMENCLATURE_biu
    before insert or update
    on SP_APP_NOMENCLATURE
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.static_id := upper(:new.static_id);
end SP_APP_NOMENCLATURE_biu;
/
