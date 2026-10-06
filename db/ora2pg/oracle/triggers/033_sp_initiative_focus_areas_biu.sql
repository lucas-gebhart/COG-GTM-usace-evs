-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_initiative_focus_areas_biu
    before insert or update
    on sp_initiative_focus_areas
    for each row
declare 
    l_old_value   varchar2(4000) := null;
    l_new_value   varchar2(4000) := null;
    l_changed_by  varchar2(255)  := null;
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- history
    --
    if updating then
        l_changed_by := lower(:new.updated_by);

        if not sp_value_compare.is_equal(:old.focus_area,:new.focus_area) then
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.id, 'INITIATIVE_FOCUS_AREA', 'UPDATE', :old.focus_area, :new.focus_area, sysdate, l_changed_by);
        end if;
        if not sp_value_compare.is_equal(:old.development_owner_id,:new.development_owner_id) then
            for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :old.development_owner_id) loop l_old_value := c1.r; end loop;
            for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :new.development_owner_id) loop l_new_value := c1.r; end loop;
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.id, 'DEVELOPMENT_OWNER', 'UPDATE', l_old_value, l_new_value, sysdate, l_changed_by);
        end if;
        if not sp_value_compare.is_equal(:old.description,:new.description) then
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.id, 'DESCRIPTION', 'UPDATE', :old.description, :new.description, sysdate, l_changed_by);
        end if;
        if not sp_value_compare.is_equal(:old.active_yn,:new.active_yn) then
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.id, 'ACTIVE', 'UPDATE', :old.active_yn, :new.active_yn, sysdate, l_changed_by);
        end if;
        if not sp_value_compare.is_equal(:old.display_sequence,:new.display_sequence) then
            insert into sp_init_focus_area_history
                (init_focus_area_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.id, 'DISPLAY_SEQUENCE', 'UPDATE', :old.display_sequence, :new.display_sequence, sysdate, l_changed_by);
        end if;
    end if;
end sp_initiative_focus_areas_biu;
/
