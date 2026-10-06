-- source: install_ai_prompts_table_and_trigger.sql (p_sequence 75, ai_prompts table and trigger)
create or replace trigger sp_ai_prompts_biu
    before insert or update 
    on sp_ai_prompts
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated    := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    :new.static_id  := upper(:new.static_id);
end sp_ai_prompts_biu;
/
