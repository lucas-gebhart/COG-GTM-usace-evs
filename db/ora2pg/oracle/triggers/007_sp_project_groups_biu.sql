-- source: install_sp_project_groups_table.sql (p_sequence 220, sp_project_groups table)
CREATE OR REPLACE EDITIONABLE TRIGGER  sp_project_groups_biu
   before insert or update on sp_project_groups 
   for each row 
begin 
   if inserting then 
       :new.created := sysdate; 
       :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
   end if; 
   if inserting or updating then 
       :new.updated := sysdate; 
       :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
   end if; 
end sp_project_groups_biu;
/
