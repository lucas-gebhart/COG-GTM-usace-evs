-- APEX supporting object install script: SP_GROUPS trigger
-- sequence 430, source application/deployment/install/install_sp_groups_trigger.sql
-- kind: ddl

create or replace trigger SP_GROUPS_biu
    before insert or update
    on SP_GROUPS
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    --
    -- set organization_name_upper
    --
    :new.group_name_upper := upper(:new.group_name);
    :new.group_tag := upper(replace(trim(:new.group_tag),' ','-'));
end SP_GROUPS_biu;
/
