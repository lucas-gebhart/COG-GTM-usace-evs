-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_init_focus_area_links_bd
    before delete
    on sp_init_focus_area_links
    for each row
begin
    --
    -- touch parent table
    --
    update sp_initiative_focus_areas set updated = sysdate, updated_by = :old.updated_by where id = :old.init_focus_area_id;
    --
    insert into sp_init_focus_area_history
        (init_focus_area_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.init_focus_area_id, 'LINK', 'DELETE', :old.link_url, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_init_focus_area_links_bd;
/
