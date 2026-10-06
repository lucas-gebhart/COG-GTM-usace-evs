-- source: install_approval_tables_and_triggers.sql (p_sequence 732, Approval tables and triggers)
create or replace trigger sp_initiative_approval_chain_biu
    before insert or update
    on sp_initiative_approval_chain
    for each row
declare
    l_initiative_id  number;
    l_approval_type  varchar2(4000) := null;
    l_old_value      varchar2(4000) := null;
    l_new_value      varchar2(4000) := null;
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    :new.alternate_start_date := trunc(:new.alternate_start_date);
    :new.alternate_end_date   := trunc(:new.alternate_end_date);
    --
    -- touch parent table
    --
    update sp_initiative_approvals set updated = sysdate, updated_by = :old.updated_by where id = :old.initiative_approval_id;
    --
    -- history
    --
    if inserting then
        for c1 in (select x.initiative_id, t.approval_type 
                     from sp_initiative_approvals x, sp_approval_types t 
                    where x.id = :new.initiative_approval_id
                      and x.approval_type_id = t.id
                  ) loop l_initiative_id := c1.initiative_id; l_approval_type := c1.approval_type; end loop;     
        for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :new.team_member_id) loop l_new_value := :new.approval_seq||'-'||c1.r; end loop;
        insert into sp_initiative_history 
            (initiative_id, attribute_column, change_type, new_value, changed_on, changed_by) 
        values 
            (l_initiative_id, 'INITIATIVE_APPROVAL_CHAIN', 'CREATE', l_approval_type||' - '||l_new_value, sysdate, lower(:new.created_by)); 
    elsif updating then
        if not sp_value_compare.is_equal(:old.team_member_id,:new.team_member_id) or
               sp_value_compare.is_equal(:old.approval_seq,:new.approval_seq) or
               sp_value_compare.is_equal(:old.active_yn,:new.active_yn) or
               sp_value_compare.is_equal(:old.alternate_team_member_id,:new.alternate_team_member_id) or
               sp_value_compare.is_equal(:old.alternate_start_date,:new.alternate_start_date) or
               sp_value_compare.is_equal(:old.alternate_end_date,:new.alternate_end_date)
        then
            for c1 in (select x.initiative_id, t.approval_type 
                         from sp_initiative_approvals x, sp_approval_types t 
                        where x.id = :new.initiative_approval_id
                          and x.approval_type_id = t.id
                      ) loop l_initiative_id := c1.initiative_id; l_approval_type := c1.approval_type; end loop;   
            for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :old.team_member_id) loop l_old_value := :old.approval_seq||'-'||c1.r; end loop;
            for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :new.team_member_id) loop l_new_value := :new.approval_seq||'-'||c1.r; end loop;
            if sp_value_compare.is_equal(:old.alternate_team_member_id,:new.alternate_team_member_id) then
                for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :old.alternate_team_member_id) loop 
                           l_old_value := l_old_value || ' [alternate '||c1.r||' '||(case when :old.alternate_start_date is not null then :old.alternate_start_date||' thru ' end)|| 
                                                                                    (case when :old.alternate_end_date is not null then :old.alternate_end_date end)||']'; end loop;
                for c1 in (select lower(email) r from SP_TEAM_MEMBERS x where x.id = :new.alternate_team_member_id) loop 
                           l_new_value := l_new_value || ' [alternate '||c1.r||' '||(case when :new.alternate_start_date is not null then :new.alternate_start_date||' thru ' end)|| 
                                                                                    (case when :new.alternate_end_date is not null then :new.alternate_end_date end)||']'; end loop;
            end if;
            insert into sp_initiative_history
                (initiative_id, attribute_column, change_type, old_value, new_value,changed_on, changed_by)
            values
                (l_initiative_id, 'INITIATIVE_APPROVAL_CHAIN', 'UPDATE', 
                 l_approval_type||' - '||l_old_value||' ('||decode(:old.active_yn,'Y','Active','Inactive')||')', 
                 l_approval_type||' - '||l_new_value||' ('||decode(:new.active_yn,'Y','Active','Inactive')||')', 
                 sysdate, lower(:new.updated_by));
        end if;
    end if;
end sp_initiative_approval_chain_biu;
/
