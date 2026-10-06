prompt --application/shared_components/files/js_sp_search_min_js
begin
--   Manifest
--     APP STATIC FILES: 7150
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '646F63756D656E742E717565727953656C6563746F72416C6C28272E742D466F726D2D6669656C64436F6E7461696E657220696E7075745B747970653D22736561726368225D27292E666F72456163682828653D3E7B636F6E737420743D646F63756D65';
wwv_flow_imp.g_varchar2_table(2) := '6E742E637265617465456C656D656E7428227370616E22293B742E7365744174747269627574652822617269612D68696464656E222C227472756522292C742E636C6173734C6973742E616464282273702D436C656172427574746F6E22292C742E6164';
wwv_flow_imp.g_varchar2_table(3) := '644576656E744C697374656E65722822636C69636B222C2828293D3E7B652E76616C75653D22222C652E666F63757328297D29292C652E706172656E744E6F64652E696E736572744265666F726528742C652E6E6578745369626C696E67297D29293B';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(53802585316685612208)
,p_file_name=>'js/sp-search.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
wwv_flow_imp.component_end;
end;
/
