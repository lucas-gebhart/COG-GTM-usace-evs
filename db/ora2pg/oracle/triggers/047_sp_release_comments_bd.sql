-- source: install_release_comments_triggers.sql (p_sequence 480, release comments triggers)
create or replace trigger sp_release_comments_bd
    before delete
    on sp_release_comments
    for each row
begin
    if :old.private_yn = 'N' then
    insert into sp_release_history
        (release_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)
    values
        (:old.release_id, 'RELEASE_COMMENT', 'DELETE', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_release_comments_bd;
/
