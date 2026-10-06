-- source: install_project_task_triggers.sql (p_sequence 720, Project Task triggers)
create or replace trigger sp_task_documents_bd
    before delete
    on sp_task_documents
    for each row
begin
    --
    -- touch parent table
    --
    update sp_tasks set updated = sysdate, updated_by = :old.updated_by where id = :old.task_id;
    --
    insert into sp_task_history
        (task_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.task_id, 'DOCUMENT', 'DELETE', :old.document_filename, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_task_documents_bd;
/
