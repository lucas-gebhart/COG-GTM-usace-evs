-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_project_approvals_bd
    before delete
    on sp_project_approvals
    for each row
declare
    l_old_value   varchar2(4000) := null;
begin
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
    --
    for c1 in (select approval_type x from sp_approval_types t where t.id = :old.approval_type_id) loop l_old_value := c1.x; end loop;
    insert into sp_project_history
        (project_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.project_id, 'APPROVAL', 'DELETE', l_old_value, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_project_approvals_bd;
/
