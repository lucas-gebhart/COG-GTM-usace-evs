-- source: install_sp_report_questions_table_and_trigger.sql (p_sequence 77, sp_report_questions table and trigger)
create or replace trigger sp_report_questions_biu
    before insert or update 
    on sp_report_questions
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated    := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_report_questions_biu;
/
