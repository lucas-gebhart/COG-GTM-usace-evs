-- source: install_initiative_focus_area_triggers.sql (p_sequence 450, Initiative Focus Area triggers)
create or replace trigger sp_init_focus_area_comments_bd
    before delete
    on sp_init_focus_area_comments
    for each row
begin
    if :old.private_yn = 'N' then
    --
    -- touch parent table
    --
    update sp_initiative_focus_areas set updated = sysdate, updated_by = :old.updated_by where id = :old.init_focus_area_id;
    --
    insert into sp_init_focus_area_history
        (init_focus_area_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)
    values
        (:old.init_focus_area_id, 'COMMENT', 'DELETE', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_init_focus_area_comments_bd;
/
