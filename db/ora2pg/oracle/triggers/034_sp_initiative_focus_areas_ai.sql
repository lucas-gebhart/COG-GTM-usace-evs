-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_initiative_focus_areas_ai
    after insert
    on sp_initiative_focus_areas
    for each row
begin
    insert into sp_init_focus_area_history
        (init_focus_area_id, attribute_column, change_type, new_value, changed_on, changed_by)
    values
        (:new.id, 'INITIATIVE_FOCUS_AREA', 'CREATE', :new.focus_area, sysdate, lower(:new.created_by));
end sp_initiative_focus_areas_ai;
/
