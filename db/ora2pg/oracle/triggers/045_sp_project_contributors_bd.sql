-- source: install_project_contributors_triggers.sql (p_sequence 470, project_contributors triggers)
create or replace trigger sp_project_contributors_bd
    before delete
    on sp_project_contributors
    for each row
declare
    v1   varchar2(255) := null;
    v2   varchar2(255) := null;
begin
    --
    -- touch parent table
    --
    update sp_projects set updated = sysdate, updated_by = :old.updated_by where id = :old.project_id;
    --
    for c1 in (select email from sp_team_members x where x.id = :old.team_member_id) loop
        v1 := c1.email;
    end loop;
    for c1 in (select resource_type from sp_resource_types x where x.id = :old.responsibility_id) loop 
        v2 := c1.resource_type;
    end loop;
    insert into sp_project_history
        (project_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.project_id, 'CONTRIBUTOR', 'DELETE', v2||': '||v1, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_project_contributors_bd;
/
