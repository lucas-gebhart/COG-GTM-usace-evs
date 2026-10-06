-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_initiative_approval_chain_bd
    before delete
    on sp_initiative_approval_chain
    for each row
declare
    l_initiative_id  number;
    l_approval_type  varchar2(4000) := null;
    l_old_value      varchar2(4000) := null;
begin
    --
    -- touch parent table
    --
    update sp_initiative_approvals set updated = sysdate, updated_by = :old.updated_by where id = :old.initiative_approval_id;
    --
    -- history
    --
    for c1 in (select x.initiative_id, t.approval_type 
                 from sp_initiative_approvals x, sp_approval_types t 
                where x.id = :old.initiative_approval_id
                  and x.approval_type_id = t.id
              ) loop l_initiative_id := c1.initiative_id; l_approval_type := c1.approval_type; end loop; 
    for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :old.team_member_id) loop l_old_value := :old.approval_seq||'-'||c1.r; end loop;
    insert into sp_initiative_history
        (initiative_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (l_initiative_id, 'INITIATIVE_APPROVAL', 'DELETE', 
         l_approval_type||' - '||l_old_value||' ('||decode(:old.active_yn,'Y','Active','Inactive')||')', 
         sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_initiative_approval_chain_bd;
/
