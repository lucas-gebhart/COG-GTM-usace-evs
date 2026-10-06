-- source: install_initiatives_triggers.sql (p_sequence 440, Initiatives triggers)
create or replace trigger sp_initiatives_ai
    after insert
    on sp_initiatives
    for each row
declare
    l_new_value   varchar2(4000) := null;
begin
    for c1 in (select AREA r from SP_AREAS x where x.id = :new.AREA_ID) loop l_new_value := c1.r; end loop;
    insert into sp_initiative_history
        (initiative_id, attribute_column, change_type, old_value, changed_on, changed_by)
    values
        (:new.id, 'INITIATIVE', 'CREATE', l_new_value||': '||:new.initiative, sysdate, lower(:new.created_by));
end sp_initiatives_ai;
/
