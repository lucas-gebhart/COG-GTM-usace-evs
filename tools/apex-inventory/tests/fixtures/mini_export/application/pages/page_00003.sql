prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'&NOMENCLATURE_PROJECT. Details'
,p_alias=>'PROJECT-DETAILS'
,p_page_mode=>'MODAL'
,p_step_title=>'&P3_NAME.'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40)
,p_plug_name=>'Detail'
,p_plug_display_sequence=>10
);
end;
/
