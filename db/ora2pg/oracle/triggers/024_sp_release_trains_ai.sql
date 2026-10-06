-- source: install_release_trains_triggers.sql (p_sequence 390, release trains triggers)
create or replace trigger sp_release_trains_ai
    after insert
    on sp_release_trains
    for each row
begin
    insert into sp_release_history
        (release_id, attribute_column, change_type, new_value, changed_on, changed_by)
    values
        (:new.id, 'RELEASE', 'CREATE', :new.release_train || ' ' ||:new.release, sysdate, lower(:new.created_by));
end sp_release_trains_ai;
/
