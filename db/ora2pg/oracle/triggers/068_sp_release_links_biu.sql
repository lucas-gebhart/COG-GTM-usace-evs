-- source: install_create_table_sp_release_links.sql (p_sequence 680, create table sp_release_links)
create or replace trigger sp_release_links_biu
    before insert or update
    on sp_release_links
    for each row
declare
    l_changed_by  varchar2(255)  := null;
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
    update sp_release_trains set updated = sysdate, updated_by = :new.updated_by where id = :new.release_id;

    --
    -- change history tracking
    --
    if inserting then
        insert into sp_release_history
            (release_id, attribute_column, change_type, new_value, changed_on, changed_by)
        values
            (:new.release_id, 'RELEASE_LINK', 'CREATE', :new.link_name, sysdate, lower(:new.created_by));
    elsif updating then
        l_changed_by := lower(:new.updated_by);
        --
        if not sp_value_compare.is_equal(:old.link_name,:new.link_name) then
           insert into sp_release_history
               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)
           values
               (:new.release_id, 'RELEASE_LINK', 'UPDATE', :old.link_name, :new.link_name, sysdate, l_changed_by);
        end if;
        --
        if not sp_value_compare.is_equal(:old.link_url,:new.link_url) then
           insert into sp_release_history
               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)
           values
               (:new.release_id, 'RELEASE_LINK_URL', 'UPDATE', :new.link_name||' - ' ||:old.link_url, :new.link_name||' - ' ||:new.link_url, sysdate, l_changed_by);
        end if;
        --
        if not sp_value_compare.is_equal(:old.important_yn,:new.important_yn) then
           insert into sp_release_history
               (release_id, attribute_column, change_type, old_value, new_value, changed_on, changed_by)
           values
               (:new.release_id, 'RELEASE_LINK_IMPORTANT', 'UPDATE', :new.link_name||' - ' ||:old.important_yn, :new.link_name||' - ' ||:new.important_yn, sysdate, l_changed_by);
        end if;
    end if;
end sp_release_links_biu;
/
