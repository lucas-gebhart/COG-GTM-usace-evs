-- source: install_create_table_sp_release_links.sql (p_sequence 680, create table sp_release_links)
create or replace trigger sp_release_links_bd
    before delete
    on sp_release_links
    for each row
begin
    insert into sp_release_history
        (release_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.release_id, 'RELEASE_LINK', 'DELETE', :old.link_name, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_release_links_bd;
/
