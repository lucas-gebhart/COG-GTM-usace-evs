-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_initiative_focus_areas_bd
    before delete
    on sp_initiative_focus_areas
    for each row
begin
    insert into sp_init_focus_area_history
        (init_focus_area_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.id, 'INITIATIVE_FOCUS_AREA', 'DELETE', :old.focus_area, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_initiative_focus_areas_bd;
/
