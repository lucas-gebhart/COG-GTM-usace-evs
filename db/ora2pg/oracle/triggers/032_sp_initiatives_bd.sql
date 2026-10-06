-- source: install_initiatives_triggers.sql (p_sequence 440, Initiatives triggers)
create or replace trigger sp_initiatives_bd
    before delete
    on sp_initiatives
    for each row
declare
    l_old_value   varchar2(4000) := null;
begin
    --
    -- touch parent table
    --
    update sp_areas set updated = sysdate, updated_by = :old.updated_by where id = :old.area_id;
    --
    for c1 in (select AREA r from SP_AREAS x where x.id = :old.AREA_ID) loop l_old_value := c1.r; end loop;
    insert into sp_initiative_history
        (initiative_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:old.id, 'INITIATIVE', 'DELETE', l_old_value||': '||:old.initiative, sysdate, lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user)));
end sp_initiatives_bd;
/
