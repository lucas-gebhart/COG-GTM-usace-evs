-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_initiative_approvals_biu
    before insert or update
    on sp_initiative_approvals
    for each row
declare
    l_old_value   varchar2(4000) := null;
    l_new_value   varchar2(4000) := null;
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
    update sp_initiatives set updated = sysdate, updated_by = :new.updated_by where id = :new.initiative_id;
    --
    -- history
    --
    if inserting then
        for c1 in (select approval_type r from sp_approval_types x where x.id = :new.approval_type_id) loop l_new_value := c1.r; end loop; 
        insert into sp_initiative_history 
            (initiative_id, attribute_column, change_type, new_value, changed_on, changed_by) 
        values 
            (:new.initiative_id, 'INITIATIVE_APPROVAL', 'CREATE', l_new_value||' ('||(case when :new.active_yn = 'Y' then 'Active' else 'Inactive' end)||')', sysdate, lower(:new.created_by)); 
    elsif updating then
        if not sp_value_compare.is_equal(:old.approval_type_id,:new.approval_type_id) or
           not sp_value_compare.is_equal(:old.active_yn,:new.active_yn) then
            for c1 in (select approval_type r from sp_approval_types x where x.id = :old.approval_type_id) loop l_old_value := c1.r; end loop;
            for c1 in (select approval_type r from sp_approval_types x where x.id = :new.approval_type_id) loop l_new_value := c1.r; end loop; 
            insert into sp_initiative_history
                (initiative_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (:new.initiative_id, 'INITIATIVE_APPROVAL', 'UPDATE', 
                 l_old_value||' ('||(case when :old.active_yn = 'Y' then 'Active' else 'Inactive' end)||')', 
                 l_new_value||' ('||(case when :new.active_yn = 'Y' then 'Active' else 'Inactive' end)||')', 
                 sysdate, lower(:new.updated_by));
        end if;
    end if;
end sp_initiative_approvals_biu;
/
