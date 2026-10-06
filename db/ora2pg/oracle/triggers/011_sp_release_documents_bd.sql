-- source: install_release_documents_table_and_triggr.sql (p_sequence 310, release_documents table and triggr)
create or replace trigger sp_release_documents_bd
    before delete
    on sp_release_documents
    for each row
begin
    insert into sp_release_history
        (release_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.release_id, 'DOCUMENT', 'DELETE', :old.document_filename, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_release_documents_bd;
/
