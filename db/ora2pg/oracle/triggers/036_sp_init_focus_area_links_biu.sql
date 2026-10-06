-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_init_focus_area_links_biu
    before insert or update
    on sp_init_focus_area_links
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
    update sp_initiative_focus_areas set updated = sysdate, updated_by = :new.updated_by where id = :new.init_focus_area_id;
    --
    -- history
    --
    if inserting then
        insert into sp_init_focus_area_history
            (init_focus_area_id, attribute_column, change_type, new_value, changed_on, changed_by)
        values
            (:new.init_focus_area_id, 'LINK', 'CREATE', :new.link_url, sysdate, lower(:new.created_by));
    elsif updating then
        if not sp_value_compare.is_equal(:old.link_url,:new.link_url) then
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.init_focus_area_id, 'LINK', 'UPDATE', :old.link_url, :new.link_url, sysdate, lower(:new.updated_by));
         end if;
    end if;
end sp_init_focus_area_links_biu;
/
