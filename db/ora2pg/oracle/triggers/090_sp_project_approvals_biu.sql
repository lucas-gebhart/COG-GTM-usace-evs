-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_project_approvals_biu
    before insert or update
    on sp_project_approvals
    for each row
declare
    l_old_value   varchar2(4000) := null;
    l_new_value   varchar2(4000) := null;
begin
    if inserting then
        :new.submitted := sysdate;
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :new.updated_by where id = :new.project_id;
    --
    -- history
    -- 
    if inserting then
        for c1 in (select approval_type x from sp_approval_types t where t.id = :new.approval_type_id) loop l_new_value := c1.x; end loop;
        insert into sp_project_history
            (project_id, attribute_column, change_type, new_value, changed_on, changed_by)
        values
            (:new.project_id, 'APPROVAL', 'CREATE', l_new_value, sysdate, coalesce(sys_context('APEX$SESSION','APP_USER'),user));
    elsif updating then
        if not sp_value_compare.is_equal(:old.status,:new.status) then
            for c1 in (select approval_type x from sp_approval_types t where t.id = :new.approval_type_id) loop l_new_value := c1.x; end loop;
            insert into sp_project_history
                (project_id, attribute_column, change_type, new_value, changed_on, changed_by)
            values
                (:new.project_id, 'APPROVAL', 'UPDATE', l_new_value||' - '||:new.status, sysdate, coalesce(sys_context('APEX$SESSION','APP_USER'),user));
        end if;
    end if;
end sp_project_approvals_biu;
/
