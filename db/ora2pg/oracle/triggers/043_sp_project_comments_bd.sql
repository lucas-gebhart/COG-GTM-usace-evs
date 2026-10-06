-- source: install_project_comments_triggers.sql (p_sequence 460, project comments triggers)
create or replace trigger sp_project_comments_bd
    before delete
    on sp_project_comments
    for each row
begin
    if :old.private_yn = 'N' then
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
    --
    -- history
    --
    insert into sp_project_history
        (project_id, attribute_column, change_type, old_value, old_value_clob, changed_on, changed_by)
    values
        (:old.project_id, 'COMMENT', 'DELETE', dbms_lob.substr(:old.body_no_images,500,1), :old.body_no_images, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
    end if;
end sp_project_comments_bd;
/
