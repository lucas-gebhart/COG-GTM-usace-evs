-- source: install_proj_interactions_log_table.sql (p_sequence 540, proj_interactions_log table)
create or replace trigger sp_proj_interactions_log_biu
    before insert or update
    on sp_proj_interactions_log
    for each row
begin
    :new.page_rendered := sysdate;
    :new.app_user := lower(coalesce(sys_context('APEX$SESSION','APP_USER'),user));
end sp_proj_interactions_log_biu;
/
