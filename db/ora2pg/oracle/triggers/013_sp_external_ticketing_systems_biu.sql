-- source: install_external_system_names.sql (p_sequence 340, external system names)
create or replace trigger SP_EXTERNAL_TICKETING_SYSTEMS_biu
    before insert or update
    on SP_EXTERNAL_TICKETING_SYSTEMS
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- default values
    --
    if :new.evaulation_sequence is null then
       :new.evaulation_sequence := 100;
    end if;
    if :new.is_active_yn is null then
       :new.is_active_yn := 'N';
    end if;
end SP_EXTERNAL_TICKETING_SYSTEMS_biu;
/
