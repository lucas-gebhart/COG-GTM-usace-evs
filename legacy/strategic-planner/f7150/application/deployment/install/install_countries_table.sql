prompt --application/deployment/install/install_countries_table
begin
--   Manifest
--     INSTALL: INSTALL-countries table
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(47508963272536358384)
,p_install_id=>wwv_flow_imp.id(176222573236493322734)
,p_name=>'countries table'
,p_sequence=>330
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create table  sp_countries (',
'   id                 number default on null to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') ',
'                      constraint sp_countries_pk primary key,',
'   country_code       varchar2(2   char) not null enable, ',
'   COUNTRY_CODE3      varchar2(3   char),',
'   country_name       varchar2(255 char) not null enable, ',
'   region             varchar2(30  char) not null enable, ',
'   display_yn         varchar2(1   char) not null enable, ',
'   quick_pick_yn      varchar2(1   char) not null enable, ',
'   lat                number,',
'   lon                number,',
'   --',
'   created            date,',
'   created_by         varchar2(255 char), ',
'   updated            date, ',
'   updated_by         varchar2(255 char)',
'   )',
'/',
'',
'create unique index  sp_countries_i1 on  sp_countries (country_code)',
'/',
'',
'create unique index  sp_countries_i2 on  sp_countries (country_name)',
'/',
'',
'CREATE OR REPLACE EDITIONABLE TRIGGER  sp_countries_biu',
'   before insert or update on sp_countries ',
'   for each row ',
'begin ',
'   if inserting then ',
'       :new.created := sysdate; ',
'       :new.created_by := nvl(wwv_flow.g_user,user); ',
'   end if; ',
'   if inserting or updating then ',
'       :new.updated := sysdate; ',
'       :new.updated_by := nvl(wwv_flow.g_user,user); ',
'   end if; ',
'   if inserting or updating then ',
'       :new.updated := sysdate; ',
'       :new.updated_by := nvl(wwv_flow.g_user,user); ',
'   end if; ',
'   if :new.display_yn is null then  ',
'      :new.display_yn := ''Y''; ',
'   end if; ',
'   if :new.quick_pick_yn is null then  ',
'      :new.quick_pick_yn := ''N''; ',
'   end if; ',
'end sp_countries_biu; ',
'/',
''))
);
wwv_flow_imp.component_end;
end;
/
