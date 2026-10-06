-- source: install_release_trains_triggers.sql (p_sequence 390, release trains triggers)
create or replace trigger sp_release_trains_bd
    before delete
    on sp_release_trains
    for each row
begin
    insert into sp_release_history
        (release_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.id, 'RELEASE', 'DELETE', :old.release_train || ' ' ||:old.release, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_release_trains_bd;
/
