-- source: install_release_milestone_triggers.sql (p_sequence 530, release milestone triggers)
create or replace trigger sp_release_milestones_bd
    before delete
    on sp_release_milestones
    for each row
begin
    insert into sp_release_history
        (release_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.release_id, 'RELEASE_MILESTONE', 'DELETE', :old.milestone_name, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_release_milestones_bd;
/
