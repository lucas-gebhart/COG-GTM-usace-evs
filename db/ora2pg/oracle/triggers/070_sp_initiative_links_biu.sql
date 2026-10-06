-- source: install_initiative_links_table_and_trigger.sql (p_sequence 690, INITIATIVE_LINKS table and trigger)
create or replace trigger SP_INITIATIVE_LINKS_biu
    before insert or update
    on SP_INITIATIVE_LINKS
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
   --
   -- touch parent table
   --
   update sp_initiatives set updated = sysdate, updated_by = :new.updated_by where id = :new.initiative_id;
end SP_INITIATIVE_LINKS_biu;
/
