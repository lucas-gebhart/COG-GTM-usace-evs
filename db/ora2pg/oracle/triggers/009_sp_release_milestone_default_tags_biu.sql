-- source: install_release_milestone_default_tags_table_and_trigger.sql (p_sequence 305, release_milestone_default_tags table and trigger)
create or replace trigger sp_release_milestone_default_tags_biu
    before insert or update
    on sp_release_milestone_default_tags
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.tag := upper(:new.tag);
end sp_release_milestone_default_tags_biu;
/
