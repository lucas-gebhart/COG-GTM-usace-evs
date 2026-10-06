-- source: install_sp_error_log_table_and_trigger.sql (p_sequence 65, sp_error_log table and trigger)
create or replace trigger sp_error_log_bi
    before insert
    on sp_error_log
    for each row
begin
    :new.created       := sysdate;
    :new.created_trunc := trunc(sysdate);
    :new.created_by    := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end sp_error_log_bi;
/
