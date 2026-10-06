-- source: install_activity_types_triggers.sql (p_sequence 560, activity_types triggers)
create or replace trigger sp_activity_types_bd
    before delete
    on sp_activity_types
    for each row
begin
    insert into sp_app_log
        (activity, details)
    values
        ('Deleted Activity Type', :old.activity_type);
end sp_activity_types_bd;
/
