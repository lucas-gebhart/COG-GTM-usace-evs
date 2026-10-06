-- source: install_favorites_table.sql (p_sequence 610, favorites table)
CREATE OR REPLACE TRIGGER sp_favorites_biu
    before insert or update
    on sp_favorites
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end sp_favorites_biu;
/
