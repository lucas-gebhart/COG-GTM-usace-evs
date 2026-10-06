-- source: install_project_documents_triggers.sql (p_sequence 490, project documents triggers)
create or replace trigger sp_project_documents_bd
    before delete
    on sp_project_documents
    for each row
begin
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
    --
    insert into sp_project_history
        (project_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.project_id, 'DOCUMENT', 'DELETE', :old.document_filename, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_project_documents_bd;
/
