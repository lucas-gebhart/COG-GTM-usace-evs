-- source: install_initiative_comments_table_and_trigger.sql (p_sequence 670, initiative_comments table and trigger)
create or replace trigger sp_initiative_comments_bd
    before delete
    on sp_initiative_comments
    for each row
begin
    if :old.private_yn = 'N' then
    --
    -- touch parent table
    --
    update sp_initiatives set updated = sysdate, updated_by = :old.updated_by where id = :old.initiative_id;
    --
    insert into sp_initiative_history
        (initiative_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)
    values
        (:old.initiative_id, 'COMMENT', 'DELETE', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_initiative_comments_bd;
/
