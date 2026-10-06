-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_initiative_approvals_bd
    before delete
    on sp_initiative_approvals
    for each row
declare
    l_old_value   varchar2(4000) := null;
begin
    --
    -- touch parent table
    --
    update sp_initiatives set updated = sysdate, updated_by = :old.updated_by where id = :old.initiative_id;
    --
    for c1 in (select approval_type r from sp_approval_types x where x.id = :old.approval_type_id) loop l_old_value := c1.r; end loop; 
    insert into sp_initiative_history
        (initiative_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.initiative_id, 'INITIATIVE_APPROVAL', 'DELETE', 
         l_old_value||' ('||(case when :old.active_yn = 'Y' then 'Active' else 'Inactive' end)||')', sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_initiative_approvals_bd;
/
