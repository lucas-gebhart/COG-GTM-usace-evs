-- source: install_countries_table.sql (p_sequence 330, countries table)
CREATE OR REPLACE EDITIONABLE TRIGGER  sp_countries_biu
   before insert or update on sp_countries 
   for each row 
begin 
   if inserting then 
       :new.created := sysdate; 
       :new.created_by := nvl(wwv_flow.g_user,user); 
   end if; 
   if inserting or updating then 
       :new.updated := sysdate; 
       :new.updated_by := nvl(wwv_flow.g_user,user); 
   end if; 
   if inserting or updating then 
       :new.updated := sysdate; 
       :new.updated_by := nvl(wwv_flow.g_user,user); 
   end if; 
   if :new.display_yn is null then  
      :new.display_yn := 'Y'; 
   end if; 
   if :new.quick_pick_yn is null then  
      :new.quick_pick_yn := 'N'; 
   end if; 
end sp_countries_biu;
/
