-- source: install_triggers.sql (p_sequence 350, triggers)
create or replace trigger sp_project_sizes_biu
    before insert or update
    on sp_project_sizes
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    if :new.include_yn is null then
       :new.include_yn := 'Y';
    end if;
end sp_project_sizes_biu;
/
