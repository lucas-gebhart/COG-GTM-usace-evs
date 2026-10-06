-- source: install_initiative_comments_table_and_trigger.sql (p_sequence 670, initiative_comments table and trigger)
create or replace trigger sp_initiative_comments_biu
    before insert or update
    on sp_initiative_comments
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    --
    --
    if :new.private_yn is null then 
        :new.private_yn := 'N';
    end if;
    --
    -- touch parent table
    --
    update sp_initiatives set updated = sysdate, updated_by = :new.updated_by where id = :new.initiative_id;
    -- history
    if inserting and :new.private_yn = 'N' then
        insert into sp_initiative_history
            (initiative_id, attribute_column, change_type, new_value, new_value_clob, changed_on, changed_by)
        values
            (:new.initiative_id, 'COMMENT', 'CREATE', dbms_lob.substr(:new.body_no_images,500,1), :new.body_no_images, sysdate, lower(:new.created_by));
     elsif updating and :old.private_yn = 'N' and :new.private_yn = 'N' then
        if not sp_value_compare.is_equal(:old.body_no_images,:new.body_no_images) then
            insert into sp_initiative_history
                (initiative_id, attribute_column, change_type, old_value, new_value, old_value_clob, new_value_clob, changed_on, changed_by)
            values
                (:new.initiative_id, 'COMMENT', 'UPDATE', dbms_lob.substr(:old.body_no_images,500,1), dbms_lob.substr(:new.body_no_images,1), :old.body_no_images, :new.body_no_images, sysdate, lower(:new.updated_by));
        end if;
    end if;
end sp_initiative_comments_biu;
/
